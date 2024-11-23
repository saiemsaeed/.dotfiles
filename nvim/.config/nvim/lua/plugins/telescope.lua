return {
  "nvim-telescope/telescope.nvim",
  keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>p",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
  },
  -- change some options
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
    },
  },
  -- disabled this because the keymap above <leader>p does not work with this plugin enabled, check later
  -- {
  --   "nvim-telescope/telescope-ui-select.nvim",
  --   config = function()
  --     local actions = require("telescope.actions")
  --     require("telescope").setup({
  --       extensions = {
  --         ["ui-select"] = {
  --           require("telescope.themes").get_dropdown({}),
  --         },
  --       },
  --       defaults = {
  --         mappings = {
  --           i = {
  --             ["<esc>"] = actions.close,
  --             ["<CR>"] = function(bufnr)
  --               actions.select_default(bufnr)
  --               vim.cmd("normal! zz")
  --             end,
  --           },
  --         },
  --       },
  --     })
  --     require("telescope").load_extension("ui-select")
  --   end,
  -- },
}
