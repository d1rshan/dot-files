return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- 👈 this is the important line
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
