;; only need projectile-ripgrep
(lazy-load-global-keys
 '(("C-S-S" . projectile-ripgrep))
 "projectile")

(with-eval-after-load 'projectile
  (require 'counsel-projectile)
  (counsel-projectile-mode)
  (define-key projectile-mode-map (kbd "C-c p") 'nil)
  (setq counsel-projectile-rg-initial-input '(ivy-thing-at-point)))

(defun local/get-project-name ()
  ;; (projectile-project-name)
  (ignore-errors
    (file-name-nondirectory
     (directory-file-name
      (project-root (project-current))))))

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
