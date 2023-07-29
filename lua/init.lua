-- The boolean flag representing if nvim is loaded **only in nvim** and **not in VSCode** using vscode-neovim extension
local isNvimOnly = not vim.g.vscode

-- Install and attach "lazy.nvim" to Neovim to manage the plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup the lazy.nvim with plugins
require("lazy").setup({
    -- Plugins shared between VSCode and Neovim
    {
        'michaeljsmith/vim-indent-object',
    },
    {
        'tpope/vim-surround',
    },
    {
        'justinmk/vim-sneak',
    },
    {
        'bkad/CamelCaseMotion',
    },

    -- Neovim specific plugins
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        cond = isNvimOnly,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        cond = isNvimOnly
    },
    {
        'neovim/nvim-lspconfig',
        cond = isNvimOnly
    },
    {
        'nvim-lua/plenary.nvim',
        cond = isNvimOnly
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cond = isNvimOnly,
    },
    {
        "ahmedkhalf/project.nvim",
        cond = isNvimOnly
    },
    {
        'airblade/vim-gitgutter',
        cond = isNvimOnly
    },
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local logo = [[
                                         _.oo.
                _.u[[/;:,.         .odMMMMMM'
              .o888UU[[[/;:-.  .o@P^    MMM^
             oN88888UU[[[/;::-.        dP^
            dNMMNN888UU[[[/;:--.   .o@P^
           ,MMMMMMN888UU[[/;::-. o@^
           NNMMMNN888UU[[[/~.o@P^
           888888888UU[[[/o@^-..
          oI8888UU[[[/o@P^:--..
       .@^  YUU[[[/o@^;::---..
     oMP     ^/o@P^;:::---..
  .dMMM    .o@^ ^;::---...
 dMMMMMMM@^`       `^^^^
YMMMUP^
 ^^
      ]]

            dashboard.section.header.val = vim.split(logo, "\n")
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
                dashboard.button("p", "󰒲 " .. " Plugins", ":Lazy<CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
        cond = isNvimOnly
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        cond = isNvimOnly
    }
})

if isNvimOnly then
    -- Colorscheme
    require("tokyonight").setup({ transparent = true })
    vim.cmd [[colorscheme tokyonight-night]]

    -- Treesitter
    require("nvim-treesitter.install").prefer_git = false
    require('nvim-treesitter.configs').setup {
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "javascript", "typescript" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
            enable = true,
        }
    }

    -- LSP
    local lspconfig = require('lspconfig')
    -- Setup tsserver
    lspconfig.tsserver.setup {}

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        end,
    })

    -- We already have diagnostics virtual text so there is no need for this
    -- Since these signs replace the hunks signs (+ | ~ | -) let's disable them
    vim.diagnostic.config({ signs = false })
end
