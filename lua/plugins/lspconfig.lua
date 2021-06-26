require('lspkind').init({
    -- enables text annotations
    with_text = true,
    -- default symbol map
    preset = 'codicons',
    -- override preset symbols
    symbol_map = {
      Text = '',
      Method = '',
      Function = '',
      Constructor = '',
      Field = 'ﴲ',
      Variable = '[]',
      Class = '',
      Interface = 'ﰮ',
      Module = '',
      Property = '襁',
      Unit = '',
      Value = '',
      Enum = '練',
      Keyword = '',
      Snippet = '',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = '',
      Event = '',
      Operator = '',
      TypeParameter = '',
    },
})

require("lspsaga").init_lsp_saga({
    error_sign = "▊",
    warn_sign = "▊",
    hint_sign = "▊",
    infor_sign = "▊",
    dianostic_header_icon = "   ",
    code_action_icon = " ",
    finder_definition_icon = "  ",
    finder_reference_icon = "  ",
    definition_preview_icon = "  ",
    border_style = "single",
    rename_prompt_prefix = "❱❱"
})

require("trouble").setup({
    height = 7, -- height of the trouble list
    icons = true, -- use dev-icons for filenames
    mode = "document", -- "workspace" or "document"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    action_keys = { -- key mappings for actions in the trouble list
        close = "q", -- close the list
        refresh = "r", -- manually refresh
        jump = "<cr>", -- jump to the diagnostic or open / close folds
        toggle_mode = "m", -- toggle between "workspace" and "document" mode
        toggle_preview = "P", -- toggle auto_preview
        preview = "p", -- preview the diagnostic location
        close_folds = "zM", -- close all folds
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        open_folds = "zR", -- open all folds
        previous = "k", -- preview item
        next = "j", -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
    },
    use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

local on_attach = function(client, bufnum)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnum, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnum, ...) end
  local noremap_silent = { noremap = true, silent = true }

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  buf_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()", noremap_silent)

  -- vim already has builtin docs
  if vim.bo.ft ~= "vim" then buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", noremap_silent) end
end

-- Configure lua language server for neovim development.
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = "LuaJIT",
      path = vim.split(package.path, ";"),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        maxPreload = 10000,
      },
    },
    telemetry = { enabel = false, }
  },
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.colorProvider = { dynamicRegistration = false }
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- lsp-install
local function setup_servers()
  require'lspinstall'.setup()

  -- get all installed servers
  local servers = require'lspinstall'.installed_servers()

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
      config.root_dir = function(fname)
        local util = require'lspconfig/util'
        return util.find_git_ancestor(fname) or util.path.dirname(fname)
      end
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
