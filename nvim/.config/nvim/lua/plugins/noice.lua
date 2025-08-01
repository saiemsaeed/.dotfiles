return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = true,
  opts = {
    lsp = {
      hover = {
        enabled = false,
        silent = true,
        opts = {
          border = {
            style = "rounded",
            padding = { 0, 0 },
          },
        },
      },
      signature = {
        enabled = false,
        opts = {
          border = {
            style = "rounded",
            padding = { 0, 0 },
          },
        },
      },
    },
    notify = {
      enabled = false,
    },
    presets = {
      bottom_search = true,
      lsp_doc_border = true,
    },
  },
}
