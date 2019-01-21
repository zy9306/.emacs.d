;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package dashboard
  :ensure t
  
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 2)
  (setq dashboard-items '((recents  . 10)
                          (bookmarks . 10)
                          ;; (projects . 5)
                          (agenda . 10)
                          ;; (registers . 5)
                          ))
  )


(use-package diminish
  :ensure t
  :defer t)

(provide 'init-utils)
