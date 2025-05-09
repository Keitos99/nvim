local icons = require("config.ui.icons")

local M = {}

-- Plugins
local function add_signature(bufnr)
  local signature = require("lsp_signature")
  signature.on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded",
    },
  }, bufnr)

  vim.keymap.set(
    { "n" },
    "<leader>k",
    function() signature.toggle_float_win() end,
    { silent = true, noremap = true, desc = "toggle signature" }
  )
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

---@type vim.diagnostic.Opts
M.DEFAULT_CONFIG = {
  virtual_text = false, -- easily becomes annoying
  virtual_lines = false, -- config for lsp_lines
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
    },
  },
}

function M.setup()
  vim.diagnostic.config(M.DEFAULT_CONFIG)

  -- HACK: workaround for https://github.com/neovim/nvim-lspconfig/issues/2309
  if not vim.lsp.handlers["workspace/diagnostic/refresh"] then
    vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
      local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
      pcall(vim.diagnostic.reset, ns)
      return true
    end
  end
end

function M.on_attach(client, bufnr)
  M.set_keymaps(client.name, bufnr)
  M.highlight_document(client)
end

function M.highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if not client.server_capabilities.document_highlight then return end

  vim.cmd([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
  ]])
end

function M.set_keymaps(client_name, bufnr)
  local fmt = function(cmd)
    return function(str) return cmd:format(str) end
  end

  local lsp = fmt("<cmd>lua vim.lsp.%s<cr>")
  local diagnostic = fmt("<cmd>lua vim.diagnostic.%s<cr>")

  local opts = { noremap = true, silent = true, buffer = bufnr }
  local map = vim.keymap.set

  -- :h lsp-defaults
  -- gr: references
  -- K: hover

  map("n", "grr", "<cmd>Telescope lsp_references<CR>", opts)
  map("n", "gD", lsp("buf.declaration()"), opts)
  map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
  map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- gri
  map("n", "<leader>rn", lsp("buf.rename()"), opts) -- or grn
  map("n", "<leader>ca", lsp("buf.code_action()"), opts) -- or gra
  map("n", "K", lsp("buf.hover({ border = 'rounded'})"), opts)

  map("n", "gl", diagnostic("open_float()"), opts)
  map("n", "[d", diagnostic("jump({ count=-1 })") .. "zz", opts)
  map("n", "]d", diagnostic("jump({ count=1 })") .. "zz", opts)

  map(
    "n",
    "<leader>F",
    function() require("conform").format({ bufnr = bufnr, lsp_format = "fallback", timeout_ms = 500 }) end,
    opts
  )

  -- client name based keymaps
  if client_name == "jdtls" then
    map("n", "<A-o>", "<Cmd>lua require('jdtls').organize_imports()<CR>", opts)

    opts.desc = "Test current java class"
    map("n", "<leader>dC", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)

    opts.desc = "Test nearest java method"
    map("n", "<leader>dM", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
    return
  end

  if client_name == "typescript-tools" then
    map("n", "<M-o>", "<Cmd>TSToolsRemoveUnused<CR><Cmd>TSToolsAddMissingImports<CR>", opts)
    return
  end

  if vim.tbl_contains({ "pyright", "basedpyright" }, client_name) then
    vim.keymap.set("n", "<A-o>", "<Cmd>PyrightOrganizeImports<CR>", opts)
    return
  end
end

return M
