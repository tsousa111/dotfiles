return {
    "williamboman/mason.nvim",
    config = function()
        local present, mason = pcall(require, "mason")
        vim.api.nvim_create_augroup("_mason", { clear = true })
        options = {
            PATH = "skip",
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
            },
            max_concurrent_installers = 10,
        }
        mason.setup(options)
    end
}
