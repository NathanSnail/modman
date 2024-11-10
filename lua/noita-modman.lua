local M = {}

function M.setup()
	vim.api.nvim_create_user_command("helloworl", function()
		print("hello world")
	end, {})
end

return M
