if not vim.g.vscode then
    -- Ordinary Neovim stuffs
    require("tokyonight").setup({ transparent = true })
    vim.cmd[[colorscheme tokyonight-night]]
end