return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      view = {
        entries = { name = "custom" },
      },
      experimental = {
        ghost_text = false,
      },
      sources = {
        {
          group_index = 1,
          name = "snippets",
          option = {},
          priority = 1000,
        },
        {
          name = "copilot",
          group_index = 1,
          priority = 600,
        },
        {
          group_index = 1,
          name = "nvim_lsp",
          option = {},
          priority = 500,
        },
        {
          group_index = 1,
          name = "path",
          option = {},
        },
        {
          group_index = 2,
          name = "buffer",
          option = {},
        },
        {
          group_index = 0,
          name = "lazydev",
          option = {},
        },
        {
          group_index = 1,
          name = "git",
          option = {},
        },
      },
    },
  },
}
