;;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'lsp-bridge)

(setq lsp-bridge-enable-auto-import nil)
(setq lsp-bridge-disable-backup nil)
(setq lsp-bridge-enable-diagnostics nil)
(setq lsp-bridge-diagnostics-fetch-idle 5)
(setq lsp-bridge-enable-signature-help t)
(setq acm-enable-doc nil)
(setq acm-enable-dabbrev t)
(setq acm-dabbrev-min-length 2)
(setq acm-menu-candidate-limit 50)
(setq acm-candidate-match-function 'orderless-flex)

(if (image-type-available-p 'svg)
    (setq acm-enable-icon t)
  (setq acm-enable-icon nil))

(when (or *mac* *unix*)
  (setq-default lsp-bridge-python-command "/usr/local/bin/python3"))

(add-to-list 'lsp-bridge-lang-server-extension-list
             '(("json") . "javascript"))

(add-hook 'lsp-bridge-mode-hook (lambda () (corfu-mode -1)))
(global-lsp-bridge-mode)

(define-key lsp-bridge-mode-map (kbd "M-.") #'lsp-bridge-find-def)
(define-key lsp-bridge-mode-map (kbd "C-x 4 .") #'lsp-bridge-find-def-other-window)
(define-key lsp-bridge-mode-map (kbd "M-,") #'lsp-bridge-return-from-def)
(define-key lsp-bridge-mode-map (kbd "C-c l h") #'lsp-bridge-lookup-documentation)
(define-key lsp-bridge-mode-map (kbd "C-c l i") #'lsp-bridge-find-impl)
(define-key lsp-bridge-mode-map (kbd "C-c l 4 i") #'lsp-bridge-find-impl-other-window)
(define-key lsp-bridge-mode-map (kbd "C-c l r") #'lsp-bridge-rename)
(define-key lsp-bridge-mode-map (kbd "C-c l R") #'lsp-bridge-restart-process)


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
