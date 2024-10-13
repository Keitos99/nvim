local function create_user_cmds()
  vim.api.nvim_create_user_command(
    "TestCurrent",
    function() require("neotest").run.run() end,
    { nargs = "*", desc = "Run nearest test" }
  )

  vim.api.nvim_create_user_command(
    "TestAll",
    function() require("neotest").run.run(vim.fn.expand("%")) end,
    { nargs = "*", desc = "Run all test of the current file" }
  )

  vim.api.nvim_create_user_command(
    "TestDap",
    function() require("neotest").run.run({ strategy = "dap" }) end,
    { nargs = "*", desc = "Debug nearest test" }
  )

  vim.api.nvim_create_user_command(
    "TestStop",
    function() require("neotest").run.stop() end,
    { nargs = "*", desc = "Stop nearest test" }
  )

  vim.api.nvim_create_user_command(
    "TestToggleSummary",
    function() require("neotest").summary.toggle() end,
    { nargs = "*", desc = "Toggle test summary" }
  )
end

local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/nvim-nio",
  },
  cmd = {
    "TestCurrent",
    "TestAll",
    "TestDap",
    "TestStop",
  },
}

M.keys = {

  {
    "<leader>tc",
    function() require("neotest").run.run() end,
    desc = "Run nearest test",
  },
  {
    "<leader>ta",
    function() require("neotest").run.run(vim.fn.expand("%")) end,
    desc = "Run all test of the current file",
  },
  {
    "<leader>td",
    function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end,
    desc = "Run nearest test with nvim-dap",
  },
  {
    "<leader>tS",
    function() require("neotest").run.stop() end,
    desc = "Run nearest test with nvim-dap",
  },
  {
    "<leader>tl",
    function() require("neotest").output.open({ enter = true, last_run = true }) end,
    desc = "Open last test output",
  },

  {
    "<leader>ts",
    function() require("neotest").summary.toggle() end,
    desc = "Toggle test summary",
  },

  {
    "<leader>tr",
    function() require("neotest").summary.run_marked() end,
    desc = "Run marked tests",
  },

  {
    "<leader>to",
    function() require("neotest").output_panel.toggle() end,
    desc = "Toggle test output",
  },

  {
    "[n",
    function() require("neotest").jump.prev({ status = "failed" }) end,
    desc = "Jump to previous failed test",
  },
  {
    "]n",
    function() require("neotest").jump.next({ status = "failed" }) end,
    desc = "Jump to next failed test",
  },
}

function M.config()
  local neotest = require("neotest")
  local helper = require("config.helper.python")

  neotest.setup({
    adapters = {
      require("neotest-python")({
        dap = { justMyCode = false },
        python = helper.get_python_path,
      }),
      require("neotest-jest")({
        jestCommand = require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h")) .. " --watch",
      }),
    },
  })
  create_user_cmds()
end

return M
