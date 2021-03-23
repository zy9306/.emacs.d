;; -*- coding: utf-8; lexical-binding: t; -*-


(defun local/apheleia-mode ()
  (require 'apheleia)
  (apheleia-mode)
  (diminish 'apheleia-mode))


;;; START golang

;; 实时保存可能会造成卡顿
;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun local/go-mode-save-hooks ()
  (setq gofmt-show-errors 'echo)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

(with-eval-after-load 'apheleia
  (setf (alist-get 'gofmt apheleia-formatters) '("goimports")))

(add-hook 'go-mode-hook #'local/go-mode-save-hooks)

;; TODO 异步，性能较好，但有一定概率导致当前 buffer 被关闭
;; (add-hook 'go-mode-hook #'local/apheleia-mode)

;;; END golang


;;; START python

;; (add-hook 'python-mode-hook #'local/apheleia-mode)

;;; END python

(provide 'init-formatter)
