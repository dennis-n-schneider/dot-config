require('nvim-treesitter.configs').setup {
    ensure_installed = {"bash", "python", "lua", 
        "gitcommit", "gitignore", "markdown", "markdown_inline", 
        "regex", "dockerfile", "yaml", "toml", "json"},
    ignore_install = {"help"},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = { "latex", "markdown" },
    },
    indent = {
        enable = true,
        disable = {}
    },
}

