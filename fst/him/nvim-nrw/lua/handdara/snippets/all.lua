---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "all"
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

local sdate = s("today", {
    f(function()
        local ts = u.timestamp()
        -- return ts.dy .. ts.mo .. ts.yr
        return ts.yr .. '-' .. ts.mo_num .. '-' .. ts.dy
    end),
})

-- local stmrw = s({"tmrw", 'tomorrow'}, {
--     f(function()
--         local ts = u.timestamp()
--         return ts.dy .. ts.mo .. ts.yr
--     end),
-- })

local sdatetime = s("datetime", {
    f(function()
        local ts = u.timestamp()
        return ts.yr .. '-' .. ts.mo_num .. '-' .. ts.dy .. ' ' .. ts.hr .. '' .. ts.mi
    end),
})

local shhmm = s("hhmm", {
    f(function()
        local ts = u.timestamp()
        return ts.hr .. ts.mi
    end),
})

local stime = s('time', { f(function() return tostring(os.time()) end) })

local salldates = s('alldates', d(1, function()
    local ts = u.timestamp()
    return sn(nil, {
        t {
            ts.yr .. '-' .. ts.mo_num .. '-' .. ts.dy,
            ts.yr .. '-' .. ts.wk .. '-' .. ts.wd,
            ts.yr .. '-' .. ts.yrdy,
        },
    })
end))

ls.add_snippets("all", {
    sdate,
    sdatetime,
    shhmm,
    stime,
    salldates,
})
