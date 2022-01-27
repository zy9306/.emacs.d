;;; -*- coding: utf-8; lexical-binding: t; -*-


(add-hook 'rust-mode-hook #'local/nox-ensure)

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



;; rust-analyzer 表现优于 rls，racer 是非 lsp 方案中较快的，但目前没有处于积极维护状态
;; rustup component add rust-src 安装标准库源码，不手动安装的话，rust-analyzer 也会尝试自动下载
;; https://github.com/rust-analyzer/rust-analyzer/releases 下载二进制
(with-eval-after-load 'nox
  (add-to-list 'nox-server-programs
               `(rust-mode . ("rust-analyzer"))))



(provide 'init-rust)
