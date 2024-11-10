return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } }, -- Load luvit types when the `vim.uv` word is found
      },
    },
    dependencies = { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
