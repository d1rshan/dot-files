return {
  {
    "folke/snacks.nvim",
    -- This 'opts' table will be merged with the default LazyVim 'opts'
    lazy = false,
    opts = {
      picker = {
        hidden = true,
        sources = {
          files = {
            hidden = true,
          },
          explorer = {
            layout = {
              -- This tells snacks to hide the input bar
              -- It will reappear when you press "/" to search
              auto_hide = { "input" },
            },
          },
        },
      },
    },
  },
}
