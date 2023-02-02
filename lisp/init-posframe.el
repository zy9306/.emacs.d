;; -*- coding: utf-8; lexical-binding: t; -*-


(with-eval-after-load 'posframe
  (require 'ivy-posframe)
  (setq ivy-posframe-border-width 5
        ivy-posframe-parameters
        '(
          (alpha . 10) ; not work
          (left-fringe . 8)
          (right-fringe . 8)
          )
        )
  (setq ivy-posframe-display-functions-alist
        '((swiper          . ivy-display-function-fallback)
          (swiper-isearch  . ivy-display-function-fallback)
          (counsel-rg      . ivy-display-function-fallback)
          (complete-symbol . ivy-posframe-display-at-point)
          (counsel-M-x     . ivy-posframe-display-at-frame-center)
          (t               . ivy-posframe-display-at-frame-center)))
  (ivy-posframe-mode 1))

(local/after-init-hook 'posframe)

(provide 'init-posframe)
