;; -*- coding: utf-8; lexical-binding: t; -*-

(setq debug-on-error t)

(push (expand-file-name "~/.emacs.d/lisp") load-path)

(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

;; define variables for system type
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *win* (eq system-type 'windows-nt))
(defconst *cygwin* (eq system-type 'cygwin))
(defconst *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)))
(defconst *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)))

(require 'init-font)
(require 'init-elpa)
(require 'init-gui-frames)
(require 'init-modeline)
(require 'init-edit-utils)
(require 'init-ivy)
(require 'init-avy)
(require 'init-ace-window)
(require 'init-company)
(require 'init-vc)
(require 'init-mac)
(require 'init-org)
(require 'init-md)

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
