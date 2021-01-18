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
 :background miku-origin)
(set-face-attribute
 'highlight nil
 :background miku-brightness-65)
(set-face-attribute
 'font-lock-string-face nil
 :foreground miku-brightness-50)
(set-face-attribute
 'tooltip nil
 :background "white" :foreground miku-brightness-65)

(with-eval-after-load 'company-mode
  (set-face-attribute
   'company-tooltip-selection nil
   :background miku-origin :weight bold))

(with-eval-after-load 'imenu-list
  (set-face-attribute
   'imenu-list-entry-face-1 nil
   :foreground miku-brightness-65))

(with-eval-after-load 'easy-kill
  (set-face-attribute
   'easy-kill-selection nil
   :inherit 'region))

(with-eval-after-load 'eglot
  (set-face-attribute
   'eglot-highlight-symbol-face nil
   :inherit 'normal))

(with-eval-after-load 'hl-line-mode
  (set-face-attribute
   'hl-line nil
   :background "pink"))


(provide 'init-face)
