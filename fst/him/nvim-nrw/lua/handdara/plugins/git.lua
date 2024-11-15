return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        opts = {},
        config = function ()
            require 'handdara.git'
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {},
    },
}
