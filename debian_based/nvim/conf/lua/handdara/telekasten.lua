require('telekasten').setup({
  home = vim.fn.expand("~/MEGA/ansible"),
  templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
  tag_notation = ":tag:",
  subdirs_in_links = true,
  command_palette_theme = "dropdown",
  vaults = {
    personal = {
      home = vim.fn.expand("~/MEGA/ansible/personal"),
    },
    work = {
      home = vim.fn.expand("~/MEGA/ansible/work"),
    },
    dnd = {
      home = vim.fn.expand("~/MEGA/ansible/dnd"),
    },
  },

})
