local M = {
  -- a  preview for quickfix
  "kevinhwang91/nvim-bqf",
  ft = "qf",
}

function M.config()
  local ok, bqf = pcall(require, "bqf")
  if not ok then
    return
  end

  bqf.setup({
    preview = {
      win_height = 5,
      win_vheight = 5,
    },
  })
end

return M
