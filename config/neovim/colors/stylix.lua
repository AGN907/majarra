---@type { base00 : string, base01: string, base02: string, base03: string, base04: string, base05: string, base06: string, base07: string, base08:string, base09:string, base0A:string, base0B: string, base0C: string, base0D: string, base0E: string, base0F: string }
local colors = nixInfo({}, "info", "colors")

require("mini.base16").setup({
	palette = colors,
	plugins = {
		default = true,
	},
})

local hl = function(group)
	return vim.api.nvim_get_hl(0, {
		name = group,
		link = false,
		create = false,
	})
end

for group, opts in pairs({
	NormalFloat = { fg = hl("NormalFloat").fg, bg = colors.base00 },
	FloatBorder = { fg = colors.base02, bg = colors.base00 },
	Pmenu = { fg = hl("Pmenu").fg, bg = colors.base00 },
	PmenuSel = { fg = "NONE", bg = colors.base01 },
	PmenuThumb = { fg = hl("PmenuThumb").fg, bg = colors.base01 },
	SignColumn = { fg = hl("SignColumn").fg, bg = colors.base00 },

	LineNr = { fg = hl("LineNr").fg, bg = colors.base00 },
	LineNrAbove = { fg = hl("LineNrAbove").fg, bg = colors.base00 },
	LineNrBelow = { fg = hl("LineNrBelow").fg, bg = colors.base00 },

	DiagnosticSignError = { fg = hl("DiagnosticSignError").fg, bg = colors.base00 },
	DiagnosticSignHint = { fg = hl("DiagnosticSignHint").fg, bg = colors.base00 },
	DiagnosticSignInfo = { fg = hl("DiagnosticSignInfo").fg, bg = colors.base00 },
	DiagnosticSignOk = { fg = hl("DiagnosticSignOk").fg, bg = colors.base00 },
	DiagnosticSignWarn = { fg = hl("DiagnosticSignWarn").fg, bg = colors.base00 },

	WhichKeySeparator = { fg = hl("WhichKeySeparator").fg, bg = colors.base00 },

	MiniDiffSignAdd = { fg = hl("MiniDiffSignAdd").fg, bg = colors.base00 },
	MiniDiffSignChange = { fg = hl("MiniDiffSignChange").fg, bg = colors.base00 },
	MiniDiffSignDelete = { fg = hl("MiniDiffSignDelete").fg, bg = colors.base00 },

	MiniFilesCursorLine = { fg = hl("MiniFilesCursorLine").fg, bg = colors.base01 },

	BlinkCmpMenuBorder = { fg = colors.base02 },
	BlinkCmpDocBorder = { fg = colors.base02 },
	BlinkCmpDocSeparator = { fg = colors.base02 },
	BlinkCmpSignatureHelpBorder = { fg = colors.base02 },
	BlinkCmpLabelDeprecated = { fg = colors.base03, strikethrough = true },
	BlinkCmpKind = { fg = colors.base02 },
	BlinkCmpKindClass = { link = "Type" },
	BlinkCmpKindColor = { link = "Special" },
	BlinkCmpKindConstant = { link = "Constant" },
	BlinkCmpKindConstructor = { link = "Type" },
	BlinkCmpKindEnum = { link = "Structure" },
	BlinkCmpKindEnumMember = { link = "Structure" },
	BlinkCmpKindEvent = { link = "Exception" },
	BlinkCmpKindField = { link = "Structure" },
	BlinkCmpKindFile = { link = "Tag" },
	BlinkCmpKindFolder = { link = "Directory" },
	BlinkCmpKindFunction = { link = "Function" },
	BlinkCmpKindInterface = { link = "Structure" },
	BlinkCmpKindKeyword = { link = "Keyword" },
	BlinkCmpKindMethod = { link = "Function" },
	BlinkCmpKindModule = { link = "Structure" },
	BlinkCmpKindOperator = { link = "Operator" },
	BlinkCmpKindProperty = { link = "Structure" },
	BlinkCmpKindReference = { link = "Tag" },
	BlinkCmpKindSnippet = { link = "Special" },
	BlinkCmpKindStruct = { link = "Structure" },
	BlinkCmpKindText = { link = "Statement" },
	BlinkCmpKindTypeParameter = { link = "Type" },
	BlinkCmpKindUnit = { link = "Special" },
	BlinkCmpKindValue = { link = "Identifier" },
	BlinkCmpKindVariable = { link = "Delimiter" },
}) do
	vim.api.nvim_set_hl(0, group, opts)
end
