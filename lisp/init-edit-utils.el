;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://github.com/magnars/multiple-cursors.el/tree/master
;; To yank from the kill-rings of every cursor use yank-rectangle, normally found at C-x r y

(use-package multiple-cursors
  :ensure t

  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

(delete-selection-mode t)  ;; if nil, when select `abc` then enter x,if will be `abcx` rather than `x`

;; select a region, C-x tab then can use left/right or shift+left/shift+right to indent the region
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; auto close ()
(electric-pair-mode t)

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

(provide 'init-edit-utils)
