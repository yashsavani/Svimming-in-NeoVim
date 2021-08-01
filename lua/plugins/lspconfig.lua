local on_attach = function(client, bufnum)
  require"lsp_signature".on_attach()

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnum, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnum, ...) end
  local noremap_silent = { noremap = true, silent = true }

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  buf_set_keymap("n", "gD", [[:lua vim.lsp.buf.declaration()]], noremap_silent)
  buf_set_keymap("n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], noremap_silent)
  buf_set_keymap("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]], noremap_silent)
  buf_set_keymap("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<C-k>", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]], noremap_silent)
  buf_set_keymap("n", "<Leader>wa", [[<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>]],
                 noremap_silent)
  buf_set_keymap("n", "<Leader>wr", [[<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>]],
                 noremap_silent)
  buf_set_keymap("n", "<Leader>wl",
                 [[<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>]],
                 noremap_silent)
  -- buf_set_keymap("n", "<Leader>D", [[<cmd>lua vim.lsp.buf.type_definition()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>e", [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]], noremap_silent)
  buf_set_keymap("n", "[d", [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], noremap_silent)
  buf_set_keymap("n", "]d", [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>dl", [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]], noremap_silent)
  buf_set_keymap("n", "<Leader>p",
                 [[<cmd>lua vim.lsp.buf.formatting_seq_sync(nil, 1000, { 'html', 'php', 'efm' })<CR>]],
                 noremap_silent)
  -- buf_set_keymap("n", "<Leader>P", [[<cmd>lua vim.lsp.buf.formatting()<CR>]], noremap_silent)
  -- buf_set_keymap("v", "<Leader>p", [[<cmd>lua vim.lsp.buf.range_formatting()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>l", [[<cmd>lua require'lsp-codelens'.buf_codelens_action()<CR>]], noremap_silent)

  -- vim already has builtin docs
  -- if vim.bo.ft ~= "vim" then buf_set_keymap("n", "K", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], noremap_silent) end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
    augroup lsp_codelens
      autocmd! * <buffer>
      autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua require"lsp-codelens".buf_codelens_refresh()
    augroup END
    ]]
  end

  if client.server_capabilities.colorProvider then
    require"lsp-documentcolors".buf_attach(bufnum, { single_column = true })
  end

  -- vim already has builtin docs
  if vim.bo.ft ~= "vim" then
    buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", noremap_silent)
  end
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
    telemetry = { enable = false },
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
  require"lspinstall".setup()

  -- get all installed servers
  local servers = require"lspinstall".installed_servers()

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
      config.root_dir = function(fname)
        local util = require "lspconfig/util"
        return util.find_git_ancestor(fname) or util.path.dirname(fname)
      end
    end

    require"lspconfig"[server].setup(config)
  end
end

setup_servers()

require"lspconfig".efm.setup {
  init_options = { documentFormatting = true },
  filetypes = { "lua", "python", "markdown" },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      lua = {
        {
          formatCommand = "lua-format -i ${--tab-width:blacktabSize} ${--indent-width:tabSize} ${--continuation-indent-width:tabSize} --spaces-inside-table-braces --single-quote-to-double-quote --chop-down-parameter --chop-down-table --chop-down-kv-table --extra-sep-at-table-end --column-limit=100",
          formatStdin = true,
        },
      },
      python = {
        {
          lintCommand = "flake8 --ignore=E501 --std-display-name ${INPUT} -",
          lintStdin = true,
          lintFormats = { "%f:%l:%c: %m" },
        },
        { formatCommand = "black --quiet -", formatStdin = true },
        { formatCommand = "isort --quiet -", formatStdin = true },
      },
      markdown = {
        {
          lintCommand = "markdownlint -s",
          lintStdin = true,
          lintFormats = { "%f:%l:%c %m" },
        },
      },
    },
  },
}

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require"lspinstall".post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
