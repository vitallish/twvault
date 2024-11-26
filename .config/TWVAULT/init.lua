-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "vimwiki/vimiki",
      enabled = true,
      lazy = true,
      init = function()
        vim.g.vimwiki_list = {
          {
            -- Here will be the path for your wiki
            path = "~/Documents/twvault/.config/testvault/",
            -- The syntax for the wiki
            syntax = "markdown",
            ext = "md",
          },
        }
      end,
    },
    {
      "twvault",
      name = "twvault",
      dev = {true},
      
      init = function()
        vim.g.taskwiki_taskrc_location = "~/.config/task/taskrc"
      end,
      dependencies = {
        "vimwiki/vimwiki",

      }

    },

  },
    dev = {
        ---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
        path = "~/Documents",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {}, -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
      },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
