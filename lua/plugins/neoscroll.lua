require("neoscroll").setup({
  -- All these keys will be mapped. Pass an empty table ({}) for no mappings
  mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
  hide_cursor = false, -- Don't hide cursor while scrolling
  stop_eof = false, -- Don't stop at <EOF> when scrolling downwards
  respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
})

require("neoscroll.config").set_mappings({
  ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "200" } },
  ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "200" } },
})

