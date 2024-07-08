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
              function() require("hop").hint_patterns({}, '{\\|(\\|\\[\\|"') end,
              desc = "Hop hint bracket",
            },
            ["<leader>s"] = {
              function() require("hop").hint_char1() end,
              desc = "Hop hint char",
            },
            ["<S-l>"] = {
              function() require("hop").hint_lines_skip_whitespace() end,
              desc = "Hop hint line",
            },
          },
          v = {
            ["s"] = { function() require("hop").hint_words { extend_visual = true } end, desc = "Hop hint words" },
            ["<S-s>"] = {
              function() require("hop").hint_patterns({}, '{\\|(\\|\\[\\|"') end,
              desc = "Hop hint bracket",
            },
            ["<leader>s"] = {
              function() require("hop").hint_char1() end,
              desc = "Hop hint char",
            },
            ["<S-l>"] = {
              function() require("hop").hint_lines_skip_whitespace() end,
              desc = "Hop hint line",
            },
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
