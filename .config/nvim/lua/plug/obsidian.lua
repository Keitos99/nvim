local NOTES_DIR = vim.fn.expand("~") .. "/Documents/Notes"

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cond = require("config.helper").is_existing_dir(NOTES_DIR),
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  cmd = {
    "Obsidian",
  },
  event = {
    "BufReadPre " .. NOTES_DIR .. "/**.md",
    "BufNewFile " .. NOTES_DIR .. "/**.md",
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

    templates = {
      folder = "~/Documents/Notes/templates/",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },

    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({ "xdg-open", url }) -- linux
    end,

    follow_img_func = function(img)
      vim.fn.jobstart({ "xdg-open", img }) -- linux
    end,

    ui = {
      checkboxes = {
        [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
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
