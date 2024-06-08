local M = {}

local icons = require("config.ui.icons")
local signs = {
  { name = "DiagnosticSignError", text = icons.diagnostics.Error },
  { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
  { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
  { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
}

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
M.DEFAULT_CONFIG = {
  virtual_text = false, -- easily becomes annoying
  virtual_lines = false, -- config for lsp_lines
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

function M.setup()
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config(M.DEFAULT_CONFIG)

  -- HACK: workaround for https://github.com/neovim/nvim-lspconfig/issues/2309
  if not vim.lsp.handlers["workspace/diagnostic/refresh"] then
    vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
      local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
      pcall(vim.diagnostic.reset, ns)
      return true
    end
  end

  -- LspAttach autocommand
  local autocmd = vim.api.nvim_create_autocmd
  autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      local lsp = require("plug.lsp.handlers")
      lsp.on_attach(client, bufnr)
    end,
  })
end

function M.on_attach(client, bufnr)
  M.load_plugins(client, bufnr)
  M.set_keymaps(bufnr)
  M.highlight_document(client)
end

function M.extend_with_telescope(telescope)
  -- changing ui with plugins
  vim.lsp.handlers["textDocument/references"] = telescope.lsp_references
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

function M.load_plugins(client, bufnr) add_signature() end

function M.set_keymaps(bufnr)
  local fmt = function(cmd)
    return function(str) return cmd:format(str) end
  end

  local lsp = fmt("<cmd>lua vim.lsp.%s<cr>")
  local diagnostic = fmt("<cmd>lua vim.diagnostic.%s<cr>")

  local opts = { noremap = true, silent = true, buffer = bufnr }
  local map = vim.keymap.set

  map("n", "gD", lsp("buf.declaration()"), opts)
  map("n", "gd", lsp("buf.definition()"), opts)
  map("n", "K", lsp("buf.hover()"), opts)
  map("n", "gi", lsp("buf.implementation()<CR>"), opts)
  map("n", "gr", lsp("buf.references()"), opts)
  map("n", "<leader>rn", lsp("buf.rename()"), opts)
  map("n", "<leader>ca", lsp("buf.code_action()"), opts)
  map("n", "<leader>F", lsp("buf.format({async = true})"), opts)

  map("n", "gl", diagnostic("open_float()"), opts)
  map("n", "[d", diagnostic("goto_prev({ border = 'rounded' })") .. "zz", opts)
  map("n", "]d", diagnostic("goto_next({ border = 'rounded' })") .. "zz", opts)
end

return M
