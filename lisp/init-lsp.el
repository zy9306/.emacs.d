;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/emacs-lsp/lsp-mode
;; https://emacs-lsp.github.io/lsp-mode/
;; https://github.com/emacs-lsp/lsp-ui

;; lsp-auto-guess-root + remap xref能解决项目路径问题


(setq lsp-keymap-prefix "C-c l")

(use-package lsp-mode
  :ensure t
  :defer t
  :hook
  (
   (lsp-mode . lsp-enable-which-key-integration)
   )
  :commands lsp
  :config
  (setq lsp-auto-guess-root t)
  (setq lsp-ui-doc-enable nil)
  ;; keymap
  (define-key lsp-mode-map [remap xref-find-definitions] #'lsp-find-definition)
  (define-key lsp-mode-map [remap xref-find-references] #'lsp-find-references)
  )

(use-package lsp-ui
  :ensure t
  :defer t
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'lsp-mode-hook 'flycheck-mode)
  :commands lsp-ui-mode
  :config
  ;; lsp ui
  (setq lsp-ui-sideline-enable t)
  ;; keymap
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  )

(use-package lsp-ivy
  :ensure t
  :defer t
  :config
  (global-set-key (kbd "C-c l i") 'lsp-ivy-workspace-symbol)
  (global-set-key (kbd "C-c l I") 'lsp-ivy-global-workspace-symbol)
  )


(provide 'init-lsp)
