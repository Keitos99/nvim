-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

return {
  Telescope = "  ",
  diagnostics = {
    Error = "",
    Warning = "",
    Information = "",
    Question = "",
    Hint = "󰌵",
  },
  todo = {
    FIX = "!",
    TODO = "",
    WARN = " ",
    NOTE = " ",
    HACK = " ",
    PERF = "",
    TEST = "",
  },
  dap = {
    BreakPoint = "",
    StopPoint = "",
    BreakPointRejected = "",
    ConditionalBreakpoint = "?>",
    LogPoint = ".>",
  },
}
