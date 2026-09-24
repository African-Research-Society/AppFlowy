# AppFlowy audit (second pass)

## Coverage Matrix

| Subsystem | Depth | Notes |
| --- | --- | --- |
| Cloud HTTP client (`client-api`) | Deep | `http.rs` verify URL, blob client, websocket v2 token |
| Flutter cloud sign-in task | Deep | `appflowy_cloud_task.dart` deep link |
| Server glue `flowy-server` | Light | Confirms it uses client-api |
| ARS rebrand commit | Deep | Scheme and share host only |
| Editor, grids, AI UI, local SQLite | Not applicable | Not the network boundary ARS inherits. Data still syncs through the client-api path above |

## Findings

The desktop app calls `GET /api/user/verify/{access_token}` and can use websocket v2 with `token` in the query. Blob downloads send a bearer token, but Cloud does not require it. The ARS rebrand commit does not add secrets. OAuth return uses `ars-workspace://login-callback#access_token=...`, which is the normal fragment pattern and can still show up in OS logs.

No change was made here. The protocol lives in AppFlowy-Cloud and this client together. Patching only one side breaks sign-in.

## Fixed Findings

None in this repository.

## Unfixed Findings

Token-in-path and unauthenticated blob GET. Owned by the Cloud service. See that repo’s summary.

## Security

Inherited from the Cloud API the app is pinned to (`African-Research-Society/AppFlowy-Cloud` in `frontend/rust-lib/Cargo.toml`).

## Database Integrity

Local SQLite was not audited.

## Authentication

Cloud sign-in task and client-api verify.

## Authorization

Enforced on the server, and only if access control is enabled there.

## Bugs

None unique to the rebrand.

## Race Conditions

Not examined.

## Vestigial Code

Not swept across the Flutter tree. A repo-wide unused-widget hunt would not change the network risk.

## Mapping/Consistency Problems

Share links point at `workspace.africanresearchsociety.org`. That host must match the deployed web app.

## Compatibility

The crate pin must move together with Cloud if verify or blob auth changes.

## Dependencies

Pin recorded. No upgrade.

## Performance

Not examined.

## Accessibility

Not examined. Out of the security scope of this pass.

## Testing

Not rebuilt.

## Cross-Repository Findings

See Cloud summary. AfriNexus hands the browser a magic link; the desktop app uses the verify path directly.

## Product Decisions Required

Whether the desktop client is still shipped. If it is, schedule a joint change: header verify, authenticated blob GET.

## Remaining Risks

Anyone with a blob URL can fetch the file from the current Cloud build.

## Areas Where Audit Confidence Is Low

Which websocket version production desktop builds actually negotiate.

## Verification

Read the client-api and cloud task sources. No Flutter build.

## Metrics

- Network-path files opened: client-api http, blob, ws v2, user.rs, file_storage.rs, appflowy_cloud_task.dart, Cargo pin.
- Editor and database UI: excluded, named above.
- Code fixes: 0.
