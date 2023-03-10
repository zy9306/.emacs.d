;;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package company
  :defer 0.1
  :custom
  (company-idle-delay 0.2)
  (company-tooltip-idle-delay 0.5)
  (company-minimum-prefix-length 1)
  (company-require-match nil)
  (company-dabbrev-downcase nil)
  (company-dabbrev-ignore-case nil)
  (company-show-numbers t)

  :bind
  (
   ("M-<RET>" . company-tabnine)

   :map company-mode-map
   ("M-/" . company-complete)

   :map company-active-map
   ("M-/" . company-other-backend)
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("M-v" . company-previous-page)
   ("C-v" . company-next-page)
   )

  :config
  (add-to-list 'company-transformers #'delete-dups))

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'global-company-mode-hook #'local/config-company-backends)


;;; misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun local/config-company-backends ()
  (require 'company)
  (setq company-backends
        '(
          (company-keywords company-files company-dabbrev company-dabbrev-code company-capf)
          ))

  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")

  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))

  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (require 'company-elisp)
              (push 'company-elisp company-backends))))


(defun company-transform-pyright (candidates)
  (mapcar (lambda (c)
            (let ((annotation
                   (ignore-errors
                     (company-capf--annotation c))))
              (if (and
                   annotation
                   (string-prefix-p
                    " Auto-import"
                    (company-capf--annotation c)))
                  (setq candidates (delete c candidates)))))
          candidates)
  candidates)

(add-hook 'python-mode-hook
          (lambda ()
            (setq-local company-transformers '(delete-dups company-transform-pyright))))


(provide 'init-company)
