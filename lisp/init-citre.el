;;; -*- coding: utf-8; lexical-binding: t; -*-

;;; citre
;; https://github.com/universal-ctags/citre/wiki
(with-eval-after-load 'citre
  (require 'citre)
  (require 'citre-config)

  (setq-default citre-enable-imenu-integration nil)

  ;; make sure lsp at first
  (add-hook 'citre-mode-hook
            (lambda ()   (dolist (xref-backend '(nox-xref-backend))
                           (if (member xref-backend xref-backend-functions)
                               (progn
                                 (setq xref-backend-functions (remove xref-backend xref-backend-functions))
                                 (add-to-list 'xref-backend-functions xref-backend))))))

  (defun my--push-point-to-xref-marker-stack (&rest r)
    (xref-push-marker-stack (point-marker)))

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


;;; mixin lsp
(defun local/nox-result ()
  (ignore-errors (nox-completion-at-point)))

(defun local/lsp-result ()
  (ignore-errors (lsp-completion-at-point)))

(defun lsp-citre-capf-function ()
  "A capf backend that tries lsp first, then Citre."
  (let ((lsp-result (local/lsp-result)))
    (if (ignore-errors (and lsp-result
                            (try-completion
                             (buffer-substring (nth 0 lsp-result)
                                               (nth 1 lsp-result))
                             (nth 2 lsp-result))))
        lsp-result
      (citre-completion-at-point))))

(defun enable-lsp-citre-capf-backend ()
  (setq-local completion-at-point-functions nil)
  (add-hook 'completion-at-point-functions 'lsp-citre-capf-function nil t))

(add-hook 'citre-mode-hook 'enable-lsp-citre-capf-backend)

(local/after-init-hook 'citre)


(provide 'init-citre)
