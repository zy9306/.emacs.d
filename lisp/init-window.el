;; -*- coding: utf-8; lexical-binding: t; -*-

;; only more than two windows `M-o` will show keys
;; can type ? when `M-o` to show command help

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
  "Kill any other windows and re-split such that the current window is on the top half of the frame."
  (interactive)
  (let ((other-buffer (and (next-window) (window-buffer (next-window)))))
    (delete-other-windows)
    (split-window-horizontally)
    (when other-buffer
      (set-window-buffer (next-window) other-buffer))))

(defun split-window-vertically-instead ()
  "Kill any other windows and re-split such that the current window is on the left half of the frame."
  (interactive)
  (let ((other-buffer (and (next-window) (window-buffer (next-window)))))
    (delete-other-windows)
    (split-window-vertically)
    (when other-buffer
      (set-window-buffer (next-window) other-buffer))))

(global-set-key (kbd "C-x |") 'split-window-horizontally-instead)
(global-set-key (kbd "C-x _") 'split-window-vertically-instead)


;; https://www.emacswiki.org/emacs/WindowResize#toc3

(defun iresize-window (&optional arg)    ; Hirose Yuuji and Bob Wiener
  "*Resize window interactively."
  (interactive "p")
  (if (one-window-p) (error "Cannot resize sole window"))
  (or arg (setq arg 1))
  (let (c)
    (catch 'done
      (while t
	(message
	 "h=heighten, s=shrink, w=widen, n=narrow (by %d);  1-9=unit, q=quit"
	 arg)
	(setq c (read-char))
	(condition-case ()
	    (cond
	     ((= c ?h) (enlarge-window arg))
	     ((= c ?s) (shrink-window arg))
	     ((= c ?w) (enlarge-window-horizontally arg))
	     ((= c ?n) (shrink-window-horizontally arg))
	     ((= c ?\^G) (keyboard-quit))
	     ((= c ?q) (throw 'done t))
	     ((and (> c ?0) (<= c ?9)) (setq arg (- c ?0)))
	     (t (beep)))
	  (error (beep)))))
    (message "Done.")))


(global-set-key (kbd "C-S-h") 'windmove-left)
(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-x w r") 'iresize-window)
(global-set-key (kbd "C-x w s") 'ace-swap-window)
(global-set-key (kbd "C-x w d") 'ace-delete-other-windows)


;; TODO error when use treemacs
;; 最大化当前窗口，再次执行回到先前的窗口状态
(defvar window-split-saved-config nil)
(defun window-split-toggle-one-window ()
  "Make the current window fill the frame.
If there is only one window try reverting to the most recently saved
window configuration."
  (interactive)
  (if (and window-split-saved-config (not (window-parent)))
      (set-window-configuration window-split-saved-config)
    (setq window-split-saved-config (current-window-configuration))
    (delete-other-windows)))

;; (global-set-key (kbd "C-x 1") 'window-split-toggle-one-window)


;; https://github.com/purcell/emacs.d/blob/master/lisp/init-windows.el
;; 固定当前buffer不被覆盖
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
  (global-set-key (kbd "<C-S-up>")     'buf-move-up)
  (global-set-key (kbd "<C-S-down>")   'buf-move-down)
  (global-set-key (kbd "<C-S-left>")   'buf-move-left)
  (global-set-key (kbd "<C-S-right>")  'buf-move-right))


;; (defun local/delete-window (&optional window)
;;   (interactive)
;;   (if window
;;       (delete-window window)
;;     (delete-window))
;;   (balance-windows))

;; (defun local/kill-buffer-and-window ()
;;   (interactive)
;;   (kill-buffer-and-window)
;;   (balance-windows))

;; (global-set-key [remap delete-window] #'local/delete-window)
;; (global-set-key [remap kill-buffer-and-window] #'local/kill-buffer-and-window)

(provide 'init-window)
