;;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package rust-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))

(use-package flycheck-rust
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))


(provide 'init-rust)
