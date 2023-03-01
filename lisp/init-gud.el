;;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Debuggers.html


;; (global-set-key (kbd "<f8>") 'gud-print)
;; (global-set-key (kbd "<f9>") 'gud-next)
;; (global-set-key (kbd "<f10>") 'gud-step)
;; (global-set-key (kbd "<f12>") 'gud-cont)

(global-set-key [left-margin mouse-1] 'gud-break)
(global-set-key [left-fringe mouse-1] 'gud-break)



(with-eval-after-load 'go-mode
  (require 'go-dlv))


(provide 'init-gud)
