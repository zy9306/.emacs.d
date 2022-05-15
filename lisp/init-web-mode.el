;;; -*- coding: utf-8; lexical-binding: t; -*-

(require-package 'typescript-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))

(add-hook 'js-mode-hook 'js2-minor-mode)

(setq js-indent-level 2)
(setq json-reformat:indent-width 2)
(setq css-indent-offset 2)


;;; deprecated
;;; tide (now use lsp-bridge instead)
;; (require-package 'web-mode)
;; (require-package 'tide)

;; (setq web-mode-css-indent-offset 2)

;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   (company-mode +1))

;; "*HTTP Response*" buffer 不要启用tide
;; (defun setup-tide-mode-patch ()
;;   (if (not (equal (buffer-name) "*HTTP Response*"))
;;       (setup-tide-mode)))

;; ;; aligns annotation to the right hand side
;; (setq company-tooltip-align-annotations t)

;; (add-hook 'typescript-mode-hook #'setup-tide-mode)

;; (add-hook 'js-mode-hook #'setup-tide-mode-patch)

;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))
;; (with-eval-after-load 'flycheck
;;   (flycheck-add-mode 'typescript-tslint 'web-mode))

;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "jsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))

;; (with-eval-after-load 'flycheck
;;   (require 'tide)
;;   (flycheck-add-mode 'javascript-eslint 'web-mode)
;;   (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append))


(provide 'init-web-mode)
