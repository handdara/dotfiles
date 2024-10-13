return {
  'tpope/vim-fugitive', -- Git related plugins
  'tpope/vim-rhubarb',

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'neovim/nvim-lspconfig', -- LSP Configuration & Plugins
    dependencies = {
      'williamboman/mason.nvim', -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      --   NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      'folke/neodev.nvim', -- Additional lua configuration, makes nvim stuff amazing!
    },
  },

  {
    'hrsh7th/nvim-cmp', -- Autocompletion
    dependencies = {
      'L3MON4D3/LuaSnip', -- Snippet Engine & its associated nvim-cmp source
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp', -- Adds LSP completion capabilities

      'rafamadriz/friendly-snippets', -- Adds a number of user-friendly snippets
    },
  },

  { 'folke/which-key.nvim',  opts = {} }, -- Useful plugin to show you pending keybinds.

  {
    'lewis6991/gitsigns.nvim', -- Adds git related signs to the gutter, as well as utilities for managing changes
    opts = {
      signs = { -- See `:help gitsigns.txt`
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        local gs = package.loaded.gitsigns -- don't override the built-in and fugitive keymaps
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    'nvim-lualine/lualine.nvim', -- Set lualine as statusline
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { {
          'filename',
          file_status = true,
          newfile_status = true,
          path = 1,
        } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    },

  },

  {
    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
    main = 'ibl', -- See `:help ibl`
    opts = {},
  },

  { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines

  {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  'nvim-treesitter/playground',

  'mbbill/undotree',

  {
    "kylechui/nvim-surround",

    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  'lervag/vimtex',

  'kmonad/kmonad-vim',

  { 'echasnovski/mini.files', version = false },

  {
    'NFrid/due.nvim',
    config = function()
      require("due_nvim").setup({
        default_due_time = "noon",
        date_hi = "String",
      })
    end
  },

  'xiyaowong/transparent.nvim',

  {
    'mrcjkb/haskell-tools.nvim',
    version = '^3', -- Recommended
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },

  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' }
  },

  'rhysd/vim-fixjson',

  'nvim-lua/popup.nvim',
  'nvim-telescope/telescope-media-files.nvim',

  {
    "emmanueltouzery/decisive.nvim",
    config = function()
      require('decisive').setup {}
    end,
    lazy = true,
    ft = { 'csv' },
    -- keys = {
    --   { '<leader>cca', ":lua require('decisive').align_csv({})<cr>",        { silent = true }, desc = "Align CSV",          mode = 'n' },
    --   { '<leader>ccA', ":lua require('decisive').align_csv_clear({})<cr>",  { silent = true }, desc = "Align CSV clear",    mode = 'n' },
    --   { '[c',          ":lua require('decisive').align_csv_prev_col()<cr>", { silent = true }, desc = "Align CSV prev col", mode = 'n' },
    --   { ']c',          ":lua require('decisive').align_csv_next_col()<cr>", { silent = true }, desc = "Align CSV next col", mode = 'n' },
    -- }
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  }
}
