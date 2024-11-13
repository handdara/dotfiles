return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'cpp',
        'rust',
        'matlab',
        'latex',
        'fish',
        'haskell',
        'json',
        'json5',
        'make',
        'gitignore',
        'yaml',
        'toml',
        'just',
        'python',
        'regex',
        'xml',
        'nix',
        'zig',
      },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true },
    })
  end
}
