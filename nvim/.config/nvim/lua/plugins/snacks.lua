return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {
        linelength = 800,
      },
      notifier = { enabled = false },
      words = { enabled = false },
      indent = { enabled = false },
      animate = { enabled = false },
      scroll = { enabled = false },
      image = {},
      dashboard = {
        preset = {
          header = [[
/*  .--. .----.  .----. .-------. */
/* /_  |\_.-,  |\_.-,  ||   _   ' */
/*  |  |  |_  <   |_  < `-' /  /  */
/*  |  |.-. \  |.-. \  |   .  /   */
/*  |  |\ `-'  /\ `-'  /  /  /    */
/*  `--' `---''  `---''  `--'     */
          ]],
        },
      },
      lazygit = {
        config = {
          os = {
            edit = '[ -z ""$NVIM"" ] && (nvim -- {{filename}}) || (nvim --server ""$NVIM"" --remote-send ""q"" && nvim --server ""$NVIM"" --remote {{filename}})',
          },
        },
      },
      picker = {
        sources = {
          explorer = {
            ---@diagnostic disable-next-line: missing-fields
            diagnostics = false,
            auto_close = true,
            layout = {
              cycle = false,
              preview = false,
              layout = {
                backdrop = false,
                width = 80,
                min_width = 40,
                height = 0,
                position = "float",
                border = "rounded",
                box = "vertical",
              },
            },
          },
        },
      },
    },
  },
}
