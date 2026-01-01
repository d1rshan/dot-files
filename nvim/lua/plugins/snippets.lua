return {
  "L3MON4D3/LuaSnip",
  keys = function()
    return {}
  end,
  config = function(plugin, opts)
    -- Include the default lazyvim setup
    require("luasnip").setup(opts)

    -- Load snippets from ~/.config/nvim/snippets/
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })

    -- Optional: Load lua-style snippets if you prefer .lua files
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })
  end,
}
