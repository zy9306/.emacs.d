;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package go-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))

(use-package go-eldoc
  :ensure t
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package company-go
  ;; should install gocode
  ;; https://github.com/nsf/gocode
  :ensure t
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode))))


;; https://github.com/flycheck/flycheck/issues/1523
(let ((govet (flycheck-checker-get 'go-vet 'command)))
  (when (equal (cadr govet) "tool")
    (setf (cdr govet) (cddr govet))))


(provide 'init-go)
