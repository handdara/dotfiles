---@diagnostic disable: unused-local
local ansible_path = vim.fn.expand("~/MEGA/ansible")

-- local pomo_opts = {
--     -- How often the notifiers are updated.
--     update_interval = 1000,
--     -- Configure the default notifiers to use for each timer.
--     -- You can also configure different notifiers for timers given specific names, see
--     -- the 'timers' field below.
--     notifiers = {
--         -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
--         {
--             name = "Default",
--             opts = {
--                 -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
--                 -- continuously displayed. If you only want a pop-up notification when the timer starts
--                 -- and finishes, set this to false.
--                 sticky = true,
--                 -- Configure the display icons:
--                 title_icon = "",
--                 text_icon = "",
--                 -- Replace the above with these if you don't have a patched font:
--                 -- title_icon = "⏳",
--                 -- text_icon = "⏱️",
--             },
--         },
--         -- The "System" notifier sends a system notification when the timer is finished.
--         -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
--         { name = "System" },
--         -- You can also define custom notifiers by providing an "init" function instead of a name.
--         -- { init = function(timer) ... end }
--     },
--     -- Override the notifiers for specific timer names.
--     timers = {
--         -- For example, use only the "System" notifier when you create a timer called "Break",
--         -- e.g. ':TimerStart 2m Break'.
--         Break = {
--             { name = "System" },
--         },
--     },
--     -- You can optionally define custom timer sessions.
--     sessions = {
--         -- Example session configuration for a session called "pomodoro".
--         pomodoro = {
--             { name = "Work", duration = "25m" },
--             { name = "Short Break", duration = "5m" },
--             { name = "Work", duration = "25m" },
--             { name = "Short Break", duration = "5m" },
--             { name = "Work", duration = "25m" },
--             { name = "Long Break", duration = "15m" },
--         },
--     },
-- }

return {
    "epwalsh/obsidian.nvim",
    version = "*",
    -- lazy = true,
    ft = "markdown",
    event = "VeryLazy",
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional dependencies below
        'hrsh7th/nvim-cmp',
        'nvim-telescope/telescope.nvim',
        'nvim-treesitter/nvim-treesitter',
        -- {
        --     "epwalsh/pomo.nvim",
        --     version = "*", -- Recommended, use latest release instead of latest commit
        --     lazy = true,
        --     cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
        --     opts = pomo_opts,
        -- },
        -- 'rcarriga/nvim-notify', -- for pomo.nvim, optional, but highly recommended if you want to use the "Default" timer
    },
    init = function()
        require 'handdara.obsidian'
    end,
    opts = {
        workspaces = {
            { name = "ansible", path = ansible_path },
        },
        daily_notes = {
            folder = '0-quest-board/dailies'
        },
        completion = {
            -- Set to false to disable completion.
            nvim_cmp = true,
        },
        notes_subdir = "0-quest-board/inbox",
        mappings = { -- Optional, configure key mappings. These are the defaults. 
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            ["<C-;>"] = { -- the <leader>ch mapping was the original
                action = "<CMD>ObsidianToggleCheckbox<CR>",
                opts = { buffer = true },
            },
            ["<leader>nt"] = {
                action = "<CMD>ObsidianTags<CR>",
                opts = { buffer = true },
            },
            ["<leader>nb"] = {
                action = "<CMD>ObsidianBacklinks<CR>",
                opts = { buffer = true },
            },
            ["<leader>ng"] = {
                action = "<CMD>ObsidianSearch<CR>",
                opts = { buffer = true },
            },
            ["<leader>nc"] = {
                action = "<CMD>ObsidianTOC<CR>",
                opts = { buffer = true },
            },
            ["<leader>nls"] = {
                action = "<CMD>ObsidianLinks<CR>",
                opts = { buffer = true },
            },
        },

        -- Where to put new notes. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "notes_subdir",
        -- customize how note file names are generated given the ID, target directory, and title
        ---@param spec { id: string, dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
            if spec.title then
                local path = spec.dir / tostring(spec.title)
            else
                local path = spec.dir / tostring(spec.id)
            end
            return path:with_suffix(".md")
        end,

        preferred_link_style = "wiki", -- Either 'wiki' or 'markdown'.
        disable_frontmatter = true,
        -- templates = { -- Optional, for templates (see below).
        --     folder = "templates",
        --     date_format = "%Y-%m-%d",
        --     time_format = "%H:%M",
        --     -- A map for custom variables, the key should be the variable and the value a function
        --     substitutions = {},
        -- },
        picker = {
            name = "telescope.nvim", -- Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
            -- mappings = {
            --     new = "<C-x>", -- Create a new note from your query.
            --     insert_link = "<C-l>", -- Insert a link to the selected note.
            -- },
        },
        -- Optional, sort search results by "path", "modified", "accessed", or "created".
        -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
        -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
        sort_by = "modified",
        sort_reversed = true,

        -- Optional, define your own callbacks to further customize behavior.
        callbacks = {
            -- Runs at the end of `require("obsidian").setup()`.
            ---@param client obsidian.Client
            post_setup = function(client) end,

            -- Runs anytime you enter the buffer for a note.
            ---@param client obsidian.Client
            ---@param note obsidian.Note
            enter_note = function(client, note) end,

            -- Runs anytime you leave the buffer for a note.
            ---@param client obsidian.Client
            ---@param note obsidian.Note
            leave_note = function(client, note) end,

            -- Runs right before writing the buffer for a note.
            ---@param client obsidian.Client
            ---@param note obsidian.Note
            pre_write_note = function(client, note) end,

            -- Runs anytime the workspace is set/changed.
            ---@param client obsidian.Client
            ---@param workspace obsidian.Workspace
            post_set_workspace = function(client, workspace) end,
        },

        -- Optional, configure additional syntax highlighting / extmarks.
        -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
        ui = {
            enable = true,  -- set to false to disable all additional syntax features
            update_debounce = 200,  -- update delay after a text change (in milliseconds)
            max_file_length = 5000,  -- disable UI features for files with more than this many lines
            -- Define how various check-boxes are displayed
            checkboxes = {
                -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                -- You can also add more custom ones...
                [" "] = { char = "", hl_group = "ObsidianTodo" },
                ["x"] = { char = "", hl_group = "ObsidianDone" },
                [">"] = { char = "󰄚", hl_group = "ObsidianRightArrow" },
                ["~"] = { char = "", hl_group = "ObsidianTilde" },
                ["!"] = { char = "", hl_group = "ObsidianImportant" },
                ["-"] = { char = "", hl_group = "ObsidianDelayed" },
                ["."] = { char = "", hl_group = "ObsidianInProg" },
            },
            -- Use bullet marks for non-checkbox lists.
            bullets = { char = "󰾡", hl_group = "ObsidianBullet" },
            external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            -- Replace the above with this if you don't have a patched font:
            -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            reference_text = { hl_group = "ObsidianRefText" },
            highlight_text = { hl_group = "ObsidianHighlightText" },
            tags = { hl_group = "ObsidianTag" },
            block_ids = { hl_group = "ObsidianBlockID" },
            hl_groups = {
                -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
                ObsidianTodo = { bold = true, fg = "#939393" },
                ObsidianDone = { bold = true, fg = "#236b2a" },
                ObsidianRightArrow = { bold = true, fg = "#686868" },
                ObsidianTilde = { bold = true, fg = "#ce0a04" },
                ObsidianImportant = { bold = true, fg = "#f9bb01" },
                ObsidianDelayed = { bold = true, fg = "#302de2" },
                ObsidianInProg = {bold = true, fg = "#f96c00"},
                ObsidianBullet = { bold = true, fg = "#89ddff" },
                ObsidianRefText = { underline = true, fg = "#c792ea" },
                ObsidianExtLinkIcon = { fg = "#c792ea" },
                ObsidianTag = { italic = true, fg = "#89ddff" },
                ObsidianBlockID = { italic = true, fg = "#89ddff" },
                ObsidianHighlightText = { bg = "#75662e" },
            },
        },

        -- Specify how to handle attachments.
        attachments = {
            -- The default folder to place images in via `:ObsidianPasteImg`.
            -- If this is a relative path it will be interpreted as relative to the vault root.
            -- You can always override this per image by passing a full path to the command instead of just a filename.
            img_folder = "assets/imgs",  -- This is the default
            -- A function that determines the text to insert in the note when pasting an image.
            -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
            -- This is the default implementation.
            ---@param client obsidian.Client
            ---@param path obsidian.Path the absolute path to the image file
            ---@return string
            img_text_func = function(client, path)
                path = client:vault_relative_path(path) or path
                return string.format("![%s](%s)", path.name, path)
            end,
        },
        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        -- https://github.com/Vinzent03/obsidian-advanced-uri
        -- use_advanced_uri = false,
        open_app_foreground = true, -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    },
}
