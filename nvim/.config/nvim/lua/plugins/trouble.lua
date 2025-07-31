return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      indent_guides = false, -- show indent guides
      win = {
        type = "split", -- split window
        relative = "win", -- relative to current window
        position = "bottom", -- right side
        size = 0.4,
      },
    },
  },
}
