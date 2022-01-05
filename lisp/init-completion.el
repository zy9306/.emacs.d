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


;; https://manateelazycat.github.io/emacs/2021/06/30/company-multiple-backends.html

(defun local/config-company-backends ()
  (require 'company)
  (setq company-backends
        '((company-dabbrev
           company-dabbrev-code
           company-keywords
           company-files
           company-citre
           company-capf))))

(with-eval-after-load 'company (local/config-company-backends))


;; 电脑性能的话不好不要加到 company-backends 里
(global-set-key (kbd "M-<RET>") 'company-tabnine)


;;; citre
;; https://github.com/universal-ctags/citre/wiki
(with-eval-after-load 'citre
  (require 'citre)
  (require 'citre-config)

  (define-advice xref--create-fetcher (:around (-fn &rest -args) fallback)
    (let ((fetcher (apply -fn -args))
          (citre-fetcher
           (let ((xref-backend-functions '(citre-xref-backend t)))
             (apply -fn -args))))
      (lambda ()
        (or (with-demoted-errors "%s, fallback to citre"
              (funcall fetcher))
            (funcall citre-fetcher)))))

  (defun my--push-point-to-xref-marker-stack (&rest r)
    (xref-push-marker-stack (point-marker)))

  (dolist (func '(find-function
                  counsel-imenu
                  projectile-grep
                  projectile-ripgrep
                  counsel-rg
                  citre-jump))
    (advice-add func :before 'my--push-point-to-xref-marker-stack)))


(defun company-citre (-command &optional -arg &rest _ignored)
  (interactive (list 'interactive))
  (cl-case -command
    (interactive (company-begin-backend 'company-citre))
    (prefix (and (bound-and-true-p citre-mode)
                 (or (citre-get-symbol) 'stop)))
    (meta (citre-get-property 'signature -arg))
    (annotation (citre-capf--get-annotation -arg))
    (candidates (all-completions -arg (citre-capf--get-collection -arg)))
    (ignore-case (not citre-completion-case-sensitive))))


(local/after-init-hook 'citre)



(provide 'init-completion)
