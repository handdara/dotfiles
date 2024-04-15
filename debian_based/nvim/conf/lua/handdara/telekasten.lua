require('telekasten').setup({
  home = vim.fn.expand("~/MEGA/ansible"),
  templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
  tag_notation = ":tag:",
  subdirs_in_links = true,
  command_palette_theme = "dropdown",
  vaults = {
    personal = {
      home = vim.fn.expand("~/MEGA/ansible/personal"),
      tag_notation = ":tag:",
      command_palette_theme = "dropdown",
    },
    work = {
      home = vim.fn.expand("~/MEGA/ansible/work"),
      tag_notation = ":tag:",
      command_palette_theme = "dropdown",
    },
    dnd = {
      home = vim.fn.expand("~/MEGA/ansible/dnd"),
      tag_notation = ":tag:",
      command_palette_theme = "dropdown",
    },
    conlanging = {
      home = vim.fn.expand("~/MEGA/ansible/dnd/conlang"),
      tag_notation = ":tag:",
      command_palette_theme = "dropdown",
    },
    namer_conlang = {
      home = vim.fn.expand("~/MEGA/ansible/dnd/conlang/namer-lang"),
      tag_notation = ":tag:",
      command_palette_theme = "dropdown",
    },
  },

})
