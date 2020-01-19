;; -*- coding: utf-8; lexical-binding: t; -*-


;; ;;;;;;; 一些通用且无依赖的包 ;;;;;;;

(use-package diminish
  :ensure t
  :defer t)

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode))

;; see also https://www.emacswiki.org/emacs/AutoSave `auto-save-visited-mode`
(use-package real-auto-save
  :ensure t
  :diminish real-auto-save-mode
  :config
  (add-hook 'prog-mode-hook 'real-auto-save-mode)
  (add-hook 'text-mode-hook 'real-auto-save-mode)
  (setq real-auto-save-interval 1))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom))

(use-package imenu-list
  :ensure t
  :config
  (setq imenu-list-auto-resize t)
  (setq imenu-list-focus-after-activation t)
  (global-set-key (kbd "C-x \"") #'imenu-list-smart-toggle)
  (global-set-key (kbd "C-\"") #'counsel-imenu))

(use-package flycheck
  ;; http://www.flycheck.org/en/latest/
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc)))

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode t)
  (diff-hl-margin-mode t)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(use-package symbol-overlay
  ;; https://github.com/wolray/symbol-overlay/tree/master
  ;; https://github.com/purcell/emacs.d/blob/master/lisp/init-editing-utils.el
  ;; 高亮相同单词，可同时高亮多个，M-i增加单词
  ;; 一些mode的关键字会被忽略，在symbol-overlay-ignore-functions变量中定义相关mode的忽略函数
  :ensure t
  :diminish symbol-overlay-mode
  :config
  (dolist (hook '(prog-mode-hook html-mode-hook conf-mode-hook text-mode-hook yaml-mode-hook))
  (add-hook hook 'symbol-overlay-mode))
  (define-key symbol-overlay-mode-map (kbd "M-i") 'symbol-overlay-put)
  (define-key symbol-overlay-mode-map (kbd "M-I") 'symbol-overlay-remove-all)
  (define-key symbol-overlay-mode-map (kbd "M-n") 'symbol-overlay-jump-next)
  (define-key symbol-overlay-mode-map (kbd "M-p") 'symbol-overlay-jump-prev))

(use-package anzu
  ;; https://github.com/purcell/emacs.d/blob/master/lisp/init-isearch.el
  ;; 实时显示搜索及替换结果
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-anzu-mode)
  (setq anzu-mode-lighter "")
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace))

(use-package multiple-cursors
  ;; https://github.com/magnars/multiple-cursors.el/tree/master
  ;; To yank from the kill-rings of every cursor use yank-rectangle, normally found at C-x r y
  :ensure t
  :defer t
  )
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(use-package expand-region
  ;; expand-region 快速选中及增减选区
  :ensure t
  :defer t
  )
(global-set-key (kbd "C-=") 'er/expand-region)

(use-package page-break-lines
  ;; C-q C-l 可以在当前位置插入并显示分页符
  :ensure t
  :diminish page-break-lines-mode)
(dolist (hook '(prog-mode-hook html-mode-hook conf-mode-hook text-mode-hook))
  (add-hook hook 'page-break-lines-mode))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package magit
  :ensure t
  :defer t)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)
(global-set-key (kbd "C-c M-g") 'magit-file-dispatch)

(use-package browse-kill-ring
  :ensure t
  :defer t
  :config
  (setq browse-kill-ring-highlight-current-entry t)
  (setq browse-kill-ring-highlight-inserted-item t)
  (setq browse-kill-ring-show-preview t))
(global-set-key (kbd "M-y") 'browse-kill-ring)

(use-package recentf
  ;; C-x b will see recent file
  :ensure t
  :config
  (setq-default recentf-max-saved-items 50)
  (setq recentf-filename-handlers
        (append '(abbreviate-file-name) recentf-filename-handlers))
  (recentf-mode t))





;; ;;;;;;; gui-frame ;;;;;;;

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

(setq-default cursor-type 'bar)  ;; box 方块



;; ;;;;;;; dired ;;;;;;;

(use-package dired-subtree
  :ensure t
  :config
  (setq dired-subtree-use-backgrounds nil)
  (setq dired-subtree-line-prefix "        ")
  (define-key dired-mode-map (kbd "C-<return>") 'dired-subtree-toggle))

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



;; ;;;;;;; backup ;;;;;;;
(make-directory "~/.emacs.d/autosaves/" t)
(make-directory "~/.emacs.d/backups/" t)
(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/autosaves/" t)))



;; ;;;;;;; mac ;;;;;;;
(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none)

  (global-set-key (kbd "M-ƒ") 'toggle-frame-fullscreen)
  )



;; ;;;;;;; 设置某些目录下的文件以只读打开 ;;;;;;;
; Define a read-only directory class
(dir-locals-set-class-variables 'read-only
 '((nil . ((buffer-read-only . t)))))

;; Associate directories with the read-only class
(dolist (dir (list "~/Envs" "/usr" "~/.cargo" "~/.rustup"))
  (dir-locals-set-directory-class (file-truename dir) 'read-only))



;; ;;;;;;; 折叠 ;;;;;;

;; 主用yafolding和vimish-fold, origami行为有些诡异, 暂时不用, yafolding折叠所有的时候有些慢, 但是行为较明确
;; vimish-fold可以自定义折叠区域, 且可持久化到本地

(use-package yafolding
  ;; C-RET: toggle-element  C-S-RET: hide-parent-element  C-M-RET: toggle-all
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'yafolding-mode))

(use-package vimish-fold
  :ensure t
  :config
  (vimish-fold-global-mode t)
  (global-set-key (kbd "C-c v f") #'vimish-fold)
  (global-set-key (kbd "C-c v v") #'vimish-fold-delete)
  (global-set-key (kbd "C-c v t") #'vimish-fold-toggle))  ;; also C-`





;; ;;;;;;; Revert buffer without confirmation ;;;;;;

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))





(defun sudo-save ()
  (interactive)
  (if (not buffer-file-name)
      (write-file (concat "/sudo:root@localhost:" (ido-read-file-name "File:")))
    (write-file (concat "/sudo:root@localhost:" buffer-file-name))))





(provide 'init-basic)
