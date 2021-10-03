-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'

local M = {}
M.ui = {}
M.mappings = {
  window_alternative = {'n', '<leader>w', '<C-w>', {silent = true, noremap = true}},
}

M.options = {
   tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
}

M.plugins = {
  status = {
    dashboard = true,
    colorizer = true
  },
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig"
    }
  },
  default_plugin_config_replace = {
    nvim_cmp = "custom.plugins.cmp",
    nvim_treesitter = "custom.plugins.treesitter"
  },
}

M.mappings = {
  terminal = {
      pick_term = "<leader>tW",
      new_horizontal = "<leader>th",
      new_vertical = "<leader>tv",
      new_window = "<leader>tw"
   },

   nvimtree = {
      focus = "<leader>t"
   },
}

-- NOTE: To use this, make a copy with `cp example_chadrc.lua chadrc.lua`

--------------------------------------------------------------------

-- To use this file, copy the strucutre of `core/default_config.lua`,
-- examples of setting relative number & changing theme:

-- M.options = {
--    relativenumber = true,
-- }

-- M.ui = {
--   theme = "nord"
-- }
-- NvChad included plugin options & overrides
-- M.plugins = {
--    options = {
--       --   lspconfig = {
--       --    path of file containing setups of different lsps (ex : "custom.plugins.lspconfig"), read the docs for more info
--       --    setup_lspconf = "",
--       --   },
--    },
--    -- To change the Packer `config` of a plugin that comes with NvChad,
--    -- add a table entry below matching the plugin github name
--    --              '-' -> '_', remove any '.lua', '.nvim' extensions
--    -- this string will be called in a `require`
--    --              use "(custom.configs).my_func()" to call a function
--    --              use "custom.blankline" to call a file
--    default_plugin_config_replace = {},
-- }

return M
