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

(defun local/load-package (package)
  (setq _starttime (float-time))
  (require package)
  (message "load %s, time: %s" package (- (float-time) _starttime)))

;; (local/load-package 'init-package)
(local/load-package 'init-font)
(local/load-package 'init-elpa)
(local/load-package 'init-basic)
(local/load-package 'init-completion)
(local/load-package 'init-edit-utils)
(local/load-package 'init-ivy)
(local/load-package 'init-avy)
(local/load-package 'init-window)
(local/load-package 'init-projectile)
(local/load-package 'init-find)
(local/load-package 'init-lsp)
(local/load-package 'init-org)
(local/load-package 'init-python)
(local/load-package 'init-rust)
(local/load-package 'init-go)
(local/load-package 'init-additional-major-mode)
(local/load-package 'init-display-buffer)
(local/load-package 'init-keyfreq)

(local/load-package 'init-macro)

(local/load-package 'init-format)

(local/load-package 'origami)
(local/load-package 'init-folding)

;; (local/load-package 'init-key-chord)

;; 自动检测编码，如果错误的将utf-8检测成gbk等中文编码，可能会导致lsp崩
;; 溃，编码默认为utf-8，如遇gbk等乱码，尝试C-x RET手动切换编码
;; (local/load-package 'unicad)


(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-arguments nil)
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))


(use-package spacemacs-theme
  :ensure t
  :defer t)


;; evil config
;; make `emacs --daemon` not load evil.
(if (and (not (daemonp)) (not (display-graphic-p)))
    (local/load-package 'init-evil))


;; when offline
;; (setq package-archives '(("myelpa" . "~/Nutstore/apps/configs/emacs/myelpa/")))

;; some variables

;; don't ask me "Active processes exist; kill them and exit anyway?"
(setq-default confirm-kill-processes nil)


;; some key binding
(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "C-x C-S-b") 'list-buffers)

(global-set-key (kbd "C-x C-S-x") 'exchange-point-and-mark)

(global-set-key (kbd "C-x C-x") 'local/set-mark-set-mark)

(defun scroll-half-page-down ()
  "scroll down half the page"
  (interactive)
  (scroll-down (/ (window-body-height) 2)))

(defun scroll-half-page-up ()
  "scroll up half the page"
  (interactive)
  (scroll-up (/ (window-body-height) 2)))

(global-set-key (kbd "C-S-v") 'scroll-up-command)
(global-set-key (kbd "M-S-v") 'scroll-down-command)
(global-set-key (kbd "C-v") 'scroll-half-page-up)
(global-set-key (kbd "M-v") 'scroll-half-page-down)

;; 避免origami折叠大文件时栈溢出或内存超过阈值，不知道是否有副作用
(setq max-specpdl-size 5000)
(setq max-lisp-eval-depth 5000)

;; end of the file reset gc
;; (setq gc-cons-threshold 16777216)
(setq gc-cons-percentage 0.1)

;; https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold (* 100 1024 1024)) ;; 100mb

;; read-process-output-max is only available on recent
;; development builds of Emacs 27 and above
(when (boundp 'read-process-output-max)
  (setq read-process-output-max (* 1024 1024)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (spacemacs-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "pink"))))
 '(lsp-ui-sideline-symbol-info ((t (:foreground "grey" :slant italic :height 0.99))))
 '(mode-line ((t (:background "white" :foreground "grey20" :box (:line-width -1 :color "dim gray") :slant normal :weight light))))
 '(mode-line-inactive ((t (:background "white" :foreground "grey20" :box (:line-width -1 :color "gray") :slant italic :weight light)))))


;; close debug when finally load
(setq debug-on-error nil)

(message "init time: %s" (emacs-init-time))
