# Harper + Vale Migration Plan

Replacing Grammarly with Harper (grammar/spell via LSP) + Vale (style linting via flymake)

## Background

Grammarly's Text Editor SDK was shut down on January 10, 2024. The `@emacs-grammarly/grammarly-languageserver` you had registered via eglot:

1. Uses `@grammarly/sdk` (deprecated, API shut down)
2. Requires Grammarly authentication that no longer works through third-party clients
3. The server binary is installed but calls a dead API

## Why This Approach?

### Harper via eglot (LSP)

- Replaces the grammarly-languageserver registration on same modes
- Grammar/spell checking via LSP diagnostics → flymake
- No conflicts with existing eglot setup
- Privacy-first: runs entirely locally

### Vale via flymake-vale

- Style linting (Microsoft, write-good, etc.) via flymake
- NO flycheck involved — avoids the known Doom 3.x flymake/flycheck conflict (#8546)
- Flymake natively supports multiple backends per buffer
- Independent from eglot (complementary layer)

### Conflict Analysis

| Tool | Conflict Risk | Detail |
|----|----|----------|
| Harper (eglot LSP) | None | Replaces dead grammarly-languageserver registration |
| Vale (flymake-vale) | None | Flymake supports multiple backends; no flycheck involved |
| flyspell (Doom spell module) | None | Independent from both Harper and Vale |

## Configuration Changes

### System Installation

```bash
# Harper LSP server (Rust — cargo install)
cargo install harper-ls --locked

# Vale (Go — guix install, since you have Guix)
guix install vale
```

### Emacs Package

Add to `packages.el`:

```elisp
(package! flymake-vale
  :recipe (:host github :repo "tpeacock19/flymake-vale"))
```

### Replace Grammarly eglot block in `config.el`

**Remove** (lines 466–481):

```elisp
;;;; Enable Grammarly
;;(use-package! eglot-grammarly
;;:defer t
;;:hook ((markdown-mode text-mode org-mode latex-mode-hook) . eglot-ensure))
(use-package! eglot
  :defer t
  :hook ((text-mode
          markdown-mode
          org-mode
          latex-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(((text-mode markdown-mode org-mode latex-mode))
                 . ("grammarly-languageserver" "--stdio"
                    :initializationOptions
                    (:clientId "client_BaDkMgx4X19X9UxxYRCXZo"))))
```

**Add** Harper + Vale block:

```elisp
;;;; Harper + Vale (Grammarly replacements)
;; Harper (grammar/spell via eglot LSP) — replaces grammarly-languageserver
(add-to-list 'eglot-server-programs
             '(((text-mode markdown-mode org-mode latex-mode) :language . "english")
               . ("harper-ls")))

;; Harper auto-ensure on text modes (replaces grammarly eglot-ensure)
(add-hook 'text-mode-hook #'eglot-ensure)
(add-hook 'markdown-mode-hook #'eglot-ensure)
(add-hook 'org-mode-hook #'eglot-ensure)
(add-hook 'latex-mode-hook #'eglot-ensure)

;; Vale (style linting via flymake) — no conflict with eglot
(use-package! flymake-vale
  :defer t
  :hook ((text-mode
          markdown-mode
          org-mode
          latex-mode) . flymake-vale-on))
```

### Vale Configuration

Create `~/.config/vale/` with `.vale.ini`:

```ini
[*.md]
BasedOnStyles = Vale, Microsoft, write-good
Vale.Spelling = WARNING
Microsoft.Contractions = NO
Microsoft.FirstPerson = NO

[*.org]
BasedOnStyles = Vale, Microsoft, write-good

[*.{txt,text}]
BasedOnStyles = Vale, write-good
```

Download styles:

```bash
mkdir -p ~/.config/vale/styles
cd ~/.config/vale/styles
git clone --depth 1 https://github.com/errata-ai/Microsoft.git
git clone --depth 1 https://github.com/errata-ai/write-good.git
git clone --depth 1 https://github.com/errata-ai/Vale.git
```

## Migration Steps

1. **Install system binaries**

   ```bash
   cargo install harper-ls --locked
   guix install vale
   ```

2. **Configure Vale**
 
   ```bash
   mkdir -p ~/.config/vale
   # ... [create .vale.ini and clone styles as above]
   ```

3. **Modify Emacs configs**
   - Add `flymake-vale` package to `packages.el`
   - Replace Grammarly block in `config.el` with Harper + Vale block
   - Remove `eglot-grammarly` from `packages.el`
   - Disable the empty `grammar` checkers module in `init.el` (line 96: comment out `grammar`)

4. **Sync and restart**
   
   ```bash
   cd ~/.config/doom
   doom sync
   ```

5. **Verification**
   - Open a `.md` or `.org` file
   - Verify Harper shows grammar/spell diagnostics
   - Verify Vale shows style guide warnings
   - Check modeline shows flymake/Vale indicators
   - Confirm no conflicts with existing eglot registrations

## What You'll Get

| Tool | Provides | Mechanism |
|----|------|------|
| Harper (eglot LSP) | Grammar checking, spelling, inline suggestions | LSP diagnostics → flymake |
| Vale (flymake-vale) | Style enforcement (Microsoft, write-good) | flymake backend |
| flyspell (Doom built-in) | Dictionary spell checking | Emacs overlays |

All three layers coexist peacefully — Harper handles grammar, Vale handles style, flyspell provides inline dictionary checking.

## Rollback Plan

If anything breaks:

1. Revert `config.el` to restore the eglot registration
2. Remove `flymake-vale` from `packages.el`
3. Run `doom sync`
4. Restart Emacs

Note: Grammarly will still be broken (API is dead), at least until you find a replacement.

## References

- Harper LSP docs: https://writewithharper.com/docs/integrations/language-server
- Harper Emacs integration: https://writewithharper.com/docs/integrations/emacs
- flymake-vale: https://github.com/tpeacock19/flymake-vale
- Vale documentation: https://vale.sh/docs/vale-cli
- Known Doom 3.x flymake/flycheck conflict: https://github.com/doomemacs/doomemacs/issues/8546
