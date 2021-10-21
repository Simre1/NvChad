local config_present, ts_config = pcall(require, "nvim-treesitter.configs")

local parsers_present, ts_parsers = pcall(require, "nvim-treesitter.parsers")

if not config_present and not parsers_present then
   return
end

local parser_configs = ts_parsers.get_parser_configs()

parser_configs.norg = {
   install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg",
      files = { "src/parser.c", "src/scanner.cc" },
      branch = "main",
   },
}

ts_config.setup {
   ensure_installed = {
      "lua",
      "rust",
      "c",
      "javascript",
      "norg",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
}
