require("lint").linters_by_ft = {
	nix = { "statix" },
	go = { "golangci-lint" },
	c = { "clangtidy" },
	cpp = { "clangtidy" },
	yaml = { "yamllint" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
