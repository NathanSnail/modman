local nxml = require("nxml")
local M = {}
local mod_path = ""

---@enum SourceType
local SOURCE_TYPE = {
	Git = 0,
	Steam = 1,
	Manual = 2,
}

---@class Mod
---@field name string
---@field id string
---@field source SourceType

---@return Mod[]
local function ParseMods()
	local mod_fd = vim.uv.fs_open(mod_path, "r", 438) -- magic flags, apparently fopen(2) is relevant, bad api
	if mod_fd == nil then return {} end
	local mod_file_content = ""
	while true do
		local chunk = vim.uv.fs_read(mod_fd, 4096)
		mod_file_content = mod_file_content .. chunk
		if chunk == "" then break end
	end
	print(mod_file_content)
	local xml = nxml.parse(mod_file_content)
	print(xml)
	local mods = {}
	return mods
end

local function NoitaModRead() end
local function NoitaModWrite()
	local cur_buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(cur_buf, 0, vim.api.nvim_buf_line_count(cur_buf), false)
	local mods = ParseMods()
end

function M.setup(path)
	print(path)
	mod_path = path
	vim.api.nvim_create_user_command("NoitaModRead", NoitaModRead, {})
	vim.api.nvim_create_user_command("NoitaModWrite", NoitaModWrite, {})
end

return M
