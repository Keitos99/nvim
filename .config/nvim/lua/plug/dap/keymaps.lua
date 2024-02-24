return {
  {
    "<leader>dc",
    function()
      require("dap").continue()
    end,
    desc = "Dap continue",
    { silent = true },
  },
  {
    "<leader>drl",
    function()
      require("dap").run_last()
    end,
    { silent = true, desc = "Run the last debug session again" },
  },
  {
    "<leader>drc",
    function()
      require("dap").run_to_cursor()
    end,
    { silent = true, desc = "run to cursor" },
  },
  {
    "<leader>dX",
    ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>",
    { exit = true, silent = true, desc = "Disconnect from the debug session" },
  },
  {
    "<leader>dx",
    function()
      require("dap").close()
    end,
    { silent = true, desc = "Close debug session" },
  },
  {
    "<leader>db",
    function()
      require("dap").toggle_breakpoint()
    end,
    { silent = true, desc = "Toggle breakpoint" },
  },
  {
    "<leader>dt",
    ":lua require('dapui').toggle({ reset = true })<CR>",
    { nowait = true, desc = "Toggle UI" },
  },
  {
    "<leader>df",
    "<CMD>lua require('dapui').float_element()<CR>",
    { silent = true, desc = "Toggle UI" },
  },
  {
    "<leader>dR",
    "<CMD>lua require('dapui').float_element('repl', {position = 'center', enter = true})<CR>",
    { silent = true, desc = "Toggle reply" },
  },
  {
    "<leader>dS",
    "<CMD>lua require('dapui').float_element('stacks', {enter = true})<CR>",
    { silent = true, desc = "Toggle stacks ui" },
  },
  {
    "<leader>dB",
    function()
      require("dap").set_breakpoint(vim.fn.input({ prompt = "Breakpoint condition: " }))
    end,
    { silent = true, desc = "Set conditional breakpoints" },
  },
  {
    -- the log message wil be printed to the dap-repl
    "<leader>dlb",
    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    { nowait = true, desc = "set logpoints" },
  },

  {
    "<leader>df",
    function()
      local ok, jdtls = pcall(require, "jdtls")

      if not ok then
        return
      end

      if vim.bo.modified then
        vim.cmd("w")
      end
      jdtls.test_class()
    end,
  },

  {
    "<leader>dn",
    function()
      local ok, jdtls = pcall(require, "jdtls")
      if not ok then
        return
      end

      if vim.bo.modified then
        vim.cmd("w")
      end
      jdtls.test_nearest_method()
    end,
  },
  { "<F1>", ":lua require('dapui').toggle({ layout = 1, reset = true })<CR>" },
  { "<F2>", ":lua require('dapui').toggle({ layout = 2, reset = true })<CR>" },
  { "<F3>", ":lua require('dapui').toggle({ layout = 3, reset = true })<CR>" },

  { "<F8>", ":lua require('dap').step_over()<CR>" },
  { "<F7>", ":lua require('dap').step_into()<CR>" },
  { "<S-F8>", ":lua require('dap').step_out()<CR>" },
}
