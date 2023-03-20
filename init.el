;;; -*- coding: utf-8; lexical-binding: t; -*-

(setq debug-on-error t)

(defun local/load-package (package)
  (setq _starttime (float-time))
  (require package)
  (message "load %s, time: %s" package (- (float-time) _starttime)))

(make-directory (expand-file-name ".persist" user-emacs-directory) t)

(push (expand-file-name "lisp" user-emacs-directory) load-path)

(local/load-package 'init-elpa)

(load-file (expand-file-name "pkg.el" user-emacs-directory))

(require 'lazy-load)

(local/load-package 'init-constant)
(local/load-package 'init-option)
(local/load-package 'init-font)
(local/load-package 'init-color)
(local/load-package 'init-theme)
(local/load-package 'init-basic)
(local/load-package 'init-utils)
(local/load-package 'init-citre)
(local/load-package 'init-tabnine-capf)
(local/load-package 'init-ivy)
(local/load-package 'init-posframe)
(local/load-package 'init-avy)
(local/load-package 'init-window)
(local/load-package 'init-project)
(local/load-package 'init-rg)
(local/load-package 'init-gud)
(local/load-package 'init-org)
(local/load-package 'init-python)
(local/load-package 'init-rust)
(local/load-package 'init-web-mode)
(local/load-package 'init-go)

(local/load-package 'init-additional-major-mode)
(local/load-package 'init-display-buffer)
(local/load-package 'init-macro)
(local/load-package 'init-snippet)
(local/load-package 'init-folding)
(local/load-package 'init-hydra)
(local/load-package 'init-restclient)
(local/load-package 'init-mark)
(local/load-package 'init-bufler)

(local/load-package 'init-tree-sitter)

(local/load-package 'init-edit)

(local/load-package 'init-modeline)

(local/load-package 'init-codeium)
(local/load-package 'init-copilot)
(local/load-package 'init-company)

;; (local/load-package 'init-corfu)

;; (local/load-package 'init-lsp-deprecated)
;; (local/load-package 'init-lsp-bridge)
(local/load-package 'init-lsp)

(local/load-package 'init-translate)

(local/load-package 'init-web-browser)

(if (not (display-graphic-p))
    (local/load-package 'init-evil-v3))

(local/load-package 'init-proxy)

;;; unicad
;; 自动检测编码，如果错误的将utf-8检测成gbk等中文编码，可能会导致lsp崩
;; 溃，编码默认为utf-8，如遇gbk等乱码，尝试C-x RET手动切换编码
;; (local/load-package 'unicad)

;;; custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;;; site-lisp config
(load-file (expand-file-name "site-lisp/config.el" user-emacs-directory))


;;; set desktop
(let ((desktop-dir (expand-file-name ".persist" user-emacs-directory)))
  (setq desktop-dirname desktop-dir)
  (setq desktop-path `(,desktop-dir)))

;;; close debug when finally load
(setq debug-on-error nil)

(message "init time: %s" (emacs-init-time))
