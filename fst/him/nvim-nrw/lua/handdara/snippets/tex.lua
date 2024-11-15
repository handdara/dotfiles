require('luasnip.session.snippet_collection').clear_snippets "tex"

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require 'luasnip.extras'
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

local bbeg = [[
\begin{{{}}}
  {}
\end{{{}}}
]]

ls.add_snippets("tex", {
    s("begin", fmt(bbeg, {i(1), i(0), rep(1)}))
})
