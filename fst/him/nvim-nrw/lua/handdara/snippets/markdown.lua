---@diagnostic disable: unused-local
require('luasnip.session.snippet_collection').clear_snippets "markdown"
require('luasnip.session.snippet_collection').clear_snippets "telekasten"
local ls = require 'luasnip'
local s = ls.snippet
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

local snips = {
    sdateheader,
}

ls.add_snippets("markdown", snips)
ls.add_snippets("telekasten", snips)
