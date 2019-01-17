;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package diff-hl
  :ensure t

  :config
  (global-diff-hl-mode t)
  (diff-hl-margin-mode t)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(provide 'init-vc)
