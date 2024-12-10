---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "zig"
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

local S = {}
local function use(snip)
    table.insert(S, snip)
end

-- snips go here

local bFn = [[
{4}fn {1}({2}) {3} {{
    {5}
}}
]]
local sFn = s('fn', fmt(bFn, {
    i(1, 'name'),
    c(2, { i(1, 'args'), t '' }),
    i(3, '!void'),
    c(4, { t 'pub ', t '' }),
    i(0),
}))
use(sFn)

ls.add_snippets("zig", S)
