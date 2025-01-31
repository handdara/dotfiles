local M = {}

M.ansible = vim.fn.expand("~/MEGA/ansible")
M.inbox = M.ansible .. "/0-quest-board/inbox"
M.dailies = M.ansible .. "/0-quest-board/dailies"
M.stache = M.ansible .. "/5-stache"

return M
