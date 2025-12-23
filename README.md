# employees_app

Diffusely case-study.

## Features implemented

- Core CRUD operations on Employees list
- Offline support with local caching & optimistic UI (change validated locally, API call performed afterwards)
- Employees list pull-to-refresh
- Error management with custom error messages

## Architecture

- State-management using Riverpod
- Models with generated code using freezed + json_serializable
- Localization relies on easy_localization
- 3 layers as per Clean Architecture : presentation, domain, data
- Mocked data repository (for Employees API)
- Navigation using Navigator 2.0 through go_router package
- Local persistence database using sembast

## Further improvements axis

- No true databases reconciliation strategy implemented. Caching is rolled back if an operation fails. Could be possible to store queue operations to pass when possible
- Connectivity-aware service to resolve remote database proactively.
- Expand on the testing strategies
