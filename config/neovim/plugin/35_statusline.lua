local M = {}

local palette = {

    -- Zen Bg Shades
    zenBg0 = "#090E13",
    zenBg1 = "#1C1E25",
    zenBg2 = "#22262D",
    zenBg3 = "#393B44",

    -- Ink Bg Shades
    inkBg0 = "#14171d",
    inkBg1 = "#1f1f26",
    inkBg2 = "#22262D",
    inkBg3 = "#393B44",
    inkBg4 = "#4b4e57",

    -- Mist Bg Shades
    mistBg0 = "#22262D",
    mistBg1 = "#2a2c35",
    mistBg2 = "#393B44",
    mistBg3 = "#5C6066",

    -- Popup and Floats
    altBlue1 = "#223249",
    altBlue2 = "#2D4F67",

    -- Diff and Git
    diffGreen = "#2B3328",
    diffYellow = "#49443C",
    diffRed = "#43242B",
    diffBlue = "#252535",
    gitGreen = "#76946A",
    gitRed = "#C34043",
    gitYellow = "#DCA561",

    -- Main Colors
    red = "#C34043",
    red2 = "#E46876",
    red3 = "#c4746e",
    yellow = "#DCA561",
    yellow2 = "#E6C384",
    yellow3 = "#c4b28a",
    green = "#98BB6C",
    green2 = "#87a987",
    green3 = "#8a9a7b",
    green4 = "#6A9589",
    green5 = "#7AA89F",
    blue = "#7FB4CA",
    blue2 = "#658594",
    blue3 = "#8ba4b0",
    blue4 = "#8ea4a2",
    violet = "#938AA9",
    violet2 = "#8992a7",
    violet3 = "#949fb5",
    pink = "#a292a3",
    orange = "#b6927b",
    orange2 = "#b98d7b",
    aqua = "#8ea4a2",

    -- Saturated variants (20% more saturation)
    redSaturated = "#C93134",
    red2Saturated = "#ED5965",
    red3Saturated = "#CA675F",
    yellowSaturated = "#E59F49",
    yellow2Saturated = "#EDC272",
    yellow3Saturated = "#CAAC7A",
    greenSaturated = "#8FC055",
    green2Saturated = "#7CAF7C",
    green3Saturated = "#7F9F6E",
    green4Saturated = "#5B9A82",
    green5Saturated = "#6BAE97",
    blueSaturated = "#6EBBD4",
    blue2Saturated = "#568B8F",
    blue3Saturated = "#7EAABA",
    blue4Saturated = "#81AAA9",
    violetSaturated = "#8A88B0",
    violet2Saturated = "#7E91AF",
    violet3Saturated = "#8A9FBE",
    pinkSaturated = "#A08AA2",
    orangeSaturated = "#BC8A6C",
    orange2Saturated = "#BF856B",
    aquaSaturated = "#81AAA9",

    -- Fg and Comments
    fg = "#C5C9C7",
    fg2 = "#f2f1ef",
    gray = "#717C7C",
    gray2 = "#A4A7A4",
    gray3 = "#909398",
    gray4 = "#75797f",
    gray5 = "#5C6066",
  }

local hl = function(group)
	return vim.api.nvim_get_hl(0, {
		name = group,
		link = false,
		create = false,
	})
end

function M.set_hl_groups()
	local base = hl("StatusLine")
      local colors = require("kanso.colors").setup({theme = 'zen'})
      local palette_colors = colors.palette
      local theme_colors = colors.theme

	for group, opts in pairs({
		ModeNormal = { fg = palette_colors.zenBg0, bg = palette_colors.blue3 },
		ModePending = { fg = base.bg, bg = hl("Comment").fg },
		ModeVisual = { fg = base.bg, bg = hl("SpecialKey").fg },
		ModeInsert = { fg = base.bg, bg = hl("DiffAdded").fg },
		ModeCommand = { fg = base.bg, bg = hl("Number").fg },
		ModeReplace = { fg = base.bg, bg = hl("Constant").fg },
    Git = { fg = palette_colors.blue3, bg = palette_colors.diffBlue },
		Bold = { fg = base.fg, bg = base.bg, bold = true },
		Dim = { fg = hl("LineNr").fg, bg = base.bg },
	}) do
		group = "StatusLine" .. group
		vim.api.nvim_set_hl(0, group, opts)
		opts.fg, opts.bg = opts.bg, opts.fg
		vim.api.nvim_set_hl(0, group .. "Inverted", opts)
	end
end

Config.new_autocmd("ColorScheme", nil, M.set_hl_groups, "Re-apply statusline highlights on colorscheme change")

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
    "%#StatusLineMode" .. mode.hl .. "Inverted" .. "#",
    "%#StatusLineMode" .. mode.hl .. "#" .. mode.name,
    "%#StatusLineMode" .. mode.hl .. "Inverted" .. "#",
  })
end

local git_branch_component = function ()
  local summary = vim.b.minigit_summary
  if not summary or summary == '' then
    return ''
  end

  local branch = summary.head_name or ''
  local repo  = summary.repo or ''

  return table.concat({
    "%#StatusLineGit" .. " " .. repo .. '/' .. branch .. '#'
  })
end

function M.render()
	local active_win = vim.fn.win_getid()
	local status_win = tonumber(vim.g.actual_curwin)

	if status_win ~= active_win then
		return "Statusline for inactive windows"
	end

	return table.concat({
    mode_component(),
    git_branch_component(),
		"%=",
		"Statusline right-aligned stuff",
	})
end

return M
