;;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'lsp-bridge)
(require 'lsp-bridge-icon)

(when (or *mac* *unix*)
  (setq-default lsp-bridge-python-command "/usr/local/bin/python3"))

(add-hook
 'lsp-bridge-mode-hook
 (lambda ()
   (progn
     (setq-local corfu-auto nil)
     (setq-local corfu-auto-prefix 1)

     (with-eval-after-load 'company
       (company-mode -1)))))

(dolist (hook (list
               'emacs-lisp-mode-hook))
  (add-hook hook (lambda ()
                   (setq-local corfu-auto t))))

(dolist (hook (list
               'python-mode-hook
               'rust-mode-hook
               'go-mode-hook
               'typescript-mode-hook
               'js2-mode-hook
               'js-mode-hook))
  (add-hook hook (lambda () (lsp-bridge-mode 1))))

(define-key lsp-bridge-mode-map (kbd "M-.") 'lsp-bridge-find-def)
(define-key lsp-bridge-mode-map (kbd "M-,") 'lsp-bridge-return-from-def)


;;; fix python Path
(defcustom lsp-bridge-current-python-command ""
  ""
  :type 'string)

(defun lsp-bridge-set-current-python-command ()
  (setq lsp-bridge-current-python-command (executable-find "python")))

(add-hook 'pyvenv-post-activate-hooks
          (lambda ()
              (lsp-bridge-set-current-python-command)
              (lsp-bridge-restart-process)))


(provide 'init-lsp-bridge)
