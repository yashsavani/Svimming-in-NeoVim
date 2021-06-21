local npairs = require("nvim-autopairs")

_G.MUtils= {}

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    return npairs.esc("<cr>")
  else
    return npairs.autopairs_cr()
  end
end

vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},-- it will not add pair on that treesitter node
    javascript = {'template_string'},
    java = false,-- don't check treesitter on java
  }
})

local endwise = require('nvim-autopairs.ts-rule').endwise

npairs.add_rules({
  endwise('then$', 'end', 'lua', 'if_statement')
})
