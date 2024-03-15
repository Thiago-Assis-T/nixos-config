local function colorMyThing(color)
	color = color or "tokyonight-night"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none", ctermbg = "none" })
end

colorMyThing()
