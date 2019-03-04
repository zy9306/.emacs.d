;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package dired-subtree
  :ensure t
  :config
  (setq dired-subtree-use-backgrounds nil)
  (setq dired-subtree-line-prefix "        ")
  (define-key dired-mode-map (kbd "C-<return>") 'dired-subtree-toggle))


;; Prefer g-prefixed coreutils version of standard utilities when available
;; brew install coreutils for mac
(let ((gls (executable-find "gls")))
  (when gls (setq insert-directory-program gls)))

(setq dired-listing-switches "-al -h --group-directories-first --color=always")

(provide 'init-dired)
