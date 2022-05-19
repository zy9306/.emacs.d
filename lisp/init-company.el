;;; option
(with-eval-after-load 'company
  (setq company-idle-delay 0.2)
  (setq company-tooltip-idle-delay 0.5)
  (setq company-minimum-prefix-length 1)
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


;;; backends
;; https://manateelazycat.github.io/emacs/2021/06/30/company-multiple-backends.html
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
            (lambda ()
              (require 'company-elisp)
              (push 'company-elisp company-backends))))

(with-eval-after-load 'company (local/config-company-backends))

;; 机器性能的话不好不要加到 company-backends 里
(global-set-key (kbd "M-<RET>") 'company-tabnine)


;;; 禁用 lsp-pyright 自动导入，通过参数好像禁用不掉
(defun company-transform-pyright (candidates)
  (mapcar (lambda (c)
            (let ((annotation
                   (ignore-errors
                     (company-capf--annotation c))))
              (if (and
                   annotation
                   (string-prefix-p
                    " Auto-import"
                    (company-capf--annotation c)))
                  (setq candidates (delete c candidates)))))
          candidates)
  candidates)


(add-hook 'python-mode-hook
          (lambda ()
            (setq-local company-transformers '(delete-dups company-transform-pyright))))


(provide 'init-company)
