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
local stache = require('stache')

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

-- local bweekly = [[
-- ### WK{1}-2025, week of {4}
--
-- | M      | T      | W           | R    | F    | S     | N   |
-- |--------|--------|-------------|------|------|-------|-----|
-- | thesis | thesis | thesis/seal | seal | seal | piano |     |
--
-- #### affirms & active investments
-- #todo, see {2}
--
-- #### goals
-- #todo, see {3}
--
-- #### reflection
--
-- ##### wheel of life
--
-- health:
-- -   body
--     -   how im doing in general: {5}
--     -   how well i did this past week: {6}
-- -   mind
--     -   how im doing in general: {7}
--     -   how well i did this past week: {8}
-- -   soul
--     -   how im doing in general: {9}
--     -   how well i did this past week: {10}
-- work:
-- -   mission
--     -   how im doing in general: {11}
--     -   how well i did this past week: {12}
-- -   money
--     -   how im doing in general: {13}
--     -   how well i did this past week: {14}
-- -   growth
--     -   how im doing in general: {15}
--     -   how well i did this past week: {16}
-- relationships:
-- -   family
--     -   how im doing in general: {17}
--     -   how well i did this past week: {18}
-- -   romance
--     -   how im doing in general: {19}
--     -   how well i did this past week: {20}
-- -   friends
--     -   how im doing in general: {21}
--     -   how well i did this past week: {22}
--
-- ]]
local bweekly = [=[
## planning for WK{1}

- [ ]   calculating remaining hours needed at gtri for the month
- [ ]   reflecting on the prev week
    -   including the wheel of life exercise
- [ ]   reviewing [[affirms-vals-goals]] and setting one affirmation in my wkly affirm iphone note
- [ ]   reviewing quarterly goals (see [[quarterly-goals-2025#spring-goals]])
- [ ]   review calendar for the week
- [ ]   review  task board:
    ```lua
    Handdara.stache.task_board()
    ```
- [ ]   go through pocket notebook for unfinished tasks
- [ ]   set out weekly goals
    - [ ]   setup alistair page for goals and add [[weekly-quests]] to it
        -   i have a list for [[my-space#weekly-upkeep]] on my watch
        -   includ hours of work each day
- [ ]   clear garmin weekly upkeep checklist
- [ ]   plan meals/exercise for the week

]=]
local dweekly = d(1, function()
    local ts = u.timestamp()
    return sn(nil, fmt(bweekly, {
        t(u.dtnum2str(ts.wk + 1)),
        -- t({ '[[affirms-vals-goals]]', 'also [[quarterly-goals-2025#list of possible personal investments]]' }),
        -- t('[[quarterly-goals-2025#Quarter ' .. ts.qt .. ' Goals]]'),
        -- i(1, 'DDmmmYYYY'),
        -- c(2, {t'1', t'2', t'3', t'4', }),
        -- c(3, {t'1', t'2', t'3', t'4', }),
        -- c(4, {t'1', t'2', t'3', t'4', }),
        -- c(5, {t'1', t'2', t'3', t'4', }),
        -- c(6, {t'1', t'2', t'3', t'4', }),
        -- c(7, {t'1', t'2', t'3', t'4', }),
        -- c(8, {t'1', t'2', t'3', t'4', }),
        -- c(9, {t'1', t'2', t'3', t'4', }),
        -- c(10, {t'1', t'2', t'3', t'4', }),
        -- c(11, {t'1', t'2', t'3', t'4', }),
        -- c(12, {t'1', t'2', t'3', t'4', }),
        -- c(13, {t'1', t'2', t'3', t'4', }),
        -- c(14, {t'1', t'2', t'3', t'4', }),
        -- c(15, {t'1', t'2', t'3', t'4', }),
        -- c(16, {t'1', t'2', t'3', t'4', }),
        -- c(17, {t'1', t'2', t'3', t'4', }),
        -- c(18, {t'1', t'2', t'3', t'4', }),
        -- c(19, {t'1', t'2', t'3', t'4', }),
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

local function mkCBasic(idx, opts, custom)
    local ts = {}
    for _, val in ipairs(opts) do
        table.insert(ts, t(val))
    end
    if custom then
        table.insert(ts, 1, i(1, custom))
    end
    return c(idx, ts)
end

local function mkStacheFilt(idx)
    return c(idx,
         {
            { i(1), t 'STACHE ', mkCBasic(2, stache.itemTypes) },
            { i(1), t 'FIELD ', mkCBasic(2, {'status', 'priority'}, 'id') },
            { t 'GREP "', i(1,'regex'), t'"' },
        })
end

local mkSetOp = function(idx)
    return sn(idx, {
        c(1, { t 'INTERSECT', t 'SUBTRACT', t 'UNION' }),
        t ' ',
        c(2, { { t 'FROM ', i(1, '-'), t' ' }, t '' }),
        mkStacheFilt(3),
    })
end
use(s('setop', mkSetOp(1)))

local mkGrpOp = function(idx)
    return sn(idx, {
        c(1, {t'GROUP SPL ', t'GROUP '}),
        mkStacheFilt(2),
        c(3, {t' ASC',t' DES',t''}),
    })
end
use(s('grpop', mkGrpOp(1)))

use(s('tasks', { t {
    '```stache',
    'UNION FROM - STACHE task',
    'SUBTRACT FIELD status "closed"',
    'SUBTRACT FIELD status "archived"',
    'GROUP SPL FIELD status ASC',
    'GROUP FIELD priority DES',
    'LIST',
    '```',
} }))

use(s('inv-items', { t {
    '```stache',
    'UNION FROM - STACHE inventory',
    'LIST',
    '```',
} }))

ls.add_snippets("markdown", S)
ls.add_snippets("telekasten", S)
