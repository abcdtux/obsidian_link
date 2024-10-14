## 1. INTRODUCTION

The `obsidian_link` plugin allows you to easily create Obsidian-style links to Markdown files within your current directory and its subdirectories. It integrates with Telescope to provide a user-friendly interface for selecting files.

## 2. REQUIREMENTS 

- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## 3. INSTALLATION

### `Vim-plug` 

Add the following line to your `init.vim` or `init.lua`:

```lua
  Plug { 
    'abcdtux/obsidian_link',
    'requires': { 'nvim-telescope/telescope.nvim' } 
  }
```

Then run `:PlugInstall` to install the plugin.

### `Packer` 
Add the folowing line in your configuration:

```lua
  use {
    'abcdtux.nvim/obsidian_link',
    dependencies = { "nvim-telescope/telescope.nvim" }
  }
```

Then run `:PackerSync` to install the plugin.

### `Lazy`
Add new config file:

```lua
  return {
    "abcdtux/obsidian_link",
    dependencies = { "nvim-telescope/telescope.nvim" }
  }
```

Then run `:Lazy` to install the plugin.

## 4. Configuration 

`obsidian_link` does not have any configuration. You can define a shortcut in insert mode:

```lua
  vim.api.nvim_set_keymap(
    'i', 
    '<C-l>', 
    ':require("obsidian_link").obsl<CR>', 
    { noremap = true, silent = true }
  )
```

## 5. Usage

To create an Obsidian link to a Markdown file, invoke the following command:

```vim
  :require("obsidian_link").obsl
```

This will open a Telescope prompt displaying a list of Markdown files in the current directory and its subdirectories. Select a file, and it will insert a link in the format `[[<file>]]` at the cursor position.
It is possible to type characters in the prompt to filter the displayed list.

## 6. Features
- Browse and select Markdown files using Telescope. 
- Automatically format links in the Obsidian style: `[[<file>]]`. 
- Supports subdirectories for easy navigation.

## 7. License
This project is licensed under the MIT License. See the LICENSE file for more details.

