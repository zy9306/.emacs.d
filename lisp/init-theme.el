;; -*- coding: utf-8; lexical-binding: t; -*-

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
  (load-theme 'doom-one-light t)

  (local/doom-themes-ext-treemacs))

(local/doom-themes)


(require 'spaceline-config)
(spaceline-spacemacs-theme)

(set-face-attribute
 'mode-line nil
 :background "#e7e7e7" :box '(:line-width 1 :color "grey75"))


(provide 'init-theme)
