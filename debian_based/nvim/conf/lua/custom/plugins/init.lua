-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

	'nvim-treesitter/playground',

	'mbbill/undotree',

	{
		"kylechui/nvim-surround",

		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},

	'lervag/vimtex',

	'kmonad/kmonad-vim',

	{ 'echasnovski/mini.files', version = false },

	-- 'jakewvincent/mkdnflow.nvim',

	{
		'NFrid/due.nvim',
		config = function ()
			require("due_nvim").setup({
				default_due_time = "noon",
				date_hi = "String",
			})
		end
	},
}
