local dap = require("dap")
local dap_utils = require("dap.utils")
local filename = vim.api.nvim_buf_get_name(0)

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "/home/agsayan/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter",
  },
}

dap.adapters["node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "/home/agsayan/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter",
  },
}

local js_based_languages = { "javascript", "typescript" }
for _, language in ipairs(js_based_languages) do
  dap.configurations[language] = {

    {
      -- Configuration for R4
      type = "pwa-node",
      request = "launch",
      name = "Launch file (ts-node-dev)",
      skipFiles = { "<node_internals>/**" },
      runtimeExecutable = "${workspaceFolder}/node_modules/.bin/ts-node-dev",
      runtimeArgs = { "--respawn" },
      program = "${file}",
      console = "integratedTerminal", -- Use integrated terminal for better visibility
      outputCapture = "std", -- Capture standard output for debugging
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      skipFiles = { "<node_internals>/**" },
      runtimeExecutable = "node",
      runtimeArgs = { "--inspect" },
      program = "${file}",
      console = "integratedTerminal", -- Use integrated terminal for better visibility
      outputCapture = "std", -- Capture standard output for debugging
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach process",
      program = "${file}",
      processId = dap_utils.pick_process,
      cwd = "${workspaceFolder}",
      console = "integratedTerminal", -- Use integrated terminal for better visibility
      outputCapture = "std", -- Capture standard output for debugging
    },
  }
end
