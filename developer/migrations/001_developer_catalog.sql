CREATE SCHEMA IF NOT EXISTS developer;

CREATE TABLE IF NOT EXISTS developer.link_types (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  from_module TEXT NOT NULL,
  from_entity TEXT NOT NULL,
  from_field TEXT NOT NULL,
  to_module TEXT NOT NULL,
  to_entity TEXT NOT NULL,
  to_field TEXT NOT NULL,
  link_kind TEXT NOT NULL DEFAULT 'reference'
    CHECK (link_kind IN ('reference', 'composition', 'assignment', 'membership')),
  via TEXT,
  description TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_developer_link_types_from
  ON developer.link_types (from_module, from_entity);

CREATE INDEX IF NOT EXISTS idx_developer_link_types_to
  ON developer.link_types (to_module, to_entity);
