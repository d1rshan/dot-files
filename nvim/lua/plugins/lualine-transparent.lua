return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- remove lualine background
    opts.options = opts.options or {}
    opts.options.section_separators = ""
    opts.options.component_separators = ""

    opts.options.theme = {
      normal = { c = { bg = "NONE" } },
      inactive = { c = { bg = "NONE" } },
    }

    return opts
  end,
}
