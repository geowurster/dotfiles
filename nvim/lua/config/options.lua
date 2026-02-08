-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-------------------------------------------------------------------------------
-- Neovim UI Settings

-- Highlight column 80 as a guideline (e.g. for code width)
vim.opt.colorcolumn = "80"

-- Do not conceal any text
vim.opt.conceallevel = 0

-- Highlight the current line
vim.opt.cursorline = true

-- Show line numbers
vim.opt.number = true

-- Relative line numbers for easy line navigation
vim.opt.relativenumber = false

-- Always show sign column (for gitsigns, LSP) to avoid text shifting
vim.opt.signcolumn = "yes"

-- Open vertical splits to the right
vim.opt.splitright = true

-- Open horizontal splits below
vim.opt.splitbelow = true

-- Keep N lines above/below cursor when scrolling
vim.opt.scrolloff = 3

-- True color support
vim.opt.termguicolors = true

-------------------------------------------------------------------------------
-- Indentation and Tabs

-- Maintain indent of current line on new lines
vim.opt.autoindent = true
vim.opt.copyindent = true

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Shift indent by 4 spaces (for autoindent, <<, >>)
vim.opt.shiftwidth = 4

-- Smart indentation on new lines
vim.opt.smartindent = true

-- A tab counts as 4 spaces
vim.opt.tabstop = 4

-------------------------------------------------------------------------------
-- Search Settings

-- Case-insensitive search unless a capital letter is used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Incremental search (find as you type)
vim.opt.incsearch = true

-- Highlight search matches
vim.opt.hlsearch = true

-------------------------------------------------------------------------------
-- Performance and UX

-- Faster update for CursorHold (for gitgutter or diagnostics)
vim.opt.updatetime = 300

-- Shorten key sequence timeout for a snappier experience
vim.opt.timeoutlen = 500

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all yank, delete, paste, etc.

-- Disable backup, swap and restore (handled by git/Nix, and to avoid swap files)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Enable persistent undo
vim.opt.undofile = true

--  .. "/undo" -- set undo file directory
vim.opt.undodir = vim.fn.stdpath("state")

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Limit popup menu to 5 items
vim.opt.pumheight = 5

-------------------------------------------------------------------------------
-- Code and Text Formatting

-- Disable autoformat-on-save
vim.g.autoformat = false
