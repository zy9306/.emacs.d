;;; -*- coding: utf-8; lexical-binding: t; -*-


;;; use shackle instead
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

;;; shackle

;;; https://depp.brause.cc/shackle/

(use-package shackle
  :ensure t
  :defer t
  :init
  (setq shackle-default-rule nil)
  (setq shackle-rules
        '(("*Buffer List*"
           :regexp nil
           :select t
           :align right
           :size 0.33)

          ("*Async Shell Command*"
           :regexp nil
           :ignore t)

          ("*Bufler*"
           :regexp nil
           :inhibit-window-quit t
           :same t)

          ("\\*Flycheck errors\\*.*"
           :regexp t
           :inhibit-window-quit t
           :same t)

          ("\\*Flycheck checker\\*"
           :regexp t
           :inhibit-window-quit t
           :select nil
           :ignore t)

          ;; the last rule
          ("\\*.*\\*"
           :regexp t
           :select t
           :align below
           :size 0.33)))

  (add-hook 'after-init-hook (lambda () (shackle-mode 1))))


;;; unused

;; (".*ivy-occur.*" :regexp t :select t :popup t :align below :size 0.33)
;; ("*Warnings*" :regexp nil :select t :align below :size 0.33)
;; ("*Disabled Command*" :regexp nil :select t :align below :size 0.33)
;; ("*Help*" :regexp nil :select t :align below :size 0.33)
;; ("*xref*" :regexp nil :select t :align below :size 0.33)
;; ("\\*gud-test\\*.*" :regexp t :select t :align right :other t :size 0.5)
;; ("\\*gud-test_.*" :regexp t :select t :align right :other t :size 0.5)
;; ("*go-test*" :regexp nil :select t :align right :other t :size 0.5)
;; ("\\*pytest-.*\\*" :regexp t :select t :align right :other t :size 0.5)
;; (magit-status-mode :select t :inhibit-window-quit t :same t)


(provide 'init-display-buffer)
