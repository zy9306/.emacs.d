(use-package ts-fold
  :init
  (add-hook 'after-init-hook 'global-ts-fold-mode)
  :config
  (global-set-key (kbd "<C-return>") 'ts-fold-toggle)
  (global-set-key (kbd "<C-M-return>") 'ts-fold-close-all)
  (global-set-key (kbd "<C-S-return>") 'ts-fold-open-all))

(use-package ts-fold-indicators
  :init
  (add-hook 'after-init-hook 'global-ts-fold-indicators-mode))
