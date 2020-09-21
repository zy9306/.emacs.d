;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md

(require-package 'go-mode)
(require-package 'yasnippet)

(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md

(with-eval-after-load 'go-mode
  (require 'lsp-mode)
  (require 'yasnippet)
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" nil nil)
     ("gopls.staticcheck" t t)))
  (add-hook 'go-mode-hook 'lsp-deferred)
  (yas-minor-mode)
  )

;; 实时保存会造成卡顿
;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
;; (defun lsp-go-install-save-hooks ()
;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
;; (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(provide 'init-go)
