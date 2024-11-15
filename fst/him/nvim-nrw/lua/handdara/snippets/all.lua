require('luasnip.session.snippet_collection').clear_snippets "lua"

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("lua", {
  s("hello", {
    t('print("hello '),
    i(1),
    t('. What a great '),
    i(2),
    t('!")'),
  })
})
