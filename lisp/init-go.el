;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md

(require-package 'go-mode)
(require-package 'yasnippet)

(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; START
;; use nox instead of lsp-mode
;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md

;; (with-eval-after-load 'go-mode
;;   (require 'lsp-mode)
;;   (require 'yasnippet)
;;   (lsp-register-custom-settings
;;    '(("gopls.completeUnimported" nil nil)
;;      ("gopls.staticcheck" t t)))
;;   (add-hook 'go-mode-hook 'lsp-deferred)
;;   (yas-minor-mode)
;;   )
;; END

;; 实时保存可能会造成卡顿
;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun go-mode-save-hooks ()
  (setq gofmt-show-errors 'echo)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))
(add-hook 'go-mode-hook #'go-mode-save-hooks)

(provide 'init-go)
