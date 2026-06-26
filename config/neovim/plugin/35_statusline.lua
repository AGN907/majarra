local colors = nixInfo({}, "info", "colors")
local space = "%="

local hl = function(group)
	return vim.api.nvim_get_hl(0, {
		name = group,
		link = false,
		create = false,
	})
end

local set_hl_groups = function()
	local base = hl("StatusLine")

	for group, opts in pairs({
		ModeNormal = { fg = colors.base00, bg = colors.base0D, bold = true },
		ModePending = { fg = colors.base00, bg = hl("Comment").fg, bold = true },
		ModeVisual = { fg = colors.base00, bg = hl("SpecialKey").fg, bold = true },
		ModeInsert = { fg = colors.base00, bg = hl("DiffAdded").fg, bold = true },
		ModeCommand = { fg = colors.base00, bg = hl("Number").fg, bold = true },
		ModeReplace = { fg = colors.base00, bg = hl("Constant").fg, bold = true },
		Git = { fg = colors.base0D, bg = colors.base01 },
		FileDir = { fg = colors.base04, bg = colors.base00 },
		FileName = { fg = colors.base05, bg = colors.base00, bold = true },
		FileModified = { fg = colors.base06, bg = colors.base00 },
		FileReadOnly = { fg = colors.base07, bg = colors.base00 },
		DiffAdd = { fg = hl("DiffAdd").fg, bg = colors.base00 },
		DiffChange = { fg = hl("DiffChange").fg, bg = colors.base00 },
		DiffDelete = { fg = hl("DiffDelete").fg, bg = colors.base00 },
		LSP = { fg = colors.base04, bg = colors.base00 },
		Fmt = { fg = colors.base04, bg = colors.base00 },
		Bold = { fg = base.fg, bg = base.bg, bold = true },
		Dim = { fg = hl("LineNr").fg, bg = base.bg },
		ScrollPos = { fg = colors.base04, bg = "NONE" },
		Recording = { fg = colors.base0D, bg = "NONE" },
		MiniIconsAzure = { fg = hl("MiniIconsAzure").fg, bg = colors.base00 },
		MiniIconsBlue = { fg = hl("MiniIconsBlue").fg, bg = colors.base00 },
		MiniIconsCyan = { fg = hl("MiniIconsCyan").fg, bg = colors.base00 },
		MiniIconsGreen = { fg = hl("MiniIconsGreen").fg, bg = colors.base00 },
		MiniIconsGrey = { fg = hl("MiniIconsGrey").fg, bg = colors.base00 },
		MiniIconsOrange = { fg = hl("MiniIconsOrange").fg, bg = colors.base00 },
		MiniIconsPurple = { fg = hl("MiniIconsPurple").fg, bg = colors.base00 },
		MiniIconsRed = { fg = hl("MiniIconsRed").fg, bg = colors.base00 },
		MiniIconsYellow = { fg = hl("MiniIconsYellow").fg, bg = colors.base00 },
	}) do
		group = "St" .. group
		vim.api.nvim_set_hl(0, group, opts)
		opts.fg, opts.bg = opts.bg, opts.fg
		vim.api.nvim_set_hl(0, group .. "Inverted", opts)
	end

	vim.api.nvim_set_hl(0, "StBase", { bg = "NONE" })
end

Config.new_autocmd("ColorScheme", nil, set_hl_groups, "Re-apply statusline highlights on colorscheme change")

local mode_component = function()
	local CTRL_S = vim.api.nvim_replace_termcodes("<C-S>", true, true, true)
	local CTRL_V = vim.api.nvim_replace_termcodes("<C-V>", true, true, true)
	local mode_settings = {
		["n"] = { name = "n", hl = "Normal" },
		["v"] = { name = "v", hl = "Visual" },
		["V"] = { name = "v", hl = "Visual" },
		[CTRL_V] = { name = "v", hl = "Visual" },
		["s"] = { name = "s", hl = "Visual" },
		["S"] = { name = "s", hl = "Visual" },
		[CTRL_S] = { name = "s", hl = "Visual" },
		["i"] = { name = "i", hl = "Insert" },
		["R"] = { name = "r", hl = "Replace" },
		["r"] = { name = "r", hl = "Replace" },
		["c"] = { name = "c", hl = "Command" },
		["!"] = { name = "sh", hl = "Command" },
		["t"] = { name = "t", hl = "Command" },
	}

	local mode = mode_settings[vim.fn.mode()] or {}

	return table.concat({
		"%#StMode" .. mode.hl .. "Inverted#",
		"%#StMode" .. mode.hl .. "# " .. mode.name,
		" %#StMode" .. mode.hl .. "Inverted#",
		"%#StBase#",
	})
end

local git_branch_component = function()
	local summary = vim.b.minigit_summary_string
	if summary == nil then
		return " "
	end

	local branch = vim.split(summary, " ")[1]

	return table.concat({
		"%#StGit#",
		"  " .. branch,
		" ",
	})
end

local file_name_component = function()
	local path = vim.fn.expand("%f")
	if path == "" then
		return ""
	end

	local filename = ""
	local dir = ""

	local parts = vim.split(path, "/", { plain = true })
	if #parts == 1 then
		filename = parts[1]
	elseif #parts == 2 then
		filename = parts[#parts - 1] .. "/" .. parts[#parts]
		dir = parts[#parts - 1]
	else
		filename = parts[#parts]
		dir = parts[#parts - 2] .. "/" .. parts[#parts - 1]
	end

	if vim.bo.buftype == "terminal" then
		return "%t"
	end

	local icon, icon_hl = require("mini.icons").get("extension", filename)

	return table.concat({
		"%#StBase#",
		"%#StFileDir# " .. dir .. "/",
		"%#StFileName#" .. filename,
		"%#St" .. icon_hl .. "# " .. icon .. " ",
		vim.bo.readonly and "%#StFileReadOnly#  " or "",
	})
end

local diff_component = function()
	local summary = vim.b.minidiff_summary
	if summary == nil then
		return ""
	end

	local add, change, delete = summary.add or 0, summary.change or 0, summary.delete or 0

	return table.concat({
		"%#StDiffAdd# " .. (add > 0 and "+" .. add or "") .. " ",
		"%#StDiffChange#" .. (change > 0 and "~" .. change or "") .. " ",
		"%#StDiffDelete#" .. (delete > 0 and "-" .. delete or "") .. " ",
		"%#StBase#",
	})
end

local fmt_component = function()
	local is_loaded, conform = pcall(require, "conform")
	if not is_loaded then
		return ""
	end

	local formatters = conform.list_formatters_for_buffer(vim.api.nvim_get_current_buf())

	local fmt_name = formatters[1] or "unknown"

	return table.concat({
		"%#StFmt#",
		string.format("%s ", fmt_name),
	})
end

local lsp_component = function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if next(clients) == nil then
		return ""
	end

	local client_names = {}
	for _, client in ipairs(clients) do
		table.insert(client_names, client.name)
	end

	return table.concat({
		"%#StLSP# ",
		string.format("%s ", table.concat(client_names, ",")),
		fmt_component() == "" and "" or "| ",
	})
end

local diagnostic_status = function()
	return table.concat({
		" ",
		vim.diagnostic.status(),
		"%#StBase#",
	})
end

local searchcount_component = function()
	local ok, s_count = pcall(vim.fn.searchcount, { recompute = true })
	if not ok or s_count.current == nil or s_count.total == 0 then
		return ""
	end

	if s_count.incomplete == 1 then
		return "?/?"
	end

	local too_many = ">" .. s_count.maxcount
	local current = s_count.current > s_count.maxcount and too_many or s_count.current
	local total = s_count.total > s_count.maxcount and too_many or s_count.total
	return table.concat({
		current,
		"/",
		total,
		" ",
	})
end

local blink_icon = true
local blink_timer = nil
local function macro_component()
	local is_rec = vim.fn.reg_recording()
	if is_rec == "" then
		if blink_timer then
			blink_timer:stop()
			blink_timer:close()
			blink_timer = nil
		end
		return ""
	end
	if not blink_timer then
		blink_timer = vim.uv.new_timer()
		if blink_timer ~= nil then
			blink_timer:start(
				0,
				500,
				vim.schedule_wrap(function()
					blink_icon = not blink_icon
					vim.cmd("redrawstatus")
				end)
			)
		end
	end
	local icon = blink_icon and "" or " "
	return "%#StRecording#" .. icon .. "%#StBase#" .. " @" .. is_rec
end

function _G.Statusline_active()
	return table.concat({
		"%#StBase# ",
		mode_component(),
		file_name_component(),
		lsp_component(),
		fmt_component(),
		diagnostic_status(),
		space,
		macro_component(),
		space,
		searchcount_component(),
		diff_component(),
		git_branch_component(),
	})
end

function _G.Statusline_inactive()
	return table.concat({
		"%#StBase#",
		file_name_component(),
		space,
	})
end
