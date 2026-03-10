;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; Commentary:
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)

;;; Code:
;; Helpers
(defun near/unsetenv (var)
  "Remove VAR from Emacs process environment."
  (setenv var nil))

;; Handle TTY Usage
(defun near/linux-vt-console-p ()
  "True when running on the Linux virtual console (e.g. tty1, TERM=linux)."
  (and (not (display-graphic-p))
       (let ((term (getenv "TERM")))
         (or (equal term "linux")
             ;; Sometimes you'll see these on weird console setups:
             (equal term "vt100")
             (equal term "vt220")))))

(when (near/linux-vt-console-p)
  ;; --------- Modeline / icons ------------
  (setq doom-modeline-icon nil
        doom-modeline-major-mode-icon nil
        doom-modeline-minor-modes nil
        doom-modeline-buffer-file-name-style 'file-name
        doom-modeline-enable-word-count nil)

  ;; --------- Pretty / Unicode-ish features -----------
  ;; Doom's "pretty" features rely on symbols & glyphs that a VT console lacks
  (setq doom-symbol-fallback-font-families nil)

  ;; Turn off symbol prettification that producesp glyhs
  (when (boundp 'prettify-symbols-mode)
    (add-hook 'after-change-major-mode-hook
              (lambda () (prettify-symbols-mode -1))))

  ;; Turn off ligatures if used
  (when (fboundp 'ligature-mode)
    (add-hook 'after-change-major-mode-hook
              (lambda () (ligature-mode -1))))

  ;; --------- Org-specific tofu offenders -----------
  ;; I don't use org-superstar, leaving empty

  ;; --------- General sanity ----------
  ;; Less visual noise on raw console
  (setq display-line-numbers-type nil))

;; Configure spacemacs dark
(setq doom-theme 'spacemacs-dark)

;; Darken spacemacs buffer Spacemacs background theme to match number column
(defun my/spacemacs-match-line-number-bg ()
  "Set the buffer background to match the line-number background."
  (let ((ln-bg (face-background 'line-number nil t)))
    (set-face-attribute 'default nil :background ln-bg)
    (set-face-attribute 'fringe nil  :background ln-bg)
    (when (facep 'font-lock-comment-face)
      (set-face-attribute 'font-lock-comment-face nil :background ln-bg))))

(add-hook 'doom-load-theme-hook #'my/spacemacs-match-line-number-bg)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;;; Commentary:
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;; Code:
;; Set vterm font
(defvar my/vterm-font-family "MesloLGS NF"
  "Font family to use in vterm buffers.")

(after! vterm
  (add-hook 'vterm-mode-hook
            (lambda ()
              (setq-local buffer-face-mode-face `(:family ,my/vterm-font-family))
              (buffer-face-mode 1)))
  (setq vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=yes"))

;; GPTEL Install
;; TODO Put in Keyring
;; NOTE: Do NOT store API keys in plaintext in config.el. Prefer env vars or auth-source.
;; - OPENAI_API_KEY: used for the OpenAI backend
;; - ANTHROPIC_API_KEY: optional if you also configure an Anthropic backend in gptel
;;:init
  ;;;; Helper to fetch secrets from env or auth-source (Doom already enables auth-source).
;;(defun my/auth-source-secret (host &optional user)
;;"Return a secret for HOST (and optional USER) from auth-source, or nil."
;;(require 'auth-source)
;;(let* ((found (car (auth-source-search :host host
;;:user user
;;:max 1
;;:require '(:secret))))
;;(secret (plist-get found :secret)))
;;(when secret
;;(if (functionp secret) (funcall secret) secret))))
(use-package! gptel
  :commands (gptel gptel-menu)

  :preface
  ;; Local Ollama backend (chat models only)
  (defvar my/gptel-ollama-backend
    (gptel-make-ollama "Ollama"
      :host "localhost:11434"
      :stream t
      :models
      ;; This set of models tuned for Razer Laptop with 8gb VRAM 5070
      '((qwen3.5:9b
         :description "Qwen 3.5 9b (local reasoning)"
         :capabilities (reasoning json tool-use)
         :context-window 8
         :request-params (:options (:num_ctx 8192)))
        (qwen3:8b
         :description "Qwen 3 8b (local worker)"
         :capabilities (json tool-use)
         :context-window 16
         :request-params (:options (:num_ctx 16384)))
        (qwen2.5-coder:7b-instruct
         :description "Qwen 2.5 7B (local coder)"
         :capabilities (json)
         :context-window 16
         :request-params (:options (:num_ctx 16384)))))
    "gptel backend for local Ollama models.")

  ;; --- Convenience commands for fast switching (buffer-local) ---
  (defun my/gptel-use-ollama (&optional model)
    "Switch current buffer to Ollama backend, optionally selecting MODEL."
    (interactive)
    (setq-local gptel-backend my/gptel-ollama-backend)
    (when model (setq-local gptel-model model))
    (message "gptel: using Ollama%s"
             (if model (format " (%s)" model) "")))

  ;;(setq! gptel-api-params
  ;;`(("reasoning_effort" . "minimal")   ;; or "low", "medium", "high"
  ;;("max_completion_tokens" . 1500)
  ;;)))

  (defun my/gptel-ollama-worker () (interactive) (my/gptel-use-ollama 'qwen3:8b))
  (defun my/gptel-ollama-coder  () (interactive) (my/gptel-use-ollama 'qwen2.5-coder:7b-instruct))
  (defun my/gptel-ollama-planner() (interactive) (my/gptel-use-ollama 'qwen3.5:9b))

  ;; Keybindings need to be available before loading
  :init
  (map! :leader
        (:prefix "o l"
         :desc "gptel" "RET" #'gptel
         :desc "gptel menu" "m" #'gptel-menu
         :desc "gptel Ollama worker (qwen3:8b)" "w" #'my/gptel-ollama-worker
         :desc "gptel Ollama coder (qwen2.5-coder:7b)" "c" #'my/gptel-ollama-coder
         :desc "gptel Ollama planner (qwen3.5:9b)" "p" #'my/gptel-ollama-planner
         :desc "gptel OpenAI thinker (gpt-5.2)" "x" #'my/gptel-openai-think
         :desc "gptel OpenAI worker (gpt-5-mini)" "g" #'my/gptel-openai-mini))

  ;; Label the prefix in which-key instead of using (:prefix (".." . "LLM")).
  (after! which-key
    (which-key-add-key-based-replacements
      (general--concat t doom-leader-key "o l") "LLM"
      (general--concat t doom-leader-alt-key "o l") "LLM"))

  :config
  (setq! gptel-api-key "<replace>")

  ;; Set default model
  (setq! gptel-backend my/gptel-ollama-backend)
  (setq! gptel-model 'qwen3.5:9b)

  ;; Set model parameters
  (setq! gptel-temperature 0.7)      ; Range: 0.0 to 2.0 (lower = more focused, higher = more creative)
  (setq! gptel-max-tokens nil)       ; Maximum tokens in response (nil = no limit)

  ;; Optional: Set other parameters
  ;; (setq! gptel-top-p 1.0)          ; Nucleus sampling (0.0 to 1.0)
  ;; (setq! gptel-frequency-penalty 0.0)  ; Reduce repetition (-2.0 to 2.0)
  ;; (setq! gptel-presence-penalty 0.0)   ; Encourage new topics (-2.0 to 2.0)
  )

(after! gptel
  ;; Built-in backend (already registered by gptel)
  (defvar my/gptel-openai-backend (gptel-get-backend "ChatGPT"))

  (defun my/gptel-use-openai (&optional model)
    (interactive)
    (setq-local gptel-backend my/gptel-openai-backend)
    (when model (setq-local gptel-model model)))

  (defun my/gptel-openai-mini  () (interactive) (my/gptel-use-openai 'gpt-5-mini))
  (defun my/gptel-openai-think () (interactive) (my/gptel-use-openai 'gpt-5.2)))

;; Claudemacs Install
(use-package! claudemacs
  :commands (claudemacs-transient-menu)
  :config
  (require 'claudemacs)

  ;; TODO Replace localhost:11434 when I have a model that supports tool calling
  ;;(defun near/claude-profile-ollama ()
  ;;"Configure env for Claude Code -> local Ollama."
  ;;(interactive)
    ;;;; Ollama's Claude Code integration uses these 3 vars
  ;;(setenv "ANTHROPIC_BASE_URL" "http://localhost:11434")
  ;;(setenv "ANTHROPIC_AUTH_TOKEN" "ollama")
    ;;;;(setenv "ANTHROPIC_API_KEY" "")
  ;;(message "Claude Code: using LOCAL Ollama (http://localhost:11434)"))

  (defun near/claude-profile-anthropic ()
    "Configure env for Claude Code -> hosted Antropic without disrupting existing auth."
    (interactive)
    ;; Remove local-ollama overrides
    (near/unsetenv "ANTHROPIC_BASE_URL")
    (near/unsetenv "ANTHROPIC_AUTH_TOKEN")
    ;;(near/unsetenv "ANTHROPIC_API_KEY")
    (message "Claude Code: using HOSTED Anthropic (default auth)"))

  ;; NOTE This is deactivated until I get a model that supports toolcalling setup elsewhere
  ;;(defun near/claudemacs-start-qwen2.5 ()
  ;;"Start Claudemacs using local Ollama."
  ;;(interactive)
  ;;(near/claude-profile-ollama)
  ;;(setenv "ANTHROPIC_MODEL" "qwen2.5-coder:7b-instruct")
  ;;(call-interactively #'claudemacs-transient-menu))

  (defun near/claudemacs-start-anthropic ()
    "Start Claudemacs using hosted Anthropic."
    (interactive)
    (near/claude-profile-anthropic)
    (call-interactively #'claudemacs-transient-menu))

  (define-key prog-mode-map (kbd "C-c C-e") #'claudemacs-transient-menu)
  (define-key emacs-lisp-mode-map (kbd "C-c C-e") #'claudemacs-transient-menu)
  (define-key text-mode-map (kbd "C-c C-e") #'claudemacs-transient-menu)

  (map! :leader
        (:prefix ("o l" . "LLM")
         ;;:desc "Claudemacs (local qwen2.5)" "e" #'near/claudemacs-start-qwen2.5
         :desc "Claudemacs (hosted Anthropic)" "E" #'near/claudemacs-start-anthropic)))

;; TODO Update with python when I actually use it

;; Set EAT scrollback size (doc suggestion)
(with-eval-after-load 'eat
  (setq eat-term-scrollback-size 400000))

;; Window placement
(add-to-list 'display-buffer-alist
             '("^\\*claudemacs"
               (display-buffer-in-side-window)
               (side . right)
               (window-width . 0.33)))

;; Prevent Claude from just saving files
(global-auto-revert-mode 1)

;; Linux notification behavior + sound
(setq claudemacs-notification-auto-dismiss-linux nil)
(setq claudemacs-notification-sound-linux "message-new-instant")

;; Font Fallback on linux
(defun my/setup-custom-font-fallbacks-linux ()
  (interactive)
  "Configure font fallbacks on linux for symbols and emojis.
This will need to be called every time you change your font size,
to load the new symbol and emoji fonts."

  (setq use-default-font-for-symbols nil)

  ;; --- Configure for 'symbol' script ---
  ;; We add fonts one by one. Since we use 'prepend',
  ;; the last one added here will be the first one Emacs tries.
  ;; So, list them in reverse order of your preference.

  ;; Least preferred among this list for symbols (will be at the end of our preferred list)
  ;; (set-fontset-font t 'symbol "FreeSerif" nil 'prepend)
  ;; (set-fontset-font t 'symbol "NotoSansSymbols2" nil 'prepend)
  ;; (set-fontset-font t 'symbol "NotoSansCJKJP" nil 'prepend)
  ;; (set-fontset-font t 'symbol "unifont" nil 'prepend)
  (set-fontset-font t 'symbol "DejaVu Sans Mono" nil 'prepend)
  ;; Most preferred for symbols -- use your main font here
  (set-fontset-font t 'symbol "JetBrainsMono Nerd Font Mono" nil 'prepend)


  ;; --- Configure for 'emoji' script ---
  ;; Add fonts one by one, in reverse order of preference.

  ;; Least preferred among this list for emojis
  ;; (set-fontset-font t 'emoji "FreeSerif" nil 'prepend)
  ;; (set-fontset-font t 'emoji "NotoSansSymbols2" nil 'prepend)
  ;; (set-fontset-font t 'emoji "NotoSansCJKJP" nil 'prepend)
  ;; (set-fontset-font t 'emoji "unifont" nil 'prepend)
  (set-fontset-font t 'emoji "DejaVuSans" nil 'prepend)
  ;; (set-fontset-font t 'emoji "Noto Emoji" nil 'prepend) ;; If you install Noto Emoji
  ;; Most preferred for emojis -- use your main font here
  (set-fontset-font t 'emoji "JetBrainsMono Nerd Font Mono" nil 'prepend)
  )

;; to test if you have a font family installed:
;;   (find-font (font-spec :family "DejaVu Sans Mono"))

;; Then, add the fonts after your setup is complete:
(add-hook 'emacs-startup-hook
          (lambda ()
            (progn
              (when (string-equal system-type "gnu/linux")
                (my/setup-custom-font-fallbacks-linux)))))

;; Enable ActivityWatch
(after! activity-watch-mode
  (setq activity-watch-api-host "http://localhost:5600")
  (global-activity-watch-mode 1))

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
                    (:clientId "client_BaDkMgx4X19X9UxxYRCXZo")))))

;; Load scripts
(load! "lisp/scripts")

;;; config.el ends here
