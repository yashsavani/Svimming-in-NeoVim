local ts_config = require("nvim-treesitter.configs")

ts_config.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    use_languagetree = true,
  },
  indent = { enable = true },
  rainbow = { enable = true, extended_mode = true },
  autopairs = { enable = true },
  autotag = { enable = true },
  matchup = { enable = true },
}
