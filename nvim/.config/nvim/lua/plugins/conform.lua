return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
        go = { "gofumpt", "goimports" },
        astro = { "prettierd" },
        java = { "google-java-format" },
      },
      formatters = {
        prettier = {
          single_quote = true,
          jsx_single_quote = true,
        },
      },
    }
    return opts
  end,
}
