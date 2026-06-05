nixInfo.lze.load({
	{
		"snacks.nvim",
		lazy = false,
		after = function()
			require("snacks").setup({
				terminal = {},
				input = {},
				rename = {},
				lazygit = {
					configure = false,
				},
			})

			Config.new_autocmd("User", "MiniFilesActionRename", function(event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end)

			Config.new_autocmd("User", "DeferredUIEnter", function()
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end

				if vim.fn.has("nvim-0.11") == 1 then
					---@diagnostic disable-next-line: duplicate-set-field
					vim._print = function(_, ...)
						dd(...)
					end
				else
					vim.print = _G.dd
				end
			end)
		end,
	},
	{
		"nvim-treesitter",
		lazy = false,
		auto_enable = true,
		after = function()
			---@param buf integer
			---@param language string
			local function treesitter_try_attach(buf, language)
				-- check if parser exists and load it
				if not vim.treesitter.language.add(language) then
					return false
				end
				-- enables syntax highlighting and other treesitter features
				vim.treesitter.start(buf, language)

				-- enables treesitter based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

				return true
			end

			local installable_parsers = require("nvim-treesitter").get_available()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match
					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					if not treesitter_try_attach(buf, language) then
						if vim.tbl_contains(installable_parsers, language) then
							-- not already installed, so try to install them via nvim-treesitter if possible
							require("nvim-treesitter").install(language):await(function()
								treesitter_try_attach(buf, language)
							end)
						end
					end
				end,
			})
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
		"fzf-lua",
		after = function()
			local fzf = require("fzf-lua")

			fzf.setup({
				git_icons = false,
				winopts = {
					height = 0.90, -- window height
					width = 0.90, -- window width
					preview = {
						default = "bat",
						border = "noborder",
						---@type 'horizontal'|'vertical'|'flex'
						layout = "vertical",
						vertical = "up:70%", -- up|down:size -- preview goes above the list
					},
				},
				fzf_opts = { ["--layout"] = "reverse-list" },
			})
			fzf.register_ui_select()
		end,
	},
	{
		"colorful-menu.nvim",
		auto_enable = true,
		on_plugin = { "blink.cmp" },
	},
	{
		"friendly-snippets",
		auto_enable = true,
	},
	{
		"blink.cmp",
		auto_enable = true,
		event = "DeferredUIEnter",
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
				snippets = {
					preset = "mini_snippets",
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
					default = { "lsp", "path", "snippets", "buffer", "omni" },
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

			local biome_fmt = nixInfo(nil, "settings", "enabled_specs", "typescript") and { "biome-check" } or nil
			conform.setup({
				formatters_by_ft = {
					lua = nixInfo(nil, "settings", "enabled_specs", "lua") and { "stylua" } or nil,
					nix = nixInfo(nil, "settings", "enabled_specs", "nix") and { "nixfmt" } or nil,
					typescript = biome_fmt,
					typescriptreact = biome_fmt,
					svelte = biome_fmt,
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
			require("which-key").add(Config.leader_group_spec)
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
		"tiny-inline-diagnostic.nvim",
		after = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					use_icons_from_diagnostic = false,
					show_source = {
						enabled = true,
					},
				},
			})
			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				virtual_text = false,
				document_highlight = {
					enabled = true,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "●",
						[vim.diagnostic.severity.INFO] = "●",
						[vim.diagnostic.severity.WARN] = "●",
						[vim.diagnostic.severity.HINT] = "●",
					},
				},
			})
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
					{ path = "snacks.nvim", words = { "Snacks" } },
				},
			})
		end,
	},
	{
		"quicker.nvim",
		after = function()
			require("quicker").setup({
				keys = {
					{
						">",
						function()
							require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
						end,
						desc = "Expand quickfix context",
					},
					{
						"<",
						function()
							require("quicker").collapse()
						end,
						desc = "Collapse quickfix context",
					},
				},
			})
		end,
	},
	{
		"zk-nvim",
		after = function()
			require("zk").setup({
				picker = "fzf_lua",
				lsp = {},
			})
		end,
	},
	{
		"render-markdown.nvim",
		after = function()
			require("render-markdown").setup({
				render_modes = { "n", "c", "t" },
				preset = "obsidian",
				checkbox = { checked = { scope_highlight = "@markup.strikethrough" } },
				sign = {
					enabled = false,
				},
			})
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
		"trigger_statusline",
		load = function()
			vim.opt.statusline =
				"%{%(nvim_get_current_win()==#g:actual_curwin || &laststatus==3) ? v:lua.Statusline.active() : v:lua.Statusline.inactive()%}"
		end,
	},
})
