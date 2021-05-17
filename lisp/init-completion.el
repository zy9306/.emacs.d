;;; -*- coding: utf-8; lexical-binding: t; -*-


(with-eval-after-load 'company
  (setq company-idle-delay 0.2)
  (setq company-tooltip-idle-delay 0.5)
  (setq company-minimum-prefix-length 3)
  (setq company-require-match nil)
  (setq company-dabbrev-downcase nil)  ;; 补全时不要忽略大小写
  (setq company-dabbrev-ignore-case nil)
  (setq company-show-numbers t)

  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-other-backend)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "M-v") 'company-previous-page)
  (define-key company-active-map (kbd "C-v") 'company-next-page)

  (global-company-mode))

(local/after-init-hook 'company)

(defun local/config-company-backends ()
  (require 'company)
  (setq company-backends
        '(company-capf
          company-tabnine
          (company-dabbrev company-dabbrev-code)
          company-keywords
          company-files)))

(with-eval-after-load 'company (local/config-company-backends))


(global-set-key (kbd "M-<RET>") 'company-tabnine)


(provide 'init-completion)
