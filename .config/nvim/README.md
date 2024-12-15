<h1 align="center">TeVim</h1>

<div align="center">

![GitHub top language](https://img.shields.io/github/languages/top/sownteedev/TeVim?color=6d92bf&style=for-the-badge&labelColor=111418)
![Last Commit](https://img.shields.io/github/last-commit/sownteedev/TeVim?&style=for-the-badge&color=da696f&logoColor=D9E0EE&labelColor=111418)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/sownteedev/TeVim?color=e1b56a&style=for-the-badge&labelColor=111418)
![GitHub Repo stars](https://img.shields.io/github/stars/sownteedev/TeVim?color=74be88&style=for-the-badge&labelColor=111418)

</div>

<img src="https://github.com/sownteedev/TeVim/assets/90148193/dda6c61f-10a1-4317-8df2-561e3f961bd2">

<div align="center">

```txt
Performance for time startup on low laptop
On Power                              : 15ms - 20ms
On Battery                            : 17ms - 21ms
```

</div>
<h5> Themes Showcase with 16 colorschemes </h5>

| <img src="https://github.com/sownteedev/TeVim/assets/90148193/7b5e73eb-244c-48b0-937a-bd9590ca151c" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/0dad550e-08f0-4ed3-a0a5-b8ace6e561d2" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/a3f2a5ab-e17f-4132-9c52-7ea8b0962ab8" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/ed8f0347-b809-4570-b0d9-6b49e81257d9" align="center" width="200px"> |
| :-------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/sownteedev/TeVim/assets/90148193/a7426bf0-43cd-4eb5-943c-7995b23a5b4b" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/49100402-f82c-40e3-9197-debdc04a0e54" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/7ec88e9b-5e40-475c-b765-82cc83571dd5" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/2148b26a-b799-426b-89ec-5ceda8a1006b" align="center" width="200px"> |
| <img src="https://github.com/sownteedev/TeVim/assets/90148193/c4fe9259-0714-4247-8c95-9cec37c0c697" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/073d64fd-f049-43a4-903d-6fde8ab1fbe3" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/a77bc174-cc25-4610-9c58-32590ad8c577" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/2ff7f908-51e7-4214-9609-9c4b72da8f90" align="center" width="200px"> |
| <img src="https://github.com/sownteedev/TeVim/assets/90148193/c9bc8b70-1912-4700-8f8c-928493189805" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/974c9cec-5479-49a1-9d37-05e82749ac97" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/eabb7fba-1596-44ec-b93c-98fb2244c911" align="center" width="200px"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/f7502d7c-fe4b-4970-899c-d32cd83bec73" align="center" width="200px"> |

</details>

## 🔎 Requirements

- Neovim >= v0.9 (Recommend nightly version).

- Nerd Font as your terminal font.

- `Ripgrep` and `Fzf` are required for grep searching with Telescope.

- `GCC (Clang)`, **Windows** users must have `mingw` installed and set on PATH.

- `Lazygit` and `Ranger` (OPTIONAL).

- `Xsel` and `Xclip` for copy and paste (X11), `wl-clipboard` (Wayland) (OPTIONAL).

## ⬇️  Installation

#### Linux
- Backup your config
  ```zsh
  mv ~/.config/nvim ~/.config/nvim.bak
  ```
- Remove cache setup
  ```zsh
  rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
  ```
- Install TeVim
  ```zsh
  git clone https://github.com/sownteedev/TeVim ~/.config/nvim --depth 1 && nvim
  ```

- Adding Mason to PATH
  ```zsh
  # this is for zsh
  export PATH=$PATH:~/.local/share/nvim/mason/bin
  ```

#### Windows (PowerShell)
- Backup your config
  ```powershell
  Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
  ```
- Remove cache setup
  ```powershell
  Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
  ```
- Install TeVim
  ```powershell
  git clone https://github.com/sownteedev/TeVim $env:LOCALAPPDATA\nvim --depth 1 && nvim
  ```

#### Custom Colorschemes
> Read file colorschemes on tevim/themes/schemes/ and write like it on custom/themes/schemes/

#### TeVim Commands
> **TeVimThemes** : Open list colorschemes
>
> **TeVimToggleTrans** : Toggle Transparency
>
> **TeVimCheckMason** : Install or Remove package you add or remove on custom/configs/overrides.lua
>
> **TeVimUpdate** : Update TeVim (If you have any problems, please create issues)

<br>

<h3> ENJOY WITH TEVIM ! 🎉 </h3>

<br>

> **NOTE:**
>
> TeVim auto create Custom Folder, change or add everything on it.
>
> THIS IS NOT A "DISTRO" and not for BEGINNERS, you need to have some experiences with Lua and Neovim.
>
> If there are any errors or questions, please create Issues or contact me
<a href="https://discordapp.com/users/745732774027198554">here</a>

## Plugins

| Plugin (~30 plugs)                                                                    | Description                                                    |  Lazy   |
| ------------------------------------------------------------------------------------- | -------------------------------------------------------------- | :-----: |
| [folke/lazy](https://github.com/folke/lazy.nvim)                                      | the package manager for newbies                                | `true`  |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | syntax highlighting, most popular one for neovim               | `true`  |
| [HiPhish/rainbow-delimiters.nvim](https:://github.com/HiPhish/rainbow-delimiters.nvim)| highlights matching delimiters                                 | `true`  |
| [NvChad/nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)             | highlights colors and is really frickin fast                   | `true`  |
| [nvim-neo-tree/neo-tree.lua](https://github.com/nvim-neo-tree/neo-tree.nvim)          | a very neat, simple and clean file tree and most features      | `true`  |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)         | more devicons for neovim                                       | `true`  |
| [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)                   | automatically close and rename html tags                       | `true`  |
| [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)                     | automatically close and rename brackets                        | `true`  |
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)     | probably the most popular menu. can be used for a lot of stuff | `true`  |
| [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)                 | terminal integration in neovim                                 | `true`  |
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                 | Super fast git decorations implemented purely in Lua.          | `true`  |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)                 | installing LSPs made super easy                                | `true`  |
| [nvimdev/lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim)                       | responsible for the winbar and lightbulb                       | `true`  |
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                     | the most popular LSP client for neovim                         | `true`  |
| [hrsh7th/nvim-cmp](https:://github.com/hrsh7th/nvim-cmp)                              | autocompletion plugin for neovim                               | `true`  |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)                               | very simple and easy to use snippet engine                     | `true`  |
| [RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate)                     | highlights all instances of the word under the cursor          | `true`  |
| [lukas-reineke/indent-blankline.nvim](https:://github.com/lukas-reineke/indent-blankline.nvim)| shows indent lines in neovim                           | `true`  |
| [echasnovski/mini.indentscope](https:://github.com/echasnovski/mini.indentscope)      | perfect animation indent lines                                 | `true`  |
| [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)                     | quik and easy commenting                                       | `true`  |
| [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)               | beautiful highlights for TODO comments                         | `true`  |

## Keybinds

| Keys        | Function          |
| ------------- |-------------|
| <kbd>CTRL</kbd> <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd> | Moving Window Focus Towards Left/Up/Down/Right (Normal) |
| <kbd>CTRL</kbd> <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd> | Moving Cursor Left/Up/Down/Right (Insert) |
| <kbd>CTRL</kbd> <kbd>e</kbd> | Toggle Explorer with Neotree |
| <kbd>CTRL</kbd> <kbd>`</kbd> | Open And Close ToggleTerm |`
| <kbd>ALT</kbd> / <kbd>⬇️</kbd> / <kbd>⬆️</kbd> | Moving Current Line or Lines Down/Up |
| <kbd>Enter</kbd> | Clear Highlight Search |

#### File Operations

| Keys        | Function          |
| ------------- |-------------|
| <kbd>LDR</kbd> <kbd>q</kbd> | Exit Neovim |
| <kbd>CTRL</kbd> <kbd>s</kbd> | Save File (N + I) |
| <kbd>CTRL</kbd> <kbd>q</kbd> | Close Current Buffer |
| <kbd>CTRL</kbd> <kbd>o</kbd> | Close Other Buffer |
| <kbd>TAB</kbd>               | Next Buffer |
| <kbd>SHIFT</kbd> <kbd>TAB</kbd> | Previous Buffer |
| <kbd>CTRL</kbd> <kbd>/</kbd> | Toggle Comment (N + I + V) |

#### Telescope

| Keys        | Function          |
| ------------- |-------------|
| <kbd>LDR</kbd> <kbd>f</kbd> <kbd>f</kbd> | Find Files |
| <kbd>LDR</kbd> <kbd>f</kbd> <kbd>r</kbd> | Find Recently Visited Files |
| <kbd>LDR</kbd> <kbd>f</kbd> <kbd>w</kbd> | Find File By String |
| <kbd>LDR</kbd> <kbd>f</kbd> <kbd>t</kbd> | TODO |

#### LSP

| Keys        | Function          |
| ------------- |-------------|
| <kbd>LDR</kbd> <kbd>l</kbd> <kbd>a</kbd>  | Code Action |
| <kbd>LDR</kbd> <kbd>l</kbd> <kbd>o</kbd>  | Outline |
| <kbd>LDR</kbd> <kbd>l</kbd> <kbd>i</kbd>  | Lsp Infor |
| <kbd>LDR</kbd> <kbd>l</kbd> <kbd>r</kbd>  | Lsp Rename |

#### Treesitter

| Keys        | Function          |
| ------------- |-------------|
| <kbd>LDR</kbd> <kbd>s</kbd> <kbd>i</kbd> | Treesitter Info |
| <kbd>LDR</kbd> <kbd>s</kbd> <kbd>u</kbd> | Treesitter Update |

#### TeVim

| Keys        | Function          |
| ------------- |-------------|
| <kbd>LDR</kbd> <kbd>LDR</kbd> <kbd>u</kbd> | TeVim Update |
| <kbd>LDR</kbd> <kbd>LDR</kbd> <kbd>c</kbd> | TeVim Colorscheme Picker |
| <kbd>LDR</kbd> <kbd>LDR</kbd> <kbd>t</kbd> | Toggle Transparency |
| <kbd>LDR</kbd> <kbd>LDR</kbd> <kbd>m</kbd> | TeVim Check Mason |

<br>

> Use **Telescope keymaps** for more keybinds

<br>

<details><summary> <b>Credits</b></summary>

- [Nvchad](https://github.com/nvchad) helped TeDash and TeBufline (fix some bugs for theme)

</details>
