;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package projectile
  :ensure t
  :defer t
  :ensure counsel-projectile
  :init
  (add-hook 'after-init-hook 'projectile-mode)
  (add-hook 'after-init-hook 'counsel-projectile-mode)
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line-function '(lambda () (format " Proj[%s]" (projectile-project-name))))


(provide 'init-projectile)
