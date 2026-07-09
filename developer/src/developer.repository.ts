import { BaseRepository } from '@erganis/platform';

export interface LinkTypeRecord {
  id: string;
  name: string;
  fromModule: string;
  fromEntity: string;
  fromField: string;
  toModule: string;
  toEntity: string;
  toField: string;
  linkKind: string;
  via: string | null;
  description: string;
}

export interface EntitySample {
  publicId: string;
  label: string;
  moduleId: string;
  entity: string;
  extra?: Record<string, string | null>;
}

export interface LiveLinkRecord {
  linkTypeId: string;
  fromPublicId: string;
  fromLabel: string;
  toPublicId: string;
  toLabel: string;
  contextPublicId?: string | null;
  contextLabel?: string | null;
}

export class DeveloperRepository extends BaseRepository {
  async listLinkTypes(): Promise<LinkTypeRecord[]> {
    return this.queryMany(
      `SELECT id, name, from_module, from_entity, from_field,
              to_module, to_entity, to_field, link_kind, via, description
       FROM developer.link_types
       ORDER BY from_module, name`,
      [],
      (row) => ({
        id: String(row.id),
        name: String(row.name),
        fromModule: String(row.from_module),
        fromEntity: String(row.from_entity),
        fromField: String(row.from_field),
        toModule: String(row.to_module),
        toEntity: String(row.to_entity),
        toField: String(row.to_field),
        linkKind: String(row.link_kind),
        via: row.via ? String(row.via) : null,
        description: String(row.description),
      }),
    );
  }

  async sampleProducts(orgId: string): Promise<EntitySample[]> {
    return this.queryMany(
      `SELECT public_id, name, sku FROM inventory.products
       WHERE org_id = $1 AND archived_at IS NULL
       ORDER BY name LIMIT 20`,
      [orgId],
      (row) => ({
        publicId: String(row.public_id),
        label: String(row.name),
        moduleId: 'erganis.inventory',
        entity: 'product',
        extra: { sku: row.sku ? String(row.sku) : null },
      }),
    );
  }

  async sampleProjects(orgId: string): Promise<EntitySample[]> {
    return this.queryMany(
      `SELECT public_id, name, phase FROM projects.projects
       WHERE org_id = $1 AND archived_at IS NULL
       ORDER BY name LIMIT 20`,
      [orgId],
      (row) => ({
        publicId: String(row.public_id),
        label: String(row.name),
        moduleId: 'erganis.projects',
        entity: 'project',
        extra: { phase: row.phase ? String(row.phase) : null },
      }),
    );
  }

  async sampleRooms(orgId: string): Promise<EntitySample[]> {
    return this.queryMany(
      `SELECT public_id, name, project_public_id FROM projects.rooms
       WHERE org_id = $1 AND archived_at IS NULL
       ORDER BY name LIMIT 30`,
      [orgId],
      (row) => ({
        publicId: String(row.public_id),
        label: String(row.name),
        moduleId: 'erganis.projects',
        entity: 'room',
        extra: { projectPublicId: String(row.project_public_id) },
      }),
    );
  }

  async liveAssignmentLinks(orgId: string): Promise<LiveLinkRecord[]> {
    return this.queryMany(
      `SELECT a.public_id AS assignment_id,
              a.project_public_id,
              pp.name AS project_name,
              a.room_public_id,
              pr.name AS room_name,
              a.product_public_id,
              ip.name AS product_name
       FROM projects.item_assignments a
       LEFT JOIN projects.projects pp
         ON pp.org_id = a.org_id AND pp.public_id = a.project_public_id
       LEFT JOIN projects.rooms pr
         ON pr.org_id = a.org_id AND pr.public_id = a.room_public_id
       LEFT JOIN inventory.products ip
         ON ip.org_id = a.org_id AND ip.public_id = a.product_public_id
       WHERE a.org_id = $1 AND a.archived_at IS NULL
       ORDER BY pp.name, pr.name NULLS FIRST, ip.name`,
      [orgId],
      (row) => ({
        linkTypeId: 'projects.assignment-to-product',
        fromPublicId: String(row.assignment_id),
        fromLabel: `Assignment → ${row.product_name ?? row.product_public_id}`,
        toPublicId: String(row.product_public_id),
        toLabel: String(row.product_name ?? row.product_public_id),
        contextPublicId: row.room_public_id ? String(row.room_public_id) : String(row.project_public_id),
        contextLabel: row.room_public_id
          ? String(row.room_name ?? row.room_public_id)
          : String(row.project_name ?? row.project_public_id),
      }),
    );
  }

  async liveRoomProjectLinks(orgId: string): Promise<LiveLinkRecord[]> {
    return this.queryMany(
      `SELECT r.public_id AS room_id, r.name AS room_name,
              r.project_public_id, p.name AS project_name
       FROM projects.rooms r
       JOIN projects.projects p
         ON p.org_id = r.org_id AND p.public_id = r.project_public_id
       WHERE r.org_id = $1 AND r.archived_at IS NULL
       ORDER BY p.name, r.name`,
      [orgId],
      (row) => ({
        linkTypeId: 'projects.room-belongs-to-project',
        fromPublicId: String(row.room_id),
        fromLabel: String(row.room_name),
        toPublicId: String(row.project_public_id),
        toLabel: String(row.project_name),
      }),
    );
  }
}
