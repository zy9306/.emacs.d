;; -*- coding: utf-8; lexical-binding: t; -*-

(setq debug-on-error t)

(defun local/load-package (package)
  (setq _starttime (float-time))
  (require package)
  (message "load %s, time: %s" package (- (float-time) _starttime)))

(make-directory (expand-file-name "./persist") t)
(push (expand-file-name "./lisp") load-path)
(local/load-package 'init-elpa)
(load-file (expand-file-name "./pkg.el"))

(local/load-package 'init-constant)
(local/load-package 'init-option)
(local/load-package 'init-font)
(local/load-package 'init-face-common)
(local/load-package 'init-face)
(local/load-package 'init-face-org)
(local/load-package 'init-basic)
(local/load-package 'init-utils)
(local/load-package 'init-completion)
(local/load-package 'init-ivy)
(local/load-package 'init-avy)
(local/load-package 'init-window)
(local/load-package 'init-projectile)
(local/load-package 'init-rg)
(local/load-package 'init-gnu-global)
(local/load-package 'init-lsp)
(local/load-package 'init-nox)
(local/load-package 'init-org)
(local/load-package 'init-python)
(local/load-package 'init-rust)
;; (local/load-package 'init-js-ts)
(local/load-package 'init-go)
(local/load-package 'init-additional-major-mode)
(local/load-package 'init-display-buffer)
(local/load-package 'init-keyfreq)
(local/load-package 'init-macro)
(local/load-package 'init-snippet)
(local/load-package 'init-folding)
(local/load-package 'init-surround)
(local/load-package 'init-hydra)
(local/load-package 'init-restclient)
;; TODO (local/load-package 'init-posframe)

(if (and (not (daemonp)) (not (display-graphic-p)))
    (local/load-package 'init-evil-v2))

(local/load-package 'init-keybinding)

;; 自动检测编码，如果错误的将utf-8检测成gbk等中文编码，可能会导致lsp崩
;; 溃，编码默认为utf-8，如遇gbk等乱码，尝试C-x RET手动切换编码
;; (local/load-package 'unicad)

;; 将 custom-set-variables 和 custom-set-faces 移到单独的文件
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; close debug when finally load
(setq debug-on-error nil)

(message "init time: %s" (emacs-init-time))
