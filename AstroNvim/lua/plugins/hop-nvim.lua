return {
  {
    "smoka7/hop.nvim",
    opts = {},
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["s"] = { function() require("hop").hint_words() end, desc = "Hop hint words" },
            ["<S-s>"] = {
              function() require("hop").hint_camel_case { current_line_only = true } end,
              desc = "Hop hint lines",
            },
            -- ["<S-s>"] = { ":HopNodes<cr>" },
          },
          v = {
            ["s"] = { function() require("hop").hint_words { extend_visual = true } end, desc = "Hop hint words" },
            ["<S-s>"] = {
              function() require("hop").hint_camel_case { current_line_only = true } end,
              desc = "Hop hint lines",
            },
            -- ["<S-s>"] = { ":HopNodes<cr>" },
          },
        },
      },
    },
  },
  {
    "catppuccin/nvim",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { hop = true } },
  },
}
