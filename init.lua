require("pluginlist")

local cmd = vim.cmd -- To execute Vim commands e.g. cmd("pwd").
local fn = vim.fn -- To call Vim functions e.g. fn.bufnr().

-- PLUGIN CONFIGS
require("onedark").setup()
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.nvimtree")
require("plugins.gitsigns")
require("plugins.comment")
require("plugins.autopairs")
require("plugins.neoscroll")
cmd "runtime macros/sandwich/keymap/surround.vim"
require("plugins.indentline")
require("plugins.dashboard")
require("plugins.galaxyline")
require("plugins.barbar")

-- SETTINGS
vim.g.mapleader = " "
vim.g.python3_host_prog = "/usr/local/anaconda3/bin/python3"
vim.g.onedark_style = "warm"

cmd "syntax on"
cmd "syntax enable" -- Enable syntax highlighting.

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

opt("o", "encoding", "utf-8") -- Set encoding.
opt("o", "fileencoding", "utf-8") -- Set encoding written to file.
opt("o", "hidden", true) -- Allow background buffers.
opt("o", "pumblend", 10) -- Enables transperency of popup menu.
opt("o", "pumheight", 15) -- Makes popoup menu smaller.
opt("o", "ruler", true) -- Show cursor position
opt("o", "cmdheight", 2) -- More space for displaying messages.
opt("o", "mouse", "a") -- Enable mouse.
opt("o", "splitbelow", true) -- Horizontal splits will automatically be below.
opt("o", "splitright", true) -- Vertical splits will automatically be to the right.
opt("o", "termguicolors", true) -- set term gui colors most terminals support this.
opt("w", "number", true) -- Line numbers.
opt("w", "relativenumber", true) -- Relative line numbers.
opt("w", "cursorline", true) -- Enable highlighting of the current line.
opt("o", "hlsearch", true) -- Highlight search
opt("o", "incsearch", true) -- Search in realtime.
opt("o", "laststatus", 2) -- Always have a status line.
opt("o", "scrolloff", 5) -- Keep 5 lines between cursor and vertical edges of window.
opt("o", "showmatch", true) -- Show matching brackets.
opt("o", "showtabline", 2) -- Always show tab line.
opt("b", "swapfile", false) -- No swapfile.
opt("w", "list", true) -- Show list of formatting. Doesn't seem to work for some reason.
opt("o", "inccommand", "nosplit") -- Show effect of a command in realtime.
opt("o", "title", true) -- Set title.
opt("b", "tabstop", 2) -- Set tabstop to 2.
opt("b", "shiftwidth", 2) -- Set tabstop to 2.
opt("o", "smarttab", true) -- Makes tabbing smarter.
opt("b", "expandtab", true) -- Converts tabs to spaces.
opt("o", "autoindent", true) -- Inherit indenting.
opt("b", "autoread", true) -- Automatically update changes.
opt("b", "smartindent", true) -- Makes indenting smart.
opt("o", "shiftround", true) -- Round indent to multiples of 2.
opt("o", "smartcase", true) -- Search smartly.
opt("o", "showtabline", 2) -- Always show tabs.
opt("w", "signcolumn", "yes") -- Always show the signcolumn, otherwise it would shift the text each time.
opt("o", "updatetime", 300) -- Faster completion.
opt("o", "timeoutlen", 500) -- Default is much longer at 1000ms.
opt("o", "guifont", [['Operator Mono Lig', 'Cascadia Code PL', 'MonoLisa', 'JetBrains Mono', 'Fira Code', 'MenloLGS NF', Menlo, Monaco, 'Courier New', monospace]]) -- Fonts!!!

vim.bo.iskeyword = vim.bo.iskeyword..",-"
vim.o.iskeyword = vim.o.iskeyword..",-"
vim.o.shortmess = vim.o.shortmess.."c"

-- KEY-MAPPINGS

local noremap_silent = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap

-- NOPS
map("n", "<Space>", [[<NOP>]], noremap_silent)

-- Better escapes.
map("i", "jk", [[<Esc>]], noremap_silent)
map("c", "jk", [[<C-C>]], noremap_silent)
map("i", "kj", [[<Esc>]], noremap_silent)

-- Better window resizing.
map("n", "<S-Left>", [[:vertical resize +2<CR>]], noremap_silent)
map("n", "<S-Up>", [[:resize -2<CR>]], noremap_silent)
map("n", "<S-Right>", [[:vertical resize -2<CR>]], noremap_silent)
map("n", "<S-Down>", [[:resize +2<CR>]], noremap_silent)

-- Terminal
map("n", "<leader>tl", [[<Cmd>vnew term://zsh <CR>]], noremap_silent) -- term over right
map("n", "<leader>tj", [[<Cmd>split term://zsh | resize 10 <CR>]], noremap_silent) --  term bottom
map("n", "<leader>tt", [[<Cmd>tabnew | term <CR>]], noremap_silent) -- term newtab

-- Better window navigation.
map("n", "<C-h>", [[<C-w>h]], noremap_silent)
map("n", "<C-j>", [[<C-w>j]], noremap_silent)
map("n", "<C-l>", [[<C-w>l]], noremap_silent)
map("n", "<C-k>", [[<C-w>k]], noremap_silent)

-- Better indentation.
map("v", "<", [[<gv]], noremap_silent)
map("v", ">", [[>gv]], noremap_silent)
map("v", "<C-]>", [[>gv]], noremap_silent)
map("v", "<C-[>", [[<gv]], noremap_silent)
map("n", "<C-]>", [[>>]], noremap_silent)
map("n", "<C-[>", [[<<]], noremap_silent)

-- Tab switch buffer.
map("n", "<TAB>", [[:BufferNext<CR>]], noremap_silent) -- TAB in normal mode will move to the next buffer.
map("n", "<S-TAB>", [[:BufferPrevious<CR>]], noremap_silent) -- SHIFT + TAB in normal mode will move to prev bufffer.
map("n", "<S-x>", [[:BufferClose<CR>]], noremap_silent) -- SHIFT + TAB in normal mode will move to prev bufffer.
map("n", "<A-1>", [[:BufferGoto 1<CR>]], noremap_silent) -- SHIFT + TAB in normal mode will move to prev bufffer.


-- Move selected  line / block of text in visual mode.
map("x", "K", [[:move '<-2<CR>gv-gv]], noremap_silent)
map("x", "J", [[:move '>+1<CR>gv-gv]], noremap_silent)

-- Quick Save
map("i", "<C-s>", [[<Esc>:w<CR>a]], noremap_silent)
map("n", "<C-s>", [[:w<CR>]], noremap_silent)

-- Quick Save and exit
map("n", "<C-x>", [[:x<CR>]], noremap_silent)

-- Emacs sol and eol.
map("i", "<C-e>", [[<Esc>A]], noremap_silent)
map("i", "<C-a>", [[<Esc>I]], noremap_silent)

-- Clear Highlights
map("n", "<Leader>l", [[:noh<CR>]], noremap_silent)

-- Telescope
map("n", "<C-p>", [[:lua require("telescope.builtin").find_files()<CR>]], noremap_silent)
map("n", "<Leader>ff", [[:lua require("telescope.builtin").find_files()<CR>]], noremap_silent)
map("n", "<Leader>fo", [[:lua require("telescope.builtin").oldfiles()<CR>]], noremap_silent)
map("n", "<Leader>fw", [[:lua require("telescope.builtin").live_grep()<CR>]], noremap_silent)
map("n", "<Leader>fb", [[:lua require("telescope.builtin").buffers()<CR>]], noremap_silent)
map("n", "<Leader>fh", [[:lua require("telescope.builtin").help_tags()<CR>]], noremap_silent)
map("n", "<Leader>fm", [[:lua require("telescope").extensions.media_files.media_files()<CR>]], noremap_silent)
map("n", "<Leader>fp", [[:lua require("telescope").extensions.project.project{}<CR>]], noremap_silent)

-- Dashboard
map("n", "<Leader>fn", [[:DashboardNewFile<CR>]], noremap_silent)
map("n", "<Leader>bm", [[:DashboardJumpMarks<CR>]], noremap_silent)

-- nvim tree.lua
map("n", "`", [[:lua require("togglenvimtree").toggle()<CR>]], noremap_silent)
map("n", "<C-n>", [[:lua require("togglenvimtree").toggle()<CR>]], noremap_silent)

-- comment toggle
map("n", "<leader>,", ":CommentToggle<CR>", noremap_silent)
map("v", "<leader>,", ":CommentToggle<CR>", noremap_silent)

-- AUTOCOMMANDS

cmd "filetype plugin on"

cmd [[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]]

-- hide line numbers in terminal windows
vim.api.nvim_exec([[
   au BufEnter term://* setlocal nonumber | setlocal norelativenumber | set laststatus=0 | startinsert
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
]], false)

-- require("highlights")
