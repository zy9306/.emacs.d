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

(provide 'init-edit-utils)
