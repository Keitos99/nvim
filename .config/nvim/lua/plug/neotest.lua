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
    { nargs = "*", desc = "Run nearest test" }
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
    "<leader>tl",
    function() require("neotest").output.open({ enter = true, last_run = true }) end,
  },

  {
    "<leader>ts",
    function() require("neotest").summary.toggle() end,
  },

  {
    "<leader>tr",
    function() require("neotest").summary.run_marked() end,
  },

  {
    "<leader>to",
    function() require("neotest").output_panel.toggle() end,
  },

  {
    "[n",
    function() require("neotest").jump.prev({ status = "failed" }) end,
  },
  {
    "]n",
    function() require("neotest").jump.next({ status = "failed" }) end,
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
    quickfix = {
      enabled = true,
      open = function() vim.cmd("Trouble quickfix") end,
    },
  })
  create_user_cmds()
end

return M
