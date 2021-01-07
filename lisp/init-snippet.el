;; -*- coding: utf-8; lexical-binding: t; -*-


(push (expand-file-name "~/.emacs.d/repo/yasnippet-snippets") load-path)

;; https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (yas-global-mode 1)
  )


(use-package yasnippet-snippets)


(provide 'init-snippet)
