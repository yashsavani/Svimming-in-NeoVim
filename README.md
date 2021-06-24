# Svimming in NeoVim.
A beautiful and fast neovim config written in lua.

## Plugins

Plugin Manager: Packer.

### Functionality

- TimUntersberger/neogit
- ahmedkhalf/lsp-rooter.nvim
- folke/lsp-trouble.nvim
- kabouzeid/nvim-lspinstall
- kyazdani42/nvim-tree.lua
- lewis6991/spellsitter.nvim
- neovim/nvim-lspconfig
- nvim-treesitter/nvim-treesitter
- nvim-treesitter/nvim-treesitter-textobjects

### Aesthetics

- RRethy/vim-hexokinase
- RRethy/vim-illuminate
- code-biscuits/nvim-biscuits
- glepnir/dashboard-nvim
- glepnir/galaxyline.nvim
- kyazdani42/nvim-web-devicons
- lewis6991/gitsigns.nvim
- lukas-reineke/indent-blankline.nvim
- navarasu/onedark.nvim
- nvim-telescope/telescope-fzy-native.nvim
- nvim-telescope/telescope-media-files.nvim
- nvim-telescope/telescope-project.nvim
- nvim-telescope/telescope.nvim
- onsails/lspkind-nvim
- p00f/nvim-ts-rainbow
- romgrk/barbar.nvim

### Quality of Life

- andymass/vim-matchup
- folke/which-key.nvim
- ggandor/lightspeed.nvim
- hrsh7th/nvim-compe
- hrsh7th/vim-vsnip
- karb94/neoscroll.nvim
- machakann/vim-sandwich
- terrortylor/nvim-comment
- windwp/nvim-autopairs
- windwp/nvim-ts-autotag


## Key-Mappings

### I hate escapes
jk -> <Esc>
jk -> <C-C>

### Resize Windows
<S-Right> -> :vertical resize +2<CR>
<S-Up> -> :resize -2<CR>
<S-Left> -> :vertical resize -2<CR>
<S-Down> -> :resize +2<CR>

### Terminal
<leader>tl -> <Cmd>vnew term://zsh <CR>
<leader>tj -> <Cmd>split term://zsh | resize 10 <CR>
<leader>tt -> <Cmd>tabnew | term <CR>
<A-h> -> <C-\><C-N><C-w>h
<A-j> -> <C-\><C-N><C-w>j
<A-k> -> <C-\><C-N><C-w>k
<A-l> -> <C-\><C-N><C-w>l
<A-h> -> <C-\><C-N><C-w>h
<A-j> -> <C-\><C-N><C-w>j
<A-k> -> <C-\><C-N><C-w>k
<A-l> -> <C-\><C-N><C-w>l
<Esc> -> <C-\><C-n>
jk -> <C-\><C-n>

### Better window navigation.
<A-h> -> <C-w>h
<A-j> -> <C-w>j
<A-l> -> <C-w>l
<A-k> -> <C-w>k

### Better indentation.
< -> <gv
> -> >gv

### Tab switch buffer.
<TAB> -> :BufferNext<CR>
<S-TAB> -> :BufferPrevious<CR>
<Leader>w -> :BufferClose<CR>
<A-1> -> :BufferGoto 1<CR>
<A-2> -> :BufferGoto 2<CR>
<A-3> -> :BufferGoto 3<CR>
<A-4> -> :BufferGoto 4<CR>
<A-5> -> :BufferGoto 5<CR>
<A-6> -> :BufferGoto 6<CR>

### Move selected  line / block of text in visual mode.
K -> :move '<-2<CR>gv-gv
J -> :move '>+1<CR>gv-gv
<A-u> -> :move -2<CR>==
<A-j> -> :move +<CR>==

### Quick Save
<C-s> -> :w<CR>
<Leader>s -> :w<CR>

### Quick exit
<Leader>q -> :q<CR>
<Leader>x -> :close<CR>

### Emacs sol and eol.
<C-e> -> <Esc>A
<C-a> -> <Esc>I

### Clear Highlights
<Leader>l -> :set hlsearch!<CR>

### Telescope
<C-p> -> :lua require("telescope.builtin").find_files()<CR>
<Leader>ff -> :lua require("telescope.builtin").find_files()<CR>
<Leader>fo -> :lua require("telescope.builtin").oldfiles()<CR>
<Leader>fw -> :lua require("telescope.builtin").live_grep()<CR>
<Leader>fb -> :lua require("telescope.builtin").buffers()<CR>
<Leader>fh -> :lua require("telescope.builtin").help_tags()<CR>
<Leader>fm -> :lua require("telescope").extensions.media_files.media_files()<CR>
<Leader>fp -> :lua require("telescope").extensions.project.project{}<CR>

### Dashboard
<Leader>fn -> :DashboardNewFile<CR>
<Leader>bm -> :DashboardJumpMarks<CR>

### nvim tree.lua
\` -> :lua require("togglenvimtree").toggle()<CR>
<C-n> -> :lua require("togglenvimtree").toggle()<CR>

### comment toggle
<leader>, -> :CommentToggle<CR>

### NeoGit
<leader>gg -> :lua require("neogit").open({ kind = "vsplit" })<CR>
<leader>gc -> :lua require("neogit").open({ "commit" })<CR>

## Inspired by

- https://github.com/mnabila/nvimrc
- https://github.com/siduck76/NvChad/tree/main
- https://github.com/ChristianChiarulli/LunarVim

