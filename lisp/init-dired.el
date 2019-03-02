;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package dired-subtree
  :ensure t
  :config
  (setq dired-subtree-use-backgrounds nil)
  (setq dired-subtree-line-prefix "        ")
  (define-key dired-mode-map (kbd "C-<return>") 'dired-subtree-toggle))

(provide 'init-dired)
