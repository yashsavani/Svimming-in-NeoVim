require("lspkind").init({
  -- enables text annotations
  with_text = true,
  -- default symbol map
  preset = "codicons",
  -- override preset symbols
  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﴲ",
    Variable = "[]",
    Class = "",
    Interface = "ﰮ",
    Module = "",
    Property = "襁",
    Unit = "",
    Value = "",
    Enum = "練",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
})

