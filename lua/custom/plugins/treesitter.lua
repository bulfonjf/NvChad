require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "tsx",
    "typescript",
    "javascript",
    "css",
    "html",
    "c_sharp",
    "json",
  },
  highlight = { enable = true },
}
