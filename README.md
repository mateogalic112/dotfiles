# Dotfiles

Personal configuration files for macOS.

## Contents

- **nvim/** — Neovim config
- **claude/** — Claude Code settings and status line
- **.zshrc / .zshenv / .zprofile** — Shell config
- **.gitconfig** — Git config
- **git/ignore** — Global gitignore (linked to `~/.config/git/ignore`)
- **.tmux.conf** — Tmux config
- **ghostty/** — Ghostty terminal config
- **starship/** — Starship prompt config

## Setup on a new machine

Requires [Homebrew](https://brew.sh). Everything else is installed by the script.

```bash
# Clone the repo
git clone git@github.com:mateogalic112/dotfiles.git ~/dotfiles

# Run install script
cd ~/dotfiles
./install.sh
```

`install.sh` installs neovim, tmux, starship, ripgrep, fd, lazygit, stylua, node, go,
ruby, the zsh plugins and the language servers via Homebrew, plus `vtsls` via npm and
`gopls`/`goimports` via go — then symlinks every config. It is idempotent, so
re-running it after a config change is safe.

Neovim plugins and treesitter parsers install themselves on first launch. Tmux plugins
install via tpm, which the script clones if missing.

---

# Neovim plugins

Managed by `vim.pack` (built-in, no plugin manager). Specs live in
`nvim/lua/plugins/`, one file per plugin, all listed in `nvim/lua/plugins/init.lua`.

**Leader is `<Space>`.**

## snacks.nvim

The workhorse: fuzzy picker, file explorer, dashboard, notifications, lazygit
integration and LSP reference highlighting in one plugin.

*Use case:* every "where is that file / where is this used / what changed" question.
Its picker also answers the LSP navigation keys, so results come with a preview
instead of a bare quickfix list.

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fb` | Find open buffers |
| `<leader>fr` | Recent files |
| `<leader>sg` | Grep the project |
| `<leader>sw` | Grep word under cursor (or the visual selection) |
| `<leader>sl` | Search lines in the current buffer |
| `<leader>sb` | Grep across open buffers |
| `<leader>sd` | Diagnostics picker |
| `<leader>sr` | Resume the last picker |
| `<leader>e` | File explorer (centered float, closes on jump) |
| `<leader>bd` | Delete buffer, keeping the window layout |
| `<leader>gg` | Open lazygit |
| `<leader>gs` | Git status picker |
| `<leader>gl` | Git log picker |
| `<leader>gb` | Git branches picker |
| `]]` / `[[` | Jump to next / previous reference of the symbol under the cursor |

## nvim-lspconfig

Server configs for the built-in LSP client. Enabled: `vtsls`, `tailwindcss`, `gopls`,
`eslint`, `lua_ls`, `bashls`, `jsonls`, `cssls`, `html`.

*Use case:* completion sources, diagnostics, and code navigation for TS/JS, Go, Lua and
web files. `gopls` runs with staticcheck and the nilness/unusedparams analyses on.

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `grr` | References |
| `gri` | Implementations |
| `grt` | Type definition |
| `grc` | Incoming calls |
| `gO` / `<leader>ss` | Document symbols |
| `<leader>sS` | Workspace symbols |
| `<leader>ci` | Fix imports (add missing + organize) |
| `grn` | Rename (Neovim built-in) |
| `gra` | Code action (Neovim built-in) |
| `K` | Hover docs (Neovim built-in) |

## blink.cmp

Completion engine, paired with `friendly-snippets`.

*Use case:* autocomplete with docs popup after 200ms, dimmed ghost-text preview of the
selected item, and signature hints while typing inside a call.

| Key | Action |
| --- | --- |
| `<C-space>` | Open / toggle the docs popup |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-y>` | Accept |
| `<C-e>` | Cancel |
| `<Tab>` / `<S-Tab>` | Jump between snippet placeholders |

## nvim-treesitter (`main` branch)

Syntax-aware parsing. Parsers for bash, css, go, gomod, gowork, html, javascript,
json, lua, markdown, tsx, typescript and yaml install on demand — only the missing
ones are fetched, so startup stays cheap.

*Use case:* accurate highlighting and indentation, plus the structural awareness that
flash's treesitter mode and autopairs' string/comment skipping rely on. An autocmd
starts treesitter for any filetype that has a parser, so nothing needs to be listed
twice. No keymaps of its own.

## conform.nvim

Formatter dispatch with format-on-save (1s timeout, LSP as fallback).

*Use case:* stylua for Lua, goimports for Go, prettier for JS/TS/JSON/CSS/HTML/
Markdown/YAML. Prettier resolves from the project's `node_modules`, so each repo gets
its own version and config. No keymaps — saving with `<C-s>` is enough.

## gitsigns.nvim

Hunk signs in the gutter, staging from the buffer, and inline blame at end of line
(200ms delay).

*Use case:* reviewing and staging your own change without leaving the file.

| Key | Action |
| --- | --- |
| `]h` / `[h` | Next / previous hunk |
| `<leader>gp` | Preview hunk |
| `<leader>ga` | Stage hunk (visual: stage selected lines) |
| `<leader>gr` | Reset hunk (visual: reset selected lines) |
| `<leader>gB` | Toggle current-line blame |

## diffview.nvim

Full-window diff and file-history views.

*Use case:* the bigger git question that a gutter can't answer — reviewing a whole
branch diff, or walking the history of one file. `<leader>gd` toggles: it opens a view
if none is open, closes the open one otherwise.

| Key | Action |
| --- | --- |
| `<leader>gd` | Toggle diff view |
| `<leader>gh` | File history (current file) |
| `<leader>gH` | Repo history |

## flash.nvim

Label-based motion — type a couple of characters, jump to the label.

*Use case:* replaces most `f`/`t`/`/` hunting and search-then-`n` cycling. `s` in
operator-pending mode composes with operators, and remote flash lets `yr`/`dr` act on
a target elsewhere in the buffer and return the cursor.

| Key | Mode | Action |
| --- | --- | --- |
| `s` | n, x, o | Flash jump |
| `S` | n, x, o | Flash treesitter (select expanding syntax nodes) |
| `r` | o | Remote flash — operate at a distance, cursor comes back |
| `R` | o, x | Treesitter search |
| `<C-s>` | c | Toggle flash labels during a `/` search |

## nvim-autopairs

Auto-closes brackets and quotes, using treesitter to skip pairing inside strings and
comments.

| Key | Action |
| --- | --- |
| `<M-e>` | Fast wrap — wrap the rest of the line in the pair under the cursor |

## bufferline.nvim

Buffer tabline with LSP diagnostic counts per buffer.

| Key | Action |
| --- | --- |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<leader>bd` | Delete the current buffer |

## lualine.nvim

Statusline: mode, branch, gitsigns diff counts, file path, diagnostics, filetype and
cursor position. Custom theme keeps every section unpainted so Ghostty's background
image shows through; only the mode accent color changes. Diagnostic symbols are read
back from `vim.diagnostic.config()` so they stay in sync with the LSP setup.

## gruvbox.nvim

Colorscheme, `transparent_mode` on for the same reason as lualine. Overrides keep the
statusline strip, the cursor line number and the flash label readable.

## nvim-web-devicons

Filetype icons for the picker, explorer, bufferline and lualine. Requires a Nerd Font
(Ghostty is configured with one).

## Core keymaps

Not plugin-specific, from `nvim/lua/config/keymaps.lua`:

| Key | Action |
| --- | --- |
| `<Esc>` | Clear search highlight |
| `<C-s>` | Save (works from normal, insert and visual) |

---

# Tmux plugins

Managed by [tpm](https://github.com/tmux-plugins/tpm). **Prefix is `C-a`.**

| Plugin | Use case |
| --- | --- |
| `tmux-plugins/tpm` | The plugin manager itself. `prefix + I` installs, `prefix + U` updates. |
| `tmux-plugins/tmux-sensible` | Sane defaults everyone ends up writing by hand — bigger history, faster escape time, no repeat-time surprises. |
| `egel/tmux-gruvbox` | Gruvbox theme, matching Neovim. Status line, borders and window formats are overridden after tpm loads so the bar stays transparent over Ghostty's background image. |

## Tmux keys

| Key | Action |
| --- | --- |
| `C-a` | Prefix (`C-b` is unbound; `C-a C-a` sends a literal `C-a`) |
| `prefix + h/j/k/l` | Select pane left/down/up/right |
| `prefix + H/J/K/L` | Resize pane by 10 (repeatable) |
| `prefix + "` | Split horizontally, in the current pane's directory |
| `prefix + %` | Split vertically, in the current pane's directory |
| `prefix + r` | Reload `~/.tmux.conf` |
| `prefix + I` | Install plugins |
| `prefix + U` | Update plugins |

Windows and panes are 1-indexed and renumbered on close; copy mode uses vi keys.

---

# Zsh plugins

Installed via Homebrew, sourced from `.zshrc`.

| Plugin | Use case |
| --- | --- |
| `zsh-autosuggestions` | Ghost-text suggestion of the rest of the command from history, falling back to the completion system when history has no match (`ZSH_AUTOSUGGEST_STRATEGY=(history completion)`). |
| `zsh-syntax-highlighting` | Colors the command line as you type — invalid commands and unclosed quotes show up before you hit enter. Sourced last, since it wraps every widget defined before it. |
| `starship` | Cross-shell prompt, configured in `starship/starship.toml`. |

| Key | Action |
| --- | --- |
| `^Y` | Accept the current autosuggestion |
| `<Tab>` | Completion menu (select-style, case-insensitive matching) |

## Shell functions

| Command | Action |
| --- | --- |
| `kp <port>` | Kill whatever is listening on that port |
| `gcp "<msg>"` | `git add .`, commit with the message, push |
| `nic` | Open the current directory as a tmux session: nvim on the left (70%), claude top-right, terminal bottom-right |
| `nova` | Open the nova workspace: `backend` window (atlas-edge \| nova-practice), `frontend` window (nvim \| claude), `config` window (dotfiles) |

`nvm` is deferred — `nvm`, `node`, `npm`, `npx`, `corepack` and `yarn` start as shims
that source `nvm.sh` on first use and then replace themselves, keeping ~1.4s off shell
startup.
