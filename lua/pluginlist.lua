local packer = require("packer")
local use = packer.use

packer.init({
  display = { open_cmd = "leftabove 80vnew [packer]" },
  profile = { enable = true, threshold = 1 },
})

return packer.startup(function()
  -- Packer can manage itself.
  use "wbthomason/packer.nvim"

  -- Themes
  use "sainnhe/sonokai"
  use "navarasu/onedark.nvim"
  use "sainnhe/gruvbox-material"
  use "rafamadriz/neon"
  use "kyazdani42/nvim-web-devicons"

  -- Tree-Sitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "windwp/nvim-ts-autotag"
  use "andymass/vim-matchup"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "p00f/nvim-ts-rainbow"

  -- Language Server
  use { "neovim/nvim-lspconfig", requires = { "kabouzeid/nvim-lspinstall", "glepnir/lspsaga.nvim" } }
  use { "ahmedkhalf/lsp-rooter.nvim", config = function() require("lsp-rooter").setup {} end }
  use "onsails/lspkind-nvim"
  use "folke/lsp-trouble.nvim"
  -- use "code-biscuits/nvim-biscuits"
  -- use "kevinhwang91/nvim-bqf"
  -- use "sbdchd/neoformat"
  -- use "lukas-reineke/format.nvim"

  -- Autocomplete
  use "hrsh7th/vim-vsnip"
  use "hrsh7th/nvim-compe"
  use "rafamadriz/friendly-snippets"

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  }
  use "nvim-telescope/telescope-fzy-native.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-project.nvim"

  -- Explorer
  use "kyazdani42/nvim-tree.lua"

  -- Git
  use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use { "TimUntersberger/neogit", requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" } }

  -- Miscellaneous
  use "terrortylor/nvim-comment"
  use "windwp/nvim-autopairs"
  use "karb94/neoscroll.nvim"
  use "folke/which-key.nvim"
  use "machakann/vim-sandwich"
  use "ggandor/lightspeed.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "glepnir/dashboard-nvim"
  use { "RRethy/vim-hexokinase", run = "make hexokinase" }
  use "RRethy/vim-illuminate"
  use { "lewis6991/spellsitter.nvim", config = function() require("spellsitter").setup() end }
  use "ray-x/lsp_signature.nvim"
  use { "nacro90/numb.nvim", config = function() require("numb").setup() end }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup() end,
  }
  use "preservim/vim-pencil"
  use "tpope/vim-abolish"
  use { "iamcco/markdown-preview.nvim", run = "cd app && npm install" }

  -- Statuslines
  use { "glepnir/galaxyline.nvim", branch = "main" }
  use "romgrk/barbar.nvim"

end, { display = { border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" } } })
