;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/mooz/js2-mode/tree/master
;; https://github.com/ananthakumaran/tide/tree/master

(require-package 'js2-mode)
(require-package 'tide)

(add-to-list 'auto-mode-alist '("\\.\\(js\\|es6\\)\\(\\.erb\\)?\\'" . js-mode))

(add-hook 'js-mode-hook 'js2-minor-mode)

(setq-default js2-basic-offset 2)

(add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))


(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-hook 'js-mode-hook #'setup-tide-mode)


(provide 'init-js-ts)
