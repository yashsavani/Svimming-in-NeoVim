local packer = require("packer")
local use = packer.use

packer.init({
    display = {
        open_cmd = "leftabove 80vnew [packer]",
    },
    profile = {
        enable = true,
        threshold = 1,
    },
})

return packer.startup(
  function()
    -- Packer can manage itself.
    use "wbthomason/packer.nvim"

    -- Themes
    use {"dracula/vim", as = "dracula"}
    use 'navarasu/onedark.nvim'

    -- Tree-Sitter
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        "windwp/nvim-ts-autotag",
        "andymass/vim-matchup",
      }
    })

    -- Language Server
    use ({
      "neovim/nvim-lspconfig",
      requires = { "kabouzeid/nvim-lspinstall" }
    })

    -- Telescope
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-project.nvim",
      },
    })

    -- Explorer
    use({
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons" }
    })

    -- Git
    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" }
    })
    use "TimUntersberger/neogit"

    -- Miscellaneous
    use "terrortylor/nvim-comment" 
    use "windwp/nvim-autopairs"
    use "karb94/neoscroll.nvim"
    use "folke/which-key.nvim"
    use "machakann/vim-sandwich"
    use "justinmk/vim-sneak"
    use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
    use 'glepnir/dashboard-nvim'

    -- Statuslines
    use({
      "glepnir/galaxyline.nvim",
      branch = "main",
      requires = { "kyazdani42/nvim-web-devicons" }
    })
    use({
      "romgrk/barbar.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
    })

  end,
  {
    display = {
      border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
    }
  }
)
