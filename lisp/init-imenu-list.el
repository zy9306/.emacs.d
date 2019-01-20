;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package imenu-list
  :ensure t

  :config
  (setq imenu-list-auto-resize t)
  (setq imenu-list-focus-after-activation t)
  (global-set-key (kbd "C-\"") #'imenu-list-smart-toggle))


(provide 'init-imenu-list)
