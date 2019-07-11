;; -*- coding: utf-8; lexical-binding: t; -*-


;; use shackle instead
;; (add-to-list 'display-buffer-alist
;;              '("\\*.*\\*"
;;                (display-buffer-reuse-window
;;                 display-buffer-below-selected)
;;                (split-window-sensibly)
;;                (window-height   . 0.3)
;;                (reusable-frames . visible)))


;; (add-to-list 'display-buffer-alist
;;              '("\\*Ilist\\*"
;;                (imenu-list-display-buffer)))


;; (add-to-list 'display-buffer-alist
;;              '(".*magit.*"
;;                (display-buffer-reuse-window display-buffer-same-window)))


;; (add-to-list 'display-buffer-alist
;;              '(".*magit-diff.*"
;;                (display-buffer-reuse-window display-buffer-in-side-window)
;;                (side . right)
;;                (window-width . 0.7)))


;; (add-to-list 'display-buffer-alist
;;              '(".*ivy-occur.*"
;;                (display-buffer-reuse-window display-buffer-same-window)))


(use-package shackle
  :ensure t
  :config
  (setq shackle-default-rule nil)

  (setq shackle-rules
        '(
          (magit-status-mode :select t :inhibit-window-quit t :same t)
          (".*ivy-occur.*" :regexp t :select t :inhibit-window-quit t :same t)

          ;; the last rule
          ("\\*.*\\*" :regexp t :select t :size 0.3 :align below)
          )
        )
  (shackle-mode 1))


(provide 'init-display-buffer)
