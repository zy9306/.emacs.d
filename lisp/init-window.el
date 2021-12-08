;;; -*- coding: utf-8; lexical-binding: t; -*-


;;; ace-window
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



;;; 调整 buffer 分割方向，有点问题
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



;;; resize and switch window
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



(require 'toggle-one-window)
(global-set-key (kbd "C-x 1") 'toggle-one-window)



;;; 固定当前buffer不被覆盖
;; https://github.com/purcell/emacs.d/blob/master/lisp/init-windows.el
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



;;; buffer-move
(use-package buffer-move
  :ensure t
  :defer t
  :init
  (global-set-key (kbd "<C-S-up>")     'buf-move-up)
  (global-set-key (kbd "<C-S-down>")   'buf-move-down)
  (global-set-key (kbd "<C-S-left>")   'buf-move-left)
  (global-set-key (kbd "<C-S-right>")  'buf-move-right))



;;; balance-windows
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



;;; 水平适应，垂直适应
(defun local/fit-window-to-buffer-horizontally ()
  (interactive)
  (setq fit-window-to-buffer-horizontally 'only)
  (fit-window-to-buffer)
  (setq fit-window-to-buffer-horizontally nil))

(global-set-key (kbd "C-x w h") 'local/fit-window-to-buffer-horizontally)
(global-set-key (kbd "C-x w v") 'fit-window-to-buffer)


(provide 'init-window)
