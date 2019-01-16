;; -*- coding: utf-8; lexical-binding: t; -*-

;; only more than two windows `M-o` will show keys
;; can type ? when `M-o` to show command help

(use-package ace-window
  :ensure t

  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (global-set-key (kbd "M-o") 'ace-window))

(provide 'init-ace-window)
