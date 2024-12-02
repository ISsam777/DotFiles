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
--statuscolumn
vim.opt.numberwidth = 2
vim.opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({ { import = "plugins" }, { import = "plugins.lsp" } }, {
   -- Configure any other settings here. See the documentation for more details.
   -- colorscheme that will be used when installing plugins.
   -- install = { colorscheme = { "rose-pine/neovim", name = "rose-pine-moon" }
   -- automatically check for plugin updates
   checker = { enabled = true, notify = false },
   change_detection = { notify = false },
})

-----------cmp.lua config-----------------------
------------------------------------------------
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
   return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
   return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
   local col = vim.fn.col(".") - 1
   return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
   Text = "󰉿",
   Method = "󰆧",
   Function = "󰊕",
   Constructor = "",
   Field = " ",
   Variable = "󰀫",
   Class = "󰠱",
   Interface = "",
   Module = "",
   Property = "󰜢",
   Unit = "󰑭",
   Value = "󰎠",
   Enum = "",
   Keyword = "󰌋",
   Snippet = "",
   Color = "󰏘",
   File = "󰈙",
   Reference = "",
   Folder = "󰉋",
   EnumMember = "",
   Constant = "󰏿",
   Struct = "",
   Event = "",
   Operator = "󰆕",
   TypeParameter = " ",
   Misc = " ",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
   },
   mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping({
         i = cmp.mapping.abort(),
         c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.expandable() then
            luasnip.expand()
         elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
         elseif check_backspace() then
            fallback()
         else
            fallback()
         end
      end, {
         "i",
         "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, {
         "i",
         "s",
      }),
   },
   formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
         -- Kind icons
         vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
         -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
         vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
         })[entry.source.name]
         return vim_item
      end,
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
   },
   confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
   },
   window = {
      documentation = {
         border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
   },
   experimental = {
      ghost_text = false,
      native_menu = false,
   },
})

-- Attaches to every FileType mode
require("colorizer").setup()

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require("colorizer").setup({
   "css",
   "javascript",
   html = {
      mode = "foreground",
   },
})

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require("colorizer").setup({
   "css",
   "javascript",
   html = { mode = "background" },
}, { mode = "foreground" })

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require("colorizer").setup({
   "*", -- Highlight all files, but customize some others.
   css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
   html = { names = false }, -- Disable parsing "names" like Blue or Gray
})

-- Exclude some filetypes from highlighting by using `!`
require("colorizer").setup({
   "*", -- Highlight all files, but customize some others.
   "!vim", -- Exclude vim from highlighting.
   -- Exclusion Only makes sense if '*' is specified!
})
