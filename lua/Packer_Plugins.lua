

 
-- local packpath = vim.fn.stdpath("data") .. "/site/pack/packer/start"

-- local packer_plugins = vim.fn.readdir(packpath)

-- for _, plugin_name in ipairs(packer_plugins) do
--     local plugin_path = packpath .. '/' .. plugin_name
--     if vim.fn.isdirectory(plugin_path) == 1 then
--         local init_lua_path = plugin_path .. '/init.lua'
--         local success, _ = pcall(require, init_lua_path)
--         if not success then
--             print("Failed to load plugin:", plugin_name)
--         end
--     end
-- end