local autocmd = vim.api.nvim_create_autocmd

-- auto save markdown files, before closing file
autocmd("FileType", { pattern = "markdown", command = "set awa" })

-- Check if we need to reload the file when it changed
autocmd("FocusGained", { command = "checktime" })

-- Highlight on yank
autocmd("TextYankPost", {
  desc = "highlight text on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "Search",
      timeout = 150,
      on_visual = true,
    })
  end,
})

-- show the cursor line only in the active window
autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", true)
      vim.wo.cursorline = false
    end
  end,
})

-- automatically jump to the last place you’ve visited in a file before exiting
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- LspAttach autocommand
autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end

    -- do not run on_attach for the GitHub Copilot lsp
    if client.name == "GitHub Copilot" then return end

    local lsp = require("plug.lsp.handlers")
    lsp.on_attach(client, bufnr)
  end,
})
