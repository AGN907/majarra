return {
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
          "pubspec.yaml",
          "sqlc configuration",
				},
			}),
		},
	},
}
