;;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package lsp-bridge-ui
  :config
  (global-lsp-bridge-ui-mode))

(use-package lsp-bridge-ui-history
  :config
  (lsp-bridge-ui-history-mode t))

(use-package lsp-bridge
  :bind (:map lsp-bridge-mode-map
              ("M-." . lsp-bridge-find-def)
              ("C-x 4 ." . lsp-bridge-find-def-other-window)
              ("M-," . lsp-bridge-return-from-def)
              ("C-c l h" . lsp-bridge-lookup-documentation)
              ("C-c l i" . lsp-bridge-find-impl)
              ("C-c l 4 i" . lsp-bridge-find-impl-other-window)
              ("C-c l r" . lsp-bridge-rename)
              ("C-c l R" . lsp-bridge-restart-process))
  :config
  (setq lsp-bridge-enable-auto-import nil)

  (when (or *mac* *unix*)
    (setq-default lsp-bridge-python-command "/usr/local/bin/python3"))

  (add-to-list 'lsp-bridge-lang-server-extension-list
               '(("json") . "javascript"))

  (dolist (hook lsp-bridge-default-mode-hooks)
    (add-hook hook (lambda ()
                     (setq-local lsp-bridge-ui-auto nil)
                     (lsp-bridge-mode 1)
                     (lsp-bridge-mix-multi-backends)
                     )))

  (dolist (hook (list
                 'emacs-lisp-mode-hook
                 ))
    (add-hook hook (lambda ()
                     (setq-local lsp-bridge-ui-auto t)))))

(defun lsp-bridge-mix-multi-backends ()
  (setq-local completion-category-defaults nil)
  (setq-local completion-at-point-functions
              (list
               (cape-capf-buster
                (cape-super-capf
                 #'lsp-bridge-capf
                 ;; need a good cpu.
                 ;; #'tabnine-completion-at-point
                 #'cape-file
                 #'cape-dabbrev
                 )
                'equal))))

;;; workaround for python Path
(defcustom lsp-bridge-current-python-command ""
  ""
  :type 'string)

(defun lsp-bridge-set-current-python-command ()
  (setq lsp-bridge-current-python-command (executable-find "python")))

(add-hook 'pyvenv-post-activate-hooks
          (lambda ()
            (lsp-bridge-set-current-python-command)
            (lsp-bridge-restart-process)))

;;; lsp server install
;; py
;; npm install -g pyright

;; ts,js
;; npm install -g typescript-language-server typescript

;; go
;; go install golang.org/x/tools/gopls@latest

;; rust
;; curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
;; chmod +x ~/.local/bin/rust-analyzer
;; rustup component add rust-src

(provide 'init-lsp-bridge)
