require('telekasten').setup({
  home = vim.fn.expand("~/MEGA/ansible"),
  templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
  tag_notation = ":tag:",
  subdirs_in_links = true,
  command_palette_theme = "dropdown",
  vaults = {
    personal = {
      home = vim.fn.expand("~/MEGA/ansible/personal"),
      templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
      tag_notation = ":tag:",
      subdirs_in_links = true,
      command_palette_theme = "dropdown",
    },
    work = {
      home = vim.fn.expand("~/MEGA/ansible/work"),
      templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
      tag_notation = ":tag:",
      subdirs_in_links = true,
      command_palette_theme = "dropdown",
    },
    dnd = {
      home = vim.fn.expand("~/MEGA/ansible/dnd"),
      templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
      tag_notation = ":tag:",
      subdirs_in_links = true,
      command_palette_theme = "dropdown",
      media_previewer = "telescope-media-files",
    },
    conlanging = {
      home = vim.fn.expand("~/MEGA/ansible/dnd/conlang"),
      templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
      tag_notation = ":tag:",
      subdirs_in_links = true,
      command_palette_theme = "dropdown",
    },
    namer_conlang = {
      home = vim.fn.expand("~/MEGA/ansible/dnd/conlang/namer-lang"),
      templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
      tag_notation = ":tag:",
      subdirs_in_links = true,
      command_palette_theme = "dropdown",
    },
    tadok = {
      home = vim.fn.expand("~/MEGA/ansible/dnd/tadok"),
      templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
      tag_notation = ":tag:",
      subdirs_in_links = true,
      command_palette_theme = "dropdown",
    },
    finance = {
      home = vim.fn.expand("~/MEGA/ansible/personal/finance"),
      tag_notation = ":tag:",
      subdirs_in_links = true,
      command_palette_theme = "dropdown",
    },
    what_we_owe = {
      home = vim.fn.expand("~/MEGA/ansible/dnd/what-we-owe"),
      tag_notation = ":tag:",
      subdirs_in_links = true,
      command_palette_theme = "dropdown",
    },
  },

})
