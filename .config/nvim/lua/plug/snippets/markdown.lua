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
  -- Select link, press C-s, enter link to receive snippet
  snippet({
    trig = "link",
    namr = "markdown_link",
    dscr = "Create markdown link [txt](url)",
  }, {
    text("["),
    insert(1),
    text("]("),
    func(function(_, snip)
      return snip.env.TM_SELECTED_TEXT[1] or {}
    end, {}),
    text(")"),
    insert(0),
  }),
  snippet({
    trig = "codewrap",
    namr = "markdown_code_wrap",
    dscr = "Create markdown code block from existing text",
  }, {
    text("``` "),
    insert(1, "Language"),
    text({ "", "" }),
    func(function(_, snip)
      local tmp = {}
      tmp = snip.env.TM_SELECTED_TEXT
      tmp[0] = nil
      return tmp or {}
    end, {}),
    text({ "", "```", "" }),
    insert(0),
  }),
}
