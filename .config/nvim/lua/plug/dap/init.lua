local icons = require("config.ui.icons").dap
local signs = {
  { name = "DapBreakpoint", text = icons.BreakPoint, highlight = "DiagnosticSignError" },
  { name = "DapStopped", text = icons.StopPoint, highlight = "DiagnosticWarn" },
  { name = "DapBreakpointRejected", text = icons.BreakPointRejected, highlight = "DiagnosticError" },
  { name = "DapBreakpointCondition", text = icons.ConditionalBreakpoint, highlight = "DiagnosticInfo" },
  { name = "DapLogPoint", text = icons.LogPoint, highlight = "DiagnosticInfo" },
}

return {
  {
    "mfussenegger/nvim-dap", -- debug adapter protocol client implementation for neovim
    dependencies = {
      "rcarriga/nvim-dap-ui", -- a UI for nvim-dap
      "nvim-neotest/nvim-nio", -- dependency of nvim-dap-ui
    },
    config = function()
      local dap = require("dap")
      local keymap = vim.keymap

      local dapui = require("plug.dap.ui")
      local startDap = function()
        keymap.set("n", "<down>", dap.step_over)
        keymap.set("n", "<right>", dap.step_into)
        keymap.set("n", "<left>", dap.step_out)
        dapui.open({ layout = 1 }) -- only show console and repl
      end

      local stopDap = function()
        pcall(keymap.del, "n", "<down>")
        pcall(keymap.del, "n", "<left>")
        pcall(keymap.del, "n", "<right>")
      end

      dap.listeners.after.event_initialized["dapui_config"] = startDap
      dap.listeners.before.event_terminated["dapui_config"] = stopDap
      dap.listeners.before.event_exited["dapui_config"] = stopDap

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.highlight, text = sign.text, numhl = "" })
      end

      -- add Command for clearing the buffer:
      vim.api.nvim_create_user_command("DapClear", function(args)
        -- TODO: The last few lines still appear after DapClear and

        ---@param buf integer
        local function clear_buffer(buf)
          -- Clear the content of the buffer
          vim.bo[buf].modifiable = true
          vim.api.nvim_buf_set_lines(buf, 0, -1, true, {})

          -- By default the buffer should not be modifiable
          vim.bo[buf].modifiable = false
        end

        -- Seach for all the dapui_console buffers
        local buffers = vim.api.nvim_list_bufs()
        for _, buf in ipairs(buffers) do
          -- Check if the buffer is loaded
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "dapui_console" then clear_buffer(buf) end
        end
      end, { desc = "Searches for the buffer with the filetype dapui_console and clears it content" })
    end,
    keys = require("plug.dap.keymaps"),
  },
  require("plug.dap.print"),
}
