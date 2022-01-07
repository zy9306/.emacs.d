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

  ;; Remove duplicate candidate.
  (add-to-list 'company-transformers #'delete-dups)

  (global-company-mode))

(local/after-init-hook 'company)


;;; config backends
;; https://manateelazycat.github.io/emacs/2021/06/30/company-multiple-backends.html

;; (defun local/config-company-backends ()
;;   (require 'company)
;;   (setq company-backends
;;         '((company-dabbrev
;;            company-dabbrev-code
;;            company-keywords
;;            company-files
;;            company-citre
;;            company-capf))))

(defun local/config-company-backends ()
  (require 'company)
  (setq company-backends
        '(
          (company-keywords company-files company-dabbrev company-dabbrev-code company-capf)
          ))

  ;; Add yasnippet support for all company backends.
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")

  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))

  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

  ;; Add `company-elisp' backend for elisp.
  (add-hook 'emacs-lisp-mode-hook
            #'(lambda ()
                (require 'company-elisp)
                (push 'company-elisp company-backends)))
  )


(with-eval-after-load 'company (local/config-company-backends))


;; 电脑性能的话不好不要加到 company-backends 里
(global-set-key (kbd "M-<RET>") 'company-tabnine)



;;; citre
;; https://github.com/universal-ctags/citre/wiki
(with-eval-after-load 'citre
  (require 'citre)
  (require 'citre-config)

  (setq-default citre-enable-imenu-integration nil)

  ;; make sure lsp at first
  (add-hook 'citre-mode-hook
            '(lambda ()   (dolist (xref-backend '(nox-xref-backend))
                            (if (member xref-backend xref-backend-functions)
                                (progn
                                  (setq xref-backend-functions (remove xref-backend xref-backend-functions))
                                  (add-to-list 'xref-backend-functions xref-backend))))))

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


;; Put company-citre before company-capf if you don't use the following
(defun lsp-citre-capf-function ()
  "A capf backend that tries lsp first, then Citre."
  (let ((lsp-result (nox-completion-at-point)))
    (if (and lsp-result
             (try-completion
              (buffer-substring (nth 0 lsp-result)
                                (nth 1 lsp-result))
              (nth 2 lsp-result)))
        lsp-result
      (citre-completion-at-point))))

(defun enable-lsp-citre-capf-backend ()
  "Enable the lsp + Citre capf backend in current buffer."
  (add-hook 'completion-at-point-functions #'lsp-citre-capf-function nil t))

(add-hook 'citre-mode-hook #'enable-lsp-citre-capf-backend)


(local/after-init-hook 'citre)



(provide 'init-completion)
