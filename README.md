# Top-Up App

A Flutter mobile application for managing phone top-ups to saved beneficiaries.

## Setup

1. Ensure Flutter SDK is installed (requires Dart SDK ^3.11.4).
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Running Tests

Run all tests:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

Run a single test file:
```bash
flutter test test/features/history/domain/top_up_use_case_test.dart
```

## Assumptions

- Mock backend: There is no real HTTP server. All data is served from hardcoded in-memory data sources that simulate REST responses.
- Pre-seeded data: The app launches with 2 pre-seeded beneficiaries and several transactions for the current calendar month.
- Default user state: The mock user starts with balance: 1500.0 and isVerified: true. These values can be changed in UserRemoteDataSource.
- Balance persistence: User balance is updated in-memory via UserCubit.deductBalance() after each successful top-up. It resets to the mock value on app restart.
- Transaction persistence: New top-ups are appended to TransactionCubit state in-memory. They are not persisted to any local or remote store and reset on restart.
- No real navigation guards: The TopUpScreen is accessible for any beneficiary regardless of monthly limit status — limits are enforced by the domain use case and surfaced as error messages.
