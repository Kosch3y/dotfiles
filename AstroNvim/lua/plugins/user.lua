-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "folke/which-key.nvim",
    opts = {
      triggers_nowait = {
        -- registers
        '"',
        "<c-r>",
        -- spelling
        "z=",
      },
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for keymaps that start with a native binding
        i = { "j", "k", ";", "," },
        v = { "j", "k" },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "kdheepak/nvim-dap-julia",
      config = function()
        require("nvim-dap-julia").setup()
      end,
    },
  },

  -- == Examples of Overriding Plugins ==

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
}
