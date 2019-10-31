;; -*- coding: utf-8; lexical-binding: t; -*-

;; only more than two windows `M-o` will show keys
;; can type ? when `M-o` to show command help

(use-package ace-window
  :ensure t

  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (global-set-key (kbd "M-o") 'ace-window))


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

;; (global-set-key (kbd "C-x |") 'split-window-horizontally-instead)
;; (global-set-key (kbd "C-x _") 'split-window-vertically-instead)


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


(defun iwindhelper (&optional arg)
  "move window interactively."
  (interactive)
  ;; (if (one-window-p) (error "Cannot resize sole window"))
  (or arg (setq arg 1))
  (let (c)
    (catch 'done
	(message
	 "h=left, j=down, k=up, l=right, r=iresize-window, s=ace-swap-window, d=ace-delete-other-windows, |=|, _=-"
	 arg)
	(setq c (read-char))
	(condition-case ()
	    (cond
	     ((= c ?h) (windmove-left arg))
	     ((= c ?j) (windmove-down arg))
	     ((= c ?k) (windmove-up arg))
	     ((= c ?l) (windmove-right arg))

         ((= c ?s) (ace-swap-window))
         ((= c ?d) (ace-delete-other-windows))

         ((= c ?|) (split-window-horizontally-instead))
         ((= c ?_) (split-window-vertically-instead))

         ((= c ?r) (iresize-window))

	     ((= c ?\^G) (keyboard-quit))
	     ((= c ?q) (throw 'done t))
	     (t (beep)))
	  (error (beep))))))

(global-set-key (kbd "C-z") 'iwindhelper)


(provide 'init-ace-window)
