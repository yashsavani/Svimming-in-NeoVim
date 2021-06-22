local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

require'lspinstall'.post_install_hook = function ()
  setup_servers()
  vim.cmd[[bufdo e]]
end

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)"
}

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define(
  "LspDiagnosticsSignError",
  {text = "", numhl = "LspDiagnosticsDefaultError"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignWarning",
  {text = "", numhl = "LspDiagnosticsDefaultWarning"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignInformation",
  {text = "", numhl = "LspDiagnosticsDefaultInformation"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignHint",
  {text = "", numhl = "LspDiagnosticsDefaultHint"}
)
