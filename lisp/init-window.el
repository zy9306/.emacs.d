;;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package ace-window
  :ensure t
  :defer t
  :init
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (global-set-key (kbd "C-x o") 'ace-window))

(defun local/switch-to-last-window ()
  (interactive)
  (let ((win (get-mru-window t t t)))
    (unless win (error "Last window not found"))
    (let ((frame (window-frame win)))
      (select-frame-set-input-focus frame)
      (select-window win))))
(global-set-key (kbd "M-o") #'local/switch-to-last-window)

(defun split-window-horizontally-instead ()
  (interactive)
  (let ((other-buffer (and (next-window) (window-buffer (next-window)))))
    (delete-other-windows)
    (split-window-horizontally)
    (when other-buffer
      (set-window-buffer (next-window) other-buffer))))

(defun split-window-vertically-instead ()
  (interactive)
  (let ((other-buffer (and (next-window) (window-buffer (next-window)))))
    (delete-other-windows)
    (split-window-vertically)
    (when other-buffer
      (set-window-buffer (next-window) other-buffer))))

(global-set-key (kbd "C-x |") 'split-window-horizontally-instead)
(global-set-key (kbd "C-x _") 'split-window-vertically-instead)

(require 'toggle-one-window)
(global-set-key (kbd "C-x 1") 'toggle-one-window)

(defun toggle-current-window-dedication ()
  "Toggle whether the current window is dedicated to its current buffer."
  (interactive)
  (let* ((window (selected-window))
         (was-dedicated (window-dedicated-p window)))
    (set-window-dedicated-p window (not was-dedicated))
    (message "Window %sdedicated to %s"
             (if was-dedicated "no longer " "")
             (buffer-name))))
(global-set-key (kbd "C-c <down>") 'toggle-current-window-dedication)

(use-package buffer-move
  :ensure t
  :defer t
  :init
  (global-set-key (kbd "<C-S-up>") 'buf-move-up)
  (global-set-key (kbd "<C-S-down>") 'buf-move-down)
  (global-set-key (kbd "<C-S-left>") 'buf-move-left)
  (global-set-key (kbd "<C-S-right>") 'buf-move-right))

(defun local/fit-window-to-buffer-horizontally ()
  (interactive)
  (setq fit-window-to-buffer-horizontally 'only)
  (fit-window-to-buffer)
  (setq fit-window-to-buffer-horizontally nil))
(global-set-key (kbd "C-x w h") 'local/fit-window-to-buffer-horizontally)
(global-set-key (kbd "C-x w v") 'fit-window-to-buffer)

(global-set-key (kbd "C-S-h") 'windmove-left)
(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-l") 'windmove-right)

(provide 'init-window)
