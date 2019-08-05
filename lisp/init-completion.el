;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package company
  :ensure t
  ;; :diminish company-mode " co"
  :config
  (add-hook 'after-init-hook 'global-company-mode)
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
  :commands lsp)

(use-package lsp-ui
  ;; https://github.com/emacs-lsp/lsp-ui
  :commands lsp-ui-mode
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'lsp-mode-hook 'flycheck-mode)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(use-package company-lsp
  ;; https://github.com/tigersoldier/company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends)
  (setq company-lsp-async t))


(provide 'init-completion)
