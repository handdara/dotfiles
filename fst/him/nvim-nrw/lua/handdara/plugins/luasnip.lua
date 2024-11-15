return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp", -- install jsregexp (optional!).
  config = function()
    require 'handdara.luasnip'
  end
}
