;;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package company
  :diminish company-mode
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
   ("M-<RET>" . local/company-tabnine)
   :map company-mode-map
   ("M-/" . local/company-complete)
   :map company-active-map
   ("M-/" . company-other-backend)
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("M-v" . company-previous-page)
   ("C-v" . company-next-page)
   )
  :config
  (add-to-list 'company-transformers #'delete-dups))

(defun local/company-tabnine (command &optional arg &rest ignored)
  (interactive (list 'interactive))
  (company-abort)
  (company-tabnine command arg ignored))


(defun local/company-complete ()
  (interactive)
  (company-abort)
  (setq-local company-backends
              '((company-files company-dabbrev company-dabbrev-code)))
  (company-complete))

(defun local/config-company-backends ()
  (require 'company)
  (setq company-backends
        '(
          (company-keywords company-files company-dabbrev company-dabbrev-code company-capf)
          ))

  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (require 'company-elisp)
              (push 'company-elisp company-backends))))


(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'global-company-mode-hook #'local/config-company-backends)

(provide 'init-company)
