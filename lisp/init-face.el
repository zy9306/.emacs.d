;; -*- coding: utf-8; lexical-binding: t; -*-

;; mode-line
(set-face-attribute
 'mode-line nil
 :background "white" :foreground "grey20" :box '(:line-width -1 :color "dim gray") :slant 'normal :weight 'light)
(set-face-attribute
 'mode-line-inactive nil
 :background "white" :foreground "grey20" :box '(:line-width -1 :color "gray") :slant 'italic :weight 'light)
(set-face-attribute
 'cursor nil
 :background miku-color)

(with-eval-after-load 'hl-line-mode
  (set-face-attribute
   'hl-line nil
   :background "pink"))



(provide 'init-face)
