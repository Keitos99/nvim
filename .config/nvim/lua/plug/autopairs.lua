local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = { "string" },
    },
    fast_wrap = {
      map = "<A-e>", -- documenting default key mapping
    },
  },
}

function M.config(_, opts)
  local npairs = require("nvim-autopairs")
  npairs.setup(opts)

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then return end
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
