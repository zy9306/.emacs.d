;; -*- coding: utf-8; lexical-binding: t; -*-


(with-eval-after-load 'projectile
  (require 'projectile)
  (require 'counsel-projectile)
  (require 'treemacs)

  (projectile-mode)
  (counsel-projectile-mode)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line-function '(lambda () (format " Proj[%s]" (projectile-project-name))))

  (global-set-key [f9] 'treemacs)
  (treemacs-follow-mode -1)
  (global-set-key [f8] 'treemacs-find-file)
  (add-hook 'treemacs-mode-hook #'(lambda () (display-line-numbers-mode -1)))
  )

(local/after-init-hook 'projectile)


;; use treemacs instead

;; (with-eval-after-load 'neotree
;;   (global-set-key [f8] 'neotree-toggle)
;;   (global-set-key (kbd "C-c C-n") 'neotree-project-dir)

;;   (setq neo-smart-open t)
;;   (setq neo-autorefresh nil)
;;   (setq neo-window-fixed-size nil)
;;   (setq neo-vc-integration '(face char))
;;   (setq projectile-switch-project-action 'neotree-projectile-action)

;;   (define-key neotree-mode-map (kbd "C") 'neotree-create-node)
;;   (define-key neotree-mode-map (kbd "R") 'neotree-rename-node)
;;   (define-key neotree-mode-map (kbd "D") 'neotree-delete-node)
;;   (define-key neotree-mode-map (kbd "P") 'neotree-copy-node)
;;   (define-key neotree-mode-map (kbd "W") 'neotree-copy-filepath-to-yank-ring)
;;   (define-key neotree-mode-map (kbd "+") 'make-directory))

;; (local/after-init-hook 'neotree)

;; (defun neotree-project-dir ()
;;   "Open NeoTree using the git root."
;;   (interactive)
;;   (let ((project-dir (projectile-project-root))
;;         (file-name (buffer-file-name)))
;;     (neotree-toggle)
;;     (if project-dir
;;         (if (neo-global--window-exists-p)
;;             (progn
;;               (neotree-dir project-dir)
;;               (neotree-find file-name)))
;;       (message "Could not find git project root."))))


(provide 'init-projectile)
