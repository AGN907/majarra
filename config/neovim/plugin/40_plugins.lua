nixInfo.lze.load({
	{
		"nvim-treesitter",
		lazy = false,
		auto_enable = true,
		after = function()
			local languages = {
				"lua",
				"vimdoc",
				"markdown",
				"go",
				"gomod",
				"gosum",
				"yaml",
				"json",
				"html",
				"rust",
				"php",
				"php_only",
				"blade",
				"just",
			}
			local isnt_installed = function(lang)
				return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
			end
			local to_install = vim.tbl_filter(isnt_installed, languages)
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end

			-- Enable tree-sitter after opening a file for a target language
			local filetypes = {}
			for _, lang in ipairs(languages) do
				for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
					table.insert(filetypes, ft)
				end
			end
			local ts_start = function(ev)
				vim.treesitter.start(ev.buf)
			end
			Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")
		end,
	},
	{
		"nvim-lspconfig",
		auto_enable = true,
		lsp = function(plugin)
			vim.lsp.config(plugin.name, plugin.lsp or {})
			vim.lsp.enable(plugin.name)
		end,
	},
	{
		"colorful-menu.nvim",
		auto_enable = true,
		on_plugin = { "blink.cmp" },
	},
	{
		"blink.cmp",
		auto_enable = true,
		event = { "InsertEnter", "CmdlineEnter" },
		after = function(_)
			require("blink.cmp").setup({
				keymap = {
					preset = "none",
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide", "fallback" },
					["<C-y>"] = { "select_and_accept", "fallback" },
					["<C-p>"] = { "select_prev", "fallback_to_mappings" },
					["<C-n>"] = { "select_next", "fallback_to_mappings" },
					["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
					["<C-h>"] = { "snippet_backward" },
					["<C-l>"] = { "snippet_forward" },
				},
				cmdline = {
					enabled = true,
					keymap = { preset = "inherit" },
					completion = {
						list = {
							selection = { preselect = false },
						},
						menu = {
							auto_show = function()
								return vim.fn.getcmdtype() == ":"
							end,
						},
						ghost_text = { enabled = true },
					},
					sources = function()
						local type = vim.fn.getcmdtype()
						-- Search forward and backward
						if type == "/" or type == "?" then
							return { "buffer" }
						end
						if type == ":" then
							return { "cmdline", "buffer" }
						end
						return {}
					end,
				},
				signature = {
					enabled = true,
					window = {
						show_documentation = true,
					},
				},
				completion = {
					menu = {
						draw = {
							columns = { { "kind_icon" }, { "label", gap = 1 } },
							components = {
								kind_icon = {
									text = function(ctx)
										local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
										return kind_icon
									end,
									highlight = function(ctx)
										local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
										return hl
									end,
								},
								label = {
									text = function(ctx)
										return require("colorful-menu").blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu").blink_components_highlight(ctx)
									end,
								},
							},
						},
					},
					documentation = {
						auto_show = true,
					},
				},
				sources = {
					default = { "lsp", "path", "buffer", "omni" },
					providers = {
						path = {
							score_offset = 50,
						},
						lsp = {
							score_offset = 40,
						},
					},
				},
			})
		end,
	},
	{
		"conform.nvim",
		auto_enable = true,
		after = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = nixInfo(nil, "settings", "enabled_specs", "lua") and { "stylua" } or nil,
					nix = nixInfo(nil, "settings", "enabled_specs", "nix") and { "nixfmt" } or nil,
				},
			})
		end,
	},
	{
		"nvim-lint",
		auto_enable = true,
		event = "FileType",
		after = function()
			require("lint").linters_by_ft = {
				-- NOTE: download some linters
				-- and configure them here
				-- markdown = {'vale',},
				-- javascript = { 'eslint' },
				-- typescript = { 'eslint' },
			}
			_G.Config.new_autocmd("BufWritePost", nil, function()
				require("lint").try_lint()
			end)
		end,
	},
	{
		"which-key.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function()
			require("which-key").setup({
				preset = "helix",
				plugins = {
					presets = {
						text_objects = false,
					},
				},
			})
			require("which-key").add({
				{ "<leader>b", group = "+Buffer" },
				{ "<leader>e", group = "+Explore/Edit" },
				{ "<leader>g", group = "+Git", mode = { "n", "x" } },
				{ "<leader>l", group = "+Language", mode = { "n", "x" } },
				{ "<leader>s", group = "+Session" },
				{ "<leader>f", group = "+Find" },
				{ "<leader>t", group = "+Terminal" },
				{ "<leader>o", group = "+Other" },
			})
		end,
	},
	{
		"zellij-vim",
		lazy = false,
		after = function()
			vim.g.zellij_navigator_no_default_mappings = 1
			if os.getenv("ZELLIJ") then
				vim.keymap.set({ "n" }, "<c-h>", "<cmd>ZellijNavigateLeft!<cr>", { desc = "Navigate Left" })
				vim.keymap.set({ "n" }, "<c-l>", "<cmd>ZellijNavigateRight!<cr>", { desc = "Navigate Right" })
				vim.keymap.set({ "n" }, "<c-j>", "<cmd>ZellijNavigateDown<cr>", { desc = "Navigate Down" })
				vim.keymap.set({ "n" }, "<c-k>", "<cmd>ZellijNavigateUp<cr>", { desc = "Navigate Up" })
			end
		end,
	},

	{
		"trigger_colorscheme",
		event = "VimEnter",
		load = function()
			vim.schedule(function()
				vim.cmd.colorscheme(nixInfo("default", "info", "colorscheme"))
			end)
		end,
	},
	{
		"trigger_diagnositc",
		event = "VimEnter",
		load = function()
			local diagnostic_opts = {
				-- Show signs on top of any other sign, but only for warnings and errors
				signs = {
					priority = 9999,
					severity = { min = "WARN", max = "ERROR" },
				},

				-- Show all diagnostics as underline (for their messages type `<Leader>ld`)
				underline = { severity = { min = "HINT", max = "ERROR" } },

				-- Show more details immediately for errors on the current line
				virtual_lines = true,
				-- Don't update diagnostics when typing
				update_in_insert = false,
			}
			vim.schedule(function()
				vim.diagnostic.config(diagnostic_opts)
			end)
		end,
	},
	{
		"trigger_statusline",
		load = function()
			vim.opt.statusline = "%{%v:lua.require'config.neovim.plugin.35_statusline'.render()%}"
		end,
	},
	{
		"lazydev.nvim",
		auto_enable = true,
		cmd = { "LazyDev" },
		ft = "lua",
		after = function(_)
			require("lazydev").setup({
				library = {
					{ words = { "nixInfo%.lze" }, path = nixInfo("lze", "plugins", "start", "lze") .. "/lua" },
					{
						words = { "nixInfo%.lze" },
						path = nixInfo("lzextras", "plugins", "start", "lzextras") .. "/lua",
					},
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ path = "nvim-lspconfig", words = { "lspconfig.settings" } },
				},
			})
		end,
	},
})
