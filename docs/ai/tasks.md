# Project Tasks

> Track all development work here. When a task is submitted for review, the Lead Architect
> reads the relevant files, checks against `constitution.md`, and marks `[x]` on pass or
> annotates with blocking feedback on fail.
>
> **Legend:** `[ ]` = not started · `[~]` = in progress · `[x]` = reviewed & accepted · `[!]` = blocked (see note)

---

## Phase 1 — Scaffolding & Core Infrastructure
o
> Goal: Every piece of shared plumbing is in place so feature work never has to touch
> core infrastructure again.

- [x] **1.1** Add `mocktail` to `dev_dependencies` in `pubspec.yaml` and run `flutter pub get`.
- [x] **1.2** Create `lib/core/errors/failure.dart` — define the `Failure` class with `statusCode` (int) and `message` (String) fields; extend `Equatable`.
- [x] **1.3** Create `lib/core/services/use_cases/base_use_case.dart` — define `BaseUseCase<Type, Params>` abstract class with a `call(Params params)` method and a `NoParams` class.
- [x] **1.4** Define the `UserEntity` in `lib/features/profile/domain/entities/` with fields: `id`, `name`, `balance` (double), `isVerified` (bool). Extend `Equatable`.
- [x] **1.5** Define the `BeneficiaryEntity` in `lib/features/beneficiaries/domain/entities/` with fields: `id`, `nickname` (String), `phoneNumber` (String). Extend `Equatable`.
- [x] **1.6** Define the `TransactionEntity` in `lib/features/history/domain/entities/` with fields: `id`, `beneficiaryId`, `amount` (double), `fee` (double), `createdAt` (DateTime). Extend `Equatable`.
- [x] **1.7** Define the `TopUpOption` constant (list of valid amounts) in `lib/core/constants/` — values: `[5, 10, 20, 30, 50, 75, 100]` (all as `double`).
- [x] **1.8** Register `GetIt` service locator (`sl`) in `lib/core/services/service_locator/di.dart` and confirm `DI.init()` is called before `runApp` in `main.dart` / `Initializer`.
- [x] **1.9** Confirm `HydratedBloc.storage` is initialized in `Initializer` before `runApp`.
- [x] **1.10** Confirm `GoRouter` with `StatefulShellRoute.indexedStack` is wired up for all four tabs: Home, Beneficiaries, History, Profile.

---

## Phase 2 — Domain & Business Logic

> Goal: All use cases and business rules (BR-01 through BR-08) are implemented and unit-tested
> in pure Dart with zero Flutter or Dio imports.

### Profile / User
- [x] **2.1** Create `IUserRepository` (abstract) in `lib/features/profile/domain/repo/` with method `Future<Either<Failure, UserEntity>> getUser()`.
- [x] **2.2** Create `GetUserUseCase` extending `BaseUseCase<UserEntity, NoParams>` — calls `IUserRepository.getUser()`.

### Beneficiaries
- [x] **2.3** Create `IBeneficiaryRepository` (abstract) in `lib/features/beneficiaries/domain/repo/` with methods:
  - `Future<Either<Failure, List<BeneficiaryEntity>>> getBeneficiaries()`
  - `Future<Either<Failure, BeneficiaryEntity>> addBeneficiary(AddBeneficiaryParams params)`
- [x] **2.4** Define `AddBeneficiaryParams` in `lib/features/beneficiaries/domain/params/` with fields `nickname` and `phoneNumber`; extend `Equatable`.
- [x] **2.5** Create `GetBeneficiariesUseCase` extending `BaseUseCase<List<BeneficiaryEntity>, NoParams>`.
- [x] **2.6** Create `AddBeneficiaryUseCase` extending `BaseUseCase<BeneficiaryEntity, AddBeneficiaryParams>`.
  - Enforce **BR-01**: if existing beneficiaries count ≥ 5, return `Left(Failure)`.
  - Enforce **BR-02**: if nickname is empty or length > 20, return `Left(Failure)`.

### Transactions / Top-Up
- [x] **2.7** Create `ITransactionRepository` (abstract) in `lib/features/history/domain/repo/` with methods:
  - `Future<Either<Failure, List<TransactionEntity>>> getTransactions()`
  - `Future<Either<Failure, TransactionEntity>> topUp(TopUpParams params)`
- [x] **2.8** Define `TopUpParams` in `lib/features/history/domain/params/` with fields: `user` (UserEntity), `beneficiaryId` (String), `amount` (double), `allBeneficiaries` (List<BeneficiaryEntity>), `monthlyTransactions` (List<TransactionEntity>); extend `Equatable`.
- [x] **2.9** Create `GetTransactionsUseCase` extending `BaseUseCase<List<TransactionEntity>, NoParams>`.
- [x] **2.10** Create `TopUpUseCase` extending `BaseUseCase<TransactionEntity, TopUpParams>`.
  - Enforce **BR-03**: amount must be in `[5, 10, 20, 30, 50, 75, 100]`.
  - Enforce **BR-04**: fee is always AED 3.
  - Enforce **BR-05**: `user.balance >= amount + 3`, else return `Left(Failure('Insufficient balance'))`.
  - Enforce **BR-06/07**: monthly spend for this beneficiary + amount ≤ limit (500 unverified / 1000 verified).
  - Enforce **BR-08**: total monthly spend across all beneficiaries + amount ≤ 3000.
  - Rule evaluation order per **BR-10**: BR-05 → BR-06/07 → BR-08.

---

## Phase 3 — Data Layer & Mocking

> Goal: Concrete repository implementations and a fully mocked HTTP layer that satisfies
> all business rule scenarios.

### Profile / User
- [x] **3.1** Create `UserModel` in `lib/features/profile/data/models/` with `fromJson`/`toJson`; includes `isVerified` bool.
- [x] **3.2** Create `UserMapper` in `lib/features/profile/data/mapper/` — `UserModel → UserEntity`.
- [x] **3.3** Create `UserRemoteDataSource` in `lib/features/profile/data/data_source/remote_data_source/` — returns a hardcoded mock `UserModel` (simulate HTTP GET `/user`); set `balance: 1500.0`, `isVerified: true` as defaults.
- [x] **3.4** Create `UserRepositoryImpl` in `lib/features/profile/data/repo_impl/` implementing `IUserRepository`; wraps data source, catches exceptions, maps to `Failure`.
- [x] **3.5** Register `IUserRepository → UserRepositoryImpl` and `GetUserUseCase` in `init_controllers.dart`.

### Beneficiaries
- [x] **3.6** Create `BeneficiaryModel` in `lib/features/beneficiaries/data/models/` with `fromJson`/`toJson`.
- [x] **3.7** Create `BeneficiaryMapper` in `lib/features/beneficiaries/data/mapper/`.
- [x] **3.8** Create `BeneficiaryRemoteDataSource` — returns a hardcoded list of mock beneficiaries (start with 2 pre-seeded entries); simulates add-beneficiary POST.
- [x] **3.9** Create `BeneficiaryRepositoryImpl` implementing `IBeneficiaryRepository`.
- [x] **3.10** Register `IBeneficiaryRepository → BeneficiaryRepositoryImpl`, `GetBeneficiariesUseCase`, and `AddBeneficiaryUseCase` in `init_controllers.dart`.

### Transactions
- [x] **3.11** Create `TransactionModel` in `lib/features/history/data/models/` with `fromJson`/`toJson`.
- [x] **3.12** Create `TransactionMapper` in `lib/features/history/data/mapper/`.
- [x] **3.13** Create `TransactionRemoteDataSource` — returns a hardcoded list of mock transactions for the **current calendar month** (include enough spend so that monthly-limit tests are meaningful but not yet at the cap).
- [x] **3.14** Create `TransactionRepositoryImpl` implementing `ITransactionRepository`; the `topUp` method must apply the AED 3 fee and create a new `TransactionEntity` with the correct fields.
- [x] **3.15** Register `ITransactionRepository → TransactionRepositoryImpl`, `GetTransactionsUseCase`, and `TopUpUseCase` in `init_controllers.dart`.

---

## Phase 4 — Presentation / UI

> Goal: A complete, navigable UI that surfaces all acceptance criteria and handles loading,
> success, and failure states for every user action.

### BLoCs / Cubits
- [x] **4.1** Create `UserCubit` (or `ProfileCubit`) with states `UserInitial`, `UserLoading`, `UserLoaded(UserEntity)`, `UserError(String)`. Register in `bloc_providers.dart`.
- [x] **4.2** Create `BeneficiaryCubit` with states `BeneficiaryInitial`, `BeneficiaryLoading`, `BeneficiaryLoaded(List<BeneficiaryEntity>)`, `BeneficiaryError(String)`, `BeneficiaryAdded`. Register in `bloc_providers.dart`.
- [x] **4.3** Create `TransactionCubit` (or `TopUpCubit`) with states `TransactionInitial`, `TransactionLoading`, `TransactionLoaded(List<TransactionEntity>)`, `TopUpSuccess(TransactionEntity)`, `TransactionError(String)`. Register in `bloc_providers.dart`.

### Screens & Widgets
- [x] **4.4** **Home Screen** (`home_screen.dart`): Display user balance and verification badge; show summary cards for beneficiaries and recent transactions. Load data on screen init via `UserCubit` + `TransactionCubit`.
- [x] **4.5** **Beneficiaries Screen** (`beneficiaries_screen.dart`): List all beneficiaries. Show a "Top Up" action per beneficiary. Show an "Add Beneficiary" button that is **disabled** (with tooltip) when 5 beneficiaries exist (visual guard; domain guard is in use case).
- [x] **4.6** **Add Beneficiary Bottom Sheet / Dialog**: Form with nickname (max 20 chars, validated live) and phone number fields. Submit calls `BeneficiaryCubit.addBeneficiary()`. Show inline error on failure.
- [x] **4.7** **Top-Up Screen**: Displays top-up option grid (BR-03 amounts). Shows total cost = selected amount + AED 3 fee. Confirm button checks balance display and calls `TransactionCubit.topUp()`. Show success/error feedback (snackbar or dialog).
- [x] **4.8** **History Screen** (`history_screen.dart`): List of `TransactionEntity` items showing beneficiary nickname, amount, fee, and date. Loaded via `TransactionCubit`.
- [x] **4.9** **Profile Screen** (`profile_screen.dart`): Display user name, balance, and verified/unverified status label.
- [ ] **4.10** Implement global error/loading state handling: wrap screens in `BlocListener` and show `SnackBar` or an `ErrorWidget` for error states; show `CircularProgressIndicator` for loading states.
- [ ] **4.11** Ensure `NavigationShell` bottom nav order matches `GoRouter` branch order: Home (0), Beneficiaries (1), History (2), Profile (3).

---

## Phase 5 — Testing

> Goal: ≥ 80% coverage on all domain use cases; every business rule has a dedicated
> failure-path test.

### Domain Use Case Unit Tests
- [ ] **5.1** `test/features/beneficiaries/domain/add_beneficiary_use_case_test.dart`
  - [ ] **5.1a** Returns `Left(Failure)` when beneficiary count is already 5 (BR-01).
  - [ ] **5.1b** Returns `Left(Failure)` when nickname is empty (BR-02).
  - [ ] **5.1c** Returns `Left(Failure)` when nickname exceeds 20 characters (BR-02).
  - [ ] **5.1d** Returns `Right(BeneficiaryEntity)` on valid input with < 5 beneficiaries.

- [ ] **5.2** `test/features/history/domain/top_up_use_case_test.dart`
  - [ ] **5.2a** Returns `Left(Failure)` when amount is not in the valid options list (BR-03).
  - [ ] **5.2b** Returns `Left(Failure)` when balance < amount + 3 (BR-05).
  - [ ] **5.2c** Returns `Left(Failure)` when unverified user monthly spend would exceed AED 500 (BR-06).
  - [ ] **5.2d** Returns `Left(Failure)` when verified user monthly spend would exceed AED 1,000 (BR-07).
  - [ ] **5.2e** Returns `Left(Failure)` when total monthly spend across all beneficiaries would exceed AED 3,000 (BR-08).
  - [ ] **5.2f** Returns `Right(TransactionEntity)` with fee = 3 on a fully valid transaction (BR-04).
  - [ ] **5.2g** Verifies BR-10 ordering: balance failure is reported before monthly-limit failure when both conditions fail simultaneously.

- [ ] **5.3** `test/features/profile/domain/get_user_use_case_test.dart`
  - [ ] **5.3a** Returns `Right(UserEntity)` when repository succeeds.
  - [ ] **5.3b** Returns `Left(Failure)` when repository throws.

### BLoC / Cubit Unit Tests
- [ ] **5.4** `test/features/beneficiaries/presentation/beneficiary_cubit_test.dart`
  - [ ] **5.4a** Emits `[Loading, Loaded]` on successful `loadBeneficiaries()`.
  - [ ] **5.4b** Emits `[Loading, Error]` on failed `loadBeneficiaries()`.
  - [ ] **5.4c** Emits `[Loading, Added]` on successful `addBeneficiary()`.
  - [ ] **5.4d** Emits `[Loading, Error]` on failed `addBeneficiary()` (e.g., cap reached).

- [ ] **5.5** `test/features/history/presentation/transaction_cubit_test.dart`
  - [ ] **5.5a** Emits `[Loading, Loaded]` on successful `loadTransactions()`.
  - [ ] **5.5b** Emits `[Loading, TopUpSuccess]` on successful `topUp()`.
  - [ ] **5.5c** Emits `[Loading, Error]` on failed `topUp()`.

### Widget Tests
- [ ] **5.6** `test/features/beneficiaries/presentation/beneficiaries_screen_test.dart`
  - [ ] **5.6a** Add Beneficiary button is disabled when 5 beneficiaries are present.
  - [ ] **5.6b** Beneficiary list renders correct number of items.

- [ ] **5.7** `test/features/history/presentation/top_up_widget_test.dart`
  - [ ] **5.7a** Top-up dialog shows correct total cost (selected amount + AED 3).
  - [ ] **5.7b** Shows error snackbar/message when `TransactionError` is emitted.
  - [ ] **5.7c** Shows success feedback when `TopUpSuccess` is emitted.

### README
- [ ] **5.8** Write `README.md` at the project root with:
  - Setup instructions (`flutter pub get`, `flutter run`).
  - Assumptions made (mock backend, pre-seeded data, default user state).
  - Instructions to run tests (`flutter test`, `flutter test --coverage`).
