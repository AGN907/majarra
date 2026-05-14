local colors = nixInfo({}, "info", "colors")
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
		ModeNormal = { fg = colors.base00, bg = colors.base0D },
		ModePending = { fg = base.bg, bg = hl("Comment").fg },
		ModeVisual = { fg = base.bg, bg = hl("SpecialKey").fg },
		ModeInsert = { fg = base.bg, bg = hl("DiffAdded").fg },
		ModeCommand = { fg = base.bg, bg = hl("Number").fg },
		ModeReplace = { fg = base.bg, bg = hl("Constant").fg },
		Git = { fg = colors.base00, bg = colors.base0D },
		Filename = { fg = colors.base04, bg = colors.base00 },
		FileModified = { fg = colors.base06, bg = colors.base00 },
		DiffAdd = { fg = hl("DiffAdd").fg, bg = colors.base00 },
		DiffChange = { fg = hl("DiffChange").fg, bg = colors.base00 },
		DiffDelete = { fg = hl("DiffDelete").fg, bg = colors.base00 },
		Bold = { fg = base.fg, bg = base.bg, bold = true },
		Dim = { fg = hl("LineNr").fg, bg = base.bg },
	}) do
		group = "StatusLine" .. group
		vim.api.nvim_set_hl(0, group, opts)
		opts.fg, opts.bg = opts.bg, opts.fg
		vim.api.nvim_set_hl(0, group .. "Inverted", opts)
	end

	vim.api.nvim_set_hl(0, "StatusLineToNorm", { fg = colors.base05, bg = colors.base00 })
end

Config.new_autocmd("ColorScheme", nil, set_hl_groups, "Re-apply statusline highlights on colorscheme change")

local mode_component = function()
	local mode_settings = {
		["n"] = { name = "NORMAL", hl = "Normal" },
		["v"] = { name = "VISUAL", hl = "Visual" },
		["V"] = { name = "V-LINE", hl = "Visual" },
		["i"] = { name = "INSERT", hl = "Insert" },
		["R"] = { name = "REPLACE", hl = "Replace" },
		["c"] = { name = "COMMAND", hl = "Command" },
		["t"] = { name = "TERMINAL", hl = "Command" },
	}

	local mode = mode_settings[vim.fn.mode()] or {}

	return table.concat({
		"%#StatusLineMode" .. mode.hl .. "Inverted#" .. "",
		"%#StatusLineMode" .. mode.hl .. "#" .. mode.name,
		"%#StatusLineMode" .. mode.hl .. "Inverted#" .. "",
		"%#StatusLineToNorm# ",
	})
end

local git_branch_component = function()
	local summary = vim.b.minigit_summary_string
	if summary == nil then
		return ""
	end

	local branch = vim.split(summary, " ")[1]

	return table.concat({
		" " .. branch .. " ",
	})
end

local file_name_component = function()
	local path = vim.fn.expand("%f")
	if path == "" then
		return ""
	end

	local filename = ""
	local parts = vim.split(path, "/", { plain = true })
	if #parts == 1 then
		filename = parts[1]
	else
		filename = parts[#parts - 1] .. "/" .. parts[#parts]
	end

	if vim.bo.buftype == "terminal" then
		return "%t"
	end

	return table.concat({
		"%#StatusLineFilename#" .. " " .. filename,
		vim.bo.modified and "%#StatusLineFileModified#  " or " ",

		"%#StatusLineToNorm#",
	})
end

local diff_component = function()
	local summary = vim.b.minidiff_summary
	if summary == nil then
		return ""
	end

	local add, change, delete = summary.add, summary.change, summary.delete

	return table.concat({
		"%#StatusLineDiffAdd#" .. (add > 0 and "+" .. add or "") .. " ",
		"%#StatusLineDiffChange#" .. (change > 0 and "~" .. change or "") .. " ",
		"%#StatusLineDiffDelete#" .. (delete > 0 and "-" .. delete or "") .. " ",
		"%#StatusLineToNorm# ",
	})
end

_G.statusline = function()
	local active_win = vim.fn.win_getid()
	local status_win = tonumber(vim.g.actual_curwin)

	if status_win ~= active_win then
		return "Statusline for inactive windows"
	end

	return table.concat({
		mode_component(),
		git_branch_component(),
		file_name_component(),
		"%=",
		diff_component(),
	})
end
