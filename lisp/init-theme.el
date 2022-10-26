;;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/doom-themes-ext-treemacs ()
  (require 'doom-themes-ext-treemacs)
  (require 'all-the-icons) ;; depends on memoize

  ;; 设置成默认 fringe 的宽度，否则无法显示左边 indicator
  (setq doom-themes-treemacs-bitmap-indicator-width 8)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)

  (with-eval-after-load 'treemacs
    ;; doom-themes 会把 treemacs 的 mode-line 隐藏掉，改成需要显示
    (remove-hook 'treemacs-mode-hook #'doom-themes-hide-modeline)))

(defun local/doom-themes ()
  (require 'doom-themes)

  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)

  ;; doom-one-light
  (setq local/light-theme 'doom-solarized-light)
  (setq local/dark-theme 'doom-one)

  (if local/is-light-theme
      (load-theme local/light-theme t)
    (load-theme local/dark-theme t))

  (if (display-graphic-p)
      (local/doom-themes-ext-treemacs)))

(local/doom-themes)

(set-face-attribute
 'cursor nil
 :background "#39c5bb")

(set-face-attribute
 'mode-line nil
 :box '(:line-width 1 :color "grey75"))

(when (and local/is-light-theme (eq local/light-theme 'doom-solarized-light))
  (with-eval-after-load 'imenu-list
    (set-face-attribute
     'imenu-list-entry-face-1 nil
     :foreground "gray31"))

  (set-face-attribute
   'font-lock-variable-name-face nil
   :foreground "#247c73")

  (set-face-attribute
   'font-lock-string-face nil
   :foreground "#cc99cc")
  )

(when (and local/is-light-theme (eq local/light-theme 'doom-one-light))
  (set-face-attribute
   'mode-line nil
   :background "#e7e7e7" :box '(:line-width 1 :color "grey75"))

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

  (with-eval-after-load 'corfu
    (set-face-attribute
     'corfu-current nil
     :background "#c295d7"))

  (with-eval-after-load 'lsp-bridge-ui
    (set-face-attribute
     'lsp-bridge-ui-current nil
     :background "#c295d7")))


(provide 'init-theme)
