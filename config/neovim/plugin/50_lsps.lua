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
						expr = "import (builtins.getFlake(toString /home/agn/agnix)).inputs.nixpkgs {}",
					},
					options = {

						nixos = {
							expr = "(builtins.getFlake(toString /home/agn/agnix)).nixosConfigurations.alkaid.options",
						},
						home_manager = {
							expr = "(builtins.getFlake(toString /home/agn/agnix)).nixosConfigurations.alkaid.options.home-manager.users.type.getSubOptions []",
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
