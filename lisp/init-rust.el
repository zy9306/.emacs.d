;; -*- coding: utf-8; lexical-binding: t; -*-


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
;; 使用rust-analyzer,缺点是不能使用snippet,但补全比rls强,rust-analyzer还在实验性阶段
;; 如果要切换为rls,注释掉以下行即可,lsp默认调用rls
(use-package ra-emacs-lsp
  :defer t
  :init
  (add-hook 'rust-mode-hook #'lsp))

;; (push '("rust" . company-lsp--rust-completion-snippet) company-lsp--snippet-functions)


(provide 'init-rust)
