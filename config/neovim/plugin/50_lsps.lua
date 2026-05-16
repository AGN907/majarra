nixInfo.lze.load({
	{
		"lua_ls",
		enabled_if = "lua",
		lsp = {
			filetypes = { "lua" },
			settings = {
				Lua = {
					signatureHelp = { enabled = true },
					diagnostics = {
						globals = { "nixInfo", "vim" },
						disable = { "missing-fields" },
					},
				},
			},
		},
	},
	{
		"nixd",
		enabled = nixInfo.isNix, -- mason doesn't have nixd
		enabled_if = "nix",
		lsp = {
			filetypes = { "nix" },
			settings = {
				nixd = {
					nixpkgs = {
						expr = nixInfo(nil, "nixd", "nixpkgs"),
					},
					options = {

						nixos = {
							expr = nixInfo(nil, "nixd", "nixos"),
						},
						home_manager = {
							expr = nixInfo(nil, "nixd", "homeManaer"),
						},
					},
					formatting = {
						command = { "nixfmt" },
					},
					diagnostic = {
						suppress = {
							"sema-escaping-with",
						},
					},
				},
			},
		},
	},
})
