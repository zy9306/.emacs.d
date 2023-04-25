;; only need projectile-ripgrep

(use-package projectile
  :diminish projectile-mode
  :commands (projectile-ripgrep)
  :bind (("C-S-S" . projectile-ripgrep)
         ))

(with-eval-after-load 'projectile
  (require 'counsel-projectile)
  (counsel-projectile-mode)
  (define-key projectile-mode-map (kbd "C-c p") 'nil)
  (remove-hook 'project-find-functions #'project-projectile)
  (setq counsel-projectile-rg-initial-input '(ivy-thing-at-point)))

(defun local/get-project-name ()
  (ignore-errors
    (file-name-nondirectory
     (directory-file-name
      (project-root (project-current))))))

(with-eval-after-load 'project
  (define-key ctl-x-map "p" 'nil)
  (define-key mode-specific-map "p" project-prefix-map)

  (remove-hook 'project-find-functions #'project-projectile)

  (setq frame-title-format
        '("miku@"(:eval (local/get-project-name)) ": "
          (:eval (if (buffer-file-name)
                     (abbreviate-file-name (buffer-file-name))
                   "%b")))))
(local/load-package 'project)


;;; treemacs
(with-eval-after-load 'treemacs
  ;; 默认在最后使用的 window 中打开文件
  (treemacs-define-RET-action 'file-node-open   #'treemacs-visit-node-in-most-recently-used-window)
  (treemacs-define-RET-action 'file-node-closed #'treemacs-visit-node-in-most-recently-used-window)

  (treemacs-define-doubleclick-action 'file-node-open   #'treemacs-visit-node-in-most-recently-used-window)
  (treemacs-define-doubleclick-action 'file-node-closed #'treemacs-visit-node-in-most-recently-used-window)

  (setq treemacs-width 20)

  (treemacs-follow-mode -1)

  (add-hook 'treemacs-mode-hook #'(lambda () (display-line-numbers-mode -1))))

(use-package treemacs
  :commands (treemacs treemacs-find-file)
  :bind (([f9] . treemacs)
         ([f8] . treemacs-find-file)))


(provide 'init-project)
