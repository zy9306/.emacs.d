;; -*- coding: utf-8; lexical-binding: t; -*-

(require-package 'diminish)
(require-package 'undo-tree)
(require-package 'real-auto-save)
(require-package 'which-key)
(require-package 'imenu-list)
(require-package 'flycheck)
(require-package 'diff-hl)
(require-package 'symbol-overlay)
(require-package 'anzu)
(require-package 'multiple-cursors)
(require-package 'expand-region)
(require-package 'browse-kill-ring)
(require-package 'magit)
(require-package 'rainbow-delimiters)
(require-package 'move-text)
(require-package 'goto-chg)
(require-package 'recentf)
(require-package 'dired-subtree)
(require-package 'highlight-indent-guides)
(require-package 'wgrep)
(require-package 'smex)
(require-package 'exec-path-from-shell)
;; NOTE: 对ivy的支持不能保证：https://github.com/raxod502/prescient.el/issues/65
(require-package 'prescient)
(require-package 'golden-ratio)
;; 透明窗口
;; see also: https://github.com/Benaiah/seethru
(require-package 'transwin)

;; underscore -> UPCASE -> CamelCase conversion of names
;; https://github.com/akicho8/string-inflection
(require-package 'string-inflection)


(defun local/after-init-hook (package)
  (add-hook 'after-init-hook (lambda () (require package))))

(with-eval-after-load 'prescient
  (setq prescient-save-file (concat "~/.emacs.d/.persist/" "prescient-save.el"))
  (prescient-persist-mode 1))

(with-eval-after-load 'exec-path-from-shell
  (setq exec-path-from-shell-arguments nil)
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))
(local/after-init-hook 'exec-path-from-shell)

(with-eval-after-load 'smex
  (setq-default smex-save-file (expand-file-name ".smex-items" user-emacs-directory)))
(local/after-init-hook 'smex)

(with-eval-after-load 'undo-tree
  (diminish 'undo-tree-mode)
  (global-undo-tree-mode))
(local/after-init-hook 'undo-tree)

;; see also https://www.emacswiki.org/emacs/AutoSave `auto-save-visited-mode`
(with-eval-after-load 'real-auto-save
  (diminish 'real-auto-save-mode)
  (setq real-auto-save-interval 10)
  (dolist (hook '(text-mode-hook
                  python-mode-hook
                  yaml-mode-hook
                  conf-mode-hook
                  elisp-mode-hook))
    (add-hook hook 'real-auto-save-mode)))
(local/after-init-hook 'real-auto-save)

(with-eval-after-load 'which-key
  (diminish 'which-key-mode)
  (which-key-setup-side-window-bottom)
  (which-key-mode))
(local/after-init-hook 'which-key)

(with-eval-after-load 'imenu-list
  (setq imenu-list-auto-resize nil)
  (setq imenu-list-size 30)
  (setq imenu-list-focus-after-activation t))
(local/after-init-hook 'imenu-list)

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc))
  (global-flycheck-mode))
(local/after-init-hook 'flycheck)

(with-eval-after-load 'diff-hl
  (global-diff-hl-mode)
  (diff-hl-margin-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))
(local/after-init-hook 'diff-hl)

;; https://github.com/wolray/symbol-overlay/tree/master
;; 一些mode的关键字会被忽略，在symbol-overlay-ignore-functions变量中定义相关mode的忽略函数
(with-eval-after-load 'symbol-overlay
  (diminish 'symbol-overlay-mode)
  (dolist (hook '(prog-mode-hook
                  html-mode-hook
                  conf-mode-hook
                  text-mode-hook
                  yaml-mode-hook))
    (add-hook hook 'symbol-overlay-mode)))
(local/after-init-hook 'symbol-overlay)

;; https://github.com/purcell/emacs.d/blob/master/lisp/init-isearch.el
;; 实时显示搜索及替换结果
(with-eval-after-load 'anzu
  (setq anzu-mode-lighter "")
  (global-anzu-mode)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace))
(local/after-init-hook 'anzu)

;; https://github.com/magnars/multiple-cursors.el/tree/master
;; To yank from the kill-rings of every cursor use yank-rectangle, normally found at C-x r y
(local/after-init-hook 'multiple-cursors)

(local/after-init-hook 'expand-region)

(with-eval-after-load 'rainbow-delimiters
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(local/after-init-hook 'rainbow-delimiters)

(local/after-init-hook 'magit)

(with-eval-after-load 'browse-kill-ring
  (setq browse-kill-ring-highlight-current-entry t)
  (setq browse-kill-ring-highlight-inserted-item t)
  (setq browse-kill-ring-show-preview t))
(local/after-init-hook 'browse-kill-ring)

(with-eval-after-load 'recentf
  (recentf-mode t)
  (setq-default recentf-max-saved-items 50)
  (setq recentf-filename-handlers
        (append '(abbreviate-file-name) recentf-filename-handlers)))
(local/after-init-hook 'recentf)

(local/after-init-hook 'goto-chg)

(local/after-init-hook 'move-text)

(with-eval-after-load 'dired-subtree
    (setq dired-subtree-use-backgrounds nil)
    (setq dired-subtree-line-prefix "        "))
(local/after-init-hook 'dired-subtree)

(with-eval-after-load 'highlight-indent-guides
  (setq highlight-indent-guides-method 'bitmap))

(with-eval-after-load 'golden-ratio
  (global-set-key (kbd "M--") 'golden-ratio))
(local/after-init-hook 'golden-ratio)

;; string-inflection
;; default
(global-set-key (kbd "C-c C-u") 'string-inflection-all-cycle)

;; for ruby
(add-hook 'ruby-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-ruby-style-cycle)))

;; for java
(add-hook 'java-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-java-style-cycle)))

;; for python
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-python-style-cycle)))

(provide 'init-basic)
