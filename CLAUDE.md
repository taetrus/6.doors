# DOORS DXL Toolkit — Project Guide for Claude Code

This file encodes the environment, conventions, and hard-won DXL rules for this
project. Follow it before writing or editing any `.dxl` or `.bat` file.

## Purpose
Batch-mode DXL automation for IBM Rational DOORS 9.7.
- `dxl/list_my_modules.dxl` — lists every formal module the running user can
  access, across all projects, to a text file.
- `dxl/batch_export.dxl` — opens a formal module read-only and exports its
  objects (id, number, level, heading, text) to CSV with a run log.
Both are launched headless from `.bat` wrappers in `scripts/`.

## Environment (assume all of this)
- IBM Rational DOORS 9.7, Windows client, database on a server (connect via
  `port@server`, default port 36677).
- Air-gapped corporate network. No external package access at runtime.
- Turkish locale. Names contain ç ğ ı İ ö ş ü. DB legacy ANSI codepage is
  Windows-1254; the cmd console default is OEM 857, which is why console output
  mojibakes (the output files themselves are correct).
- Scripts run under the logged-in user's permissions — deliberate; it makes
  "modules I can access" accurate. Do not assume an Admin account.

## DXL conventions — MUST FOLLOW
1. Concatenation rule: in juxtaposition concatenation, an int/real/Date must
   never be the LAST token — always follow it with a string, or you get
   `incorrectly concatenated tokens`. `today() ""` good; `"" today()` bad;
   `"Total: " count ""` good; `"Total: " count` bad.
2. Batch-safe only: no GUI calls (infoBox/dialogs). Output to files; use `print`
   only for console progress.
3. Define helper functions before any code that calls them (forward references
   can fail in batch with `CreateProcess failed`). Keep MAIN last.
4. One statement per line for concatenations — DXL ends the statement at the
   newline and silently drops a split continuation.
5. Open modules read-only unless writing: `read(path, false)`; guard with
   `if (null m)`; `noError()`/`lastError()`; always `close(m)`.
6. Never touch the server's physical data directory; use `dbadmin`.
7. Encoding: files inherit the DB legacy codepage (1254). Fix console display in
   the .bat with `chcp 1254` (or `chcp 65001` if the DB is Unicode/UTF-8).

## DXL cheatsheet
- Walk DB: `for proj in database do { for itm in proj do { ... } }` (inner loop
  recurses all levels within a project).
- Item: `type itm` ("Formal"/"Link"/"Descriptive"/"Folder"/"Project"),
  `name itm`, `fullName itm`.
- Object: `identifier(o)`, `number(o)`, `level(o)`, `o."Object Text"`.
- Attribute exists: `AttrDef ad = find(module(o), "Attr"); if (null ad) ...`.
- Files: `Stream s = write path` / `append path`; `s << "..."`; `close s`.
- Params: `getenv("VAR")` (null string if unset).
- Caveat: `for proj in database` misses modules in folders at the DB root
  (outside any project).

## When extending
See ROADMAP.md. Prefer factoring shared helpers (envOr, csvField, logging, safe
attribute read) into one included DXL library rather than copy-pasting.
