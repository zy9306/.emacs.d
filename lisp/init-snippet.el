;;; -*- coding: utf-8; lexical-binding: t; -*-

(lazy-load-global-keys
 '(("C-x j" . yas-insert-snippet))
 "yasnippet")

(with-eval-after-load 'yasnippet
  (require 'yasnippet-snippets)
  (yas-minor-mode)
  (yas-global-mode)
  (diminish 'yas-minor-mode))

(provide 'init-snippet)
