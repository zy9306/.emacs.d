;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://github.com/magnars/multiple-cursors.el/tree/master
;; To yank from the kill-rings of every cursor use yank-rectangle, normally found at C-x r y

(use-package multiple-cursors
  :ensure t
  :defer t
  )
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(delete-selection-mode t)  ;; if nil, when select `abc` then enter x,if will be `abcx` rather than `x`

;; select a region, C-x tab then can use left/right or shift+left/shift+right to indent the region
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; auto close ()
(electric-pair-mode t)
;; highlight ()
(show-paren-mode t)
;; todo this don't work
(setq show-paren-when-point-inside-paren t)
;; will highlight block with paren
;; (setq show-paren-style 'expression)

;; shift+return
(defun newline-at-end-of-line ()
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))
(global-set-key (kbd "S-<return>") 'newline-at-end-of-line)

;; tips
;; C-M-N and C-M-P go to ) from ( and so on...

;; C-x b will see recent file
(recentf-mode t)
(setq-default recentf-max-saved-items 50)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(column-number-mode t)


;; expand-region 快速选中及增减选区
(use-package expand-region
  :ensure t
  :defer t
  )
(global-set-key (kbd "C-=") 'er/expand-region)


;; change backup dir
(make-directory "~/.emacs.d/autosaves/" t)
(make-directory "~/.emacs.d/backups/" t)
(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/autosaves/" t)))


;; https://github.com/purcell/emacs.d/blob/master/lisp/init-editing-utils.el
;; 高亮相同单词，可同时高亮多个，M-i增加单词
(use-package symbol-overlay
  :ensure t
  :diminish symbol-overlay-mode
  :config
  (dolist (hook '(prog-mode-hook html-mode-hook conf-mode-hook text-mode-hook))
  (add-hook hook 'symbol-overlay-mode))
  (define-key symbol-overlay-mode-map (kbd "M-i") 'symbol-overlay-put)
  (define-key symbol-overlay-mode-map (kbd "M-n") 'symbol-overlay-jump-next)
  (define-key symbol-overlay-mode-map (kbd "M-p") 'symbol-overlay-jump-prev))


;; https://github.com/purcell/emacs.d/blob/master/lisp/init-isearch.el
;; 实时显示搜索及替换结果
(use-package anzu
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-anzu-mode)
  (setq anzu-mode-lighter "")
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace))


(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))


(provide 'init-edit-utils)
