if not vim.g.vscode then
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
end
