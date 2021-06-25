# Svimming in NeoVim.

A beautiful and fast neovim config written in lua.

## Introduction

I have been an avid programmer for several years now. Since I started programming I have used a variety of IDEs and editing software. However, I would inevitably always eventually return to Vim. It was the editing software that I began my programming journey with, and over the years I have become quite proficient at using it. Unfortunately, I have been really busy with work and other aspects of my life, and have not been able to customize my vim editor in the way I like until recently. For the most part, I have been using VS Code as my primary editor with the vim emulator and the VSpaceCode extension that serves as a quick config for a vim integration with VS Code. It has served me relatively well over the past few years and I have been very productive with it. However, I always knew that a customized vim editor would far surpass any IDE I could use. IDEs are very useful, but they often contain bloated extensions and code that slow down the application and hinder progress the programming progress. On the other hand, Vim and Emacs are extremely fast but take a lot of customization before you can be as productive on them. People do claim that you don't need some fancy editor to write code, but I've found that some quality of life tools like automatic linting, code highlighting, and in editor debugging tools can really make the difference between making programming a chore vs making it something you are excited to do everyday. To this end, now that I have had a little more time, I have created a custom neovim config that is designed for developers that want a fast editor with many of the undeniably useful features that ship with most IDEs. Along the way, I hope I can also teach you a little bit about how you can further customize this config to truly make it your own. After all, the key reason I decided to revert back to vim from VS Code was because of the customizability.

Now that we have a sense for what we are trying to achieve, a speedy editor with several of the nice to have features that ship with most modern IDEs, we can prioritize our config a little more. We will not shy away from using plugins. I do not have time to recode everything from scratch, and the community has already contributed several fantastic plugins for all of us to benefit from. Why not take advantage of that? However, plugins and extensions tend to create a lot of bloat, so while we won't be afraid of using plugins we should be mindful of the plugins we do chose to use. We can make sure that the plugins we use are designed and created from reputable sources, and continue to be maintained in case we every find a problem with them and want to report an issue. Furthermore, we want to make sure that the plugins are efficient and don't take up too much processing power. Often, as a quick sanity-check, we can bias our choice in plugins to those that are written in Lua or a more performant language than VimScript. While this does not guarantee efficiency, it is a good indicator of it. After all, a plugin that uses luaJIT to run will inevitably run faster for the more involved tasks like fuzzy matching.

With a general protocol in place for identifying appropriate plugins, we can turn towards the next important area to be aware of: Key Mappings. Of course, the most powerful aspect of Vim's interface is the versatility of its modal editing. There is definitely a learning curve involved to becoming a proficient vim user, but once you have reached some level of vim fluency with the basic commands, it's time to take it to the next level and start remapping keys to truly make vim an extension of your mind. We are going to be very mindful of how we map our keys and make sure that we try as little as possible to deviate from the way of vim. That is, we are going to try to stay as true as we can to the spirit of vim, while still adding the functionality we find useful.

This README is organized based on features. If you chose to use this configuration as your own, feel free to jump to the sections you are most interested in. Configuring Vim is a very parallel process; most parts of the editor do not interact with other parts. As long as the basic functionality is hashed out, the specifics for each area can evolve independently. The section selection has been entirely selfishly motivated. I have written each section based on my own limited knowledge of the Vim interface. Unfortunately, I am neither a newbie, nor an experienced Vim user, so the section choices will be diverse and opinionated based on my experiences with Vim.

I have thoroughly enjoyed configuring my Vim interface over the past few days and I am extremely excited to continue contributing to it as I use it in my daily life. I hope you enjoy using this config as much as I do, and please do feel free to reach out to me if there is anything you wanted to add or modify.

## General Information

This section will contain some general information that pertains to more than one aspect of the config features.

### NeoVim Version

With the introduction of tree-sitter, native lsp, and luaJIT to NeoVim, the choice between NeoVim and Vim was obvious. Only NeoVim currently has the functionality I need to make it the editor that can accomplish all my editing needs and desires. As of this writing, I am using the latest version of Neovim v0.5.0. This is the only version that supports many of the features I am using, so if you want to use this configuration, you will need this version as well. To get the latest version of NeoVim follow the instructions on their Github page (https://github.com/neovim/neovim/wiki/Installing-Neovim).

### Lua Language

One of the things that has always held me back from personalizing my Vim experience has been using VimScript. I was never a huge fan of the language, and have regularly lamented the lack of a formal language as the default configuration language for Vim. In fact, I expect a large part of Emacs' success can be owed to the fact that much of Emacs is written in Elisp, and Elisp can be used to customize the Emacs experience further. With the introduction of Neovim v0.5.0, my prayers have been answered in the form of LuaJIT. Now the latest version of NeoVim ships with a default Lua-based configuration language that is both well featured and fast (through the Just in Time Compiler). Refusing to use VimScript except for where it was absolutely unavoidable, I have elected to play a game of lava and rely on Lua for the configuration wherever possible. My primary programming language is Python, and I occasionally dabble in other functional languages like Haskell, Julia, and Lisp languages, as well as some more utility languages like JavaScript. However, I have never used Lua before. Nevertheless, I found learning Lua surprisingly easy, and quite enjoyable. Especially coming from a background in Python, Lua is quite a simple language and shares many similarities to other modern general purpose programming languages like Python. There were two key resources I used for learning Lua:

1. https://www.youtube.com/watch?v=iMacxZQMPXs (Derek Banas' Tutorial on Lua), and 
2. https://learnxinyminutes.com/docs/lua/

For someone coming from a Python background, some of the gotchas beyond the syntax changes are:

- All numbers are doubles.
- Variables that are not defined get a default value of nil.
- repeat ... until ... is a do while construct in Lua.
- Only one data type in the form of a table (essentially a Python dictionary).
  - Lists are just tables where the key is the location of the element in the list.
- One indexed :(.
- Metatables and metamethods allow overloading of operators for tables.
- No natural classes, but can be simulated using tables and metatables using Class:fn(...), which is equivalent to Class.fn(self, ...) where self is either the class or the object.
- The require function runs the file it operates on and sets it's return value to the value returned by the file.

For library specific documentation look at

- String: http://lua-users.org/wiki/StringLibraryTutorial.
- Table: http://lua-users.org/wiki/TableLibraryTutorial.

Like the browser exposes the DOM interface to JavaScript front-end applications, NeoVim exposes a global table called `vim` that can be used to interface with the NeoVim editor. Some references to learn how to use the global `vim` table are:

1. https://github.com/nanotee/nvim-lua-guide (This is the defacto standard reference for using Lua in Neovim).
2. https://icyphox.sh/blog/nvim-lua/.
3. https://github.com/tjdevries/config_manager/ (TJ's configuration repo for examples of how to use the Lua interface).

Things to keep in mind when using Lua code with vim are:

- the :lua command will let you run lua code from within vim. This is very useful if you want to print or inspect the contents of a table.
- `v:lua`: call Lua function in the global namespace directly from VimScript.
- `vim.inspect`: pretty-prints the Lua tables so you can examine their contents.
- `vim.loop`: module that exposes the functionality of the NeoVim event loop.
- `vim.lsp`: module that controls the built in LSP client.
- `vim.treesitter`: module that exposes the functionality of the tree-sitter library.
- `vim.api`: module that exposes the API functions.
  - `vim.api.nvim_eval()`: Evaluates VimScript expression strings and returns its value after converting the value into a Lua type.
  - `vim.api.nvim_exec()` = `vim.cmd()`: Also evaluates VimScript code, but optionally returns a value. For `vim.cmd()` the return flag is always set to false.
  - `vim.api.nvim_command()`: Executes an ex command.
  - `vim.api.nvim_replace_termcodes()`: Escape terminal codes and vim keycodes.
  - `vim.api.nvim_{set|get|del}_keymap()`: Global key mappings.
  - `vim.api.nvim_buf_{set|get|del}_keymap()`: Buffer-local key mappings.
- `vim.o.{option}`: behaves like `:set`.
- `vim.go.{option}`: behaves like `:setglobal`.
- `vim.bo.{option}`: behaves like `:setlocal` for buffer-local options.
- `vim.wo.{option}`: behaves like `:setlocal` for window-local options.
- `vim.g.{name}`: access to global variables.
- `vim.b.{name}`: access to buffer variables.
- `vim.w.{name}`: access to window variables.
- `vim.t.{name}`: access to tabpage variables.
- `vim.v.{name}`: access to vim variables.
- `vim.env.{name}`: access to environment variables.
- `vim.fn.{function}()`: can be used to call a VimScript function with Lua arguments.

### Directory Structure

This is definitely subject to change, but for now the structure is relatively simple. The entry file is init.lua. For now, this is where all the settings and most of the key mappings are located. Eventually I may break them out into individual files, but for now I didn't want to keep track of too many files. Also, having a lot of files can be jarring to someone new. Instead, I've broken the root level init.lua file into four chunks.

1. A plugin configuration section that manages where to load the settings for the plugins.
2. A settings section where the settings for the configuration are located.
3. A key-mappings section where the keymaps are defined.
4. An Autocommands section where the autocommands for filetype settings are located.

The CaKa_NF directory for a NerdFont patched version of the Cascadia Code font by Microsoft (https://github.com/microsoft/cascadia-code). It contains all the icons used by the editor to make it more aesthetically appealing.

The lua directory contains all the more specific pieces of configuration code.

The file pluginlist.lua contains the list of packer plugins to use as well as some configuration settins for Packer itself.

The togglenvimtree.lua file contains a specialized piece of code copied from https://github.com/mnabila/nvimrc that accounts for the nvimtree offset when calculating the size of the status bar.

The highlights.lua file contains specialized code for customized highlighting. It is not currently being used.

The plugins directory contains the customization preferences for the individual plugins. The customization files are named corresponding to the plugin they configure.

### Installation

If you want to use this configuration for yourself, first install the latest version of NeoVim as described in the NeoVim section. Then clone this repository into your `~/.config/nvim/` directory. The next time you start up NeoVim using the `nvim` command you should see a bunch of errors. Keep pressing enter to temporarily ignore them. Once you have passed all the errors install the plugins typing `:PackerSync` into the console in normal mode. Once all the packages have been installed (Some will fail, that's ok they will work once the tree-sitter plugins have been installed) quit out of nvim and start it again. This time you shouldn't have any errors, and your Neovim should be configured to work based on this repository. If you see a couple of symbols that look like question marks or weird characters it may be because you are using a font that is not patched with the correct icons. To remedy this you can either download a patched font from https://github.com/ryanoasis/nerd-fonts, or you can use the patched version of Cascadia Code we have provided in this repository under the CasKa_NF directory. Please check your OS documentation for specific instructions on how to install the font for your system. Once you have installed the font, make sure you are using that font for your terminal, and the weird symbols should be replaced by teh appropriate iconography chosen in this repository.


## Theme

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

