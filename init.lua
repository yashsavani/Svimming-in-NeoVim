local cmd = vim.cmd -- To execute Vim commands e.g. cmd("pwd").
local execute = vim.api.nvim_command
local fn = vim.fn

-- PACKER BOOTSTRAP
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute "packadd packer.nvim"
end


-- PLUGIN CONFIGURATION
require("pluginlist")

require("plugins.treesitter")
require("plugins.lspconfig")
require("plugins.trouble")
require("plugins.lspsaga")
require("plugins.lspkind")
require("plugins.compeconfig")
require("plugins.telescope")
require("plugins.nvimtree")
require("plugins.gitsigns")
require("plugins.neogit")
require("plugins.comment")
require("plugins.autopairs")
require("plugins.neoscroll")
cmd "runtime macros/sandwich/keymap/surround.vim"
require("plugins.indentline")
require("plugins.dashboard")
require("plugins.hexokinase")
require("plugins.galaxyline")
require("plugins.barbar")


-- SETTINGS
vim.g.mapleader = " "
vim.g.python3_host_prog = "/usr/local/anaconda3/bin/python"

cmd "syntax on"
cmd "syntax enable" -- Enable syntax highlighting.

-- Theme
-- require("onedark").setup()
-- vim.g.onedark_style = "warm"
cmd "colorscheme sonokai"

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
opt("o", "pumblend", 10) -- Enables transparency of popup menu.
opt("o", "pumheight", 15) -- Makes popup menu smaller.
opt("o", "ruler", true) -- Show cursor position
opt("o", "cmdheight", 2) -- More space for displaying messages.
opt("o", "mouse", "a") -- Enable mouse.
opt("o", "splitbelow", true) -- Horizontal splits will automatically be below.
opt("o", "splitright", true) -- Vertical splits will automatically be to the right.
opt("o", "termguicolors", true) -- set term gui colors most terminals support this.
opt("w", "number", true) -- Line numbers.
opt("w", "relativenumber", true) -- Relative line numbers.
opt("w", "cursorline", false) -- Enable highlighting of the current line.
opt("o", "hlsearch", true) -- Highlight search
opt("o", "incsearch", true) -- Search in real-time.
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
opt("o", "background", "dark") -- Dark Background
opt("o", "completeopt", "menu,menuone,noselect") -- To allow compe

vim.o.shortmess = vim.o.shortmess.."c"
vim.o.formatoptions = vim.o.formatoptions:gsub("cro", "") -- Stop extending comments


-- KEY-MAPPINGS
local noremap_silent = {noremap = true, silent = true}
local noremap_silent_expr = {noremap = true, silent = true, expr = true}
local map = vim.api.nvim_set_keymap

-- Better escapes.
map("i", "jk", [[<Esc>]], noremap_silent)
map("c", "jk", [[<C-C>]], noremap_silent)

-- Better window resizing.
map("n", "<S-Right>", [[:vertical resize +2<CR>]], noremap_silent)
map("n", "<S-Up>", [[:resize -2<CR>]], noremap_silent)
map("n", "<S-Left>", [[:vertical resize -2<CR>]], noremap_silent)
map("n", "<S-Down>", [[:resize +2<CR>]], noremap_silent)

-- Better terminal keymaps.
map("n", "<Leader>tl", [[<Cmd>vnew term://zsh<CR>]], noremap_silent) -- term over right
map("n", "<Leader>tj", [[<Cmd>split term://zsh | resize 10<CR>]], noremap_silent) --  term bottom
map("n", "<Leader>tt", [[<Cmd>tabnew | term<CR>]], noremap_silent) -- term new tab
map("t", "<C-h>", [[<C-\><C-N><C-w>h]], noremap_silent)
map("t", "<C-j>", [[<C-\><C-N><C-w>j]], noremap_silent)
map("t", "<C-k>", [[<C-\><C-N><C-w>k]], noremap_silent)
map("t", "<C-l>", [[<C-\><C-N><C-w>l]], noremap_silent)
map("i", "<C-h>", [[<C-\><C-N><C-w>h]], noremap_silent)
map("i", "<C-j>", [[<C-\><C-N><C-w>j]], noremap_silent)
map("i", "<C-k>", [[<C-\><C-N><C-w>k]], noremap_silent)
map("i", "<C-l>", [[<C-\><C-N><C-w>l]], noremap_silent)
map("t", "<Esc>", [[<C-\><C-n>]], noremap_silent)
map("t", "jk", [[<C-\><C-n>]], noremap_silent)

-- Better window navigation.
map("n", "<C-h>", [[<C-w>h]], noremap_silent)
map("n", "<C-j>", [[<C-w>j]], noremap_silent)
map("n", "<C-l>", [[<C-w>l]], noremap_silent)
map("n", "<C-k>", [[<C-w>k]], noremap_silent)

-- Better indentation.
map("v", "<", [[<gv]], noremap_silent)
map("v", ">", [[>gv]], noremap_silent)

-- Switch buffer.
map("n", "<Leader><TAB>", [[:BufferNext<CR>]], noremap_silent) -- TAB in normal mode will move to the next buffer.
map("n", "<Leader><S-TAB>", [[:BufferPrevious<CR>]], noremap_silent) -- SHIFT + TAB in normal mode will move to prev buffer.
map("n", "<Leader>w", [[:BufferClose<CR>]], noremap_silent)
map("n", "<A-1>", [[:BufferGoto 1<CR>]], noremap_silent) -- Alt+n will go to the nth buffer
map("n", "<A-2>", [[:BufferGoto 2<CR>]], noremap_silent) -- Alt+n will go to the nth buffer
map("n", "<A-3>", [[:BufferGoto 3<CR>]], noremap_silent) -- Alt+n will go to the nth buffer
map("n", "<A-4>", [[:BufferGoto 4<CR>]], noremap_silent) -- Alt+n will go to the nth buffer
map("n", "<A-5>", [[:BufferGoto 5<CR>]], noremap_silent) -- Alt+n will go to the nth buffer
map("n", "<A-6>", [[:BufferGoto 6<CR>]], noremap_silent) -- Alt+n will go to the nth buffer

-- Move selected line / block of text in visual mode.
map("x", "K", [[:move '<-2<CR>gv-gv]], noremap_silent)
map("x", "J", [[:move '>+1<CR>gv-gv]], noremap_silent)
map("n", "<A-k>", [[:move -2<CR>==]], noremap_silent)
map("n", "<A-j>", [[:move +<CR>==]], noremap_silent)

-- Quick save.
map("n", "<Leader>s", [[:w<CR>]], noremap_silent)

-- Quick exit.
map("n", "<Leader>q", [[:q<CR>]], noremap_silent)
map("n", "<Leader>x", [[:close<CR>]], noremap_silent)

-- Emacs-like sol and eol.
map("i", "<C-e>", [[<Esc>A]], noremap_silent)
map("i", "<C-a>", [[<Esc>I]], noremap_silent)

-- Toggle highlights.
map("n", "<Leader>h", [[:set hlsearch!<CR>]], noremap_silent)

-- Telescope keymaps.
map("n", "<C-p>", [[:lua require("telescope.builtin").find_files()<CR>]], noremap_silent)
map("n", "<Leader>ff", [[:lua require("telescope.builtin").find_files()<CR>]], noremap_silent)
map("n", "<Leader>fo", [[:lua require("telescope.builtin").oldfiles()<CR>]], noremap_silent)
map("n", "<Leader>fg", [[:lua require("telescope.builtin").live_grep()<CR>]], noremap_silent)
map("n", "<Leader>fb", [[:lua require("telescope.builtin").buffers()<CR>]], noremap_silent)
map("n", "<Leader>fh", [[:lua require("telescope.builtin").help_tags()<CR>]], noremap_silent)
map("n", "<Leader>fm", [[:lua require("telescope.builtin").man_pages()<CR>]], noremap_silent)
map("n", "<Leader>fM", [[:lua require("telescope").extensions.media_files.media_files()<CR>]], noremap_silent)
map("n", "<Leader>fp", [[:lua require("telescope").extensions.project.project{}<CR>]], noremap_silent)

-- Compe keymaps.
map("i", "<C-space>", [[compe#complete()]], { expr = true, silent = true })
-- map("i", "<Tab>", [[pumvisible() ? "<C-n>" : "<Tab>"]], { expr = true, silent = true })
-- map("i", "<S-Tab>", [[pumvisible() ? "<C-p>" : "<S-Tab>"]], { expr = true, silent = true })

-- Better nav for autocomplete.
map("i", "<C-j>", [[("<C-n>")]], noremap_silent_expr)
map("i", "<C-k>", [[("<C-p>")]], noremap_silent_expr)

-- Dashboard keymaps.
map("n", "<Leader>;;", [[:Dashboard<CR>]], noremap_silent)
map("n", "<Leader>;n", [[:DashboardNewFile<CR>]], noremap_silent)
map("n", "<Leader>;m", [[:DashboardJumpMarks<CR>]], noremap_silent)

-- nvim-tree keymaps.
map("n", "`", [[:lua require("togglenvimtree").toggle()<CR>]], noremap_silent)
map("n", "<C-n>", [[:lua require("togglenvimtree").toggle()<CR>]], noremap_silent)

-- Toggle comments.
map("n", "<Leader>,", [[:CommentToggle<CR>]], noremap_silent)
map("v", "<Leader>,", [[:CommentToggle<CR>]], noremap_silent)

-- Diagnostic keymaps.
map("n", "<Leader>dt", [[:TroubleToggle<CR>]], noremap_silent)
map("n", "<Leader>do", [[:TodoTrouble<CR>]], noremap_silent)
map("n", "<Leader>dw", [[:TroubleToggle lsp_workspace_diagnostics<CR>]], noremap_silent)
map("n", "<Leader>dd", [[:TroubleToggle lsp_document_diagnostics<CR>]], noremap_silent)
map("n", "<Leader>dq", [[:TroubleToggle quickfix<CR>]], noremap_silent)
map("n", "<Leader>dl", [[:TroubleToggle loclist<CR>]], noremap_silent)
map("n", "<Leader>dr", [[:TroubleToggle lsp_references<CR>]], noremap_silent)
map("n", "<Leader>dx", [[:cclose<CR>]], noremap_silent)
map("n", "gR", [[:TroubleToggle lsp_references<CR>]], noremap_silent)
map("n", "<Leader>dot", [[:TodoTelescope<CR>]], noremap_silent)

map("n", "<Leader>e", [[:lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>]], noremap_silent)
map("n", "[e", [[:lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>]], noremap_silent)
map("n", "]e", [[:lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>]], noremap_silent)

-- LSP keymaps.
map("n", "<Leader>la", [[:lua require("lspsaga.codeaction").code_action()<CR>]], noremap_silent)
map("v", "<Leader>la", [[:<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>]], noremap_silent)
map("n", "<Leader>ld", [[:Telescope lsp_document_diagnostics<CR>]], noremap_silent)
map("n", "<Leader>lw", [[:Telescope lsp_workspace_diagnostics<CR>]], noremap_silent)
map("n", "<Leader>lf", [[:lua vim.lsp.buf.formatting()<CR>]], noremap_silent)
map("n", "<Leader>lh", [[:lua require("lspsaga.hover").render_hover_doc()<CR>]], noremap_silent)
map("n", "<Leader>lI", [[:LspInfo<CR>]], noremap_silent)
map("n", "<Leader>ll", [[:lua require"lspsaga.provider".lsp_finder()<CR>]], noremap_silent)
map("n", "<Leader>lp", [[:lua require"lspsaga.provider".preview_definition()<CR>]], noremap_silent)
map("n", "<Leader>lq", [[:Telescope quickfix<CR>]], noremap_silent)
map("n", "<Leader>lr", [[:lua require("lspsaga.rename").rename()<CR>]], noremap_silent)
map("n", "<Leader>lt", [[:lua vim.lsp.buf.type_definition()<CR>]], noremap_silent)
map("n", "<Leader>lx", [[:cclose<CR>]], noremap_silent)
map("n", "<Leader>lsd", [[:Telescope lsp_document_symbols<CR>]], noremap_silent)
map("n", "<Leader>lsw", [[:Telescope lsp_dynamic_workspace_symbols<CR>]], noremap_silent)

if vim.bo.ft ~= "vim" then map("n", "K", [[:lua require("lspsaga.hover").render_hover_doc()<CR>]], noremap_silent) end
map("n", "<C-k>", [[:lua require("lspsaga.signaturehelp").signature_help()<CR>]], noremap_silent)

-- Neogit keymaps.
map("n", "<Leader>gg", [[:lua require("neogit").open({ kind = "vsplit" })<CR>]], noremap_silent)
map("n", "<Leader>gc", [[:lua require("neogit").open({ "commit" })<CR>]], noremap_silent)
map("n", "<Leader>gj", [[:lua require("gitsigns").next_hunk()<CR>]], noremap_silent)
map("n", "<Leader>gk", [[:lua require("gitsigns").prev_hunk()<CR>]], noremap_silent)


-- AUTOCOMMANDS
cmd "filetype plugin indent on"
vim.api.nvim_exec([[
  au BufEnter term://* setlocal nonumber | setlocal norelativenumber | set laststatus=0
  au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
  au BufEnter {} if line2byte('.') == -1 && len(tabpagebuflist()) == 1 | Dashboard | endif
  au BufRead,BufNewFile *.lua set formatoptions-=cro
  au Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  au FileType markdown setlocal spell
  au FileType gitcommit setlocal spell
  au Filetype markdown setlocal com=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,b:-,b:1. | set formatoptions=tcroqln
  augroup pencil
    autocmd!
    autocmd FileType markdown,mkd call pencil#init()
    autocmd FileType text         call pencil#init()
  augroup END
]], false)
