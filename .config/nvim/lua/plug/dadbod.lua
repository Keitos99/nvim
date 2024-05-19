return {
  "kristijanhusak/vim-dadbod-ui",
  lazy = true,
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" },
      lazy = true,
      config = function()
        print("AGYP[2]: dadbod.lua:10 (after config = function())")
        -- Setup up vim-dadbod
        require("cmp").setup.filetype({ "sql", "mysql" }, {
          sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
          },
        })
      end,
    },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
