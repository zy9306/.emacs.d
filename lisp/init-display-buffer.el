;; -*- coding: utf-8; lexical-binding: t; -*-


; need enhance
;  try shackle?


(add-to-list 'display-buffer-alist
             '("\\*.*\\*"
               (display-buffer-reuse-window
                display-buffer-below-selected)
               (split-window-sensibly)
               (window-height   . 0.3)
               (reusable-frames . visible)))


(add-to-list 'display-buffer-alist
             '("\\*Ilist\\*"
               (imenu-list-display-buffer)))


(add-to-list 'display-buffer-alist
             '(".*magit.*"
               (display-buffer-reuse-window display-buffer-same-window)))


(add-to-list 'display-buffer-alist
             '(".*magit-diff.*"
               (display-buffer-reuse-window display-buffer-in-side-window)
               (side . right)
               (window-width . 0.7)))


(add-to-list 'display-buffer-alist
             '(".*ivy-occur.*"
               (display-buffer-reuse-window display-buffer-same-window)))


(provide 'init-display-buffer)
