# Project Constitution

> This document is the single source of truth for all architectural decisions and business
> rules. Every piece of code written in this project must comply with it. During reviews,
> any deviation from these mandates is a **blocking** failure.

---

## 1. Tech Stack

| Concern | Library / Approach |
|---|---|
| Language | Dart (SDK `^3.11.4`) |
| Framework | Flutter |
| State Management | `flutter_bloc ^9.1.1` — BLoC/Cubit only. No `setState` in business logic. |
| Dependency Injection | `get_it ^9.2.1` — accessed via the `sl` alias |
| Navigation | `go_router ^17.2.1` — `StatefulShellRoute.indexedStack` |
| HTTP Client | `dio ^5.9.2` — **must be mocked** for this project (no live backend) |
| Functional Error Handling | `dartz ^0.10.1` — `Either<Failure, T>` throughout domain + data |
| Persistence (state) | `hydrated_bloc ^11.0.0` — for cubits that survive restarts |
| Equality | `equatable ^2.0.8` — all entities, models, states, and events must extend `Equatable` |
| ID Generation | `uuid ^4.5.3` |
| Testing | `flutter_test` (unit + widget), `mocktail` (mock dependencies) |

### Mandatory dev dependencies
- `mocktail` must be added for testing; `mockito` is **not** permitted.
- `flutter_lints` rules must pass with zero warnings on `flutter analyze`.

---

## 2. Architectural Mandates

### 2.1 Clean Architecture — Layer Rules

The project is organized by feature under `lib/features/<feature>/`. Every feature **must**
contain exactly three layers. Cross-layer import rules are enforced as follows:

```
Presentation  →  Domain  (allowed)
Data          →  Domain  (allowed)
Domain        →  nothing outside Domain  (no imports from Data or Presentation)
Presentation  →  Data    (FORBIDDEN)
Data          →  Presentation  (FORBIDDEN)
```

#### Domain layer (pure Dart, zero Flutter imports)
- `entities/` — immutable value objects extending `Equatable`. No `toJson`/`fromJson` here.
- `params/` — input objects for use cases; extend `Equatable`.
- `repo/` — **abstract** repository interfaces only. No implementation.
- `use_cases/` — one class per use case, extends `BaseUseCase<T, P>`, returns
  `Future<Either<Failure, T>>`. All business rules live here or in entities.

#### Data layer
- `models/` — JSON-serializable DTOs. Must implement `toJson`/`fromJson`.
- `mapper/` — converts Model ↔ Entity. Must be pure functions or stateless classes.
- `data_source/remote_data_source/` — Dio calls only; throws `DioException`, never returns raw JSON.
- `data_source/local_data_source/` — HydratedBloc / local storage only.
- `repo_impl/` — implements the domain repo interface; catches exceptions, maps to `Failure`.

#### Presentation layer
- `controllers/` — BLoC or Cubit; receives use cases via constructor injection; emits typed states.
- `screen/` — full-page widgets; listens to BLoC state; no business logic.
- `widgets/` — stateless/stateful UI components; no direct BLoC creation (use `context.read`).

### 2.2 SOLID Enforcement
- **SRP**: One class, one responsibility. Use cases do not validate AND execute — they delegate
  validation to domain entities or dedicated validators.
- **OCP**: Repository interfaces are open for extension (new impl) closed for modification.
- **LSP**: All repo implementations must be substitutable for their interface.
- **ISP**: No fat repository interfaces. If a repo grows beyond its feature, split it.
- **DIP**: Presentation and use cases depend on abstractions (repo interfaces), never on
  concrete `repo_impl` classes.

### 2.3 State Management Rules
- Every BLoC/Cubit must have a corresponding `State` class (sealed or abstract) with
  clearly named sub-states: `Initial`, `Loading`, `Success`, `Failure`.
- Events (for BLoC) and methods (for Cubit) must be descriptive and past-tense / imperative
  respectively (e.g., `TopUpRequested`, `loadBeneficiaries()`).
- **No business logic inside widgets or screens.** Widgets dispatch events; BLoCs compute.

### 2.4 Error Handling
- The `Failure` class (`lib/core/errors/failure.dart`) is the sole error carrier.
- Every repo `impl` wraps Dio calls in `try/catch` and maps `DioException` → `Failure`.
- Use cases propagate `Left<Failure>` upward; they never throw.
- The presentation layer must handle all three states: loading, success, and failure (with
  user-visible error messages).

### 2.5 Dependency Injection
- All registrations live in `lib/core/services/service_locator/init_controllers.dart`.
- New cubits/blocs must also be added to `lib/core/bloc/bloc_providers.dart`.
- Use `sl<T>()` in DI wiring only — never inside widgets or business logic.

---

## 3. Business Rules (Non-Negotiable)

These rules are derived directly from the PDF and must be enforced in the **domain layer**
use cases / entities. No exceptions. Any PR that implements these in the presentation layer
(e.g., disabling a button without a domain-level guard) will be rejected.

### BR-01 — Beneficiary Cap
> A user may have **at most 5 active top-up beneficiaries** at any time.
- Enforced in: `AddBeneficiaryUseCase`
- Trigger: Attempt to add a 6th beneficiary must return `Left(Failure)`.

### BR-02 — Beneficiary Nickname Length
> Each beneficiary's nickname must be **between 1 and 20 characters** (inclusive). No blank nicknames.
- Enforced in: `AddBeneficiaryUseCase` (param validation) or a dedicated `Beneficiary` entity factory.

### BR-03 — Valid Top-Up Amounts
> The only permitted top-up amounts (in AED) are: **5, 10, 20, 30, 50, 75, 100**.
> No other amounts are allowed.
- Enforced in: `TopUpUseCase`
- Represented as a constant list/enum in the domain layer.

### BR-04 — Transaction Fee
> Every top-up transaction incurs a **flat AED 3 service charge**.
> The fee is deducted from the user's balance **in addition to** the top-up amount.
> Total deducted = top-up amount + AED 3.
- Enforced in: `TopUpUseCase`

### BR-05 — Balance Sufficiency
> The user's balance must be **≥ (top-up amount + AED 3 fee)** before a transaction proceeds.
- Enforced in: `TopUpUseCase`

### BR-06 — Monthly Limit per Beneficiary (Unverified User)
> If `user.isVerified == false`: maximum **AED 500** top-up per beneficiary per calendar month.
- Enforced in: `TopUpUseCase`
- "Calendar month" = same year + same month as the transaction date.

### BR-07 — Monthly Limit per Beneficiary (Verified User)
> If `user.isVerified == true`: maximum **AED 1,000** top-up per beneficiary per calendar month.
- Enforced in: `TopUpUseCase`

### BR-08 — Total Monthly Cap (All Beneficiaries)
> Regardless of verification status, the user may not top up more than **AED 3,000 total**
> across all beneficiaries in a calendar month.
- Enforced in: `TopUpUseCase`
- Requires summing `Transaction` history for the current calendar month.

### BR-09 — Verification Status Source
> `user.isVerified` is a **read-only property** on the `UserEntity`. This app does **not**
> implement the verification flow; it only reads the flag.

### BR-10 — Top-Up Amount Ordering
> BR-05 (balance) is checked first, then BR-06/07 (per-beneficiary monthly limit),
> then BR-08 (total monthly cap). The first failing rule short-circuits and returns
> its specific `Failure` message.

---

## 4. Mocking Strategy

- The HTTP client (`Dio`) must be mocked. A `MockDioClient` (or equivalent) will live in
  `lib/features/<feature>/data/data_source/remote_data_source/` and return hardcoded
  JSON responses that simulate a real backend.
- The mock **must** supply a realistic `UserEntity` with `isVerified` set to both `true` and
  `false` so both paths can be tested.
- Mock data must include pre-existing transactions for the current calendar month to allow
  limit-enforcement tests to be meaningful.

---

## 5. Testing Requirements

- Minimum **80% coverage** on all domain use cases.
- Use `mocktail` for mocking repository interfaces in use case tests.
- Each business rule (BR-01 through BR-08) must have at least one dedicated unit test that
  exercises the **failure path** (i.e., the rule is violated and `Left(Failure)` is returned).
- Widget tests must cover the top-up flow's happy path and the "insufficient balance" error state.
- Test files mirror the `lib/` structure under `test/`.
