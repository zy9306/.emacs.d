;;; -*- coding: utf-8; lexical-binding: t; -*-

;;; citre
;; https://github.com/universal-ctags/citre/wiki
(with-eval-after-load 'citre
  (require 'citre)
  (require 'citre-config)

  (setq-default citre-enable-capf-integration nil)
  (setq-default citre-enable-imenu-integration nil)
  (setq citre-use-project-root-when-creating-tags t)
  (setq citre-prompt-language-for-ctags-command t)

  (add-hook 'completion-at-point-functions 'citre-completion-at-point nil t)

  (defun my--push-point-to-xref-marker-stack (&rest r)
    (xref-push-marker-stack (point-marker)))

  (define-key citre-mode-map (kbd "M-.") #'citre-jump+)

  (dolist (func '(find-function
                  counsel-imenu
                  projectile-grep
                  projectile-ripgrep
                  counsel-rg
                  citre-jump))
    (advice-add func :before 'my--push-point-to-xref-marker-stack)))


;;; company-backend
(defun company-citre (-command &optional -arg &rest _ignored)
  (interactive (list 'interactive))
  (cl-case -command
    (interactive (company-begin-backend 'company-citre))
    (prefix (and (bound-and-true-p citre-mode)
                 (or (citre-get-symbol) 'stop)))
    (meta (citre-get-property 'signature -arg))
    (annotation (citre-capf--get-annotation -arg))
    (candidates (all-completions -arg (citre-capf--get-collection -arg)))
    (ignore-case (not citre-completion-case-sensitive))))

(defun citre-jump+ ()
  (interactive)
  (condition-case _
      (call-interactively #'xref-find-definitions)
    (error (citre-jump))))

(local/after-init-hook 'citre)


(provide 'init-citre)
