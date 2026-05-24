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
							expr = nixInfo(nil, "nixd", "homeManager"),
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
	{
		"vtsls",
		enabled_if = "typescript",
		lsp = {
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			settings = {
				complete_function_calls = true,
				vtsls = {
					tsserver = {
						globalPlugins = {
							{
								name = "typescript-svelte-plugin",
								location = nixInfo(nil, "svelteTypescriptPlugin"),
								enableForWorkspaceTypeScriptVersions = true,
							},
						},
					},
					enableMoveToFileCodeAction = true,
					autoUseWorkspaceTsdk = true,
					experimental = {
						maxInlayHintLength = 30,
						completion = {
							enableServerSideFuzzyMatch = true,
						},
					},
				},
				typescript = {
					updateImportsOnFileMove = { enabled = "always" },
					suggest = {
						completeFunctionCalls = true,
					},
					inlayHints = {
						enumMemberValues = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						parameterNames = { enabled = "literals" },
						parameterTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						variableTypes = { enabled = false },
					},
				},
			},
		},
	},
	{
		name = "svelte",
		enabled_if = "typescript",
		lsp = {
			filetypes = { "svelte" },
		},
	},
	{
		name = "zk",
		enabled_if = "markdown",
		lsp = {
			filetypes = { "markdown" },
		},
	},
	{
		name = "yamlls",
		enabled_if = "yaml",
		lsp = {
			filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
			---@type lspconfig.settings.yamlls
			settings = {
				yaml = {
					schemaStore = {
						enable = false,
						url = "",
					},
					schemas = require("schemastore").yaml.schemas({
						select = {
							"docker-compose.yml",
							"GitHub Action",
						},
					}),
				},
			},
		},
	},
})
