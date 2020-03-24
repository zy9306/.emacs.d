;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package company
  :ensure t
  :defer t
  ;; :diminish company-mode " co"
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay 0.05)
  (setq company-tooltip-idle-delay 0.05)
  (setq company-minimum-prefix-length 2)
  ;; origin
  ;; (company-bbdb
  ;;  company-eclim
  ;;  company-semantic
  ;;  company-clang
  ;;  company-xcode
  ;;  company-cmake
  ;;  company-capf
  ;;  company-files
  ;;  (company-dabbrev-code company-gtags company-etags company-keywords)
  ;;  company-oddmuse company-dabbrev)
  (setq company-backends
        ;; 同一组(即同一括号)中的backends能同时被用到
        ;; The CAPF back-end provides a bridge to the standard completion-at-point-functions facility
        '(company-capf
          company-files
          (company-dabbrev-code company-keywords)
          company-dabbrev))
  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-other-backend)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))


;; lsp config  (目前使用lsp-mode作为client, 继续观望https://github.com/joaotavora/eglot/tree/master)

(use-package lsp-mode
  ;; https://github.com/emacs-lsp/lsp-mode
  :ensure t
  :defer t
  :commands lsp
  :config
  (setq lsp-auto-guess-root t)
  (setq lsp-prefer-flymake nil))

;; TODO custom face
(use-package lsp-ui
  ;; https://github.com/emacs-lsp/lsp-ui
  :ensure t
  :defer t
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'lsp-mode-hook 'flycheck-mode)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-border "pink")
  (setq lsp-ui-flycheck-enable t)
  (setq lsp-ui-sideline-enable nil)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(use-package company-lsp
  ;; https://github.com/tigersoldier/company-lsp
  ;; Expand snippets on completion (requires yasnippet).
  :ensure t
  :defer t
  :config
  (setq company-lsp-async t)
  (push 'company-lsp company-backends)
)


(use-package yasnippet
  ;; https://github.com/joaotavora/yasnippet
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  ;; (yas-global-mode 1)
  )


(provide 'init-completion)
