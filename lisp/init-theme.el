;;; -*- coding: utf-8; lexical-binding: t; -*-

(setq local/theme nil)

(defun local/doom-themes ()
  (require 'doom-themes)

  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)

  (if local/is-light-theme
      ;; doom-solarized-light or doom-one-light
      (setq local/theme 'doom-one-light)
    (setq local/theme 'doom-one))

  (load-theme local/theme t)
  (if (display-graphic-p)
      (local/doom-themes-ext-treemacs)))

(defun local/nano ()
  (require 'nano-theme)

  (load-theme 'nano t)

  (setq local/theme 'nano-theme)
  (if local/is-light-theme
      (nano-light)
    (nano-dark))

  (set-face-attribute
   'region nil
   :background "#E6E6E6"
   :extend t)

  (with-eval-after-load 'symbol-overlay
    (if (display-graphic-p)
        (set-face-attribute
         'symbol-overlay-default-face nil
         :background "darkseagreen2")))

  (with-eval-after-load 'which-func
    (set-face-attribute
     'which-func nil
     :inherit font-lock-function-name-face
     :foreground "#FFFFFF"
     :weight 'normal))

  (with-eval-after-load 'eglot
    (set-face-attribute
     'eglot-mode-line nil
     :inherit font-lock-constant-face
     :foreground "#FFFFFF"
     :weight 'normal))
  )

(defun local/nano-modeline ()
  (require 'nano-modeline)
  (setq nano-modeline-position 'bottom)
  (nano-modeline-mode))

(defun local/speceline ()
  (require 'spaceline)
  (if (and local/is-light-theme (eq local/theme 'doom-one-light))
      (set-face-attribute
       'mode-line nil
       :background "#e7e7e7" :box '(:line-width 1 :color "grey75"))

    (set-face-attribute
     'mode-line nil
     :box '(:line-width 1 :color "grey75"))))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq local/is-light-theme t)

;;; theme
;; (local/doom-themes)
(local/nano)

;;; modeline
;; (local/speceline)
;; (local/nano-modeline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-face-attribute
 'cursor nil
 :background "#39c5bb")


;;; doom-solarized-light overwrites
(when (and local/is-light-theme (eq local/theme 'doom-solarized-light))
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

;;; doom-one-light overwrites
(when (and local/is-light-theme (eq local/theme 'doom-one-light))
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
