;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (yas-global-mode 1)
  )


(use-package yasnippet-snippets
  :init
  (global-set-key (kbd "C-x C-j") 'yas-insert-snippet))


(provide 'init-snippet)
