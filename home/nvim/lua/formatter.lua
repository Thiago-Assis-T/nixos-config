local cmd = vim.cmd
local api = vim.api
api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.schedule(function()
			cmd("FormatWrite")
		end)
	end,
})
require("formatter").setup({
	logging = false,
	log_level = vim.log.levels.WARN,
	filetype = {
		nix = {
			require("formatter.filetypes.nix").nixfmt,
		},
		yaml = {
			require("formatter.filetypes.yaml").yamlfmt,
		},
		go = {
			require("formatter.filetypes.go").gopls,
			require("formatter.filetypes.go").golines,
			require("formatter.filetypes.go").gofumpt,
			require("formatter.filetypes.go").goimports,
		},
		cpp = {
			require("formatter.filetypes.cpp").clangformat,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
