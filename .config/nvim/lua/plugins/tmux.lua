return {
  "aserowy/tmux.nvim",

  config = function()
    return require("tmux").setup {
      copy_sync = {
        enable = false,
      },
    }
  end,
}
