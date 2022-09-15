;; only need projectile-ripgrep
(with-eval-after-load 'projectile
  (require 'projectile)
  (require 'counsel-projectile)
  (setq counsel-projectile-rg-initial-input '(ivy-thing-at-point))
  (global-set-key (kbd "C-S-S") 'projectile-ripgrep))
(local/load-package 'projectile)

(defun local/get-project-name ()
  ;; (projectile-project-name)
  (file-name-nondirectory
   (directory-file-name
    (project-root (project-current)))))

(with-eval-after-load 'project
  (define-key ctl-x-map "p" 'nil)
  (define-key mode-specific-map "p" project-prefix-map)

  (setq frame-title-format
        '("miku@"(:eval (local/get-project-name)) ": "
          (:eval (if (buffer-file-name)
                     (abbreviate-file-name (buffer-file-name))
                   "%b")))))
(local/load-package 'project)

(provide 'init-project)
