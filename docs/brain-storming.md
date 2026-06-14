
# Erganis Brain-Storming Notes

> **Migrated:** Substantive ideas and open questions now live in the workspace scratch pad:
> - [.apm/_WORKSPACE/IDEAS.md](../.apm/_WORKSPACE/IDEAS.md) — ideas, principles, project breakdown
> - [.apm/_WORKSPACE/TODO.md](../.apm/_WORKSPACE/TODO.md) — open questions and action items
>
> This file is kept as the original capture; prefer editing IDEAS/TODO for ongoing planning.

## Purpose
This document captures major architectural decisions, ideas, assumptions, and open questions discussed during early Erganis platform planning.

## Core Vision
Erganis is intended to be a modular platform rather than a monolithic application.

Platform responsibilities:
- Runtime hosting
- Contracts
- Orchestration
- Identity
- Workflow
- Composition
- APIs

Business capabilities should primarily live inside modules.

Examples:
- Inventory
- Finance
- Sustainability
- Vendor Directory
- Project Management

## Architectural Principles

### Contracts over Implementation
Modules should interact through contracts rather than directly touching each other's storage.

### Composition over Coupling
Modules should contribute:
- Data
- Validation
- UI
- Workflow
- Jobs

### Workflow First
Erganis is workflow-oriented rather than CRUD-oriented.

## Surface Model

A Surface represents:
- User intent
- Workflow boundary
- Data obligations
- Save behavior

Examples:
- Product Surface
- Project Surface
- Purchase Order Surface

A Surface is not a page and can appear in multiple layouts.

## Module Philosophy

Modules may:
- Add fields
- Add validation
- Add workflows
- Add jobs
- Add UI contributions

Modules should not:
- Directly mutate another module's storage
- Depend on database implementation details

## Internal vs Public IDs

Internal IDs:
- Storage-oriented
- Module-owned

Public IDs:
- Stable
- Cross-module
- API-safe

Reason:
Storage technology may change while references remain stable.

## Orchestration

All significant mutations should flow through orchestration.

Example:
Save Product

Participants:
- Inventory Module
- Finance Module
- Sustainability Module

## Operation Tracking

Every major action should generate:
- Operation ID
- Step IDs

Benefits:
- Auditing
- Troubleshooting
- Rollback support
- Cross-module visibility

## Partial Failure Strategy

Required:
- Failure blocks operation

Optional:
- Failure produces warning

Advisory:
- Informational only

## API Strategy

Three API categories:

### Surface API
Used by Erganis applications.

### Module Contract API
Used internally between runtime and modules.

### Public API
Used by:
- Mobile apps
- Desktop tools
- Partner systems

## Inbound vs Outbound Integrations

Inbound:
- External systems call Erganis

Outbound:
- Erganis calls external systems

## Composition Model

Composition Layers:
1. Core Defaults
2. Module Defaults
3. Organization Overrides
4. Runtime Resolution

## Admin Philosophy

Admins should control:
- Composition priorities
- Layout preferences
- Module enablement
- Conflict resolution

Core always retains ultimate authority.

## Validation Philosophy

Validation should be composable.

Examples:
- Required field validation
- Budget validation
- Business-rule validation

## Dependency Model

Modules declare:
- Dependencies
- Compatible versions
- Required contracts

## Draft Support

The platform should support:
- Draft saves
- Recovery
- Autosave
- Session restoration

## Search Layer

Persistence is the source of truth.

Search is the source of findability.

## Suggested Early Tech Direction

Frontend:
- React
- Next.js
- TypeScript

Backend:
- TypeScript

Database:
- PostgreSQL

## Major Open Questions

- Module Manifest Specification
- Operation Envelope Structure
- Schema Definition Strategy
- Versioning Strategy
- Permissions Model
- Workflow Authoring Model
- Search Architecture
- File Storage Strategy
- Rollback & Compensation Design

## Long-Term Goal

Create a platform where first-party modules, third-party modules, internal applications, and external applications all operate through the same architectural principles and contracts.
