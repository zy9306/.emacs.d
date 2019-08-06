;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package projectile
  :ensure t
  :ensure counsel-projectile
  :config
  (projectile-mode +1)
  (counsel-projectile-mode t)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line-function '(lambda () (format " Proj[%s]" (projectile-project-name))))


(provide 'init-projectile)
