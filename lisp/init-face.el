;;; -*- coding: utf-8; lexical-binding: t; -*-


(set-face-attribute
 'cursor nil
 :background "#39c5bb")


(set-face-attribute
 'region nil
 :background "#d8d8d8"
 :extend t)

(set-face-attribute
 'fringe nil
 :background "grey95")

(with-eval-after-load 'easy-kill
  (set-face-attribute
   'easy-kill-selection nil
   :inherit 'region))

(with-eval-after-load 'symbol-overlay
  (if (display-graphic-p)
      (set-face-attribute
       'symbol-overlay-default-face nil
       :background "darkseagreen2"))
  (set-face-attribute
   'symbol-overlay-default-face nil
   :background "pink"))

(with-eval-after-load 'eglot
  (set-face-attribute
   'eglot-highlight-symbol-face nil
   :inherit 'normal))

(with-eval-after-load 'hl-line-mode
  (set-face-attribute
   'hl-line nil
   :background "pink"))


(provide 'init-face)
