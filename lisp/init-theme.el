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

  (if (display-graphic-p)
      (local/doom-themes-ext-treemacs)))

(local/doom-themes)



;;; spaceline
(setq spaceline-minor-modes-p nil)

(require 'spaceline-config)
(require 'spaceline-segments)

;; override spaceline--theme
(defun spaceline--theme (left second-left &rest additional-segments)
  (spaceline-compile
    `(,left
      auto-compile
      ,second-left
      (which-function :priority 99)
      (major-mode :priority 79)
      (process :when active)
      ((flycheck-error flycheck-warning flycheck-info)
       :when active
       :priority 89)
      (minor-modes :when active
                   :priority 9)
      (mu4e-alert-segment :when active)
      (erc-track :when active)
      (version-control :when active
                       :priority 78)
      (org-pomodoro :when active)
      (org-clock :when active)
      nyan-cat)
    `((python-pyvenv :fallback python-pyenv)
      (purpose :priority 94)
      (battery :when active)
      (selection-info :priority 95)
      input-method
      ((buffer-encoding-abbrev
        point-position
        line-column)
       :separator " | "
       :priority 96)
      (global :when active)
      ,@additional-segments
      (buffer-position :priority 99)
      (hud :priority 99)))

  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-main)))))


(spaceline-spacemacs-theme)

(set-face-attribute
 'mode-line nil
 :background "#e7e7e7" :box '(:line-width 1 :color "grey75"))


(provide 'init-theme)
