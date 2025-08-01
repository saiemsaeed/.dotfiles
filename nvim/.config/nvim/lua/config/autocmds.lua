-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
local function setup_dynamic_diagnostics()
  local current_line = -1
  local timer = nil

  -- Function to show virtual lines for current line
  -- Function to show virtual lines for current line
  local function show_virtual_lines()
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = {
        current_line = true,
      },
    })
  end

  -- Function to show virtual text (default state)
  local function show_virtual_text()
    vim.diagnostic.config({
      virtual_text = true,
      virtual_lines = false,
    })
  end

  -- Set up cursor movement detection
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    callback = function()
      local line = vim.api.nvim_win_get_cursor(0)[1]

      -- If we moved to a new line
      if line ~= current_line then
        current_line = line

        -- Cancel any existing timer
        if timer then
          timer:stop()
          timer = nil
        end

        -- Always show virtual text when moving to a new line
        show_virtual_text()
      end
    end,
    desc = "Reset to virtual text on cursor movement",
  })

  -- Show virtual lines on cursor hold
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      local line = vim.api.nvim_win_get_cursor(0)[1]
      local diagnostics = vim.diagnostic.get(0, { lnum = line - 1 })

      if #diagnostics > 0 then
        show_virtual_lines()
      end
    end,
    desc = "Show virtual lines on cursor hold",
  })

  -- Reset to virtual text when leaving insert mode or buffer
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave" }, {
    callback = function()
      if timer then
        timer:stop()
        timer = nil
      end
      show_virtual_text()
    end,
    desc = "Reset to virtual text display",
  })

  -- Initialize with virtual text
  show_virtual_text()
end

-- Set up the dynamic diagnostics
setup_dynamic_diagnostics()
