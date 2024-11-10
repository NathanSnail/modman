local M = {}



print("call")
function M.setup()
	print("setup")
	vim.api.nvim_create_user_command("HelloWorld", function()
		print("")
	end, {})
end

return M
