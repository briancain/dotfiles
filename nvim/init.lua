vim.cmd('source ~/.vimrc')

local pc = require "nvim-treesitter.parsers".get_parser_configs()

pc.protobuf = {
  install_info = {
    url = "https://github.com/mitchellh/tree-sitter-proto", -- local path or git repo
    files = {"src/parser.c"},
    branch = "main",
  },
  filetype = "proto", -- if filetype does not agrees with parser name
}

pc.hardlight = {
  install_info = {
    url = "https://github.com/evanphx/tree-sitter-hardlight", -- local path or git repo
    files = {"src/parser.c"},
    branch = "main",
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "hardlight",
}

vim.filetype.add({
  extension = {
    hl = "hardlight"
  }
})

