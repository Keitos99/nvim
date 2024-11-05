local dap = require("dap")
local dap_utils = require("dap.utils")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "/home/agsayan/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter",
  },
}

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
    },
    {
      type = "pwa-node",
      request = "attach",
      -- port = 8888,
      name = "Attach process",
      program = "${file}",
      processId = dap_utils.pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end
