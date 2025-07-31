return {
  "saghen/blink.cmp",
  build = "cargo build --release",
  lazy = false,
  opts = {
    completion = {
      menu = { border = nil },
      documentation = { window = { border = "none" } },
      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
        transform_items = function(ctx, items)
          local line = ctx.cursor[1] - 1
          local col = ctx.cursor[2]

          for _, item in ipairs(items) do
            if item.textEdit then
              if item.textEdit.range then
                -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textEdit
                -- trim edit range after cursor
                local range_end = item.textEdit.range["end"]
                if range_end.line == line and range_end.character > col then
                  range_end.character = col
                end
              elseif item.textEdit.insert then
                -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#insertReplaceEdit
                -- always use insert range
                item.textEdit.range = item.textEdit.insert
                item.textEdit.replace = nil
              end
            end
          end

          return items
        end,
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },
  },
}
