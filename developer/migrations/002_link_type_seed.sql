INSERT INTO developer.link_types
  (id, name, from_module, from_entity, from_field, to_module, to_entity, to_field, link_kind, via, description)
VALUES
  (
    'projects.room-belongs-to-project',
    'Room belongs to project',
    'erganis.projects', 'room', 'projectPublicId',
    'erganis.projects', 'project', 'publicId',
    'reference', 'projects.rooms.project_public_id',
    'Each room is owned by exactly one project.'
  ),
  (
    'projects.assignment-to-project',
    'Assignment on project',
    'erganis.projects', 'assignment', 'projectPublicId',
    'erganis.projects', 'project', 'publicId',
    'assignment', 'projects.item_assignments',
    'Inventory assignment scoped to a project (with or without a room).'
  ),
  (
    'projects.assignment-to-room',
    'Assignment in room',
    'erganis.projects', 'assignment', 'roomPublicId',
    'erganis.projects', 'room', 'publicId',
    'assignment', 'projects.item_assignments.room_public_id',
    'Optional room scope for an assignment; null means project-wide.'
  ),
  (
    'projects.assignment-to-product',
    'Assignment uses catalog product',
    'erganis.projects', 'assignment', 'productPublicId',
    'erganis.inventory', 'product', 'publicId',
    'reference', 'projects.item_assignments.product_public_id → inventory.products',
    'Orchestration links org catalog SKU to a project/room pick.'
  ),
  (
    'platform.membership-user',
    'Org membership',
    'platform', 'membership', 'userId',
    'platform', 'user', 'id',
    'membership', 'platform.org_memberships',
    'User belongs to org via membership row.'
  ),
  (
    'platform.membership-role',
    'Membership role',
    'platform', 'membership', 'roleId',
    'platform', 'role', 'id',
    'reference', 'platform.org_memberships.role_id',
    'Role assigned to org membership.'
  )
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  via = EXCLUDED.via;
