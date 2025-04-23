---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "markdown"
require('luasnip.session.snippet_collection').clear_snippets "telekasten"
local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local extras = require 'luasnip.extras'
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local u = require 'handdara.util'
local stache = require('handdara.util.stache')

local S = {}
local function use(snip)
    table.insert(S, snip)
end

local filetypes = { 'yaml', 'just', 'lua', 'markdown', 'matlab', 'nix', 'tex', 'zig', 'rust', 'python', 'fish', 'bash',
    'haskell' }

local sdateheader = s('dateheader', {
    f(function()
        local ts = u.timestamp()
        return '## ' .. ts.dy .. ts.mo .. ts.yr .. ', ' .. ts.wd
    end),
    -- t(""),
})
use(sdateheader)

local bDaily = [[
---
aliases: []
tags:
  - daily-notes
curr_mo_link: "{1}"
---
# {2}

{3}

```lua
Handdara.stache.task_board{{stexcl = true, archived = true, closed = true, scheduled = false}}
```

## quests
{9}
### daily adventures
- [ ]   1. {4}
- [ ]   2. {5}
- [ ]   3. {6}
### side-quests
- [ ] {7}

## log
{8}
]]
local monSched = [[
|      | mon          |
|------|--------------|
| 0600 | ⬛️ sleep     |
| 0700 | ⬛️ sleep     |
| 0800 | ⬛️ sleep     |
| 0900 | 🟦 wind-up   |
| 1000 | ⬜           |
| 1100 | 🟦 commute   |
| 1200 | 🟥 thesis    |
| 1300 | 🟥 thesis    |
| 1400 | 🟥 thesis    |
| 1500 | 🟥 thesis    |
| 1600 | 🟧 thesis    |
| 1700 | 🟦 commute   |
| 1800 | 🟨 therapy   |
| 1900 | 🟩 exercise  |
| 2000 | 🟨 dinner    |
| 2100 | 🟨 10x       |
| 2200 | 🟦 wind-down |
| 2300 | ⬛️ sleep     |]]
local tueSched = [[
|      | tue          |
|------|--------------|
| 0600 | ⬛️ sleep     |
| 0700 | ⬛️ sleep     |
| 0800 | ⬛️ sleep     |
| 0900 | 🟦 wind-up   |
| 1000 | 🟩 10x       |
| 1100 | 🟩 10x       |
| 1200 | 🟦 commute   |
| 1300 | 🟥 thesis    |
| 1400 | 🟥 thesis    |
| 1500 | 🟥 thesis    |
| 1600 | 🟧 thesis    |
| 1700 | 🟦 commute   |
| 1800 | ⬜           |
| 1900 | 🟩 exercise  |
| 2000 | 🟨 dinner    |
| 2100 | ⬜           |
| 2200 | 🟦 wind-down |
| 2300 | ⬛️ sleep     |]]
local wedSched = [[
|      | wed            |
|------|----------------|
| 0600 | ⬛️ sleep       |
| 0700 | ⬛️ sleep       |
| 0800 | ⬛️ sleep       |
| 0900 | 🟦 wind-up     |
| 1000 | ⬜             |
| 1100 | 🟦 commute     |
| 1200 | 🟥 thesis/seal |
| 1300 | 🟥 thesis/seal |
| 1400 | 🟧 thesis/seal |
| 1500 | 🟥 seal/thesis |
| 1600 | 🟥 seal/thesis |
| 1700 | 🟦 commute     |
| 1800 | ⬜             |
| 1900 | 🟦 hang w riss |
| 2000 | 🟦 hang w riss |
| 2100 | 🟦 hang w riss |
| 2200 | 🟦 wind-down   |
| 2300 | ⬛️ sleep       |]]
local thuSched = [[
|      | thu          |
|------|--------------|
| 0600 | ⬛️ sleep     |
| 0700 | ⬛️ sleep     |
| 0800 | ⬛️ sleep     |
| 0900 | 🟦 wind-up   |
| 1000 | ⬜           |
| 1100 | 🟦 commute   |
| 1200 | 🟥 seal      |
| 1300 | 🟥 seal      |
| 1400 | 🟥 seal      |
| 1500 | 🟥 seal      |
| 1600 | 🟥 seal      |
| 1700 | 🟧 seal      |
| 1800 | 🟦 commute   |
| 1900 | 🟩 exercise  |
| 2000 | 🟨 dinner    |
| 2100 | 🟦 fun       |
| 2200 | 🟦 wind-down |
| 2300 | ⬛️ sleep     |]]
local friSched = [[
|      | fri           |
|------|---------------|
| 0600 | ⬛️ sleep      |
| 0700 | ⬛️ sleep      |
| 0800 | ⬛️ sleep      |
| 0900 | 🟦 wind-up    |
| 1000 | ⬜            |
| 1100 | 🟦 commute    |
| 1200 | 🟦 seal lunch |
| 1300 | 🟥 seal       |
| 1400 | 🟥 seal       |
| 1500 | 🟥 seal       |
| 1600 | 🟧 seal       |
| 1700 | 🟦 commute    |
| 1800 | ⬜            |
| 1900 | 🟩 exercise   |
| 2000 | 🟨 dinner     |
| 2100 | 🟨 2x         |
| 2200 | 🟦 wind-down  |
| 2300 | ⬛️ sleep      |]]
local satSched = [[
|      | sat             |
|------|-----------------|
| 0600 | ⬛️ sleep        |
| 0700 | ⬛️ sleep        |
| 0800 | ⬛️ sleep        |
| 0900 | 🟦 wind-up      |
| 1000 | 🟨 2x           |
| 1100 | ⬜              |
| 1200 | 🟩 10x          |
| 1300 | 🟩 10x          |
| 1400 | 🟦 lunch        |
| 1500 | 🟨 2x           |
| 1600 | 🟩 long workout |
| 1700 | 🟩 long workout |
| 1800 | 🟩 date night   |
| 1900 | 🟩 date night   |
| 2000 | 🟩 date night   |
| 2100 | 🟩 date night   |
| 2200 | 🟦 wind-down    |
| 2300 | ⬛️ sleep        |]]
local sunSched = [[
|      | sun                  |
|------|----------------------|
| 0600 | ⬛️ sleep             |
| 0700 | ⬛️ sleep             |
| 0800 | ⬛️ sleep             |
| 0900 | 🟦 wind-up           |
| 1000 | 🟪 boundary/planning |
| 1100 | 🟨 family call       |
| 1200 | ⬜ Rest Day          |
| 1300 | ⬜ Rest Day          |
| 1400 | ⬜ Rest Day          |
| 1500 | ⬜ Rest Day          |
| 1600 | ⬜ Rest Day          |
| 1700 | ⬜ Rest Day          |
| 1800 | ⬜ Rest Day          |
| 1900 | ⬜ Rest Day          |
| 2000 | ⬜ Rest Day          |
| 2100 | ⬜ Rest Day          |
| 2200 | 🟦 wind-down         |
| 2300 | ⬛️ sleep             |]]
local daySchedules = { sunSched, monSched, tueSched, wedSched, thuSched, friSched, satSched }
local sdaily = s('daily', d(1, function()
    local ts = u.timestamp()
    return sn(nil, fmt(bDaily, {
        t('[[p' .. u.dtnum2str(ts.mo_num) .. '-' .. ts.mo .. '-' .. ts.yr .. ']]'),
        t(ts.dy .. ts.mo .. ts.yr .. ', ' .. ts.wd),
        daySchedules[ts.wd_num],
        i(1, '...'),
        i(2, '...'),
        i(3, '...'),
        i(4, '...'),
        i(5),
        t('-   [[daily-quests]]'),
    }))
end))
use(sdaily)

local bweekly = [[
### WK{1}-2025, week of {4}

| M      | T      | W           | R    | F    | S     | N   |
|--------|--------|-------------|------|------|-------|-----|
| thesis | thesis | thesis/seal | seal | seal | piano |     |

#### affirms & active investments
#todo, see {2}

#### goals
#todo, see {3}

#### reflection

##### wheel of life

health:
-   body
    -   how im doing in general: {5}
    -   how well i did this past week: {6}
-   mind
    -   how im doing in general: {7}
    -   how well i did this past week: {8}
-   soul
    -   how im doing in general: {9}
    -   how well i did this past week: {10}
work:
-   mission
    -   how im doing in general: {11}
    -   how well i did this past week: {12}
-   money
    -   how im doing in general: {13}
    -   how well i did this past week: {14}
-   growth
    -   how im doing in general: {15}
    -   how well i did this past week: {16}
relationships:
-   family
    -   how im doing in general: {17}
    -   how well i did this past week: {18}
-   romance
    -   how im doing in general: {19}
    -   how well i did this past week: {20}
-   friends
    -   how im doing in general: {21}
    -   how well i did this past week: {22}

]]
local dweekly = d(1, function()
    local ts = u.timestamp()
    return sn(nil, fmt(bweekly, {
        t(u.dtnum2str( ts.wk+1 )),
        t({ '[[affirms-vals-goals]]', 'also [[quarterly-goals-2025#list of possible personal investments]]' }),
        t('[[quarterly-goals-2025#Quarter ' .. ts.qt .. ' Goals]]'),
        i(1, 'DDmmmYYYY'),
        c(2, {t'1', t'2', t'3', t'4', }),
        c(3, {t'1', t'2', t'3', t'4', }),
        c(4, {t'1', t'2', t'3', t'4', }),
        c(5, {t'1', t'2', t'3', t'4', }),
        c(6, {t'1', t'2', t'3', t'4', }),
        c(7, {t'1', t'2', t'3', t'4', }),
        c(8, {t'1', t'2', t'3', t'4', }),
        c(9, {t'1', t'2', t'3', t'4', }),
        c(10, {t'1', t'2', t'3', t'4', }),
        c(11, {t'1', t'2', t'3', t'4', }),
        c(12, {t'1', t'2', t'3', t'4', }),
        c(13, {t'1', t'2', t'3', t'4', }),
        c(14, {t'1', t'2', t'3', t'4', }),
        c(15, {t'1', t'2', t'3', t'4', }),
        c(16, {t'1', t'2', t'3', t'4', }),
        c(17, {t'1', t'2', t'3', t'4', }),
        c(18, {t'1', t'2', t'3', t'4', }),
        c(19, {t'1', t'2', t'3', t'4', }),
    }))
end)
use(s('wkly', dweekly))

for _, val in ipairs(filetypes) do
    local function mkCodeBlockSnip(ft)
        return s(ft, { t { '```' .. ft, '' }, i(1), t { '', '```' } })
    end
    use(mkCodeBlockSnip(val))
end
use(s('codeblock', { t { '```', '' }, i(1), t { '', '```' } }))

use(s('tasks', { t {
    '```lua',
    'Handdara.stache.task_board{stexcl = true, archived = true, closed = true, scheduled = false}',
    '```',
} }))

use(s('inv-items', {t {
'```lua',
'local queries = {',
        '{type = "stache", data = {"inventory"}},',
'}',
'local res = Handdara.stache.ask(queries)',
'Handdara.stache.print_result(res)',
'```',
}}))

ls.add_snippets("markdown", S)
ls.add_snippets("telekasten", S)
