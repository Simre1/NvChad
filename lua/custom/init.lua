-- This is where you custom modules and plugins goes.
-- See the wiki for a guide on how to extend NvChad

local hooks = require "core.hooks"

-- NOTE: To use this, make a copy with `cp example_init.lua init.lua`

--------------------------------------------------------------------

-- To modify packaged plugin configs, use the overrides functionality
-- if the override does not exist in the plugin config, make or request a PR,
-- or you can override the whole plugin config with 'chadrc' -> M.plugins.default_plugin_config_replace{}
-- this will run your config instead of the NvChad config for the given plugin

-- hooks.override("lsp", "publish_diagnostics", function(current)
--   current.virtual_text = false;
--   return current;
-- end)

-- To add new mappings, use the "setup_mappings" hook,
-- you can set one or many mappings
-- example below:

local opt = {silent = true, noremap = true};

hooks.add("setup_mappings", function(map)
   -- map("n", "<leader>cc", "gg0vG$d", opt) -- example to delete the buffer
   map("n", "<leader>w", "<C-w>", opt)
end)

-- To add new plugins, use the "install_plugin" hook,
-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- examples below:

hooks.add("install_plugins", function(use)
  use {
    "ironhouzi/starlite-nvim",
    config = function()
      require("core.hooks").add("setup_mappings", function(map)
        map("n", "*", ":lua require'starlite'.star()<CR>", opt)
        map("n", "g*", ":lua require'starlite'.g_star()<CR>", opt)
        map("n", "#", ":lua require'starlite'.hash()<CR>", opt)
        map("n", "g#", ":lua require'starlite'.g_hash()<CR>", opt)
      end) 
    end,
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        require("core.hooks").add("setup_mappings", function(map)
          map("n", m.open, ":Trouble<cr>", opt)
          map("n", m.workspace_diagnostics, ":Trouble lsp_workspace_diagnostics<cr>", opt)
          map("n", m.document_diagnostics, ":Trouble lsp_document_diagnostics<cr>", opt)
          map("n", m.loclist, ":Trouble loclist<cr>", opt)
          map("n", m.quickfix, ":Trouble quickfix<cr>", opt)
          map("n", m.lsp_references, ":Trouble lsp_references<cr>", opt)
        end)
      }
    end
  }

  use {
    "nvim-neorg/neorg",
    config = function()
      local present, neorg = pcall(require, "neorg")
      if not present then return end
      neorg.setup {
          -- Tell Neorg what modules to load
          load = {
              ["core.defaults"] = {}, -- Load all the default modules
              -- ["core.norg.concealer"] = {}, -- Allows for use of icons
              ["core.norg.dirman"] = { -- Manage your directories with Neorg
                  config = {workspaces = {my_workspace = "~/neorg"}}
              },
              ["core.norg.completion"] = {
                  config = {
                      engine = "nvim-cmp" -- We current support nvim-compe and nvim-cmp only
                  }
              }
          }
      }
    end,
    requires = "nvim-lua/plenary.nvim",
    after = "nvim-treesitter"
  }
end)

-- 
-- end)

-- alternatively, put this in a sub-folder like "lua/custom/plugins/mkdir"
-- then source it with

-- require "custom.plugins.mkdir"
