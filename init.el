;; -*- coding: utf-8; lexical-binding: t; -*-

(setq debug-on-error t)

(push (expand-file-name "~/.emacs.d/lisp") load-path)

(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

(require 'init-elpa)
(require 'init-gui-frames)
(require 'init-modeline)
(require 'init-edit-utils)
(require 'init-ivy)
(require 'init-avy)
(require 'init-ace-window)
(require 'init-company)

;; end of the file reset gc
(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; close debug when finally load
(setq debug-on-error nil)
