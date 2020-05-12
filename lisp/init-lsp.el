;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/emacs-lsp/lsp-mode
;; https://emacs-lsp.github.io/lsp-mode/

;; TODO init-completion中的lsp配置迁移

(setq lsp-keymap-prefix "C-c l")

(use-package lsp-mode
  :ensure t
  :defer t
  :hook (
         (lsp-mode . lsp-enable-which-key-integration)
         )
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)

(use-package lsp-ivy
  :ensure t
  :defer t
  :config
  (global-set-key (kbd "C-c l i") 'lsp-ivy-workspace-symbol)
  (global-set-key (kbd "C-c l I") 'lsp-ivy-global-workspace-symbol)
  )



(provide 'init-lsp)
