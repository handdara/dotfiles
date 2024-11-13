return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "runtime", words = { "vim" } }, -- load runtime types if `vim` is found
    },
  },
}
