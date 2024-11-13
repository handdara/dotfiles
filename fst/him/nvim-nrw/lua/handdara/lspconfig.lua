local lspconf = require 'lspconfig'
local tbi = require('telescope.builtin')
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- TODO: uncomment this!
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', tbi.lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', tbi.lsp_references, '[G]oto [R]eferences')
  nmap('gI', tbi.lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', tbi.lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', tbi.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', tbi.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation') -- See `:help K` for why this keymap
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create `:Format` buffer command
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

lspconf.marksman.setup { -- markdown lsp config
  -- capabilities = capabilities,
  on_attach = function(_, bufnr)
    on_attach(_, bufnr)
    vim.keymap.set('n', '<leader>nt', '<CMD>r!today<CR>i##<Space><Esc>_',
      { buffer = bufnr, desc = '[N]otes insert [t]oday\'s date as heading' })
      vim.keymap.set('v', '<leader>t', '!pandoc -t gfm<CR>', { desc = 'format highlighted [T]able' })
      vim.keymap.set('v', '<leader>T', '!pandoc -t markdown_strict+grid_tables<CR>', { desc = 'format highlighted [T]able' })
      vim.keymap.set('n', '<leader>gt', 'vip!pandoc -t ')
  end
}

require 'lspconfig'.nil_ls.setup { -- nix lsp config
  on_attach = on_attach,
}

require'lspconfig'.lua_ls.setup {
  on_attach = on_attach,
}
