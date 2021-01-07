;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/cute-jumper/embrace.el
;; https://github.com/ganmacs/emacs-surround


(require 'emacs-surround)

(global-set-key (kbd "M-\"") 'emacs-surround)

(global-set-key (kbd "M-]") #'embrace-commander)

(provide 'init-surround)
