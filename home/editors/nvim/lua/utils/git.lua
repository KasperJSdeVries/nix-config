local M = {}

---@return boolean
M.is_inside_git_repo = function()
    local handle = io.popen('git rev-parse --is-inside-work-tree 2> /dev/null')
    local result = handle:read("*a")
    handle:close()
    return result:match("true") ~= nil
end

return M
