local slow_format_filetypes = {}
return {
  "stevearc/conform.nvim",
  event = "BufReadPost",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      bash = { "beautysh" },
      zsh = { "beautysh" },
      sh = { "beautysh" },
    },

    format_on_save = function(bufnr)
      -- disable format on save globally or locally
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end

      -- detect slow formatter and run those asynchronously
      if slow_format_filetypes[vim.bo[bufnr].filetype] then return end
      local function on_format(err)
        if err and err:match("timeout$") then slow_format_filetypes[vim.bo[bufnr].filetype] = true end
      end

      return { timeout_ms = 200, lsp_format = "fallback" }, on_format
    end,

    format_after_save = function(bufnr)
      -- only run "slow"
      if not slow_format_filetypes[vim.bo[bufnr].filetype] then return end
      return { lsp_format = "fallback" }
    end,
  },

  config = function(_, opts)
    require("conform").setup(opts)

    -- Disable
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
