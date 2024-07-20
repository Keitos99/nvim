return {
  {
    "<leader>dc",
    function() require("dap").continue() end,
    desc = "Dap continue",
    { silent = true },
  },
  {
    "<leader>drl",
    function() require("dap").run_last() end,
    desc = "Run the last debug session again",
    { silent = true },
  },
  {
    "<leader>drc",
    function() require("dap").run_to_cursor() end,
    desc = "run to cursor",
    { silent = true },
  },
  {
    "<leader>db",
    function() require("dap").toggle_breakpoint() end,
    desc = "Toggle breakpoint",
    { silent = true },
  },
  {
    "<leader>dB",
    function() require("dap").set_breakpoint(vim.fn.input({ prompt = "Breakpoint condition: " })) end,
    desc = "Set conditional breakpoint",
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
    desc = "Toggle repl",
    { silent = true },
  },
  {
    "<leader>dlb",
    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    desc = "set logpoints, which be printed into the dap-repl",
    { nowait = true },
  },

  { "<F1>", ":lua require('dapui').toggle({ layout = 1, reset = true })<CR>" },
  { "<F2>", ":lua require('dapui').toggle({ layout = 2, reset = true })<CR>" },
  { "<F3>", ":lua require('dapui').toggle({ layout = 3, reset = true })<CR>" },
  { "<F4>", ":lua require('dapui').toggle({ layout = 4, reset = true })<CR>" },

  { "<F8>", ":lua require('dap').step_over()<CR>" },
  { "<F9>", ":lua require('dap').continue()<CR>" },
  { "<F7>", ":lua require('dap').step_into()<CR>" },
  { "<S-F8>", ":lua require('dap').step_out()<CR>" },
}
