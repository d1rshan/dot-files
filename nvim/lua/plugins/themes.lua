return {
  -- === THEME 1: TOKYO NIGHT (Active) ===
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 2000,
    enabled = true, -- Set to TRUE to use this theme
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      -- This ensures your borders remain visible and rounded even in Tokyo Night
      on_highlights = function(hl, c)
        local border_color = "#7aa2f7" -- Tokyo Night Blue
        hl.TelescopeBorder = { fg = border_color, bg = "NONE" }
        hl.FloatBorder = { fg = border_color, bg = "NONE" }
        hl.WhichKeyBorder = { fg = border_color, bg = "NONE" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- === THEME 2: SONOKAI (Inactive/Saved) ===
  {
    "sainnhe/sonokai",
    priority = 1000,
    enabled = false, -- Set to FALSE to disable this theme
    config = function()
      vim.g.sonokai_transparent_background = "1"
      vim.g.sonokai_enable_italic = "1"
      vim.g.sonokai_style = "atlantis"
      vim.cmd.colorscheme("sonokai")

      -- Rest of your Sonokai overrides...
      local split_gray = "#4e556a"
      local border_fg = "#a0a8b7"
      vim.api.nvim_set_hl(0, "VertSplit", { fg = split_gray, bg = "NONE" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = split_gray, bg = "NONE" })

      local highlights = {
        "NormalFloat",
        "FloatBorder",
        "WhichKey",
        "WhichKeyFloat",
        "WhichKeyNormal",
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptNormal",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "Pmenu",
        "LspFloatWinNormal",
        "DiagnosticNormal",
        "MasonNormal",
      }
      for _, name in ipairs(highlights) do
        vim.api.nvim_set_hl(0, name, { bg = "NONE" })
      end
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_fg, bg = "NONE" })
    end,
  },
}
