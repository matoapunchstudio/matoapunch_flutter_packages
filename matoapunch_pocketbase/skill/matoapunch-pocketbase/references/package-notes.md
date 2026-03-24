# Package Notes

## Public entrypoint

- Import: `package:matoapunch_pocketbase/matoapunch_pocketbase.dart`
- Main facade: `MatoapunchPocketbase`

## Current recommended API

- `MatoapunchPocketbase().init()`
- `MatoapunchPocketbase().user`
- `MatoapunchPocketbase().admin`
- `MatoapunchPocketbase().userClient`
- `MatoapunchPocketbase().adminClient`
- Legacy aliases:
  - `pbUser`
  - `pbAdmin`

## Auth client structure

- Shared auth flow lives in `lib/src/singletons/_pb_auth_client.dart`
- User-specific behavior lives in `lib/src/singletons/pb_singleton.dart`
- Admin-specific behavior lives in `lib/src/singletons/pb_admin_singleton.dart`

Each auth client supports:
- `setup()`
- `refresh()`
- `updateAuth(RecordAuth auth)`
- `loginWithEmailAndPassword(String email, String password)`
- `pocketBase`

User client also supports:
- `simulateLogin()`

## Behavior expectations

- Accessing a client before `init()` should throw a clear `StateError`.
- Failed refresh clears stale auth state and rebuilds an unauthenticated client.
- Auth tokens are persisted in `shared_preferences`.
- `PbErrorMessage.fromExceptionResponse(...)` should parse defensively.

## Environment variables

- Required:
  - `PB_BASE_URL`
- Optional local-development helpers:
  - `PB_SIMULATED_EMAIL`
  - `PB_SIMULATED_PASSWORD`

## Validation

After code changes, run:

```sh
flutter analyze
flutter test
```
