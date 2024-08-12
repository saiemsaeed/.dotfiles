return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local transparent = true
			require("catppuccin").setup({
				transparent = transparent,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		priority = 1000,
		config = function()
			local transparent = true
			require("gruvbox").setup({
				transparent_mode = transparent,
			})
			vim.cmd.colorscheme("gruvbox")
		end,
	},
}
