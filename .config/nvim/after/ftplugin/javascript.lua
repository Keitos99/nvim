local dap = require("dap")
local dap_utils = require("dap.utils")
local js_debug_path = "js-debug-adapter"

local defaulf_adapter_config = {
  type = "server",
  host = "localhost",
  port = 8123,
  executable = {
    command = js_debug_path,
  },
}

local base_config = {
  skipFiles = { "<node_internals>/**" },
  console = "integratedTerminal",
  outputCapture = "std",
  cwd = "${workspaceFolder}",
}

dap.adapters["pwa-node"] = defaulf_adapter_config
dap.adapters["node"] = defaulf_adapter_config

local js_based_languages = { "javascript", "typescript" }
for _, language in ipairs(js_based_languages) do
  dap.configurations[language] = {
    vim.tbl_extend("force", base_config, {
      type = "pwa-node",
      request = "launch",
      name = "Launch file (ts-node-dev)",
      runtimeExecutable = "${workspaceFolder}/node_modules/.bin/ts-node-dev",
      runtimeArgs = { "--respawn" },
      program = "${file}",
    }),
    vim.tbl_extend("force", base_config, {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      runtimeExecutable = "node",
      runtimeArgs = { "--inspect" },
      program = "${file}",
    }),
    vim.tbl_extend("force", base_config, {
      type = "pwa-node",
      request = "attach",
      name = "Attach process",
      program = "${file}",
      processId = dap_utils.pick_process,
    }),
  }
end
