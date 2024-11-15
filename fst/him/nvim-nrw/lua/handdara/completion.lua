local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
  snippet = { -- selecting snippet engine is required according to docs
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-y>'] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }), { 'i', 'c' }
    ),

    -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete(),

    -- ['<CR>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     if luasnip.expandable() then
    --       luasnip.expand()
    --     else
    --       cmp.confirm({
    --         select = true,
    --       })
    --     end
    --   else
    --     fallback()
    --   end
    -- end),

    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if luasnip.locally_jumpable(1) then
    --     luasnip.jump(1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),

    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if luasnip.locally_jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = "path" },
  }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  -- matching = { disallow_symbol_nonprefix_matching = false }
})

local update_capabilities = function(cs)
  cs = require('cmp_nvim_lsp').default_capabilities(cs)
  return cs
end
return {
  update_capabilities = update_capabilities
}
