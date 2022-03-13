;;; -*- coding: utf-8; lexical-binding: t; -*-

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


(local/after-init-hook 'smex)


(with-eval-after-load 'undo-tree
  (diminish 'undo-tree-mode)
  (global-undo-tree-mode))
(local/after-init-hook 'undo-tree)


;; see also https://www.emacswiki.org/emacs/AutoSave `auto-save-visited-mode`
(with-eval-after-load 'real-auto-save
  (diminish 'real-auto-save-mode)
  (setq real-auto-save-interval 30)
  (dolist (hook '(text-mode-hook
                  python-mode-hook
                  go-mode-hook
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
  (setq imenu-list-position 'left)
  (setq imenu-list-size 0.3)
  (setq imenu-max-item-length 120)
  (setq imenu-list-focus-after-activation t))
(local/after-init-hook 'imenu-list)


(when (or *linux* *mac*)
  (with-eval-after-load 'flycheck
    (setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc))
    (global-flycheck-mode))
  (local/after-init-hook 'flycheck))


(with-eval-after-load 'diff-hl
  (global-diff-hl-mode)
  (diff-hl-margin-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (add-hook 'after-revert-hook 'diff-hl-reset-reference-rev))
(local/after-init-hook 'diff-hl)


(with-eval-after-load 'symbol-overlay
  (diminish 'symbol-overlay-mode)
  (dolist (hook '(prog-mode-hook
                  html-mode-hook
                  conf-mode-hook
                  text-mode-hook
                  protobuf-mode-hook
                  yaml-mode-hook))
    (add-hook hook 'symbol-overlay-mode)))
(local/after-init-hook 'symbol-overlay)


(with-eval-after-load 'anzu
  ;; 实时显示搜索及替换结果
  (setq anzu-mode-lighter "")
  (global-anzu-mode)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace))
(local/after-init-hook 'anzu)


(defun local/config-ace-isearch()
  (require 'ace-isearch)
  (global-ace-isearch-mode +1)
  (diminish 'ace-isearch-mode)
  ;; 默认输入超过 ace-isearch-input-length 个字符触发 swiper，禁用
  (setq ace-isearch-use-function-from-isearch nil)
  (setq ace-isearch-use-jump nil)
  (setq ace-isearch-input-length 99))
(add-hook 'after-init-hook #'local/config-ace-isearch)


;; To yank from the kill-rings of every cursor use yank-rectangle, normally found at C-x r y
(local/after-init-hook 'multiple-cursors)


(local/after-init-hook 'expand-region)


(with-eval-after-load 'rainbow-delimiters
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(local/after-init-hook 'rainbow-delimiters)


(with-eval-after-load 'magit
  (define-key magit-hunk-section-map (kbd "RET") 'magit-diff-visit-file-other-window)
  (define-key magit-file-section-map (kbd "RET") 'magit-diff-visit-file-other-window))
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


(defun local/setup-terminal ()
  (unless (display-graphic-p)
    (xclip-mode)
    (xterm-mouse-mode 1)

    (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
    (global-set-key (kbd "<mouse-5>") 'scroll-up-line)))

(add-hook 'after-init-hook 'local/setup-terminal)


(with-eval-after-load 'better-jumper
  (better-jumper-mode +1)
  (global-set-key (kbd "M-*") 'better-jumper-set-jump)
  (global-set-key (kbd "M-<left>") 'better-jumper-jump-backward)
  (global-set-key (kbd "M-<right>") 'better-jumper-jump-forward))
(local/after-init-hook 'better-jumper)



(global-set-key (kbd "C-c C-u") 'string-inflection-all-cycle)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-ruby-style-cycle)))
(add-hook 'java-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-java-style-cycle)))
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-python-style-cycle)))
(add-hook 'protobuf-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-all-cycle)))
(global-set-key [remap kill-ring-save] 'easy-kill)


(provide 'init-basic)
