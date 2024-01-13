local ls = require("luasnip")
local snippet = ls.snippet
-- local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
return {
  snippet("shebang", {
    text({ "#!/usr/bin/env python", "" }),
    insert(0),
  }),
}
