# Neovim setup on a new machine

Everything in this repo is config. Everything that _breaks_ on a new machine
lives in `~/.local/share/nvim`, which is **not** in this repo: treesitter
parsers, Mason packages, the Copilot language server binary. That directory is
the entire checklist below.

Order matters. Runtimes first, then Neovim — installing a runtime while nvim is
already open does nothing, because **Neovim captures `$PATH` at startup**.

---

## 1. Runtimes (before opening Neovim)

```sh
brew install neovim ripgrep fd
curl https://mise.run | sh
```

Global tools in `~/.config/mise/config.toml`:

```sh
mise use -g node@lts        # NOT @latest — Copilot's server targets LTS
mise use -g go@latest
mise use -g ruby@x.x.x      # match the project you work in most
mise use -g python@latest
mise use -g tree-sitter     # required by nvim-treesitter main branch
```

Verify **in a fresh shell** before continuing:

```sh
which node go ruby tree-sitter
```

## 2. Neovim plugins

Open nvim once and let lazy.nvim clone everything. Then:

```vim
:Lazy sync
:checkhealth
```

## 3. Treesitter parsers

Installed automatically by the spec in `lua/plugins/treesitter.lua`, but it
needs the `tree-sitter` CLI and a C compiler present _first_. Confirm:

```vim
:lua =require('nvim-treesitter.config').get_installed()
:checkhealth nvim-treesitter
```

An empty list means the CLI was missing when they tried to build.

## 4. Mason packages — everything except Ruby

```vim
:MasonInstall gopls delve lua-language-server python-lsp-server prettier sqlfluff html-lsp json-lsp
```

These are Go binaries, npm packages and Python tools — self-contained, and
unaffected by runtime version switching.

## 5. Ruby — never through Mason

Mason compiles gems once, against whatever Ruby was active at install time.
Native extensions are ABI-bound to a Ruby minor version, so the moment a project
pins a different Ruby they are silently ignored and dependency resolution
collapses. Install per Ruby version instead:

```sh
mise use ruby@3.2.8       # inside the project
gem install ruby-lsp      # repeat once per Ruby version you work with
```

RuboCop runs through bundler (see `conform` config) so it picks up the project's
own plugins such as `rubocop-rspec`. Nothing to install globally.

Confirm nvim resolves the right one — this is the check that matters:

```vim
:lua =vim.fn.exepath('ruby-lsp')   " must be under mise/installs/ruby/<version>/
```

## 6. Copilot

Auth is per machine and lives outside this repo, in
`~/.config/github-copilot/`.

```vim
:Copilot auth
:checkhealth copilot
```

A work seat may require SAML SSO against the org.

---

## Gotchas that cost real time

**Mason's `bin` is prepended to `$PATH` inside nvim.** A command that resolves
to the mise version in your shell can resolve to Mason's copy inside Neovim.
`:lua =vim.lsp.config.<server>.cmd` shows the _name_; `vim.fn.exepath()` shows
which _file_ that name resolves to. They can disagree.

**`:checkhealth` and the failing code path may do different lookups.** Health
checks often probe `$PATH` while a plugin spawns a hardcoded path, so health can
report green in exactly the spot that's broken.

**Never hardcode absolute paths in config.** Use `vim.fn.exepath()`,
`vim.env.HOME`, `vim.fn.stdpath()`. A pinned `copilot_node_command` from a
previous machine fails silently and looks like a plugin bug.

**`:scriptnames` only lists sourced files.** It cannot show `-c` arguments,
`$VIMINIT`/`$EXINIT`, or strings passed to `vim.cmd()`. If something runs that
you can't find, check the environment.

**Listing a server in `mason-lspconfig`'s list makes Mason own its `cmd`**,
overriding `vim.lsp.config`. Remove it there if you want PATH resolution.

**Restart fully after runtime changes.** Not a new buffer — a new process.

---

## Smoke test

Open a file of each type from inside a real project and confirm:

- [ ] Syntax highlighting (treesitter, not regex fallback)
- [ ] `:LspInfo` shows the expected server attached
- [ ] `:ConformInfo` lists a formatter as ready
- [ ] Copilot suggests on `InsertEnter`
- [ ] `~/.local/state/nvim/lsp.log` has no `No such file or directory`

Note: `semantic_tokens` `-32801 "Content modified"` in the LSP log is normal —
a request cancelled because you kept typing. Neovim logs everything a server
writes to stderr at ERROR level, so routine progress output looks alarming.
