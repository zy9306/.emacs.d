;; -*- coding: utf-8; lexical-binding: t; -*-

(with-eval-after-load 'apheleia
  (setf (alist-get 'gofmt apheleia-formatters) '("goimports")))

(add-hook 'go-mode-hook 'apheleia-mode)

(diminish 'apheleia-mode)

(provide 'init-formatter)
