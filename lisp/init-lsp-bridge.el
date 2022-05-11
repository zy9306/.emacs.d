;;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'lsp-bridge)
(require 'lsp-bridge-orderless)
(require 'lsp-bridge-icon)

(dolist (hook (list
               'emacs-lisp-mode-hook
               ))
  (add-hook hook (lambda ()
                   (setq-local corfu-auto t)
                   )))

(dolist (hook (list
               'c-mode-hook
               'c++-mode-hook
               'java-mode-hook
               'python-mode-hook
               'ruby-mode-hook
               'rust-mode-hook
               'elixir-mode-hook
               'go-mode-hook
               'haskell-mode-hook
               'haskell-literate-mode-hook
               'dart-mode-hook
               'scala-mode-hook
               'typescript-mode-hook
               'js2-mode-hook
               'js-mode-hook
               'tuareg-mode-hook
               'latex-mode-hook
               'Tex-latex-mode-hook
               'texmode-hook
               'context-mode-hook
               'texinfo-mode-hook
               'bibtex-mode-hook
               ))
  (add-hook hook (lambda ()
                   (setq-local corfu-auto nil)
                   (lsp-bridge-mode 1)
                   )))


;;; fix python Path
(defcustom lsp-bridge-current-python-command ""
  :type 'string)

(defun lsp-bridge-set-current-python-command ()
  (setq lsp-bridge-current-python-command (executable-find "python")))

(add-hook 'pyvenv-post-activate-hooks
          (lambda ()
            (progn
              (lsp-bridge-set-current-python-command)
              (lsp-bridge-restart-process))
            ))


(provide 'init-lsp-bridge)
