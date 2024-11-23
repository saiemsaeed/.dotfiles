-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>update<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<C-;>", "<cmd>cnext<CR>zz", {})
vim.keymap.set({ "n" }, "<C-,>", "<cmd>cprev<CR>zz", {})

vim.keymap.set({ "v", "n" }, "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set({ "v" }, "K", ":m '<-2<CR>gv=gv", {})

vim.keymap.set({ "n" }, "n", "nzzzv", {})
vim.keymap.set({ "n" }, "N", "Nzzzv", {})

vim.keymap.set({ "x" }, "p", '"_dP', {})

vim.keymap.set({ "n" }, "<leader>y", '"+y', {})
vim.keymap.set({ "v" }, "<leader>y", '"+y', {})
vim.keymap.set({ "n" }, "<leader>Y", '"+Y', {})

-- delete without yanking to register
vim.keymap.set({ "n" }, "d", '"_d', {})
vim.keymap.set({ "v" }, "d", '"_d', {})

vim.keymap.set({ "n" }, "<leader>/", "<cmd>vsplit<CR>", {})
vim.keymap.set({ "n" }, "<leader>-", "<cmd>split<CR>", {})

vim.keymap.set({ "n" }, "<leader>q", "<cmd>bd<CR>", {})
vim.keymap.set({ "n" }, "<leader>Q", "<cmd>q<CR>", {})
vim.keymap.set({ "n" }, "<C-S>", "<cmd>wa<CR>", {})

vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, desc = "Select all text in buffer" })

--- terminal
vim.keymap.set("n", "<C-/>", function()
  Snacks.terminal.toggle(nil, { cwd = vim.fn.getcwd(), win = { height = 0 } })
end, { desc = "Term toggle" })

vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff View" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>tw",
  "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
  {}
)
