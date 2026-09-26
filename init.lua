vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.mouse = "a"
opt.clipboard = "unnamedplus"

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true

opt.undofile = true
opt.swapfile = false
opt.backup = false

opt.completeopt = {
  "menu",
  "menuone",
  "noselect",
  "noinsert",
}

vim.cmd.colorscheme("habamax")

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 4

local map = vim.keymap.set

map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<Esc>", { desc = "Escape insert mode" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit" })
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>s", "<cmd>split<CR>", { desc = "Horizontal split" })
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>S", ":%s//g<Left><Left>", { desc = "Search and replace" })
map("v", "<leader>S", ":s//g<Left><Left>", { desc = "Search and replace selection" })
map("n", "<leader>e", "<cmd>Lexplore<CR>", { desc = "Toggle file explorer" })
map("n", "<C-n>", "<cmd>Lexplore<CR>", { desc = "Toggle file explorer" })

local terminal_buf
local terminal_win

local function toggle_terminal(vertical)
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    vim.api.nvim_win_close(terminal_win, true)
    terminal_win = nil
    return
  end

  terminal_win = nil

  if vertical then
    vim.cmd("botright vsplit")
  else
    vim.cmd("botright split")
    vim.cmd("resize 12")
  end

  terminal_win = vim.api.nvim_get_current_win()

  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    vim.api.nvim_win_set_buf(terminal_win, terminal_buf)
  else
    vim.cmd("terminal")
    terminal_buf = vim.api.nvim_get_current_buf()
    vim.bo.bufhidden = "hide"
  end

  vim.cmd("startinsert")
end

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, desc = "Leave terminal mode" })
map("n", "<leader>t", function() toggle_terminal(false) end, { desc = "Toggle terminal" })
map("n", "<leader>vt", function() toggle_terminal(true) end, { desc = "Toggle vertical terminal" })

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")

    if line > 1
      and line <= vim.fn.line("$")
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd('normal! g`"')
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "fr" }
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    if data.file ~= "" and vim.fn.isdirectory(data.file) == 1 then
      vim.cmd.cd(vim.fn.fnameescape(data.file))
      vim.cmd.Lexplore()
    end
  end,
})
