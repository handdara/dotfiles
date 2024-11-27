local ansible_path = vim.fn.expand("~/MEGA/ansible")
return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
        workspaces = {
            { name = "ansible", path = ansible_path },
        },
    },
}
