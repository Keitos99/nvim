local dap_mappings = {
  {
    "c",
    function()
      require("dap").continue()
    end,
    { silent = true },
  },
  {
    "rc",
    function()
      require("dap").run_to_cursor()
    end,
    { silent = true, desc = "run to cursor" },
  },
  {
    "rl",
    function()
      require("dap").run_last()
    end,
    { silent = true },
  },

  { "X", ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>", { exit = true, silent = true } },
  {
    "x",
    function()
      require("dap").close()
    end,
    { silent = true },
  },
  {
    "b",
    function()
      require("dap").toggle_breakpoint()
    end,
    { silent = true },
  },
  { "t", ":lua require('dapui').toggle({ reset = true })<CR>", { nowait = true, desc = "toggle UI" } },
  { "f", "<CMD>lua require('dapui').float_element()<CR>", { silent = true } },
  { "R", "<CMD>lua require('dapui').float_element('repl', {position = 'center', enter = true})<CR>", { silent = true } },
  { "S", "<CMD>lua require('dapui').float_element('stacks', {enter = true})<CR>", { silent = true } },
  {
    "B",
    function()
      require("dap").set_breakpoint(vim.fn.input({ prompt = "Breakpoint condition: " }))
    end,
    { silent = true },
  },
  {
    -- the log message wil be printed to the dap-repl
    "lb",
    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    { nowait = true },
  },

  {
    "f",
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
    "n",
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

  -- { "J", require("dap").step_over },
  -- { "L", require("dap").step_into },
  -- { "H", require("dap").step_out },
}

local keys = {}
for _, value in pairs(dap_mappings) do
  local mapping = value[1]
  local dap_action = value[2]

  if mapping == "J" or mapping == "L" or mapping == "H" then
    mapping = string.lower(mapping)
  end

  if dap_action ~= nil then
      -- local opts = { noremap = true, silent = true }
      -- local keymap = vim.keymap.set
    -- keymap("n", "<leader>d" .. mapping, dap_action, opts)
    table.insert(keys, { "<leader>d" .. mapping, dap_action })
  end

end
table.insert(keys, { "<F1>",  ":lua require('dapui').toggle({ layout = 1, reset = true })<CR>"})
table.insert(keys, { "<F2>",  ":lua require('dapui').toggle({ layout = 2, reset = true })<CR>"})
table.insert(keys, { "<F3>", ":lua require('dapui').toggle({ layout = 3, reset = true })<CR>" })

-- these are the same dap keymaps as on android studio
table.insert(keys, { '<F8>', ":lua require('dap').step_over()<CR>" })
table.insert(keys, { "<F7>", ":lua require('dap').step_into()<CR>" })
table.insert(keys, { "<S-F8>", ":lua require('dap').step_out()<CR>" })
return keys
