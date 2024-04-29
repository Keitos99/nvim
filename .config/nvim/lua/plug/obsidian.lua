return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  cmd = {
    "ObsidianYesterday",
    "ObsidianToday",
    "ObsidianTomorrow",
  },
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Notes/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Notes/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/Notes/",
      },
    },
    preferred_link_style = "markdown",
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "diary",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },

    ui = {
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        -- Replace the above with this if you don't have a patched font:
        -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

        -- You can also add more custom ones...
      },
    },
    attachments = {
      img_folder = "media",
    },
    note_id_func = function(title)
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
      end
      return title
    end,
  },
}
