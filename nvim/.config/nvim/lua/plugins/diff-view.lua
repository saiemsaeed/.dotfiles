return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("diffview").setup({
        keymaps = {
          view = {
            { "n", "q", "<cmd>tabclose <cr>", { desc = "Close diffview" } },
            { "n", "<leader>q", "<cmd>tabclose <cr>", { desc = "Close diffview" } },
          },
          file_panel = {
            { "n", "q", "<cmd>tabclose <cr>", { desc = "Close diffview" } },
            { "n", "<leader>q", "<cmd>tabclose <cr>", { desc = "Close diffview" } },
          },
        },
        file_panel = {
          listing_style = "tree", -- One of 'list' or 'tree'
          tree_options = { -- Only applies when listing_style is 'tree'
            flatten_dirs = true, -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
          },
          win_config = { -- See |diffview-config-win_config|
            position = "left",
            width = 50,
            win_opts = {},
          },
        },
      })
    end,
  },
}
