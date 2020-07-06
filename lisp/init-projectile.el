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



(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))


(use-package neotree
  :ensure t
  :defer t
  :init
  (global-set-key [f8] 'neotree-toggle)
  (global-set-key (kbd "C-c C-n") 'neotree-project-dir)
  :config
  (setq neo-smart-open t)
  (setq neo-autorefresh nil)
  (setq neo-window-fixed-size nil)
  (setq neo-vc-integration '(face char))
  (setq projectile-switch-project-action 'neotree-projectile-action)

  (define-key neotree-mode-map (kbd "C") 'neotree-create-node)
  (define-key neotree-mode-map (kbd "R") 'neotree-rename-node)
  (define-key neotree-mode-map (kbd "D") 'neotree-delete-node)
  (define-key neotree-mode-map (kbd "P") 'neotree-copy-node)
  (define-key neotree-mode-map (kbd "W") 'neotree-copy-filepath-to-yank-ring)
  (define-key neotree-mode-map (kbd "+") 'make-directory)
  )


(provide 'init-projectile)
