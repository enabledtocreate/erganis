# Contributing to Erganis

Thank you for your interest in contributing to Erganis!

## Getting Started

1. Fork the repository you want to contribute to
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/erganis-<repo>.git`
3. Create a branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test your changes
6. Commit: `git commit -m "Add: description of changes"`
7. Push: `git push origin feature/your-feature-name`
8. Open a Pull Request

## Adding a New App

Apps are separate repos (e.g. `erganis-app-studio-portal`). To add another app:

1. Create a new repo (e.g. `erganis-app-mobile`) and add it as a submodule under `erganis/` (e.g. `mobile-app/`).
2. Or add a new folder to an existing app repo (e.g. add a third app to `studio-portal/` if it shares code).
3. Ensure the app consumes the API via platform (live URL or generated SDK).
4. Add tests per repo (see `docs/TESTING.md`). Platform tests live inside `platform/` (e.g. `platform/contracts/tests/`).

## Adding a New Service

To add a new service to `erganis-services`:

1. Create a new folder: `services/your-service-name/`
2. Follow the structure of existing services
3. Add a README.md explaining what the service does
4. Update `services/README.md` to list your service
5. Ensure it uses contracts from `erganis-contracts`
6. Use DAL from `erganis-infrastructure` for data access
7. Add tests in `services/your-service-name/tests/`

## Code Style

- Follow language-specific style guides (ESLint for JS/TS, EditorConfig, etc.)
- Write clear, self-documenting code
- Add comments for complex logic
- Keep functions focused and small
- Use meaningful variable and function names

## Testing

- Write tests for new features
- Ensure existing tests pass
- Aim for good test coverage
- Include integration tests for API changes

## Commit Messages

Use conventional commits format:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting)
- `refactor:` Code refactoring
- `test:` Adding tests
- `chore:` Maintenance tasks

Example: `feat(apps): add user authentication to studio app`

## Pull Request Process

1. Ensure your PR addresses a single concern
2. Update documentation if needed
3. Add tests for new functionality
4. Ensure all CI checks pass
5. Request review from maintainers
6. Address feedback promptly

## Questions?

- Open an issue for questions or discussions
- Check existing issues/PRs first
- Be respectful and constructive
