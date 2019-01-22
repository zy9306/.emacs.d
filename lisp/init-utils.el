;; -*- coding: utf-8; lexical-binding: t; -*-

;; todo not very useful, wait to delete it
;; (use-package dashboard
;;   :ensure t
  
;;   :config
;;   (dashboard-setup-startup-hook)
;;   (setq dashboard-startup-banner 2)
;;   (setq dashboard-items '((recents  . 10)
;;                           (bookmarks . 10)
;;                           ;; (projects . 5)
;;                           (agenda . 10)
;;                           ;; (registers . 5)
;;                           ))
;;   )


(use-package diminish
  :ensure t
  :defer t)


;; see also https://www.emacswiki.org/emacs/AutoSave `auto-save-visited-mode`
(use-package real-auto-save
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'real-auto-save-mode)
  (add-hook 'text-mode-hook 'real-auto-save-mode)
  (setq real-auto-save-interval 1))


(provide 'init-utils)
