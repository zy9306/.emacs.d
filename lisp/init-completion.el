;; -*- coding: utf-8; lexical-binding: t; -*-

(require-package 'company)
(require-package 'company-tabnine)
;; (require-package 'company-prescient)

(defun local/config-company-backends ()
  (require 'company)

  (if (not (member '(company-capf :with company-tabnine :separate) company-backends))
      (push '(company-capf :with company-tabnine :separate) company-backends)
    )

  )

(with-eval-after-load 'company
  (setq company-idle-delay 0.05)
  (setq company-tooltip-idle-delay 0.05)
  (setq company-minimum-prefix-length 1)
  (setq company-require-match nil)
  ;; 补全时不要忽略大小写
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case nil)
  (setq company-show-numbers t)
  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-other-backend)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "M-v") 'company-previous-page)
  (define-key company-active-map (kbd "C-v") 'company-next-page)
  (global-company-mode)
  ;; (company-prescient-mode)

  (local/config-company-backends)

  )

(local/after-init-hook 'company)

(provide 'init-completion)
