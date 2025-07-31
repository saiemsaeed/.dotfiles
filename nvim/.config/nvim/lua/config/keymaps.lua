-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Add any additional keymaps here
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>update<CR>", { silent = true, noremap = true })

-- Move to the beginning and end of a line in normal mode
vim.keymap.set({ "n" }, "<C-;>", "<cmd>cnext<CR>zz", {})
vim.keymap.set({ "n" }, "<C-,>", "<cmd>cprev<CR>zz", {})

-- Move selected line / block of text in visual mode up and down
vim.keymap.set({ "v" }, "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set({ "v" }, "K", ":m '<-2<CR>gv=gv", {})

-- Center the cursor when searching
vim.keymap.set({ "n" }, "n", "nzzzv", {})
vim.keymap.set({ "n" }, "N", "Nzzzv", {})

-- Copy to system clipboard
vim.keymap.set({ "n" }, "<leader>y", '"+y', {})
vim.keymap.set({ "v" }, "<leader>y", '"+y', {})
vim.keymap.set({ "n" }, "<leader>Y", '"+Y', {})

-- Yank without changing the clipboard
vim.keymap.set("x", "p", "P", { noremap = true })
vim.keymap.set("x", "P", "p", { noremap = true })

-- delete without yanking to register
vim.keymap.set({ "n" }, "d", '"_d', {})
vim.keymap.set({ "v" }, "d", '"_d', {})

-- Splitting Windows
vim.keymap.set({ "n" }, "<leader>/", "<cmd>vsplit<CR>", {})
vim.keymap.set({ "n" }, "<leader>-", "<cmd>split<CR>", {})

vim.keymap.set({ "n" }, "<leader>q", "<cmd>bd<CR>", {})
vim.keymap.set({ "n" }, "<leader>Q", "<cmd>q<CR>", {})
vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<cmd>wa<CR>", {})

-- Select All Text in Buffer
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, desc = "Select all text in buffer" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>tw",
  "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
  {}
)
