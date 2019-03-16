;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map "jj" 'evil-normal-state))

(modify-syntax-entry ?_ "w")

(use-package general
  :ensure t)

(use-package evil-tutor
  :ensure t)

(provide 'init-evil)
