;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/emacs-lsp/dap-mode

(require-package 'dap-mode)

(with-eval-after-load 'dap-mode
  (dap-auto-configure-mode)
  (add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra))))


(with-eval-after-load 'python
  ;; install ptvsd or debugpy
  (require 'dap-python))


(provide 'init-dap-mode)
