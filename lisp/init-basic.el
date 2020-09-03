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
(require-package 'page-break-lines)
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
  (setq real-auto-save-interval 1)
  (add-hook 'prog-mode-hook 'real-auto-save-mode)
  (add-hook 'text-mode-hook 'real-auto-save-mode))
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

;; C-q C-l 可以在当前位置插入并显示分页符
(with-eval-after-load 'page-break-lines
  (diminish 'page-break-lines-mode)
  (dolist (hook '(prog-mode-hook html-mode-hook conf-mode-hook text-mode-hook))
    (add-hook hook 'page-break-lines-mode)))
(local/after-init-hook 'page-break-lines)

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


;; settings

(delete-selection-mode t)
;; auto close ()
(electric-pair-mode t)
(push '(?\' . ?\') electric-pair-pairs)
(push '(?\" . ?\") electric-pair-pairs)
(push '(?` . ?`) electric-pair-pairs)

;; ; highlight ()
(show-paren-mode t)
(column-number-mode t)
(global-hl-line-mode t)

;; https://www.emacswiki.org/emacs/TruncateLines
(set-default 'truncate-lines t)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; todo this don't work
(setq show-paren-when-point-inside-paren t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)


;; gui

;; Suppress GUI features
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;; Show a marker in the left fringe for lines not in the buffer
(setq indicate-empty-lines t)

;; NO tool bar
(if (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
;; no scroll bar
(if (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))
;; no menu bar
(if (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

;; set frame title to filename with short path
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(setq-default cursor-type 'box)  ;; box 方块

;; dired
(when *is-a-mac*
  ;; Prefer g-prefixed coreutils version of standard utilities when available
  ;; brew install coreutils for mac
  (let ((gls (executable-find "/usr/local/bin/gls")))
    (when gls (setq insert-directory-program "/usr/local/bin/gls"))))

(when *win*
  ;; need git bash mingw environment
  ;; https://git-scm.com/download/win
  (setq ls-lisp-use-insert-directory-program t)
  (setq insert-directory-program "C:/Program Files/Git/usr/bin/ls.exe"))

(setq dired-listing-switches "-al -h --group-directories-first --color=auto")

;; backup
(make-directory "~/.emacs.d/autosaves/" t)
(make-directory "~/.emacs.d/backups/" t)
(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/autosaves/" t)))

;; read-only
(dir-locals-set-class-variables 'read-only
 '((nil . ((buffer-read-only . t)))))
(dolist (dir (list "~/Envs" "/usr" "~/.cargo" "~/.rustup" "/Library/Frameworks/Python.framework"))
  (dir-locals-set-directory-class (file-truename dir) 'read-only))

;; revert settings
;; (auto-revert-mode t)
(global-auto-revert-mode t)
(setq auto-revert-check-vc-info t)

(provide 'init-basic)
