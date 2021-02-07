;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/doom-themes-ext-treemacs ()
  (require 'doom-themes-ext-treemacs)
  (require 'all-the-icons) ;; depends on memoize

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


;; (defun local/awesome-tray-mode ()
;;      (require 'awesome-tray)
;;      (setq awesome-tray-active-modules
;;            '("location"
;;              "git"
;;              "mode-name"
;;              "parent-dir"
;;              "buffer-name"
;;              "battery"
;;              "date"
;;              "buffer-read-only"))
;;      (awesome-tray-mode 1))
;; (add-hook 'after-init-hook #'local/awesome-tray-mode)


(provide 'init-theme)
