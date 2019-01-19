;; -*- coding: utf-8; lexical-binding: t; -*-

;; 代码语法高亮
(setq org-src-fontify-natively t)
;; 始终启用缩进
(add-hook 'org-mode-hook 'org-indent-mode)

;; ox-gfm is also installed by markdown-mode

(use-package ox-qmd
  :ensure t

  :config
  (add-to-list 'ox-qmd-language-keyword-alist '("shell-script" . "sh")))

(provide 'init-org)
