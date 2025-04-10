-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.cs" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.julia" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.file-explorer.oil-nvim" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.lsp.nvim-lsp-endhints" },
}
