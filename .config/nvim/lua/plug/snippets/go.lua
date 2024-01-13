local ls = require("luasnip")
local snippet = ls.snippet
-- local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
return {
  snippet("test", {
    text("func "),
    insert(1, "Name"),
    text("(t *testing.T)"),
    text({ " {", "" }),
    text("\t"),
    insert(0),
    text({ "", "}" }),
  }),
  snippet("typei", {
    text("type "),
    insert(1, "Name"),
    text({ " interface {", "" }),
    text("\t"),
    insert(0),
    text({ "", "}" }),
  }),
  snippet("types", {
    text("type "),
    insert(1, "Name"),
    text({ " struct {", "" }),
    text("\t"),
    insert(0),
    text({ "", "}" }),
  }),
  snippet("func", {
    text("func "),
    insert(1, "Name"),
    text("("),
    insert(2),
    text(")"),
    insert(3),
    text({ " {", "" }),
    text("\t"),
    insert(0),
    text({ "", "}" }),
  }),
  snippet("if", {
    text("if "),
    insert(1, "true"),
    text({ " {", "" }),
    text("\t"),
    insert(0),
    text({ "", "}" }),
  }),

  snippet("fori", {
    text("for "),
    insert(1, "i := 0"),
    text(";"),
    insert(2, "i < 10"),
    text(";"),
    insert(3, "i++"),
    text({ " {", "" }),
    text("\t"),
    insert(0),
    text({ "", "}" }),
  }),
  snippet("forr", {
    text("for "),
    insert(1, "k, v"),
    text(" := range "),
    insert(2, "expr"),
    text({ " {", "" }),
    text("\t"),
    insert(0),
    text({ "", "}" }),
  }),
}
