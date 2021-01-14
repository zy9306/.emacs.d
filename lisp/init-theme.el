;; -*- coding: utf-8; lexical-binding: t; -*-


(require 'doom-themes)
(load-theme 'doom-one-light t)


(defun local/awesome-tray-mode ()
     (require 'awesome-tray)
     (setq awesome-tray-active-modules
        '("location" "git" "mode-name" "parent-dir" "buffer-name" "battery" "date" "buffer-read-only"))
     (awesome-tray-mode 1))
;; (add-hook 'after-init-hook #'local/awesome-tray-mode)


(provide 'init-theme)
