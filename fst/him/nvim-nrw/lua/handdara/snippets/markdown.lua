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
tags: []
curr_mo_link: "{1}"
---
# {2}

{3}

## quests
### daily adventures
- [ ]   1. {4}
- [ ]   2. {5}
- [ ]   3. {6}
### side-quests
- [ ] {7}

## log
- {8}
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
        i(1, '#? ...'),
        i(2, '#? ...'),
        i(3, '#? ...'),
        i(4, '#? ...'),
        i(5, '...'),
    }))
end))
use(sdaily)

local btask = [[
---
id: {1}-{2}
aliases: []
tags:
  - {4}-{5}/def
  - {9}
  - {10}
created: {7}
description: {3}
due: ~
edited: {8}
location: ~
notes: []
priority: 1
repos:
{11}
subtasks: []
type: task
---
# {6}

]]
local snTask = sn(1, d(1, function()
    local ts = u.timestamp()
    local dateTxt = ts.dy .. ts.mo .. ts.yr
    local timeTxt = ts.hr .. ':' .. ts.mi
    local dtText = dateTxt .. ' ' .. timeTxt
    return sn(nil, fmt(btask, {
        i(1, 'project'),
        i(2, '#'),
        i(3, 'destroy the one ring'),
        rep(1),
        rep(2),
        rep(3),
        t(dtText),
        t(dateTxt),
        mkCStatuses(4),
        mkCStacheContexts(5),
        t({ "  - ring-bearer:",
            "      branches: dev-frodo",
            "      org: fellowship-of-the-ring"}),
    }))
end))

local bContact = [[
---
id: {1}
aliases: []
tags: []
created: {2}
description: {3}
edited: {4}
notes: []
type:  contact
---
# {5}
]]
local snContact = sn(1, d(1, function()
    local ts = u.timestamp()
    local dateTxt = ts.dy .. ts.mo .. ts.yr
    local timeTxt = ts.hr .. ':' .. ts.mi
    local dtText = dateTxt .. ' ' .. timeTxt
    return sn(nil, fmt(bContact, {
        i(1, 'frodo-baggins'),
        t(dtText),
        t(dateTxt),
        i(2, 'Frodo Baggins'),
        rep(2),
    }))
end))

use(s('stache', { c(1, {
    snTask,
    snContact,
})}))

for _, val in ipairs(filetypes) do
    local function mkCodeBlockSnip(ft)
        return s(ft, { t { '```' .. ft, '' }, i(1), t { '', '```' } })
    end
    use(mkCodeBlockSnip(val))
end
use(s('codeblock', { t { '```', '' }, i(1), t { '', '```' } }))

ls.add_snippets("markdown", S)
ls.add_snippets("telekasten", S)
