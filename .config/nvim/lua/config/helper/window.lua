local M = {}

-- this function is based on the plugin mrjones2014/smart-splits.nvim
function M.resize_window(direction, amount)
  ---@param direction string
  ---@return string
  local function get_opposite_direction(direction)
    if direction == "h" then return "l" end
    if direction == "l" then return "h" end
    if direction == "j" then return "k" end
    if direction == "k" then return "j" end

    assert(false, "Invalid direction " .. direction)
    return ""
  end

  ---@param amount integer
  ---@return string
  local function format_amount(amount)
    if amount > 0 then
      return "+" .. amount
    else
      -- the minus sign will automatically be added
      return tostring(amount)
    end
  end

  local winnr = vim.fn.winnr()
  local is_at_edge = vim.fn.winnr(direction) == winnr
  local is_opposite_edge = vim.fn.winnr(get_opposite_direction(direction)) == winnr

  local is_horizontal_resize = direction == "h" or direction == "l"
  local resize_cmd = is_horizontal_resize and "vertical resize" or "resize"
  if is_at_edge then
    -- resize the window in the given direction
    vim.cmd(resize_cmd .. " " .. format_amount(amount))
  elseif is_opposite_edge then
    -- resize the window in the opposite direction
    vim.cmd(resize_cmd .. " " .. format_amount(-1 * amount))
  else
    -- is somewhere in the middle, so resize the window in the given direction
    vim.cmd(resize_cmd .. " " .. format_amount(amount))
  end
end

return M
