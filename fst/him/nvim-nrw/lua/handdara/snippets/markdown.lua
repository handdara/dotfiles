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

local sdateheader = s('dateheader', {
    f(function()
        local ts = u.timestamp()
        return '## ' .. ts.dy .. ts.mo .. ts.yr .. ', ' .. ts.wd
    end),
    -- t(""),
})

local bDaily = [[
---
curr_mo_link: {1}
---
# {2}

{3}

## quests

### daily adventure
- [ ] {4}

### side-quests
- [ ] {5}

## log
- {6}
]]
local monSched = [[
|   day plan |         Mon          |
|-----------:|:--------------------:|
|  0830-1030 | Exercise, breakfast  |
|  1030-1600 |    Work at :ccrf:    |
|  1600-1630 |   Commuting to GT    |
|  1630-1830 | Reading papers at GT |
|  1830-2330 |  Anything but work   |
|  2330-0000 |   No more screens!   |]]
local tueSched = [[
|   day plan |         Tue          |
|-----------:|:--------------------:|
|  0830-1030 | Exercise, breakfast  |
|  1030-1600 |      Work at GT      |
|  1600-1630 |      Work at GT      |
|  1630-1830 | Reading papers at GT |
|  1830-2330 |  Anything but work   |
|  2330-0000 |   No more screens!   |]]
local wedSched = [[
|   day plan |         Wed          |
|-----------:|:--------------------:|
|  0830-1030 | Exercise, breakfast  |
|  1030-1600 |    Work at :ccrf:    |
|  1600-1630 |   Commuting to GT    |
|  1630-1830 | Reading papers at GT |
|  1830-2330 |  Anything but work   |
|  2330-0000 |   No more screens!   |]]
local thuSched = [[
|   day plan |         Thu          |
|-----------:|:--------------------:|
|  0830-1030 | Exercise, breakfast  |
|  1030-1600 |      Work at GT      |
|  1600-1630 |      Work at GT      |
|  1630-1830 | Reading papers at GT |
|  1830-2330 |  Anything but work   |
|  2330-0000 |   No more screens!   |]]
local friSched = [[
|   day plan |         Fri          |
|-----------:|:--------------------:|
|  0830-1030 | Exercise, breakfast  |
|  1030-1600 |    Work at :ccrf:    |
|  1600-1630 |   Commuting to GT    |
|  1630-1830 | Reading papers at GT |
|  1830-2330 |  Anything but work   |
|  2330-0000 |   No more screens!   |]]
local satSched = 'No schedule made yet.'
local sunSched = 'No schedule made yet.'
local daySchedules = { sunSched, monSched, tueSched, wedSched, thuSched, friSched, satSched, }
local sDaily = s('daily', d(1, function()
    local ts = u.timestamp()
    return sn(nil, fmt(bDaily, {
        t('[[p' .. u.dtnum2str(ts.mo_num) .. '-' .. ts.mo .. '-' .. ts.yr .. ']]'),
        t(ts.dy .. ts.mo .. ts.yr .. ', ' .. ts.wd),
        daySchedules[ts.wd_num],
        i(1, ':?: ...'),
        i(2, ':?: ...'),
        i(3, ':?: ...'),
    }))
end))

local snips = {
    sdateheader,
    sDaily,
}

ls.add_snippets("markdown", snips)
ls.add_snippets("telekasten", snips)
