-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

return {
  documents = {
    File = {
      Default = "",
      Symlink = "",
      Files = "",
    },
    Folder = {
      Default = "",
      Open = "",
      Empty = "",
      EmptyOpen = "",
      Symlink = "",
    },
  },
  nvim_tree = {
    git = {
      unstaged = "",
      staged = "S",
      unmerged = "",
      renamed = "",
      deleted = "",
      untracked = "U",
      ignored = "◌",
    },
  },
  git = {
    Add = "",
    Mod = "",
    Remove = "",
    Ignore = "",
    Rename = "",
    Diff = "",
    Repo = "",
    ChangedLine = "▎",
  },
  ui = {
    ArrowClosed = "",
    ArrowOpen = "",
    Lock = "",
    Circle = "",
    BigCircle = "",
    BigUnfilledCircle = "",
    Close = "",
    NewFile = "",
    Search = "",
    Lightbulb = "",
    Project = "",
    Dashboard = "",
    History = "",
    Comment = "",
    Code = "",
    Telescope = " ",
    Gear = "",
    Package = "",
    List = "",
    SignIn = "",
    SignOut = "",
    Check = "",
    Fire = "",
    Note = "",
    BookMark = "",
    Pencil = "",
    ChevronRight = ">",
    Table = "",
    Calendar = "",
    CloudDownload = "",
  },
  diagnostics = {
    Error = "",
    Warning = "",
    Information = "",
    Question = "",
    Hint = "",
  },

  todo = {
    FIX = "!",
    TODO = "",
    WARN = "",
    NOTE = "",
    HACK = "",
    PERF = "",
    TEST = "",
  },
  misc = {
    Robot = "ﮧ",
    Squirrel = "",
    Tag = "",
    Watch = "",
  },
  dap = {
    BreakPoint = "",
    StopPoint = "",
    BreakPointRejected = "",
    ConditionalBreakpoint = "?>",
    LogPoint = ".>",
  },

  candies = {
    -- these are what's available for now:
    history = {
      icon = "",
      icon_highlight = "Constant",
      text_highlight = "",
    },
    scratch = {
      icon = "",
      icon_highlight = "Character",
      text_highlight = "",
    },
    connection = {
      icon = "󱘖",
      icon_highlight = "SpecialChar",
      text_highlight = "",
    },
    database_switch = {
      icon = "",
      icon_highlight = "Character",
    },
    table = {
      icon = "",
      icon_highlight = "Conditional",
      text_highlight = "",
    },
    view = {
      icon = "",
      icon_highlight = "Debug",
      text_highlight = "",
    },
    add = {
      icon = "",
      icon_highlight = "String",
      text_highlight = "String",
    },
    edit = {
      icon = "󰏫",
      icon_highlight = "Directory",
      text_highlight = "Directory",
    },
    remove = {
      icon = "󰆴",
      icon_highlight = "SpellBad",
      text_highlight = "SpellBad",
    },
    help = {
      icon = "󰋖",
      icon_highlight = "Title",
      text_highlight = "Title",
    },
    source = {
      icon = "󰃖",
      icon_highlight = "MoreMsg",
      text_highlight = "MoreMsg",
    },

    -- if there is no type
    -- use this for normal nodes...
    none = {
      icon = " ",
    },
    -- ...and use this for nodes with children
    none_dir = {
      icon = "",
      icon_highlight = "NonText",
    },

    -- chevron icons for expanded/closed nodes
    node_expanded = {
      icon = "",
      icon_highlight = "NonText",
    },
    node_closed = {
      icon = "",
      icon_highlight = "NonText",
    },
  },
}
