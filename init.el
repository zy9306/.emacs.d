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
(require 'init-basic)
(require 'init-edit-utils)
(require 'init-ivy)
(require 'init-avy)
(require 'init-ace-window)
(require 'init-ide)
(require 'init-find)
(require 'init-org)
(require 'init-python)
(require 'init-rust)
(require 'init-go)
(require 'init-additional-major-mode)
(require 'init-display-buffer)


(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-arguments nil)
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))


;; evil config
(if (not (display-graphic-p))
    ;; 目前只在终端下使用evil
    (require 'init-evil))

(require 'init-keyfreq)

;; auto detected coding systems
(use-package unicad)


;; (setq package-archives '(("myelpa" . "~/Nutstore/apps/configs/emacs/myelpa/")))

;; some variables

;; don't ask me "Active processes exist; kill them and exit anyway?"
(setq-default confirm-kill-processes nil)


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
 '(hl-line ((t (:background "pink"))))
 '(mode-line ((t (:background "white" :foreground "grey20" :box (:line-width -1 :color "dim gray") :slant italic :weight light))))
 '(mode-line-inactive ((t (:background "white" :foreground "grey20" :box (:line-width -1 :color "gray") :weight light)))))

;; close debug when finally load
(setq debug-on-error nil)
