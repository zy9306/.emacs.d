;;; -*- coding: utf-8; lexical-binding: t; -*-

(with-eval-after-load 'avy
  (avy-setup-default))

(local/after-init-hook 'avy)


;; https://github.com/Dewdrops/isearch-dabbrev
(eval-after-load "isearch"
  '(progn
     (require 'isearch-dabbrev)
     (define-key isearch-mode-map (kbd "<tab>") 'isearch-dabbrev-expand)))

(provide 'init-avy)
