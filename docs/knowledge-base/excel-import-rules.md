# Excel Import Rules — Lotto Fullstack

## Library

- Use **SheetJS (`xlsx`)** in the admin dashboard for CSV/Excel bulk upload.

## Pipeline (required order)

1. **Select lottery type** (Lotto 6 or Lotto 7) — required before file pick
2. **Upload / pick file** (client)
3. **Preview** parsed rows in a table (no DB writes yet)
4. **Validate** required columns, types, lottery type, date formats, number ranges
5. **Duplicate detection** against existing `(lottery_type, draw_number)` (and in-file dupes)
6. **Conflict decision** when overlaps exist — admin chooses **Keep existing** (default) or **Replace with file**
7. **Confirm import** → insert (and optionally update) via Supabase as **drafts** (`is_published = false`)
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

### Lotto 6 (sample: `docs/Appli LOTO6.xlsx`)

| Header aliases                         | Field          |
| -------------------------------------- | -------------- |
| Time / 回別 / draw / drawNumber        | draw number    |
| Date / 抽せん日 / drawDate             | draw date      |
| Loto1–6 / 本数字1–6                    | main numbers   |
| bonus / ボーナス数字                   | 1 bonus        |

- Ranges: mains and bonus **1–43**
- Counts: **6** mains + **1** bonus

### Lotto 7 (mirrored layout; adjust if client sample differs)

| Header aliases                                      | Field          |
| --------------------------------------------------- | -------------- |
| Time / 回別 / draw / drawNumber                     | draw number    |
| Date / 抽せん日 / drawDate                          | draw date      |
| Loto1–7 / 本数字1–7                                 | main numbers   |
| bonus / bonus1 / ボーナス数字 / ボーナス数字1        | bonus 1        |
| bonus2 / ボーナス数字2                              | bonus 2        |

- Ranges: mains and bonus **1–37**
- Counts: **7** mains + **2** bonus

Preferred sheet name: `Sample data` (falls back to first sheet).

## Rules

- Never write to the database during preview.
- Keep parsing logic in `services/excel-import-service.ts` (`parseLotteryWorkbook`).
- Show clear per-row notes; default overlap choice is **Keep existing**.
- Re-import of the same draw number for the same lottery type upserts when Replace is chosen (no duplicate rows).
- After import, deep-link to `/draws?type=lotto6|lotto7&status=draft` for review + bulk publish.
