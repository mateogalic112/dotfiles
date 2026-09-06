# Cheat sheet

Searching, replacing and navigating with this config. The first half is the short
list — the keys and combos that replace something slower you are probably still
doing. The [full reference](#full-reference) below it is exhaustive.

## Top ten

| # | Key | The move it replaces |
| --- | --- | --- |
| 1 | `<leader>sr` | Reopens the last picker with its input and results intact. Retyping a grep you already ran is pure waste — this is the single most under-used key in the config. |
| 2 | `<c-g>` (in `<leader>sg`) | Grep something broad, then flip the input to a fuzzy filter over the results. Beats guessing a precise regex up front, and both inputs are remembered so you can flip back. |
| 3 | `<leader>sw` | Search the word under the cursor, or the visual selection, without typing it. Also the fastest way to answer "is this used anywhere else". |
| 4 | `grn` | LSP rename instead of `:%s`. Crosses files, ignores look-alikes in strings and comments. If you are writing a substitution for a symbol name, this is the key you wanted. |
| 5 | `s` + label | flash jump. Replaces `f`/`t` hunting, `w`-mashing, and `/foo<CR>nnn`. Two characters and a label reaches anywhere on screen. |
| 6 | `<C-o>` | Back through the jumplist. `gd` to read a definition, `<C-o>` to return — the round trip is two keys, not a buffer hunt. |
| 7 | `]]` / `[[` | Walk the references of the symbol under the cursor, in place. For reading unfamiliar code this beats opening `grr` and picking from a list. |
| 8 | `]d` / `]h` | Jump to the next diagnostic / git hunk instead of scrolling to find the squiggle or the changed block. |
| 9 | `:%s//new/g` | Empty pattern reuses the last search. Search with `*` or `<leader>sw`, eyeball the matches, then substitute without retyping the pattern. |
| 10 | `<C-^>` | Toggle the last two buffers. Almost every `<S-l><S-l><S-h>` sequence was this key. |

## Combos

**Project-wide replace, reviewed.** The picker is the review step — drop anything you
want to spare before sending it on.

```
<leader>sg   useQuery          grep it
<Tab>                          select the hits you want (skip to take all of them)
<c-q>                          send to quickfix
:cfdo %s/useQuery/useSuspenseQuery/ge | update
```

`:cfdo undo` walks it back if it went wrong.

**Narrow a noisy grep.** Two ways, and they compose:

```
useQuery -- --type=ts --glob=!**/*.test.*     cut it down in ripgrep
<c-g>  then  !test !spec                      cut it down in the fuzzy filter
```

**Read a call chain without losing your place.** `gd` in, `<C-o>` out, repeatedly —
the jumplist keeps the whole trail, so you can go four levels deep and unwind.

```
grr          who calls this
<c-v>        open one in a vsplit, keep the picker's context in view
gd / <C-o>   descend and come back
```

**Rename that the LSP can't do** (a string, a config key, a CSS class): `<leader>sw`
to see every hit, `<c-q>`, then `:cfdo`. Same pipeline as above, minus the guessing.

**Review your own diff before committing.** `<leader>gd` for the whole working tree,
`]h` / `<leader>gp` to walk and preview hunks in the file you are in, `<leader>ga` to
stage the good ones — all without leaving Neovim.

## Habits worth dropping

| Instead of | Do |
| --- | --- |
| Counting matches before `:%s` | Just type it — `inccommand=split` previews every affected line live |
| `:w` | `<C-s>`, from any mode |
| Typing a filename you half remember | `<leader>fr` (recent) or `<leader>fb` (open buffers) — usually one character in |
| `:%s/old/new/g` on a symbol | `grn`, then `<leader>ci` if imports need fixing |
| Grepping for a function name | `<leader>ss` (this file) or `<leader>sS` (workspace) — symbol names only, no comment noise |
| `<S-l>` × 6 | `<leader>fb`, or `<C-^>` for the last one |
| `f{char}` then `;;;` | `s` and a label |
| Selecting a call by hand with `v` + motions | `S` — flash treesitter labels the argument, the call, the function |
| Yanking a word by travelling to it | `yr` + label + `iw` — the cursor never leaves |
| Scrolling to find an error | `]d`, or `<leader>sd` for the list |
| Re-running a grep you already ran | `<leader>sr`, or `:colder` to get a previous quickfix list back |
| Leaving Neovim to check git | `<leader>gg` (lazygit), `<leader>gs`, `<leader>gl` |

## Two things about pickers

`?` lists every key the picker you are currently in binds — faster than reading docs
when you want to know whether it can do the thing.

`/` toggles focus between the input and the result list. In the list you get normal
mode: `j`/`k`, `zz`, `<Tab>` to select, and `q` to close.

---

# Full reference

Every key below is bound by this config; the README documents which plugin each one
comes from.

## Search

### Find a file

| Key | Where it looks |
| --- | --- |
| `<leader>ff` | Every file in the project (respects `.gitignore`) |
| `<leader>fr` | Recently opened files |
| `<leader>fb` | Open buffers |
| `<leader>e` | File explorer — when browsing beats typing a name |
| `<leader>sr` | Reopen the last picker, results and input intact |

### Find text

| Key | Scope |
| --- | --- |
| `<leader>sg` | The whole project, live through ripgrep |
| `<leader>sw` | Word under the cursor — or, from visual mode, the selection |
| `<leader>sl` | Lines of the current buffer |
| `<leader>sb` | Only the open buffers |
| `/` `?` | Native buffer search, forward / backward, with flash labels on the matches |
| `*` `#` | Native search for the word under the cursor |
| `<Esc>` | Clear the highlight afterwards |

`ignorecase` + `smartcase` means an all-lowercase pattern is case-insensitive and one
capital letter makes it case-sensitive. Ripgrep runs with `--smart-case`, so the
pickers behave the same way.

### Inside a picker

The input line drives two engines and `<c-g>` switches between them: in `<leader>sg`
you are typing a ripgrep pattern, and after `<c-g>` you are fuzzy-filtering the
results already found. Both inputs are remembered, so you can flip back and forth.

| Key | Action |
| --- | --- |
| `<c-g>` | Toggle live mode (ripgrep pattern ⇄ fuzzy filter) |
| `<c-n>` / `<c-p>` | Next / previous result |
| `<c-f>` / `<c-b>` | Scroll the preview |
| `<Tab>` | Select this result and move on (multi-select) |
| `<c-a>` | Select all |
| `<c-q>` | Send the selection — or everything, if nothing is selected — to quickfix |
| `<c-s>` / `<c-v>` / `<c-t>` | Open in a split / vsplit / tab |
| `<a-h>` / `<a-i>` | Include hidden files / gitignored files |
| `<a-p>` / `<a-m>` | Toggle the preview / maximize the picker |
| `<c-r><c-w>` | Insert the word under the cursor into the prompt |
| `?` | List every key the current picker binds |
| `<Esc>` | Close |

The fuzzy filter takes fzf syntax — in `<leader>ff` and friends directly, in
`<leader>sg` after `<c-g>`:

| Pattern | Matches |
| --- | --- |
| `foo bar` | both terms, in any order |
| `foo \| bar` | either term |
| `!foo` | items *without* `foo` |
| `'foo` | `foo` literally, no fuzziness |
| `'foo'` | `foo` as a whole word |
| `^foo` / `foo$` | prefix / suffix |
| `file:src/api` | field filter — only items whose path matches |

Live grep hands anything after ` -- ` straight to ripgrep, no shell in between, so
globs need no quoting:

```
useQuery -- --type=ts               only TypeScript files
useQuery -- --glob=!**/*.test.*     skip tests
TODO -- --no-ignore --hidden        include gitignored and dotfiles
handler -- --word-regexp            whole word only
```

### Find a symbol

Grepping for a name finds the comment that mentions it too. The LSP doesn't.

| Key | Action |
| --- | --- |
| `<leader>ss` / `gO` | Symbols in this file |
| `<leader>sS` | Symbols across the workspace |
| `gd` | Definition |
| `grr` | Every reference |
| `gri` | Implementations |
| `grt` | Type definition |
| `grc` | Callers |
| `K` | Hover docs |
| `<leader>sd` | Diagnostics picker |

### From the shell

```bash
rg 'useQuery'                    # respects .gitignore
rg -t ts 'useQuery'              # TypeScript only (rg --type-list for the rest)
rg -l 'useQuery'                 # file names only
rg -w 'id'                       # whole word
rg -F 'a.b[0]'                   # literal, no regex
rg -C 3 'panic('                 # with 3 lines of context
rg --no-ignore --hidden 'TODO'   # include gitignored files and dotfiles
fd '\.test\.ts$'                 # files by name
fd -t d migrations               # directories only
```

`:grep` inside Neovim runs ripgrep too (`grepprg=rg --vimgrep --smart-case`) and fills
the quickfix list: `:grep useQuery` then `:copen`.

## Replace

### In one buffer

`inccommand=split` previews the substitution in a split while you type it, so you see
every affected line before pressing enter.

| Command | Action |
| --- | --- |
| `:%s/old/new/g` | Whole file |
| `:%s/old/new/gc` | Whole file, confirming each match |
| `:s/old/new/g` | Current line |
| `:'<,'>s/old/new/g` | The visual selection — typing `:` in visual mode inserts the range |
| `:%s/\<<C-r><C-w>\>/new/g` | The word under the cursor; `<C-r><C-w>` pastes it into the command line |
| `:%s//new/g` | Reuse the last search pattern — pairs with `*` or `<leader>sw` |
| `&` / `g&` | Repeat the last substitution on this line / on the whole file |

### Rename a symbol

`grn` is the tool for renaming a function, variable, type or component: LSP rename is
semantic, so it crosses files and leaves look-alikes in strings and comments alone.
`<leader>ci` afterwards fixes up imports.

### Across the project

Quickfix first, when you want to look at the matches before touching them:

```vim
:grep useQuery          " or <leader>sg, then <c-q> from the picker
:copen                  " review, delete lines you want to spare
:cfdo %s/useQuery/useSuspenseQuery/ge | update
```

The arglist skips the review:

```vim
:args `rg -l useQuery`
:argdo %s/useQuery/useSuspenseQuery/ge | update
```

The `e` flag swallows "pattern not found" so the loop doesn't abort halfway, and
`update` writes only the buffers that actually changed. `:cfdo undo` / `:argdo undo`
walks the whole thing back.

Straight from the shell when review isn't worth it — macOS `sed` needs the empty `-i`
argument, and there is no undo, so commit first:

```bash
rg -l 'useQuery' | xargs sed -i '' 's/useQuery/useSuspenseQuery/g'
```

## Navigate

### Around the visible text

| Key | Action |
| --- | --- |
| `s` | flash jump — type two characters, then the label. Replaces most `f`/`t`/`/` hunting |
| `S` | flash treesitter — labels expanding syntax nodes, i.e. "select this argument / call / function" |
| `y`/`d` then `r` | Operate at a distance: `yr`, a label, then a motion (`yriw`) yanks a word elsewhere and returns the cursor |
| `R` | Treesitter search, in operator-pending and visual mode |
| `<C-s>` | Toggle flash labels while a `/` search is open |
| `%` | Matching bracket; `[%` / `]%` for the start / end of the enclosing block |
| `{` / `}` | Previous / next blank line |

`]]` and `[[` are remapped: instead of section motions they walk the references of the
symbol under the cursor, which snacks also highlights as you sit on it.

### Within a file

| Key | Action |
| --- | --- |
| `gd` `grr` `gri` `grt` `grc` | LSP navigation, answered by a picker with a preview |
| `<C-o>` / `<C-i>` | Back / forward through the jumplist — how you return after `gd` |
| `<C-t>` | Pop the tag stack |
| `g;` / `g,` | Previous / next change |
| `` `. `` | Where you last edited |
| ``` `` ``` / `''` | Position before the last jump |
| `ma` / `` `a `` | Set / jump to mark `a` — lowercase is file-local, uppercase is global |
| `]d` / `[d` | Next / previous diagnostic |
| `]h` / `[h` | Next / previous git hunk |

### Between files

| Key | Action |
| --- | --- |
| `<S-h>` / `<S-l>` | Previous / next buffer; bufferline shows the order and error counts |
| `<C-^>` | Toggle between the last two buffers |
| `<leader>bd` | Close the buffer, keep the window layout |
| `gf` | Open the file path under the cursor |
| `<C-w>s` / `<C-w>v` | Split horizontally / vertically — new splits land right and below |
| `<C-w>h/j/k/l` | Move between splits |

In the explorer (`<leader>e`): `l` / `h` open and close a directory, `a` add, `r`
rename, `d` delete, `m` move, `y` / `p` copy and paste, `H` show hidden, `Z` collapse
everything, `]g` / `[g` jump to the next changed file, and `<leader>/` starts a grep
scoped to the highlighted directory.

### Lists

Quickfix is the shared channel: `:grep`, `<c-q>` from any picker and `:cfdo` all speak it.

| Key | Action |
| --- | --- |
| `]q` / `[q` | Next / previous entry |
| `]Q` / `[Q` | First / last entry |
| `:copen` / `:cclose` | Open / close the list |
| `]l` / `[l` | The same, for the location list (`:lopen`) |
| `:colder` / `:cnewer` | Previous / next quickfix list — every `:grep` pushes a new one |

### History

| Key | Action |
| --- | --- |
| `<leader>gg` | lazygit |
| `<leader>gs` | Changed files |
| `<leader>gl` | Commit log |
| `<leader>gb` | Branches |
| `<leader>gd` | Diff of the working tree |
| `<leader>gh` / `<leader>gH` | History of this file / of the repo |
| `<leader>gp` | Preview the hunk under the cursor |
| `<leader>gB` | Toggle inline blame |

Blame is already on at end of line, so "who wrote this, and when" usually costs no
keypress at all.

### Across panes and projects

| Key | Action |
| --- | --- |
| `prefix + h/j/k/l` | Move between tmux panes (prefix is `C-a`) |
| `prefix + [`, then `/` | Search the terminal scrollback — copy mode uses vi keys |
| `nic` | Open the current directory as a tmux session: nvim, claude, terminal |
| `nova` | Open the nova workspace: backend, frontend and config windows |

