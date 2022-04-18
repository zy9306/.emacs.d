(with-eval-after-load 'projectile
  (require 'projectile)
  (require 'counsel-projectile)

  (projectile-mode)
  (counsel-projectile-mode)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

  (setq counsel-projectile-rg-initial-input '(ivy-thing-at-point))
  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line-function '(lambda () (format " Proj[%s]" (projectile-project-name)))))

(local/after-init-hook 'projectile)

(global-set-key (kbd "C-S-S") 'projectile-ripgrep)

(with-eval-after-load 'projectile
  (require 'projectile)
  (setq frame-title-format
        '("miku@"(:eval (projectile-project-name)) ": "
          (:eval (if (buffer-file-name)
                     (abbreviate-file-name (buffer-file-name))
                   "%b")))))


(provide 'init-projectile)
