;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
;;(setq doom-theme 'default)
(setq doom-theme nil)
(defun custom_banner ()
  "")
(after! lsp-mode
  (add-hook 'before-save-hook #'lsp-format-buffer))

;; Set the custom banner function
(setq +doom-dashboard-ascii-banner-fn #'custom_banner)
;; Example: Customize syntax highlighting colors
(custom-set-faces
 ;; Comments
 '(font-lock-comment-face ((t (:foreground "#5c6370"))))
 ;; Keywords
 '(font-lock-keyword-face ((t (:foreground "#c678dd"))))
 ;; Strings
 '(font-lock-string-face ((t (:foreground "#98c379"))))
 ;; Variables
 '(font-lock-variable-name-face ((t (:foreground "#e5c07b"))))
 ;; Functions
 '(font-lock-function-name-face ((t (:foreground "#61afef")))))

(setq fancy-splash-image "~/.config/doom/doom.png")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;; Auto-save file when exiting insert mode in Doom Emacs
(add-hook 'evil-insert-state-exit-hook
          (lambda ()
            (when (and (buffer-file-name) (buffer-modified-p))
              (save-buffer))))

(global-set-key (kbd "M-c") #'copy-marker)
(after! dart-mode
  (setq +format-with-lsp nil)  ;; Disable LSP formatting if needed
  (setq dart-format-on-save t) ;; Enable auto-format on save
  (setq dart-line-length 90)) ;; Set max line length

(after! lsp-dart
  (setq lsp-dart-line-length 90)) ;; Set LSP Dart max line length





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
(use-package! undo-tree
    :hook (prog-mode . undo-tree-mode)
  )
;; accept completion from copilot and fallback to company
(use-package! copilot
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(setq undo-tree-enable-undo-in-region nil)
(use-package! gptel)
(gptel-make-ollama "Ollama"             ;Any name of your choosing
  :host "localhost:11434"              ;Where it's running
  :stream t                             ;Stream responses
  :models '(qwen2.5-coder:7b))

;; Enable lsp-mode for Dart
;; (after! lsp-mode
;;   (use-package! lsp-dart
;;     :config
;;     (setq lsp-dart-sdk-dir "/Users/gravitynx/fvm/default/bin/cache/dart-sdk/"
;;           lsp-dart-flutter-sdk-dir "/Users/gravitynx/development/flutter/bin")))

;; OPTIONAL configuration
(after! lsp-mode
  (add-hook 'prog-mode-hook #'lsp!))
(after! lsp-mode
  (setq lsp-auto-guess-root nil) ;; Prevent LSP from automatically setting the root
  (setq lsp-restart 'interactive) ;; Ask before restarting an LSP session
  (setq lsp-session-file (expand-file-name ".local/etc/lsp-session-v1" doom-emacs-dir))
)

(setq
 gptel-model 'mistral:latest
 gptel-backend (gptel-make-ollama "Ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(qwen2.5-coder:7b)))

(global-undo-tree-mode)
(setq mac-command-modifier      'control
      ns-command-modifier       'control
      mac-option-modifier       'meta
      ns-option-modifier        'meta
      mac-right-option-modifier 'meta
      ns-right-option-modifier  'meta)
(set-frame-parameter (selected-frame) 'alpha '(90 . 90)) (add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; (use-package! ellama
;;     :bind ("C-c e" . ellama-transient-main-menu)
;;     :init
;;     ;; setup key bindings
;;     ;; (setopt ellama-keymap-prefix "C-c e")
;;     ;; language you want ellama to translate to
;;     (setopt ellama-language "German")
;;     ;; could be llm-openai for example
;;     (require 'llm-ollama)
;;     (setopt ellama-provider
;; 	  (make-llm-ollama
;; 	       ;; this model should be pulled to use it
;; 	       ;; value should be the same as you print in terminal during pull
;; 	       :chat-model "llama3:8b-instruct-q8_0"
;; 	       :embedding-model "nomic-embed-text"
;; 	       :default-chat-non-standard-params '(("num_ctx" . 8192))))
;;     (setopt ellama-summarization-provider
;; 	      (make-llm-ollama
;; 	       :chat-model "qwen2.5:3b"
;; 	       :embedding-model "nomic-embed-text"
;; 	       :default-chat-non-standard-params '(("num_ctx" . 32768))))
;;     (setopt ellama-coding-provider
;; 	      (make-llm-ollama
;; 	       :chat-model "qwen2.5-coder:3b"
;; 	       :embedding-model "nomic-embed-text"
;; 	       :default-chat-non-standard-params '(("num_ctx" . 32768))))
;;     ;; Predefined llm providers for interactive switching.
;;     ;; You shouldn't add ollama providers here - it can be selected interactively
;;     ;; without it. It is just example.
;;     (setopt ellama-providers
;; 	      '(("zephyr" . (make-llm-ollama
;; 			     :chat-model "zephyr:7b-beta-q6_K"
;; 			     :embedding-model "zephyr:7b-beta-q6_K"))
;; 		("mistral" . (make-llm-ollama
;; 			      :chat-model "mistral:7b-instruct-v0.2-q6_K"
;; 			      :embedding-model "mistral:7b-instruct-v0.2-q6_K"))
;; 		("mixtral" . (make-llm-ollama
;; 			      :chat-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"
;; 			      :embedding-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"))))
;;     ;; Naming new sessions with llm
;;     (setopt ellama-naming-provider
;; 	      (make-llm-ollama
;; 	       :chat-model "llama3:8b-instruct-q8_0"
;; 	       :embedding-model "nomic-embed-text"
;; 	       :default-chat-non-standard-params '(("stop" . ("\n")))))
;;     (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
;;     ;; Translation llm provider
;;     (setopt ellama-translation-provider
;; 	    (make-llm-ollama
;; 	     :chat-model "qwen2.5:3b"
;; 	     :embedding-model "nomic-embed-text"
;; 	     :default-chat-non-standard-params
;; 	     '(("num_ctx" . 32768))))
;;     ;; customize display buffer behaviour
;;     ;; see ~(info "(elisp) Buffer Display Action Functions")~
;;     (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
;;     (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
;;     :confi`'g
;;     ;; send last message in chat buffer with C-c C-c
;;     (add-hook 'org-ctrl-c-ctrl-c-hook #'ellama-chat-send-last-message))
(defun my-write-buffer-to-hardcoded-file ()
  "Overwrite a hardcoded file with the current buffer's contents."
  (interactive)
  (let ((filename "/Users/gravitynx/checker/output.rs"))
    ;; Overwrite the file with buffer content (clearing anything previously there).
    (write-region (point-min) (point-max) filename nil 'silent)
    (message "")))

(map! :leader
      :desc "Write buffer to a hardcoded file"
      "f w" #'my-write-buffer-to-hardcoded-file)

(map! :leader
      :desc "Ollama autocomplete"
      "c y" #'gptel-send)
