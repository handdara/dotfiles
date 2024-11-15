---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "lua"
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

local bsnipfile = [[
---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "{}"
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

ls.add_snippets("{}", {{
    {},
}})
]]

ls.add_snippets("lua", {
    s("luasnipfile", fmt(bsnipfile, {i(1), rep(1), i(0)} ))
})

