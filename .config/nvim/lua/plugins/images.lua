return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = {
      enabled = true, -- Enable image viewing
      doc = {
        inline = true, -- Render images inline in markdown
        float = true, -- Render images in a floating window when hovering
      },
    },
  },
}
