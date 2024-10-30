-- local ls = require 'luasnip'
-- local s = ls.snippet
-- local t = ls.snippet
-- local i = ls.snippet

local handdara_snip_path = vim.fn.expand("~/.config/nvim/handdara-snips")
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load({ paths = handdara_snip_path })

-- ls.add_snippets("lua", {
-- 	s("hello", {
-- 		t('print("Hello World")')
-- 	})
-- })
