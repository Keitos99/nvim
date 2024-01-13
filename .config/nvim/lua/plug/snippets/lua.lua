local ls = require("luasnip")
local snippet = ls.snippet
-- local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
return {
  snippet("shebang", {
    text({ "#!/usr/bin/lua", "", "" }),
    insert(0),
  }),
  snippet("req", {
    text("require('"),
    insert(1, "Module-name"),
    text("')"),
    insert(0),
  }),
  snippet("func", {
    text("function("),
    insert(1, "Arguments"),
    text({ ")", "\t" }),
    insert(2),
    text({ "", "end", "" }),
    insert(0),
  }),
  snippet("forp", {
    text("for "),
    insert(1, "k"),
    text(", "),
    insert(2, "v"),
    text(" in pairs("),
    insert(3, "table"),
    text({ ") do", "\t" }),
    insert(4),
    text({ "", "end", "" }),
    insert(0),
  }),
  snippet("fori", {
    text("for "),
    insert(1, "k"),
    text(", "),
    insert(2, "v"),
    text(" in ipairs("),
    insert(3, "table"),
    text({ ") do", "\t" }),
    insert(4),
    text({ "", "end", "" }),
    insert(0),
  }),
  snippet("if", {
    text("if "),
    insert(1),
    text({ " then", "\t" }),
    insert(2),
    text({ "", "end", "" }),
    insert(0),
  }),
  snippet("M", {
    text({ "local M = {}", "", "" }),
    insert(0),
    text({ "", "", "return M" }),
  }),
}
