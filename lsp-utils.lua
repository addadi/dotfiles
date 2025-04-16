-- Helper function to get Mason executable paths
local function get_mason_path(executable)
    return vim.fn.stdpath("data") .. "/mason/bin/" .. executable
end

-- Set up language servers with this helper function
local function setup_lsp(server, config)
    local lspconfig = require("lspconfig")
    
    -- Apply default mason path to cmd if not specified
    if config.cmd and config.cmd[1] and not config.cmd[1]:match("^/") then
        config.cmd[1] = get_mason_path(config.cmd[1])
    end
    
    lspconfig[server].setup(config)
end

return {
    get_mason_path = get_mason_path,
    setup_lsp = setup_lsp
}
