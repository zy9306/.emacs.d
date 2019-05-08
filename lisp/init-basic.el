;; -*- coding: utf-8; lexical-binding: t; -*-


;; ;;;;;;; 一些通用且无依赖的包 ;;;;;;;

(use-package diminish
  :ensure t
  :defer t)

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
  (setq which-key-popup-type 'minibuffer)
  (which-key-setup-minibuffer))

(use-package imenu-list
  :ensure t
  :config
  (setq imenu-list-auto-resize t)
  (setq imenu-list-focus-after-activation t)
  (global-set-key (kbd "C-\"") #'imenu-list-smart-toggle))

(use-package flycheck
  ;; http://www.flycheck.org/en/latest/
  :ensure t
  :init (global-flycheck-mode))

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode t)
  (diff-hl-margin-mode t)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.05)
  (setq company-tooltip-idle-delay 0.05)
  (setq company-minimum-prefix-length 2)
  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-other-backend)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package symbol-overlay
  ;; https://github.com/purcell/emacs.d/blob/master/lisp/init-editing-utils.el
  ;; 高亮相同单词，可同时高亮多个，M-i增加单词
  :ensure t
  :diminish symbol-overlay-mode
  :config
  (dolist (hook '(prog-mode-hook html-mode-hook conf-mode-hook text-mode-hook))
  (add-hook hook 'symbol-overlay-mode))
  (define-key symbol-overlay-mode-map (kbd "M-i") 'symbol-overlay-put)
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

(use-package elpa-mirror
  ;; https://github.com/redguardtoo/elpa-mirror
  ;; M-x elpamr-create-mirror-for-installed to create local repository.
  ;; M-x elpamr-create-mirror-for-installed command again for update
  :ensure t
  :config
  (setq elpamr-default-output-directory "~/myelpa/"))

(use-package magit
  :ensure t
  :defer t)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)
(global-set-key (kbd "C-c M-g") 'magit-file-dispatch)



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
;; Prefer g-prefixed coreutils version of standard utilities when available
;; brew install coreutils for mac
(let ((gls (executable-find "gls")))
  (when gls (setq insert-directory-program gls)))
(setq dired-listing-switches "-al -h --group-directories-first --color=always")



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



(provide 'init-basic)
