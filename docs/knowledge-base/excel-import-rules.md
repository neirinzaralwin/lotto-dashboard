# Excel Import Rules — Lotto Fullstack

## Library

- Use **SheetJS (`xlsx`)** in the admin dashboard for CSV/Excel bulk upload.

## Pipeline (required order)

1. **Upload / pick file** (client) — lottery type is **detected from the workbook**
2. **Map collections** — sheets named like `new loto6` / `new loto7`, or inferred from headers (column `7` / Bonus2 → Lotto 7). One or both may be present.
3. **Preview** parsed rows — tabs **All** (when both collections exist) + **Lotto 6** / **Lotto 7**; no DB writes yet
4. **Validate** required columns, types, lottery type, date formats, number ranges
5. **Duplicate detection** against existing `(lottery_type, draw_number)` (and in-file dupes) **per collection**
6. **Conflict decision** when overlaps exist — admin chooses **Keep existing** (default) or **Replace with file**
7. **Confirm import** → insert (and optionally update) via Supabase as **drafts** (`is_published = false`) for all detected types
8. **Error report** for skipped/failed rows (Needs fix / Repeated in file)
9. **Publish** from Draws when ready — row-level or **Bulk publish** for filtered drafts (mobile only sees published)

## Plain-language row statuses (UI)

| Internal       | Admin label      | On confirm                                      |
| -------------- | ---------------- | ----------------------------------------------- |
| `new`          | New              | Always imported as draft                        |
| `will_update`  | Already saved    | Imported only if Replace with file is selected  |
| `in_file_dupe` | Repeated in file | Never imported (last row of that draw wins)     |
| `invalid`      | Needs fix        | Never imported                                  |

## Conflict period summary

Preview includes:

- **File covers** — earliest → latest date among importable rows
- **Conflict card** (when `will_update > 0`) — count, draw-number span, existing date period, file date period for those rows
- Confirm button copy reflects Keep vs Replace counts

Use `listExistingDrawSummaries` (draw number + date) so overlap periods are accurate. `previewToUpsertPayload(preview, { replaceExisting })` filters updates.

## Column contracts

Canonical admin workbook: `docs/sample.xlsx` (sheets `new loto6` / `new loto7`).

### Lotto 6

| Header aliases                                      | Field          |
| --------------------------------------------------- | -------------- |
| 回/Time / Time / 回 / 回別 / draw / drawNumber      | draw number    |
| 抽せん日/Date / Date / 抽せん日 / drawDate           | draw date      |
| 1–6 / Loto1–6 / 本数字1–6                           | main numbers   |
| Bonus / bonus / ボーナス数字                        | 1 bonus        |

- Ranges: mains and bonus **1–43**
- Counts: **6** mains + **1** bonus

### Lotto 7

| Header aliases                                      | Field          |
| --------------------------------------------------- | -------------- |
| 回/Time / Time / 回 / 回別 / draw / drawNumber      | draw number    |
| 抽せん日/Date / Date / 抽せん日 / drawDate           | draw date      |
| 1–7 / Loto1–7 / 本数字1–7                           | main numbers   |
| Bonus1 / bonus / bonus1 / ボーナス数字 / ボーナス数字1 | bonus 1      |
| Bonus2 / bonus2 / ボーナス数字2                     | bonus 2        |

- Ranges: mains and bonus **1–37**
- Counts: **7** mains + **2** bonus

Preferred sheet: name matching `loto6` / `loto7`. If the name is ambiguous (e.g. `Sample data`), headers decide the type. Non-results sheets (search samples) are skipped. A workbook may contain **one or both** collections; each type is imported at most once per file.

Use `parseLotteryWorkbookCollections` for auto-detect; `parseLotteryWorkbook(buffer, type)` still filters to one type.

## Rules

- Never write to the database during preview.
- Keep parsing logic in `services/excel-import-service.ts` (`parseLotteryWorkbookCollections` / `parseLotteryWorkbook`).
- Show clear per-row notes; default overlap choice is **Keep existing**.
- Re-import of the same draw number for the same lottery type upserts when Replace is chosen (no duplicate rows).
- After import, deep-link to `/draws?status=draft` (or a single type when only one was imported) for review + bulk publish.
- Dates are read as Excel serials (not JS `Date`) so calendar days stay correct for JST source files.
- Duplicate detection is by normalized `(lottery_type, draw_number)` — plain integers (`1`) and `第1回` both normalize to `"1"`.
- **Upcoming placeholders** — rows with only `回/Time` filled (date + numbers blank) are skipped silently; they are reserved future draws, not “Needs fix”.
