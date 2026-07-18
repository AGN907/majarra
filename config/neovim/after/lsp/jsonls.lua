return {
	---@type lspconfig.settings.jsonls
	settings = {
		json = {
			validate = {
				enable = true,
			},
			schemas = require("schemastore").json.schemas({
				select = {
					"package.json",
					"tsconfig.json",
					"Biome Formatter Config",
				},
				extra = {
					{
						description = "Shadcn-svelte registry schema",
						fileMatch = "registry.json",
						name = "registry.json",
						url = "https://shadcn-svelte.com/schema/registry.json",
					},
				},
			}),
		},
	},
}
