;;; -*- coding: utf-8; lexical-binding: t; -*-

(with-eval-after-load 'org
  (require 'org-modern)
  (setq org-modern-keyword nil)
  (add-hook 'org-mode-hook #'org-modern-mode)

  (require 'ox-hugo)
  (require 'org-hugo-auto-export-mode))

(with-eval-after-load 'org
  (require 'org-download)
  (setq-default org-download-heading-lvl nil)
  (let ((dir (format "%s/Chtholly/image/bed" local/cloud-dir)))
    (setq-default org-download-image-dir dir))
  (put 'org-download-image-dir 'safe-local-variable #'stringp))

(with-eval-after-load 'ox
  (require 'ox-hugo))

(defun local/org-hugo-export-to-md ()
  (interactive)
  (save-excursion
    (let ((cur_point (point)))
      (beginning-of-buffer)
      (org-hugo-export-to-md)
      (goto-char cur_point))))

(with-eval-after-load 'org
  (require 'ox-gfm))

(use-package toc-org
  :defer t
  :hook ((org-mode . toc-org-mode)
         (markdown-mode . toc-org-mode)))

;; 始终启用缩进
;; 和 org-modern 冲突了
;; (add-hook 'org-mode-hook 'org-indent-mode)

;; 调整内联图片的显示大小
(setq org-image-actual-width 600)

;; 如果用 hook，#+startup: nonum 可能会不起作用
(setq org-startup-numerated t)

(setq org-fontify-quote-and-verse-blocks t)

;; 打开文件时收起所有结点
(setq org-startup-folded t)

;; 代码语法高亮
(setq org-src-fontify-natively t)

(setq org-M-RET-may-split-line '((default . nil)))

;; src 块自动缩进的空格数
(setq org-edit-src-content-indentation 0)

;; tab 和在对应 major-mode 下表现一致
(setq org-src-tab-acts-natively t)

;; show all the character like * / etc...
(setq org-hide-emphasis-markers nil)

;; show all level marks *
(setq org-hide-leading-stars nil)
(setq org-indent-mode-turns-on-hiding-stars nil)

;; 在有子树的结点上执行 C-k 时，提示是否删除子树
(setq org-ctrl-k-protect-subtree t)

;; [[link]]
(setq org-link-descriptive t)

;; (add-hook 'org-mode-hook #'(lambda () (display-line-numbers-mode -1)))

;; 导出时不要执行代码块
(setq org-export-babel-evaluate nil)

(setq org-pretty-entities t)

(setq system-time-locale "C")

;; make RET like C-j
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "<RET>") 'org-return-indent))

(provide 'init-org)
