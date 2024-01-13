-- maybe replace sqls with sqlls -> https://github.com/joe-re/sql-language-server
-- nvim-lspconfig: ae3debc fix(sqls): deprecate sqls suggest sqlls instead (#2544) (2 hours ago)

local handlers = require("plug.lsp.handlers")

vim.g.sql_type_default = "mysql"

local get_tree_root = function(bufnr, capture_group)
  local parser = vim.treesitter.get_parser(bufnr, capture_group, {})
  local tree = parser:parse()[1]
  return tree:root()
end

---@param mods? string
---@param range_given? boolean
---@param show_vertical? '"-show-vertical"'
---@param line1? integer
---@param line2? integer
local function execute_query(mods, range_given, show_vertical, line1, line2)
  local function get_sqls_client_id()
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      if client.name == "sqls" then
        return client.id
      end
    end
    return nil
  end

  local client_id = get_sqls_client_id()
  if client_id == nil then
    return
  end
  require("sqls.commands").exec(client_id, "executeQuery", mods, range_given, show_vertical, line1, line2)
end

local function execute_query_under_cursor()
  local capture_group = "stmt"
  local lang = "sql"
  local current_line = vim.fn.line(".") - 1
  local bufnr = vim.api.nvim_get_current_buf()

  local root = get_tree_root(bufnr)
  local statement_query = vim.treesitter.query.parse(lang, "(statement) @" .. capture_group)

  for id, node in statement_query:iter_captures(root, bufnr, 0, -1) do
    local name = statement_query.captures[id]
    local is_statement = name == capture_group

    if is_statement then
      local range = { node:range() } -- = { start row, start col, end row, end col }
      local start_line = range[1]
      local end_line = range[3]

      if current_line >= start_line and current_line <= end_line then
        execute_query("", true, nil, start_line + 1, end_line + 1)
        return
      end
    end
  end
end

return {
  capabilities = handlers.capabilities,
  cmd = { "sqls", "-config", os.getenv("HOME") .. "/.config/sqls/config.yml" },
  on_attach = function(client, bufnr)
    local sqls = require("sqls")
    sqls.on_attach(client, bufnr)
    handlers.on_attach(client, bufnr)

    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set

    map("n", "<leader>cn", "<cmd>SqlsExecuteCursor<CR>", opts)
    map("n", "<leader>cna", "<cmd>SqlsExecuteQuery<CR>", opts)
    map("v", "<leader>cn", ":SqlsExecuteQuery<CR>", opts)

    vim.api.nvim_create_user_command("SqlsExecuteCursor", function()
      execute_query_under_cursor()
    end, { nargs = "*", desc = "Execute the statement under the cursor" })
  end,
  -- NOTE: using $HOME/.config/sqls/config.yml using $HOME/.configsqlsconfig.yml instead instead
  -- settings = {
  -- -- for configurations: https://github.com/lighttiger2505/sqls#configuration-file-sample
  --   sqls = {
  --     connections = {
  --     },
  --   },
  -- },
}
