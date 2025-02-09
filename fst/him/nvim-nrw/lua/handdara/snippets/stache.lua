---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "yaml"
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
local fmta = require("luasnip.extras.fmt").fmta
local u = require 'handdara.util'
local stache = require 'handdara.util.stache'

local S = {}
local function use(snip)
    table.insert(S, snip)
end

local blocks = {
    data = [[
        aliases: []
        tags: {2}
        created: {1}
        description: {3}
        notes: {4}
        dataseries:
        {5}
    ]],
    dataseries = [[
        - name: {1}
          units: {2}
          vals: {3}
    ]],
    datapoint = [[
        - val: {1}
          time: {2}
          units: {3}
          notes: {4}
    ]],
    contact = [[
        description: {1}
        tags: {2}
        last-interaction: {3}
        aliases: {4}
        dates: {5}
        phone: {6}
        email: {7}
        address: {10}
        created: {8}
        notes: {9}
    ]],
    task = [[
        status: {7}
        priority: {8}
        context: {6}
        due: {5}
        location: {9}
        alphabet: {10}
        subtasks: {11}
        tags:
          - {1}/def
        description: {2}
        created: {3}
        edited: {4}
        aliases: {12}
        repos: {13}
        notes: {14}
    ]],
    inventory = [[
        stache: inventory
        id: iid-{1}
        name: {3}
        location: {7}
        quantity: {10}
        category: {13}
        description: {14}
        tags:
          - "{2}/def"
        mf: {4}
        mfn: {5}
        serial-number: {6}
        condition: {8}
        created: {15}
        purchase: {12}
        warranty: {9}
        current-value: {11}
        aliases: {16}
        notes: {17}
    ]],
}

local function nextInvID()
    return '#'
end

local function mkCAreaCnt(idx)
    return c(idx, {
        i(nil, '#'),
        f(function()
            local st = ''
            for _ = 1, 4 do
                st = st .. string.char(math.random(string.byte('a'), string.byte('z')))
            end
            return st
        end)
    })
end

local function mkCStacheAreas(idx)
    local as = {}
    for _, val in ipairs(stache.areas) do
        table.insert(as, sn(nil, { t(val), i(1), t '-', mkCAreaCnt(2) }))
    end
    table.insert(as, sn(nil, { i(1, 'other'), t '-', mkCAreaCnt(2) }))
    return c(idx, as)
end
use(s('area', { mkCStacheAreas(1) }))

local function mkCStacheContexts(idx)
    local cs = {}
    for _, val in ipairs(stache.contexts) do
        table.insert(cs, t(val))
    end
    table.insert(cs, i(1, 'custom'))
    return c(idx, cs)
end
use(s('context', { mkCStacheContexts(1) }))

local function mkCLocations(idx)
    local locs = { 'hm-395', 'hm-369', 'hm-3802', 'au-1', 'of-176', }
    local lcs = {}
    for _, val in ipairs(locs) do
        table.insert(lcs, t(val))
    end
    table.insert(lcs, i(1, 'custom'))
    return c(idx, lcs)
end

local function mkCStatuses(idx)
    local ss = {}
    for _, val in ipairs(stache.statuses) do
        table.insert(ss, t(val))
    end
    return c(idx, ss)
end
use(s('status', { mkCStatuses(1) }))

local function mkCPriorities(idx)
    local ps = {}
    for _, val in ipairs(stache.priorities) do
        table.insert(ps, t(val))
    end
    return c(idx, ps)
end
use(s('priority', { mkCPriorities(1) }))

local function mkCCategories(idx)
    local cs = {}
    for _, val in ipairs(stache.categories) do
        table.insert(cs, t(val))
    end
    table.insert(cs, i(1, 'misc'))
    return c(idx, cs)
end
use(s('category', { mkCCategories(1) }))

local function mkListChoiceItem(cs, tDesc, tCustom)
    local cl = {}
    for _, choice in ipairs(cs) do
        local choice_ = string.gsub('- ch: "', 'ch', choice)
        table.insert(cl, { t(choice_), i(1, tDesc), t '"' })
    end
    table.insert(cl, { t '- ', i(1, tCustom), t(': "'), i(2, tDesc), t '"' })
    return cl
end
use(s('date-bullet', c(1, mkListChoiceItem(stache.types.date, "date", 'custom'))))
use(s('phone-bullet', c(1, mkListChoiceItem(stache.types.phone, "phone-#", 'other'))))
use(s('email-bullet', c(1, mkListChoiceItem(stache.types.email, "email", 'other'))))
use(s('address-bullet', c(1, mkListChoiceItem(stache.types.address, 'address', 'other'))))

local function mkCUnits(idx, include)
    local us = {}
    local toInc = include or {}
    if #toInc == 0 then
        for _, val in ipairs(stache.favUnits) do
            table.insert(us, t(val))
        end
    else
        for _, key in ipairs(toInc) do
            for _, val in ipairs(stache.units[key]) do
                table.insert(us, t(val))
            end
        end
    end
    table.insert(us, i(nil, '~'))
    return c(idx, us)
end
local unitCats = {}
for key, _ in pairs(stache.units) do
    table.insert(unitCats, key)
    use(s(key .. '-units', { mkCUnits(1, { key }) }))
end
use(s('units', { mkCUnits(1) }))
use(s('all-units', { mkCUnits(1, unitCats) }))

local function mkSnSubtask(idx, parentTaskID, indent)
    indent = indent or ''
    parentTaskID = parentTaskID or ''
    return sn(idx, {
        t(indent .. '- description: '), i(1),
        t { '', indent .. '  status: ' }, mkCStatuses(2),
        t { '', indent .. '  id: ' }, c(3, {
        t '~',
        { t(parentTaskID .. '-'), i(1, '1') },
    })
    })
end
use(s('subtask', mkSnSubtask(1)))

local function mkSnTask(idx)
    return sn(idx, {
        t { 'stache: task', 'id: ' },
        mkCStacheAreas(1),
        t { '', '' },
        d(2, function(args)
            local ts = u.timestamp()
            local dateTxt = ts.dy .. ts.mo .. ts.yr
            local timeTxt = ts.hr .. ':' .. ts.mi
            local dtText = dateTxt .. ' ' .. timeTxt
            return sn(1, fmt(blocks.task, {
                t(args[1][1]),
                i(8, 'Destroy the one ring'),
                t(dtText),
                t(dtText),
                i(4, '~'), -- due
                mkCStacheContexts(3),
                mkCStatuses(1),
                mkCPriorities(2),
                mkCLocations(5),
                i(6, '~'), -- alphabet
                c(7, { -- subtasks
                    sn(nil, { t '[', i(1), t ']' }),
                    sn(nil, { i(1), t { '', '' }, mkSnSubtask(2, args[1][1], '    ') }),
                }),
                i(9, '[]'),  -- aliases
                i(10, '[]'), -- repos
                c(11, {     -- notes
                    sn(nil, { t '[', i(1), t ']' }),
                    { t { '', '  - ' }, i(1, "note...") },
                }),
            }))
        end, { 1 }) })
end
use(s('task', mkSnTask(1)))

local function mkSnContact(idx)
    return sn(idx, {
        t({ 'stache: contact', 'id: ' }),
        i(1, 'frodo-baggins'),
        t({ '', '' }),
        d(2, function(args)
            local ts = u.timestamp()
            local dtText = ts.dy .. ts.mo .. ts.yr .. ' ' .. ts.hr .. ':' .. ts.mi
            local idStr = '-' .. args[1][1]
            local sp_name = string.gsub(idStr, [[(%p+)([%w])]], function(_, s_)
                return ' ' .. string.upper(s_)
            end)
            local nameStr = string.sub(sp_name, 2)
            return sn(nil, fmt(blocks.contact, {
                i(1, 'description'), -- description
                i(2, '[]'),          -- tags
                i(3, '~'),           -- last-interaction
                sn(4, {              -- aliases
                    t({ '', '  - ' .. nameStr }),
                    c(1, {
                        { t { '', '  - ' }, i(1, 'another alias') },
                        t { '' },
                    }),
                }),
                c(5, {
                    sn(nil, { t '[', i(1), t ']' }),
                    sn(nil, { i(1), t { '', '  ' }, c(2, mkListChoiceItem(stache.types.date, 'date', 'custom')) }),
                }),
                c(6, {
                    sn(nil, { t '[', i(1), t ']' }),
                    sn(nil, { i(1), t { '', '  ' }, c(2, mkListChoiceItem(stache.types.phone, 'phone-#', 'other')) }),
                }),
                c(7, {
                    sn(nil, { t '[', i(1), t ']' }),
                    sn(nil, { i(1), t { '', '  ' }, c(2, mkListChoiceItem(stache.types.email, 'email', 'other')) }),
                }),
                t(dtText), -- created
                c(9, {     -- notes
                    sn(nil, { t '[', i(1), t ']' }),
                    { t { '', '  - ' }, i(1, "note...") },
                }),
                c(8, {
                    sn(nil, { t '[', i(1), t ']' }),
                    sn(nil, { i(1), t { '', '  ' }, c(2, mkListChoiceItem(stache.types.address, 'address', 'other')) }),
                }),
            }))
        end, { 1 }) })
end
use(s('contact', mkSnContact(1)))

local function mkSnDataPt(idx, indent, units)
    indent = indent or ''
    local nUnits
    if units then
        nUnits = i(2, '~')
    else
        nUnits = mkCUnits(2)
    end
    return sn(idx, { d(1, function()
        local ts = u.timestamp()
        local dtText = ts.dy .. ts.mo .. ts.yr .. ' ' .. ts.hr .. ':' .. ts.mi .. ':' .. ts.sc
        return sn(nil, {
            t(indent .. '- val: '), i(1),
            t { '', indent .. '  time: ' .. dtText },
            t { '', indent .. '  units: ' }, nUnits,
            t { '', indent .. '  notes: ' },
            c(3, {
                sn(nil, { t '[', i(1), t ']' }),
                { t { '', indent .. '    - ' }, i(1, "note...") },
            }),
        })
    end) })
end
use(s('datapoint', mkSnDataPt(1)))

local function mkSnDataSeries(idx, indent, units)
    indent = indent or ''
    local nUnits
    if units then
        nUnits = i(2, units)
    else
        nUnits = mkCUnits(2)
    end
    return sn(idx, {
        t(indent .. '- name: '), i(1, 'name'),
        t { '', indent .. '  units: ' }, nUnits,
        t { '', indent .. '  vals:', '' }, d(3, function(args)
        return mkSnDataPt(nil, indent .. '    ', args[1][1]) -- dynamic_node here really isnt necessary
        -- as i abandoned something fancier, but i'm leaving it in b/c i might return to it
    end, { 2 }),
    })
end
use(s('dataseries', mkSnDataSeries(1)))

local function mkSnData(idx)
    return sn(idx, {
        sn(1, { t { 'stache: data', 'id: ' }, mkCStacheAreas(1), t { '', '' } }),
        d(2, function()
            local ts = u.timestamp()
            local dtText = ts.dy .. ts.mo .. ts.yr .. ' ' .. ts.hr .. ':' .. ts.mi
            return sn(nil, fmt(blocks.data, {
                t(dtText),           -- created
                i(1, '[]'),          -- tags
                i(2, 'description'), -- description
                c(3, {               -- notes
                    { t '[',            i(1),           t ']' },
                    { t { '', '  - ' }, i(1, "note...") },
                }),
                mkSnDataSeries(4, '    '), -- dataseries
            }))
        end) })
end
use(s('data', mkSnData(1)))

local function mkSnInvPurchase(idx, indent)
    indent = indent or ''
    return sn(idx, { d(1, function()
        local ts = u.timestamp()
        local dtText = ts.dy .. ts.mo .. ts.yr .. ' ' .. ts.hr .. ':' .. ts.mi .. ':' .. ts.sc
        return sn(nil, {
            t(indent .. '- location: '), i(1, '~'),
            t { '', indent .. '  price: ' }, i(2, '~'),
            t { '', indent .. '  quantity: ' }, i(3, '1'),
            t { '', indent .. '  vendor: ' }, i(4, '~'),
            t { '', indent .. '  date: ' }, i(5, dtText),
        })
    end) })
end
use(s('purchase', mkSnInvPurchase(1)))

local function mkSnInv(idx)
    return sn(idx, {
        d(1, function()
            local ts = u.timestamp()
            local dtText = ts.dy .. ts.mo .. ts.yr .. ' ' .. ts.hr .. ':' .. ts.mi
            return sn(nil, fmt(blocks.inventory, {
                i(1, nextInvID()),
                rep(1),
                i(2, 'name'),
                i(7, '~'),        -- mf
                i(8, '~'),        -- mfn
                i(9, '~'),        -- serial-number
                mkCLocations(3),  -- location
                i(10, '~'),       -- condition
                i(12, 'false'),   -- warranty
                i(4, '~'),        -- quantity
                i(13, '~'),       -- current-value
                i(11, '~'),       -- purchase
                mkCCategories(5), -- category
                i(6, '~'),        -- description
                t(dtText),
                i(14, '[]'),      -- aliases
                c(15, {           -- notes
                    { t '[',            i(1),           t ']' },
                    { t { '', '  - ' }, i(1, "note...") },
                }),
            }))
        end) })
end
use(s('inv', mkSnInv(1)))

use(s('stache', c(1, {
    { i(1), mkSnTask(2) },
    { i(1), mkSnContact(2) },
    { i(1), mkSnData(2) },
    { i(1), mkSnInv(2) },
})))

ls.add_snippets("yaml", S)
ls.add_snippets("markdown", S)
