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
    desc = "Run the last debug session again",
    { silent = true },
  },
  {
    "<leader>drc",
    function()
      require("dap").run_to_cursor()
    end,
    desc = "run to cursor",
    { silent = true },
  },
  {
    "<leader>dX",
    ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>",
    desc = "Disconnect from the debug session",
    { exit = true, silent = true },
  },
  {
    "<leader>dx",
    function()
      require("dap").close()
    end,
    desc = "Close debug session",
    { silent = true },
  },
  {
    "<leader>db",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "Toggle breakpoint",
    { silent = true },
  },
  {
    "<leader>dt",
    ":lua require('dapui').toggle({ reset = true })<CR>",
    desc = "Toggle UI",
    { nowait = true },
  },
  {
    "<leader>df",
    "<CMD>lua require('dapui').float_element()<CR>",
    desc = "Toggle UI",
    { silent = true },
  },
  {
    "<leader>dR",
    "<CMD>lua require('dapui').float_element('repl', {position = 'center', enter = true})<CR>",
    desc = "Toggle reply",
    { silent = true },
  },
  {
    "<leader>dS",
    "<CMD>lua require('dapui').float_element('stacks', {enter = true})<CR>",
    desc = "Toggle stacks ui",
    { silent = true },
  },
  {
    "<leader>dB",
    function()
      require("dap").set_breakpoint(vim.fn.input({ prompt = "Breakpoint condition: " }))
    end,
    desc = "Set conditional breakpoints",
    { silent = true },
  },
  {
    -- the log message wil be printed to the dap-repl
    "<leader>dlb",
    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    desc = "set logpoints",
    { nowait = true },
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
    ft = "java",
    desc = "test class if jdtls was installed",
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
    ft = "java",
    desc = "run test nearest method if jdtls was installed",
  },
  { "<F1>", ":lua require('dapui').toggle({ layout = 1, reset = true })<CR>" },
  { "<F2>", ":lua require('dapui').toggle({ layout = 2, reset = true })<CR>" },
  { "<F3>", ":lua require('dapui').toggle({ layout = 3, reset = true })<CR>" },

  { "<F8>", ":lua require('dap').step_over()<CR>" },
  { "<F7>", ":lua require('dap').step_into()<CR>" },
  { "<S-F8>", ":lua require('dap').step_out()<CR>" },
}
