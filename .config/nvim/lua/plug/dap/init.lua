local icons = require("config.ui.icons").dap
local signs = {
  { name = "DapBreakpoint",          text = icons.BreakPoint,            highlight = "DiagnosticSignError" },
  { name = "DapStopped",             text = icons.StopPoint,             highlight = "DiagnosticWarn" },
  { name = "DapBreakpointRejected",  text = icons.BreakPointRejected,    highlight = "DiagnosticError" },
  { name = "DapBreakpointCondition", text = icons.ConditionalBreakpoint, highlight = "DiagnosticInfo" },
  { name = "DapLogPoint",            text = icons.LogPoint,              highlight = "DiagnosticInfo" },
}
return {
  {
    "rcarriga/nvim-dap-ui", -- a UI for nvim-dap
  },
  {
    "mfussenegger/nvim-dap", -- debug adapter protocol client implementation for neovim
    -- event = "BufReadPre",
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
    end,
    keys = require("plug.dap.keymaps"),
  },
  require("plug.dap.print"),
}
