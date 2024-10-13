local ansible_path = vim.fn.expand("~/MEGA/ansible")

local subvault_config = function(vault_name, subdirs_in_links, tag_notation)
  return {
    home = ansible_path .. "/" .. vault_name,
    templates = ansible_path .. "/misc/templates",
    tag_notation = tag_notation or ":tag:",
    subdirs_in_links = subdirs_in_links or false,
    command_palette_theme = "dropdown",
  }
end

require('telekasten').setup({
  -- home vault
  home = ansible_path,
  templates = vim.fn.expand("~/MEGA/ansible/misc/templates"),
  tag_notation = ":tag:",
  subdirs_in_links = true,
  command_palette_theme = "dropdown",

  -- sub-vaults
  vaults = {
    personal = subvault_config("personal"),
    work = subvault_config("work"),
    dnd = subvault_config("dnd"),
    conlanging = subvault_config("conlanging"),
    namer_conlang = subvault_config("namer_conlang"),
    tadok = subvault_config("tadok"),
    finance = subvault_config("finance"),
    what_we_owe = subvault_config("what_we_owe"),
  },
})
