;; -*- coding: utf-8; lexical-binding: t; -*-

(setq debug-on-error t)

(push (expand-file-name "~/.emacs.d/lisp") load-path)
(push (expand-file-name "~/.emacs.d/yasnippet-snippets") load-path)

(defun local/load-package (package)
  (setq _starttime (float-time))
  (require package)
  (message "load %s, time: %s" package (- (float-time) _starttime)))

(local/load-package 'init-constant)
(local/load-package 'init-option)
(local/load-package 'init-font)
(local/load-package 'init-elpa)
(local/load-package 'init-basic)
(local/load-package 'init-utils)
(local/load-package 'init-completion)
(local/load-package 'init-ivy)
(local/load-package 'init-avy)
(local/load-package 'init-window)
(local/load-package 'init-projectile)
(local/load-package 'init-rg)
(local/load-package 'init-xxtags)
(local/load-package 'init-lsp)
(local/load-package 'init-org)
(local/load-package 'init-python)
(local/load-package 'init-rust)
(local/load-package 'init-js-ts)
(local/load-package 'init-go)
(local/load-package 'init-additional-major-mode)
(local/load-package 'init-display-buffer)
(local/load-package 'init-keyfreq)
(local/load-package 'init-macro)
(local/load-package 'init-snippet)
(local/load-package 'init-folding)
(local/load-package 'init-surround)
(local/load-package 'init-hydra)
(local/load-package 'init-dap-mode)
(local/load-package 'init-restclient)
;; TODO (local/load-package 'init-posframe)

(if (and (not (daemonp)) (not (display-graphic-p)))
    (local/load-package 'init-evil-v2))

(local/load-package 'init-keybinding)

;; 自动检测编码，如果错误的将utf-8检测成gbk等中文编码，可能会导致lsp崩
;; 溃，编码默认为utf-8，如遇gbk等乱码，尝试C-x RET手动切换编码
;; (local/load-package 'unicad)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(restclient treemacs eglot corral general key-chord vimish-fold yafolding keyfreq shackle protobuf-mode dockerfile-mode yaml-mode yasnippet go-mode tide js2-mode flycheck-rust rust-mode flycheck-pycheckers yapfify auto-virtualenv pyvenv lsp-python-ms toc-org lsp-ivy lsp-ui lsp-mode which-key use-package symbol-overlay spinner smex rg real-auto-save rainbow-delimiters neotree multiple-cursors move-text markdown-mode magit ivy-prescient ivy-hydra imenu-list highlight-indent-guides goto-chg flycheck expand-region exec-path-from-shell dired-subtree diminish diff-hl counsel-projectile company-prescient buffer-move browse-kill-ring anzu ace-window))
 '(safe-local-variable-values '((url-max-redirections . 0))))
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
