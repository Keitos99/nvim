return {
  {
    "<leader>dc",
    function() require("dap").continue() end,
    desc = "Dap continue",
    { silent = true },
  },
  {
    "<leader>dl",
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

  { "<F1>", ":lua require('dap-view').toggle(true)<CR>" },

  { "<F8>", ":lua require('dap').step_over()<CR>" },
  { "<F9>", ":lua require('dap').continue()<CR>" },
  { "<F7>", ":lua require('dap').step_into()<CR>" },
  { "<S-F8>", ":lua require('dap').step_out()<CR>" },
}
