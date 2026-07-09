import { readdir, readFile } from 'fs/promises';
import path from 'path';
import {
  DbUnitOfWork,
  ModuleManifest,
  OperationContext,
  StepHandler,
  StepHandlerResult,
} from '@erganis/platform';
import { DeveloperRepository } from '../developer.repository';

function moduleRoots(): string[] {
  const roots = new Set<string>();
  const main =
    process.env.MODULES_ROOT ?? path.resolve(process.cwd(), '../../studio/modules');
  const extra = process.env.MODULES_EXTRA_ROOTS ?? '../../developer';
  roots.add(path.resolve(main));
  for (const entry of extra.split(',')) {
    const trimmed = entry.trim();
    if (trimmed) {
      roots.add(path.resolve(trimmed));
    }
  }
  return [...roots];
}

async function tryAddManifest(
  moduleDir: string,
  manifests: ModuleManifest[],
  seen: Set<string>,
): Promise<boolean> {
  try {
    const raw = await readFile(path.join(moduleDir, 'erganis.module.json'), 'utf8');
    const manifest = JSON.parse(raw) as ModuleManifest;
    if (seen.has(manifest.id)) {
      return true;
    }
    seen.add(manifest.id);
    manifests.push(manifest);
    return true;
  } catch {
    return false;
  }
}

async function discoverInstalledManifests(): Promise<ModuleManifest[]> {
  const manifests: ModuleManifest[] = [];
  const seen = new Set<string>();
  for (const root of moduleRoots()) {
    if (await tryAddManifest(root, manifests, seen)) {
      continue;
    }
    let entries: string[];
    try {
      entries = await readdir(root);
    } catch {
      continue;
    }
    for (const entry of entries) {
      await tryAddManifest(path.join(root, entry), manifests, seen);
    }
  }
  return manifests.sort((a, b) => a.id.localeCompare(b.id));
}

export const loadDeveloperGraph: StepHandler = async (
  context: OperationContext,
  unitOfWork: DbUnitOfWork,
): Promise<StepHandlerResult> => {
  const repo = new DeveloperRepository(unitOfWork.client);

  const [linkTypes, products, projects, rooms, assignmentLinks, roomProjectLinks, manifests] =
    await Promise.all([
      repo.listLinkTypes(),
      repo.sampleProducts(context.orgId).catch(() => []),
      repo.sampleProjects(context.orgId).catch(() => []),
      repo.sampleRooms(context.orgId).catch(() => []),
      repo.liveAssignmentLinks(context.orgId).catch(() => []),
      repo.liveRoomProjectLinks(context.orgId).catch(() => []),
      discoverInstalledManifests(),
    ]);

  const modules = manifests.map((manifest) => ({
    moduleId: manifest.id,
    name: manifest.name,
    version: manifest.version,
    description: manifest.description ?? null,
    shipByDefault: manifest.shipByDefault !== false,
    operations: (manifest.contributions?.operations ?? []).map((op) => ({
      surfaceId: op.surfaceId,
      action: op.action,
      stepId: op.stepId,
      handler: op.handler,
    })),
    surfaces: [
      ...new Set((manifest.contributions?.operations ?? []).map((op) => op.surfaceId)),
    ],
  }));

  const entities = [...products, ...projects, ...rooms];
  const liveLinks = [...roomProjectLinks, ...assignmentLinks];

  const pipeline = modules.flatMap((mod) =>
    mod.operations.map((op) => ({
      moduleId: mod.moduleId,
      surfaceId: op.surfaceId,
      action: op.action,
      stepId: op.stepId,
      handler: op.handler,
      envelope: `POST /operations/execute { surfaceId: "${op.surfaceId}", action: "${op.action}" }`,
    })),
  );

  return {
    message: 'Developer graph loaded',
    data: {
      generatedAt: new Date().toISOString(),
      orgSlug: context.orgSlug,
      modules,
      linkTypes,
      entities,
      liveLinks,
      pipeline,
      contracts: [
        {
          id: 'operation-envelope',
          path: 'schemas/envelope/operation-envelope.schema.json',
          endpoint: 'POST /operations/execute',
        },
        {
          id: 'module-manifest',
          path: 'schemas/module/erganis.module.schema.json',
          endpoint: 'erganis.module.json per module',
        },
        {
          id: 'ui-layout',
          path: 'schemas/composition/ui-layout.schema.json',
          endpoint: 'GET /composition/schemas',
        },
        {
          id: 'agent-capabilities',
          path: 'runtime',
          endpoint: 'GET /agent/capabilities?orgSlug=',
        },
      ],
    },
  };
};
