# Roadmap — what to improve

## High value
1. Shared DXL library: factor envOr, csvField, logging, safe attribute read into
   dxl/lib/common.inc.dxl, included via #include. Removes copy-paste.
2. Richer module listing: add columns to list_my_modules — module type, object
   count, last-modified, and effective access (R/RM/RMCD). Emit CSV.
3. Root-folder traversal: catch modules in folders at the database root, outside
   any project (recursive folder descent).
4. Guaranteed UTF-8 output: option to write a UTF-8 BOM and convert strings so
   output is portable regardless of DB codepage. Keep the 1254 console fix.

## Medium
5. Exit codes + structured logging (severity, quiet/verbose via env var).
6. Config file (.ini/.conf, UTF-8) instead of only env vars.
7. Traceability export: walk link modules for source/target object pairs.
8. Baseline-aware export (export from a named baseline).

## Guardrails (do not regress)
- Batch-safe: no GUI calls; helpers defined before use.
- Never let an int/real/Date be the trailing token in a concatenation.
- Default to read-only module access; edit() only when intentional.
- Never write to the server's physical data directory; use dbadmin.
