# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Analyze (lint)
flutter analyze

# Run all tests
flutter test

# Run a single test file
flutter test test/path/to/test_file.dart

# Build
flutter build ios
flutter build apk
```

## Architecture

This is a Flutter app using **Clean Architecture** organized by feature. Each feature under `lib/features/` has three layers:

```
lib/features/<feature>/
  data/
    data_source/
      local_data_source/   # Local storage (HydratedBloc, etc.)
      remote_data_source/  # Dio HTTP calls
    mapper/                # Model ↔ Entity conversion
    models/                # JSON-serializable DTOs
    repo_impl/             # Concrete repository implementations
  domain/
    entities/              # Pure Dart business objects
    params/                # Input objects for use cases
    repo/                  # Abstract repository interfaces
    use_cases/             # One use case per class, extends BaseUseCase
  presentation/
    controllers/           # BLoC/Cubits for this feature
    screen/                # Full-page widgets
    widgets/               # Feature-local reusable widgets
```

Current features: `home`, `beneficiaries`, `history`, `profile`.

### Key patterns

**Use cases** extend `BaseUseCase<T, P>` and return `Future<Either<Failure, T>>` (using `dartz`). Use `NoParams` when the use case takes no arguments.

**Dependency injection** uses `GetIt` (accessed via `sl`). Register everything in `lib/core/services/service_locator/init_controllers.dart`; call `initControllers()` from `DI.init()`. New feature cubits/blocs must also be added to `lib/core/bloc/bloc_providers.dart`.

**Navigation** uses `GoRouter` with `StatefulShellRoute.indexedStack` so each tab preserves its own navigator stack. Each route is a class extending `AppRoute` — override `pageBuilder` for the screen and `redirect` for guards. The branch order in `routes.dart` must match the `_items` list in `NavigationShell`.

**Theme** is persisted across sessions via `ThemeCubit extends HydratedCubit<ThemeMode>`. `HydratedBloc` storage is initialized before `runApp` in `Initializer`.

**Error handling** uses a single `Failure` class (status code + message). Data layer methods return `Either<Failure, T>`; the left side is always `Failure`.

### Core utilities

- `lib/core/constants/` — `AppPadding`, `AppSize`, `AppFontSize`, color tokens for light/dark themes
- `lib/core/utils/extensions/build_context.dart` — `context.width`, `context.theme`, `context.titleSmall`, etc.
- `lib/core/services/navigation_service/navigation_service.dart` — global `navigatorKey` used by `GoRouter`
