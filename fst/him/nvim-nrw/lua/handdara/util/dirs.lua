local M = {}

M.ansible = vim.fs.normalize("~/MEGA/ansible")
M.inbox = { rel =  "/0-quest-board/inbox" }
M.inbox.abs = M.ansible .. M.inbox.rel
M.dailies = { rel = "/1-active-quests/dailies" }
M.dailies.abs = M.ansible .. M.dailies.rel
M.stache = { rel = "/5-stache" }
M.stache.abs = M.ansible .. M.stache.rel
M.config = { abs = vim.fs.normalize("~/.config") }
M.config_repo = { abs = vim.fs.normalize("~/code/dotfiles") }

return M
