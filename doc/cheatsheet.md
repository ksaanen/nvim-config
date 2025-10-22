# Neovim Cheatsheet
 
## Modes
| Mode             | How to Enter                                            | How to Exit |
| ---------------- | ------------------------------------------------------- | ----------- |
| **Normal**       | Press `Esc`                                             | —           |
| **Insert**       | `i`, `I`, `a`, `A`, `o`, `O`                            | `Esc`       |
| **Visual**       | `v` (character-wise), `V` (line-wise), `Ctrl+v` (block) | `Esc`       |
| **Command-line** | `:`                                                     | `Esc`       |
| **Replace**      | `R`                                                     | `Esc`       |

## Basic Navigation
| Action                    | Command               |
| ------------------------- | --------------------- |
| Left / Down / Up / Right  | `h` / `j` / `k` / `l` |
| Word forward / backward   | `w` / `W` / `b` / `B` |
| End of word               | `e`                   |
| Line start / end          | `0` / `$`             |
| Paragraph up / down       | `{` / `}`             |
| Page up / down            | `Ctrl+u` / `Ctrl+d`   |
| Go to line number *n*     | `:n` or `nG`          |
| Go to start / end of file | `gg` / `G`            |

## Insert Mode Shortcuts
| Action                         | Command   |
| ------------------------------ | --------- |
| Insert before cursor           | `i`       |
| Insert at line start           | `I`       |
| Append after cursor            | `a`       |
| Append at line end             | `A`       |
| Open new line below / above    | `o` / `O` |
| Replace character under cursor | `r<char>` |
| Enter replace mode             | `R`       |

## Editing Text
| Action                               | Command           |
| ------------------------------------ | ----------------- |
| Delete character / word / line       | `x` / `dw` / `dd` |
| Delete until end of line             | `D`               |
| Copy (yank) word / line              | `yw` / `yy`       |
| Paste after / before cursor          | `p` / `P`         |
| Change (delete + insert) word / line | `cw` / `cc`       |
| Undo / Redo                          | `u` / `Ctrl+r`    |
| Join lines                           | `J`               |
| Repeat last command                  | `.`               |

## Search & Replace
| Action                | Command          |
| --------------------- | ---------------- |
| Search forward        | `/pattern`       |
| Search backward       | `?pattern`       |
| Next / previous match | `n` / `N`        |
| Substitute in line    | `:s/old/new/`    |
| Substitute globally   | `:%s/old/new/g`  |
| Confirm each change   | `:%s/old/new/gc` |

## File Management
| Action              | Command            |
| ------------------- | ------------------ |
| Open file           | `:e filename`      |
| Save file           | `:w`               |
| Save as             | `:w newname`       |
| Quit                | `:q`               |
| Save and quit       | `:wq` or `:x`      |
| Quit without saving | `:q!`              |
| Reload file         | `:e!`              |
| View open buffers   | `:ls`              |
| Switch buffer       | `:bN` or `:b name` |

## Window & Tab Management
| Action              | Command                             |
| ------------------- | ----------------------------------- |
| Split horizontally  | `:split` or `:sp`                   |
| Split vertically    | `:vsplit` or `:vsp`                 |
| Move between splits | `Ctrl+w` + arrow key (or `h/j/k/l`) |
| Move to other window| `Ctrl+w` + `w`                      |
| Resize split        | `Ctrl+w` + `>` / `<` / `+` / `-`    |
| Close current split | `:q`                                |
| New tab             | `:tabnew`                           |
| Next / previous tab | `gt` / `gT`                         |
| Close tab           | `:tabclose`                         |

## Marks & Motions
| Action                            | Command               |
| --------------------------------- | --------------------- |
| Set mark `a`                      | `ma`                  |
| Jump to mark `a`                  | `'a`                  |
| Jump to previous position         | `''`                  |
| Repeat last find                  | `;`                   |
| Find character forward / backward | `f<char>` / `F<char>` |
| Until before character            | `t<char>` / `T<char>` |

## Netrw
| Action                    | Command                   |
| ------------------------- | ------------------------- |
| Toggle Netrw              | `<leader>e` or `:Lex`     |
| Open Netrw                | `:Ex` or `:Explore`       |
| Open Netrw (vert split)   | `:Vex` or `Vexplore`      |
| Open preview              | `p`                       |
| Close preview             | `Ctrl+z` + `z`            |

## Visual Mode Tricks
| Action                  | Command               |
| ----------------------- | --------------------- |
| Select text             | `v`, `V`, or `Ctrl+v` |
| Indent / unindent       | `>` / `<`             |
| Yank / delete selection | `y` / `d`             |
| Replace selection       | `c`                   |
| Paste over selection    | `p`                   |

## Command Mode Essentials
| Action                    | Command            |
| ------------------------- | ------------------ |
| Run shell command         | `:!command`        |
| View command history      | `q:`               |
| Repeat last command       | `@:`               |
| Source config             | `:source %`        |
| Execute Vimscript command | `:call function()` |

## LSP Commands
| Action                    | Command            |
| ------------------------- | ------------------ |
| Go to implementation      | `gi`               |
| Go to definition          | `gd`               |
| Go to declaration         | `gD`               |
| Go to references          | `gr`               |
| Code actions              | `<A-CR>`           |
| Open autocomplete         | `<C-Space>`        |

## Workflow Tips
| Tip                      | Description                                                         |
| ------------------------ | ------------------------------------------------------------------- |
| **Use leader key**       | Customize shortcuts: `map <leader>w :w<CR>`                         |
| **Set relative numbers** | `:set relativenumber` for better navigation                         |
| **Use `.` often**        | Repeat last change — it’s powerful!                                 |
| **Jump lists**           | `Ctrl+o` (back), `Ctrl+i` (forward)                                 |
| **Macro recording**      | `q<register>` to start, `q` to stop, `@<register>` to replay        |

## How to Use Help Buffers
| Action                | Command                            |
| --------------------- | ---------------------------------- |
| Open help topic       | `:help topic`                      |
| Search help           | `:helpgrep keyword` then `:copen`  |
| Go to linked topic    | `Ctrl-]`                           |
| Go back               | `Ctrl-T`                           |
| Close help window     | `:q`                               |
| View help for command | `:help :w`                         |
| View help for key     | `:help i_CTRL-R`                   |
| View help for option  | `:help 'number'` (note the quotes) |

## Custom Keymaps
| Action                     | Command                          |
| -------------------------- | -------------------------------- |
| List buffers               | `Ctrl-b`                         |

## Legenda
| Name      | Key       |
| --------- | --------- |
| Alt       | `<A>`     |
| Enter     | `<CR>`    |

## Common Configuration (init.lua or init.vim)
### Basics
```
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
```

### Keymaps
```
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>e', ':Ex<CR>')
```

## Changes to this document
This file is a custom cheatsheet, use the md2vim tool to convert this document to vim doc and put it in the vim config folder in the doc sub directory e.x. ```bash .config/nvim/doc/cheatsheet.txt```
### Run
```bash :helptags ~/.config/nvim/doc```
### Open with
```bash :help cheatsheet```
