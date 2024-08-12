vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>update<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>qq", "<ESC>:q!<CR>", {})
vim.keymap.set({ "i" }, "jj", "<ESC>", {})
vim.keymap.set({ "n" }, "<Tab>", ":b#<CR>", {})
vim.keymap.set({ "n" }, "<C-;>", "<cmd>cnext<CR>zz", {})
vim.keymap.set({ "n" }, "<C-,>", "<cmd>cprev<CR>zz", {})

vim.keymap.set({ "v" }, "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set({ "v" }, "K", ":m '<-2<CR>gv=gv", {})

vim.keymap.set({ "n" }, "n", "nzzzv", {})
vim.keymap.set({ "n" }, "N", "Nzzzv", {})

vim.keymap.set({ "x" }, "p", '"_dP', {})

vim.keymap.set({ "n" }, "<leader>y", '"+y', {})
vim.keymap.set({ "v" }, "<leader>y", '"+y', {})
vim.keymap.set({ "n" }, "<leader>Y", '"+Y', {})

vim.keymap.set({ "n" }, "<leader>d", '"_d', {})
vim.keymap.set({ "v" }, "<leader>d", '"_d', {})

vim.keymap.set({ "n" }, "<leader>/", "<cmd>vsplit<CR>", {})
vim.keymap.set({ "n" }, "<leader>-", "<cmd>split<CR>", {})

vim.keymap.set({ "n" }, "<leader>q", "<cmd>bd<CR>", {})
vim.keymap.set({ "n" }, "<leader>Q", "<cmd>q<CR>", {})
vim.keymap.set({ "n" }, "<C-S>", "<cmd>wa<CR>", {})
