;; -*- coding: utf-8; lexical-binding: t; -*-


;; dep
;; https://github.com/universal-ctags/ctags
;; or Exuberant-ctags (已经不在维护了)


(require-package 'company-ctags)  ;; for code navigation
(require-package 'counsel-etags)  ;; for code completion


;; https://github.com/redguardtoo/company-ctags
(with-eval-after-load 'company
  (setq company-ctags-fuzzy-match-p t)
  (company-ctags-auto-setup)

  (defun my-counsel-company ()
    "Input code from company backend using fuzzy matching."
    (interactive)
    (company-abort)
    (let* ((company-backends '(company-ctags))
           (company-ctags-fuzzy-match-p t))
      (counsel-company)))
  )


;; https://github.com/redguardtoo/counsel-etags
(with-eval-after-load 'counsel
  (require 'counsel-etags)
  (global-set-key (kbd "C-]") 'counsel-etags-find-tag-at-point)
  (add-hook 'prog-mode-hook
        (lambda ()
          (add-hook 'after-save-hook
                    'counsel-etags-virtual-update-tags 'append 'local)))
  (setq counsel-etags-update-interval 60)
  (push "build" counsel-etags-ignore-directories)
  )


;; disabled emacs etags ask for add tables
(setq tags-add-tables nil)

(provide 'init-code)
