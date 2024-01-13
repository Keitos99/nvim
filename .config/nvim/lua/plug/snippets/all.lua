local ls = require("luasnip")
local snippet = ls.snippet
-- local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node

local function date()
  return { os.date("%Y-%m-%d") }
end

return {
  snippet({
    trig = "date",
    namr = "Date",
    dscr = "Date in the form of YYYY-MM-DD",
  }, {
    func(date, {}),
  }),
  snippet("shebang", {
    text({ "#!/bin/sh", "" }),
    insert(0),
  }),
}
