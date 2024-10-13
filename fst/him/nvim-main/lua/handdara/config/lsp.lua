local lspconf = require 'lspconfig'

local on_attach = function(_, bufnr) --  This function gets run when an LSP connects to a particular buffer.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
	nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	nmap('K', vim.lsp.buf.hover, 'Hover Documentation') -- See `:help K` for why this keymap
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
	['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
	['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
	['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
	['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
	['<leader>r'] = { name = '[R]ename & [R]epl', _ = 'which_key_ignore' },
	['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
	['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
	['<leader>m'] = { name = '[M]arkdown', _ = 'which_key_ignore' },
	['<leader>p'] = { name = '[P]aste &/or [P]roject', _ = 'which_key_ignore' },
	['<leader>n'] = { name = '[N]otes', _ = 'which_key_ignore' },
}

-- WARNING: mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'
-- Enable the following language servers
--   - Add/remove LSPs here: they'll be installed automatically 
--   - Add additional override configuration in following tables
--     They will be passed to the `settings` field of the server config
--     Reliant on individual servers' documentation!
--   - Can override the default filetypes that your language server will attach to you can
--     define the property 'filetypes' to the map in question
local servers = {
	-- clangd = {},
	-- pyright = {},
	-- rust_analyzer = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}
mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		}
	end,
}

lspconf.texlab.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		texlab = {
			auxDirectory = ".",
			bibtexFormatter = "texlab",
			build = {
				-- args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				-- executable = "wsl_latex_wrapper",
				-- args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				-- executable = "latexmk",
				forwardSearchAfter = true,
				onSave = true,
			},
			chktex = {
				onEdit = false,
				onOpenAndSave = false
			},
			diagnosticsDelay = 300,
			formatterLineLength = 100,
			forwardSearch = {
				-- executable = "wsl_sumatra_wrapper",
				-- args = { "-reuse-instance", "%p", "-forward-search", "%f", "%l" },
				executable = "flatpak",
				args = { "run", "org.kde.okular", "--unique", "file:%p#src:%l%f" },
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = false
			}
		}
	}
}

lspconf.marksman.setup {
	capabilities = capabilities,
	-- on_attach = on_attach,
	on_attach = function(_, bufnr)
		on_attach(_, bufnr)
		vim.keymap.set('n', '<leader>nt', '<CMD>r!today<CR>i#<Space><Esc>_',
			{ buffer = bufnr, desc = '[N]otes insert [t]oday\'s date as heading' })
	end
}

lspconf.matlab_ls.setup {
	{ "matlab-language-server", "--stdio" },
	capabilities = capabilities,
	on_attach = on_attach,
}

local _border = "rounded"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		border = _border
	}
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help, {
		border = _border
	}
)
vim.diagnostic.config {
	float = { border = _border }
}
require('lspconfig.ui.windows').default_options.border = _border

-- local ht = require('haskell-tools')
vim.g.haskell_tools = {
	hls = {
		---@param client number The LSP client ID.
		---@param bufnr number The buffer number
		---@param ht HaskellTools = require('haskell-tools')
		on_attach = function(_, bufnr, ht)
			local nmap = function(keys, func, desc)
				if desc then
					desc = 'Haskell: ' .. desc
				end

				vim.keymap.set('n', keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
			end
			-- haskell-language-server relies heavily on codeLenses,
			-- so auto-refresh (see advanced configuration) is enabled by default
			nmap('<space>cl', vim.lsp.codelens.run, "Run code lens in current line")
			-- Hoogle search for the type signature of the definition under the cursor
			nmap('<space>hs', ht.hoogle.hoogle_signature,
				"Hoogle search for the type signature of the definition under the cursor")
			-- Evaluate all code snippets
			nmap('<space>ce', ht.lsp.buf_eval_all, "Evaluate all code snippets")
			-- Toggle a GHCi repl for the current package
			nmap('<leader>rr', ht.repl.toggle, "[R]epl: Toggle for current package")
			-- Toggle a GHCi repl for the current buffer
			nmap('<leader>rf', function()
				ht.repl.toggle(vim.api.nvim_buf_get_name(0))
			end, "[R]epl: Toggle for current buffer")
			nmap('<leader>rq', ht.repl.quit, "Quit GHCi repl")
			on_attach(_, bufnr)
		end,
	},
}

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(_,bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = 'Rust: ' .. desc
				end
				vim.keymap.set('n', keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
			end
    	on_attach(_,bufnr)
    end,
    -- settings = {
    --   -- rust-analyzer language server configuration
    --   ['rust-analyzer'] = {
    --   },
    -- },
  },
  -- DAP configuration
  -- dap = {
  -- },
}
