local ansible_path = vim.fn.expand("~/MEGA/ansible")

local subvault_config = function(vault_name, subdir, subdirs_in_links, tag_notation)
  local vault_subdir = "/" .. (subdir or "")
  return {
    home = ansible_path .. vault_subdir .. vault_name,
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
  subdirs_in_links = false,
  command_palette_theme = "dropdown",

  -- sub-vaults
  vaults = {
    work = subvault_config("work", "2-build/"),
    dnd = subvault_config("dnd", "2-build/"),
    conlang = subvault_config("conlang", "2-build/dnd/"),
    namer_conlang = subvault_config("namer_conlang", "2-build/dnd/conlang/"),
    tadok = subvault_config("tadok", "2-build/dnd/"),
    finance = subvault_config("finance", "2-build/"),
    what_we_owe = subvault_config("what_we_owe", "2-build/dnd/"),
  },
})
