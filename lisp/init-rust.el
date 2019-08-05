;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package rust-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))

(use-package flycheck-rust
  :ensure t
  :config
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))


;; 1. backends racer
;; (use-package racer
;;   ;; cargo +nightly install racer
;;   :ensure t
;;   :config
;;   (add-hook 'rust-mode-hook #'racer-mode)
;;   (add-hook 'racer-mode-hook #'eldoc-mode)
;;   (add-hook 'racer-mode-hook #'company-mode))


;; or 2. backends rust-analyzer use lsp
;; https://github.com/rust-analyzer/rust-analyzer
(require 'ra-emacs-lsp)
(add-hook 'rust-mode-hook #'lsp)


(provide 'init-rust)
