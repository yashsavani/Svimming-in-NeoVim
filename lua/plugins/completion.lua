
local keymap = vim.api.nvim_set_keymap

require("compe").setup({
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
      path = { kind = "   (Path)" },
      buffer = { kind = "   (Buffer)" },
      calc = { kind = "   (Calc)" },
      vsnip = { kind = "   (Snippet)" },
      nvim_lsp = { kind = "   (LSP)" },
      nvim_lua = { kind = "  " },
      spell = { kind = "   (Spell)" },
      tags = false,
      treesitter = false,
      -- snippets_nvim = {kind = "  "},
      -- ultisnips = {kind = "  "},
      -- treesitter = {kind = "  "},
      emoji = { kind = " ﲃ  (Emoji)", filetypes={"markdown", "text"} }
      -- for emoji press : (idk if that in compe tho)

      -- path = true,
      -- buffer = true,
      -- calc = true,
      -- vsnip = true,
      -- nvim_lsp = true,
      -- nvim_lua = true,
      -- spell = false,
      -- tags = false,
      -- snippets_nvim = false,
      -- treesitter = false,
    },
})

keymap("i", "<C-space>", "compe#complete()", { expr = true, silent = true })
keymap("i", "<CR>", "v:lua.completions()", { expr = true, silent = true })
keymap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true, silent = true })
keymap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true, silent = true })
