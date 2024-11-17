return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
            {
                'lewis6991/gitsigns.nvim',
                opts = {
                    current_line_blame = true,
                    current_line_blame_formatter = " 󰯙  <author>, <author_time:%R>   <summary>",
                    current_line_blame_formatter_nc = " 󰯙  <author> ",
                }
            },
        },
        opts = {},
        config = function()
            require 'handdara.git'
        end
    },
}
