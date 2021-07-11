require("gitsigns").setup {
  signs = {
    -- TODO add hl to colorscheme
    add = { hl = "GitSignsAdd", text = "▌", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = {
      hl = "GitSignsChange",
      text = "▌",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    delete = {
      hl = "GitSignsDelete",
      text = "契",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "契",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "~",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ["n ]g"] = {
      expr = true,
      [[&diff ? ']c' : '<cmd>lua require"gitsigns.actions".next_hunk()<CR>']],
    },
    ["n [g"] = {
      expr = true,
      [[&diff ? '[c' : '<cmd>lua require"gitsigns.actions".prev_hunk()<CR>']],
    },

    ["n <leader>gs"] = [[<cmd>lua require"gitsigns".stage_hunk()<CR>]],
    ["v <leader>gs"] = [[<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>]],
    ["n <leader>gu"] = [[<cmd>lua require"gitsigns".undo_stage_hunk()<CR>]],
    ["n <leader>gr"] = [[<cmd>lua require"gitsigns".reset_hunk()<CR>]],
    ["v <leader>gr"] = [[<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>]],
    ["n <leader>gR"] = [[<cmd>lua require"gitsigns".reset_buffer()<CR>]],
    ["n <leader>gp"] = [[<cmd>lua require"gitsigns".preview_hunk()<CR>]],
    ["n <leader>gb"] = [[<cmd>lua require"gitsigns".blame_line(true)<CR>]],

    -- Text objects
    ["o ih"] = [[:<C-U>lua require"gitsigns.actions".select_hunk()<CR>]],
    ["x ih"] = [[:<C-U>lua require"gitsigns.actions".select_hunk()<CR>]],
  },
  watch_index = { interval = 1000 },
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil, -- Use default
}
