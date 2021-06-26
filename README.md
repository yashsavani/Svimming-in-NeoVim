# Svimming in Neovim.

A beautiful and fast Neovim config written in Lua.

## Introduction

I have been an avid programmer for several years now. Since I started programming I have used a variety of IDEs and editing applications. However, no matter how far I strayed, I would inevitably return to Vim. It was the editing application I began my programming journey with, and over the years I have become quite proficient at using it. Unfortunately, I have been really busy with work and other aspects of my life, and have not been able to customize my Vim editor in the way I like until recently. For the most part, I have been using VS Code as my primary editor with the Vim emulator and the VSpaceCode extension, which serves as a quick config for a Vim integration. This setup has served me relatively well over the past few years through all my programming trials and tribulations. However, I always knew that a customized Vim editor would far surpass any IDE I could find. IDEs with their extenstions are very useful, but they often contain bloated code that slows down the application and hinder the programming progress. On the other hand, Vim and Emacs are extremely fast but take a lot of customization before you can be as productive on them. People do claim that you don't need some fancy editor with all their "unecessary" extenstions to write code, but I've found that some quality of life features like automatic linting, syntax highlighting, and in in-editor debugging tools can really make the difference between making programming a chore v.s. making it something you are excited to do everyday. To this end, now that I have a little more time, I have created a custom Neovim config that is designed for developers who want a fast editor with many of the undeniably useful features that ship with most IDEs and their extenstions. Along the way, I hope I can also teach you a little bit about how you can further customize this configuration to truly make it your own. After all, the key reason I decided to revert back to Vim from VS Code was because of the customizability.

Now that we have a sense for what we are trying to achieve, a speedy editor with several of the quality of life features that ship with most modern IDEs, we can prioritize our configuration a little more. We will not shy away from using plugins. I do not have time to recode everything from scratch, and the community has already contributed several fantastic plugins for all of us to benefit from. Why not take advantage of that? However, plugins and extensions tend to create a lot of software bloat, so while we won't be afraid of using plugins, we should be mindful of the plugins we do choose to use. We can make sure that the plugins we use are designe by and created by reputable sources, and that they continue to be maintained or are in a very stable state. Furthermore, we want to make sure that the plugins are efficient and don't take up too much processing power. Often, as a quick sanity-check, we can bias our choice of plugins to those that are written in Lua or a more performant language than VimScript. While this does not guarantee efficiency, it is a reasonably good indicator of it. After all, a plugin that uses LuaJIT to run will inevitably run faster for the more involved tasks like fuzzy matching.

With a general protocol in place for identifying appropriate plugins, we can turn towards the next important area to be aware of: Key-Mappings. One the most powerful aspect of Vim's interface is the versatility of its modal editing. There is definitely a learning curve involved to becoming a proficient Vim user, but once you have reached some level of Vim fluency with the basic in-built commands, it's time to take it to the next level and start remapping keys to truly make Vim an extension of your mind. We are going to be very mindful of how we map our keys and try to deviate as little from the Vim ethos as possible.

This README is organized based on features. If you chose to use this configuration as your own, feel free to jump to the sections you are most interested in. Configuring Vim is a very parallel process; most parts of the editor do not interact with other parts. As long as the basic functionality is hashed out, the specifics for each area can evolve independently. The section selection has been entirely selfishly motivated. I have written each section based on my own limited knowledge of the Vim interface. Hopefully, you will still find parts of this guide useful.

I have thoroughly enjoyed configuring my Vim interface over the past few days and I am extremely excited to continue contributing to it as I evolve as both a Vim user and a programmer. I hope you enjoy using this config as much as I do. Feel free to reach out to me if there is anything you wanted to add or modify to this configuration.

## General Information

This section will contain some general information about the Vim configuration.

### Neovim Version

With the introduction of Treesitter, Native LSP, and custom LuaJIT extensibility to Neovim, the choice between Neovim and Vim was obvious. Only Neovim currently has the functionality to fulfill all our requirements. As of this writing, this configuration only support the latest Neovim v0.5.0. To get the latest version of Neovim follow the instructions on their Github page (https://github.com/neovim/neovim/wiki/Installing-Neovim).

### Lua Language

One of the things that has always held me back from personalizing my Vim experience has been using VimScript. I was never a huge fan of the language, and have regularly lamented the lack of a formal language as the default configuration language for Vim. In fact, I expect a large part of Emacs' success can be owed to the fact that much of Emacs is written in Elisp, and that Elisp can be used by users to customize the Emacs experience further. With the introduction of LuaJIT to Neovim v0.5.0, Neovim now has a similarily powerful tool. Now the latest version of Neovim ships with a default Lua-based configuration language that is both well featured and fast (through the Just in Time Compiler). We are going to try to write as much of the configuration as we can in Lua, and therefore only use VimScript where it is unavoidable. My primary programming language is Python, though I do occasionally dabble in other functional languages like Haskell, Julia, and Lisp languages, I also often use utility languages like JavaScript for special purposes like making the front-end for web applications. However, I have never used Lua before. Nevertheless, I found learning Lua surprisingly easy, and quite enjoyable. Especially coming from a background in Python, Lua is quite a simple language and shares many similarities to other modern general purpose programming languages like Python. There were two key resources I used for learning Lua:

1. https://www.youtube.com/watch?v=iMacxZQMPXs (Derek Banas' Tutorial on Lua), and 
2. https://learnxinyminutes.com/docs/lua/.

For someone coming from a Python background, some of the gotchas beyond the syntax changes are:

- All numbers are doubles.
- Variables that are not defined get a default value of nil.
- `repeat ... until ...` is a do while construct in Lua.
- There is nly one data type: the table (essentially a Python dictionary).
  - Lists are just tables where the key is the location of the element in the table.
  - Lists are one indexed 😢.
- Metatables and metamethods allow overloading of operators for tables.
- There are no natural classes in Lua, but the OOP paradigm can be simulated using tables and metatables using `Class:fn(...)` and `object:fn(...)`.
- The `require` function runs the file it receives as an argument and sets it's return value to the value returned by code in the file.

For library specific documentation look at:

- String: http://lua-users.org/wiki/StringLibraryTutorial.
- Table: http://lua-users.org/wiki/TableLibraryTutorial.

Like the browser exposes the DOM interface to JavaScript front-end applications, Neovim exposes a global table `vim` that can be used to interface with the Neovim editor. Some references to learn how to use the global `vim` table are:

1. https://github.com/nanotee/nvim-lua-guide (This is the defacto standard reference for using Lua in Neovim).
2. https://icyphox.sh/blog/nvim-lua/.
3. https://github.com/tjdevries/config_manager/ (TJ's configuration repo for examples of how to use the Lua interface).

Some key takeaways from these resources are:

- the `:lua` command will let you run Lua code from within Vim. This is very useful if you want to print or inspect the contents of a table.
- `v:lua`: calls Lua function in the global namespace directly from VimScript.
- `vim.inspect`: pretty-prints the Lua tables so you can examine their contents.
- `vim.loop`: exposes the functionality of the Neovim event loop.
- `vim.lsp`: controls the built in LSP client.
- `vim.treesitter`: exposes the functionality of the built-in Treesitter library.
- `vim.api`: exposes the API functions.
  - `vim.api.nvim_eval()`: evaluates VimScript expression strings and returns its value after converting the value into a Lua type.
  - `vim.api.nvim_exec()` = `vim.cmd()`: evaluates VimScript code, but optionally returns a value. For `vim.cmd()` the return flag is always set to false.
  - `vim.api.nvim_command()`: executes an ex command.
  - `vim.api.nvim_replace_termcodes()`: escapes terminal codes and Vim keycodes.
  - `vim.api.nvim_{set|get|del}_keymap()`: changes global key-mappings.
  - `vim.api.nvim_buf_{set|get|del}_keymap()`: changes buffer-local key-mappings.
- `vim.o.{option}`: behaves like `:set`.
- `vim.go.{option}`: behaves like `:setglobal`.
- `vim.bo.{option}`: behaves like `:setlocal` for buffer-local options.
- `vim.wo.{option}`: behaves like `:setlocal` for window-local options.
- `vim.g.{name}`: accesses global variables.
- `vim.b.{name}`: accesses buffer variables.
- `vim.w.{name}`: accesses window variables.
- `vim.t.{name}`: accesses tabpage variables.
- `vim.v.{name}`: accesses Vim variables.
- `vim.env.{name}`: accesses environment variables.
- `vim.fn.{function}()`: can be used to call a VimScript function with Lua arguments.

Since we are electing to use Lua as our primary configuration language, we will be using Packer as our primary plugin manager. This was a default choice as most of the other configurations I looked at for inspiration had also chosen to go with the Packer plugin manager.

### Directory Structure

This is definitely subject to change, but for now the structure is relatively simple. The entry file is `init.lua`. For now, this is where all the settings and most of the key-mappings are located. Eventually I may break the contents of `init.lua` out into individual files, but for now I didn't want to keep track of too many files. Also, having a lot of files can be jarring to new users of the configuration. Instead, I've broken the root level `init.lua` file into four chunks.

1. A plugin configuration section that manages where to load the configuration for each of the plugins.
2. A settings section where the configuration for the settings is located.
3. A key-mappings section where the keymaps are defined.
4. An autocommands section where the autocommands for filetype specific settings are located.

The `CasKa_NF` directory contains a NerdFont patched version of the Cascadia Code font by Microsoft (https://github.com/microsoft/cascadia-code). The patched version contains all the icons used by the editor to make it more aesthetically appealing.

The `lua` directory contains all the more specific pieces of configuration code.

The `pluginlist.lua` file contains the list of packer plugins to use, as well as some configuration settins for Packer itself.

The `togglenvimtree.lua` file contains a specialized piece of code copied from https://github.com/mnabila/nvimrc that accounts for the nvim-tree offset when calculating the size of the status bar.

The `highlights.lua` file contains specialized code for customized highlighting. It is not currently being used.

The `plugins` directory contains the customization preferences for the individual plugins. The customization files are named corresponding to the plugin they configure.

### Installation

If you want to use this configuration for yourself, follow these instructions:

1. Install the latest version of Neovim as described in the Neovim section.
2. Clone this repository into your `~/.config/nvim/` directory.
3. Start up Neovim using the `nvim` command. You should see a bunch of errors. Keep pressing enter to temporarily ignore them.
4. Once you have passed all the errors install the plugins by typing `:PackerSync` into the console in normal mode.
5. Once all the plugins have been installed (Some will fail, but that's okay as they will work once the Treesitter plugins have been installed) quit out of nvim and start it again. This time you shouldn't have any errors, and your Neovim should be configured to work based on this repository. 

If you see a couple of symbols that look like question marks or weird characters, it may be because you are using a font that is not patched to include NerdFont icons. To remedy this you can either download a patched font from https://github.com/ryanoasis/nerd-fonts, or you can use the patched version of Cascadia Code I have provided in this repository in the `CasKa_NF` directory. Please check your OS documentation for specific instructions on how to install fonts on your system. Once you have installed the font, make sure you are using that font for your terminal. The weird symbols should be replaced by the appropriate iconography chosen in this repository.

## Theme

For now I am using the onedark.nvim theeme by navarasu. Eventually I do want to create my own custom theme though.

## Treesitter

## Language Server Protocol

## Fuzzy Finder (telescope)

## Explorer (nvim-tree)

## Git Integration (gitsigns, neogit)

## Statuslines (galaxyline, barbar)

## Miscellaneous

### dashboard
### nvim-comment
### nvim-autopairs
### neoscroll
### which-key
### vim-sandwich
### lightspeed
### indent-blankline
### vim-hexokinase
### vim-illuminate
### spellsitter


## Key-Mappings

The leader key is remapped to `<Space>`.

### I hate escapes
```
insert: jk -> Normal mode.
command: jk -> Cancel command.
```

### Resize Windows
```
normal: <S-Right> -> Increase width of window by 2 columns.
normal: <S-Up> -> Increase height of window by 2 columns.
normal: <S-Left> -> Decrease width of window by 2 columns.
normal: <S-Down> -> Decrease height of window by 2 columns.
```

### Terminal
```
normal: <leader>tl -> Open a terminal in a new right window.
normal: <leader>tj -> Open a terminal in a new bottom window.
normal: <leader>tt -> Open a terminal in a new tab.
terminal: <A-h> -> Move to left window.
terminal: <A-j> -> Move to lower window.
terminal: <A-k> -> Move to upper window.
terminal: <A-l> -> Move to right window.
insert: <A-h> -> Move to left window.
insert: <A-j> -> Move to lower window.
insert: <A-k> -> Move to upper window.
insert: <A-l> -> Move to right window.
terminal: <Esc> -> Normal mode in terminal.
terminal: jk -> Normal mode in terminal.
```

### Better window navigation.
```
normal: <A-h> -> Move to left window.
normal: <A-j> -> Move to lower window.
normal: <A-l> -> Move to upper window.
normal: <A-k> -> Move to right window.
```

### Better indentation.
```
visual: < -> Keep visual selection after indenting.
visual: > -> Keep visual selection after indenting.
```

### Switch buffer.
```
normal: <TAB> -> Go to next Buffer.
normal: <S-TAB> -> Go to previous Buffer.
normal: <Leader>w -> Close Buffer.
normal: <A-1> -> Go to first Buffer.
normal: <A-2> -> Go to second Buffer.
normal: <A-3> -> Go to third Buffer.
normal: <A-4> -> Go to fourth Buffer.
normal: <A-5> -> Go to fifth Buffer.
normal: <A-6> -> Go to sixth Buffer.
```

### Move selected  line / block of text in visual mode.
```
select: K -> Move line up.
select: J -> Move line down.
normal: <A-u> -> Move line up.
normal: <A-j> -> Move line down.
```

### Quick Save
```
normal: <C-s> -> Save.
normal: <Leader>s -> Save.
```

### Quick exit
```
normal: <Leader>q -> Quit.
normal: <Leader>x -> Close.
```

### Emacs sol and eol.
```
insert: <C-e> -> Go to end of line.
insert: <C-a> -> Go to start of line.
```

### Toggle Highlights
```
normal: <Leader>l -> Toggle highlights
```

### Telescope
```
normal: <C-p> -> Find files in telescope.
normal: <Leader>ff -> Find files in telescope.
normal: <Leader>fo -> Find old files in telescope.
normal: <Leader>fw -> Grep in telescope.
normal: <Leader>fb -> Find buffer in telescope.
normal: <Leader>fh -> Find help tags in telescope.
normal: <Leader>fm -> Find media files in telescope.
normal: <Leader>fp -> Find project in telescope.
```

### Dashboard
```
normal: <Leader>fn -> New file in Dashboard.
normal: <Leader>bm -> Dashboard jumpmarks.
```

### nvim-tree.lua
```
normal: ` -> Toggle nvim-tree.
normal: <C-n> -> Toggle nvim-tree.
```

### comment toggle
```
normal: <leader>, -> Toggle Comment.
visual: <leader>, -> Toggle Comment.
```

### Neogit
```
normal: <leader>gg -> Open Neogit window.
normal: <leader>gc -> Open Neogit commit window.
```

## Inspired by

- https://github.com/mnabila/nvimrc
- https://github.com/siduck76/NvChad/tree/main
- https://github.com/ChristianChiarulli/LunarVim

