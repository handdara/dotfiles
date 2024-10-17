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
  subdirs_in_links = true,
  command_palette_theme = "dropdown",

  -- sub-vaults
  vaults = {
    personal = subvault_config("personal"),
    work = subvault_config("work"),
    dnd = subvault_config("dnd", "personal/2-areas/"),
    conlang = subvault_config("conlang", "personal/2-areas/dnd/"),
    namer_conlang = subvault_config("namer_conlang", "personal/2-areas/dnd/conlang/"),
    tadok = subvault_config("tadok", "personal/2-areas/dnd/"),
    finance = subvault_config("finance", "personal/2-areas/"),
    what_we_owe = subvault_config("what_we_owe", "personal/2-areas/dnd/"),
  },
})
