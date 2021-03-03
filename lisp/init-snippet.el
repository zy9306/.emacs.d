;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/yas-mode ()
  (require 'yasnippet)
  (yas-minor-mode)
  (yas-global-mode)
  (diminish 'yas-minor-mode))

(use-package yasnippet
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook #'local/yas-mode))


(use-package yasnippet-snippets)


(provide 'init-snippet)
