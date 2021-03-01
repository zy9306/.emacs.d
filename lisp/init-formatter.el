;; -*- coding: utf-8; lexical-binding: t; -*-

(with-eval-after-load 'apheleia
  (setf (alist-get 'gofmt apheleia-formatters) '("goimports")))

(defun local/apheleia-mode ()
  (require 'apheleia)
  (apheleia-mode)
  (diminish 'apheleia-mode))

(add-hook 'go-mode-hook #'local/apheleia-mode)

(provide 'init-formatter)
