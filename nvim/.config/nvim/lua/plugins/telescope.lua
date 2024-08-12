local function is_git_repo()
	vim.fn.system("git rev-parse --is-inside-work-tree")
	return vim.v.shell_error == 0
end

-- Set the keybinding
return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			local function project_files()
				if is_git_repo() then
					builtin.git_files()
				else
					builtin.find_files()
				end
			end

			vim.keymap.set("n", "<C-p>", project_files, { noremap = true, silent = true, desc = "Find project files" })
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>f", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>t", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>T", builtin.lsp_dynamic_workspace_symbols, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<CR>"] = function(bufnr)
								actions.select_default(bufnr)
								vim.cmd("normal! zz")
							end,
						},
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
