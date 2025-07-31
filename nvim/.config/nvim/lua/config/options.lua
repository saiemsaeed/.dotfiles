-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_prettier_needs_config = true
vim.g.ai_cmp = true
-- vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_blink_main = false
vim.g.root_spec = { "cwd" }
--
vim.opt.cursorline = false
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.sessionoptions = { "buffers", "curdir", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.clipboard = "unnamedplus"
--
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%l %s"
vim.opt.numberwidth = 4
