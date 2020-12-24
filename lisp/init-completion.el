;; -*- coding: utf-8; lexical-binding: t; -*-

;; company-fuzzy 比较卡，会将所有 backends 放一起，无效结果多，
;; company-flx 只对 company-capf 起作用
;; 可以尝试下 ycmd

(require-package 'company)
(require-package 'company-tabnine)
(require-package 'company-flx)
(require-package 'company-fuzzy)
(require-package 'company-prescient)


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

(with-eval-after-load 'company
  (setq company-flx-limit 100)
  (company-flx-mode +1))

;; (with-eval-after-load 'company (company-prescient-mode))


;; START tabnine company-transformers
;; https://emacs-china.org/t/tabnine/9988/40

;; 有性能问题 company-tabnine 和 company-capf 同时用的话

;; (defun local/company-sort-by-tabnine (candidates)
;;   (if (or (functionp company-backend)
;;           (not (and (listp company-backend) (memq 'company-tabnine company-backend))))
;;       candidates
;;     (let ((candidates-table (make-hash-table :test #'equal))
;;           candidates-1
;;           candidates-2)
;;       (dolist (candidate candidates)
;;         (if (eq (get-text-property 0 'company-backend candidate)
;;                 'company-tabnine)
;;             (unless (gethash candidate candidates-table)
;;               (push candidate candidates-2))
;;           (push candidate candidates-1)
;;           (puthash candidate t candidates-table)))
;;       (setq candidates-1 (nreverse candidates-1))
;;       (setq candidates-2 (nreverse candidates-2))
;;       (nconc (seq-take candidates-1 2)
;;              (seq-take candidates-2 2)
;;              (seq-drop candidates-1 2)
;;              (seq-drop candidates-2 2)))))

;; (defun local/config-company-backends ()
;;   (require 'company)
;;   ;; `:separate` 使得不同 backend 分开排序
;;   (if (not (member '(company-capf :with company-tabnine :separate) company-backends))
;;       (push '(company-capf :with company-tabnine :separate) company-backends)
;;     )
;;   )

;; (with-eval-after-load 'company (add-to-list 'company-transformers 'local/company-sort-by-tabnine t))
;; END tabnine

(provide 'init-completion)
