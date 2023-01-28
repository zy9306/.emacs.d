;;; lsp
(setenv "WORKON_HOME" "~/Envs")

;;; key
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-p"))))
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-l"))))
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-f"))))

(global-set-key (kbd "C-c C-y") 'yapfify-region)
(global-set-key (kbd "C-c C-b") 'python-black-region)

;;; utils
(defun local/pytest-shanbay-flask ()
  (interactive)
  (require 'pytest)
  (let* ((test-project-root (pytest-find-project-root))
         (test-obj (pytest-py-testable))
         (test-cmd (format "FLASK_ENV=testing PROC_ENV=flask flask test -s --no-cov %s" test-obj)))
    (setq default-directory test-project-root)
    (message test-cmd)
    (async-shell-command test-cmd "*python-test-flask*")))

(defun local/pytest-shanbay-sea ()
  (interactive)
  (require 'pytest)
  (let* ((test-project-root (pytest-find-project-root))
         (test-obj (pytest-py-testable))
         (test-cmd (format "FLASK_ENV=testing PROC_ENV=sea sea test -s --no-cov %s" test-obj)))
    (setq default-directory test-project-root)
    (message test-cmd)
    (async-shell-command test-cmd "*python-test-sea*")))

(defun local/pdb-current-test ()
  (interactive)
  (require 'pytest)
  (let* ((test-project-root (pytest-find-project-root))
         (test-obj (pytest-py-testable))
         (test-runner (pytest-find-test-runner))
         (test-cmd (format "%s %s %s" test-runner pytest-cmd-flags test-obj))
         )
    (setq default-directory test-project-root)
    (message test-cmd)
    (pdb test-cmd)))

(defun local/pytest-test-path ()
  (interactive)
  (require 'pytest)
  (let* ((test-project-root (pytest-find-project-root))
         (test-obj (pytest-py-testable))
         (relative-test-obj (string-trim-left test-obj test-project-root)))
    (message relative-test-obj)
    (kill-new relative-test-obj)))

(defun local/setup-flycheck-for-py ()
  (require 'flycheck)
  (dolist (checker (list
                    'python-mypy
                    'python-pycompile
                    'python-pyright
                    'python-pylint
                    ))
    (add-to-list 'flycheck-disabled-checkers checker))
  (local/setup-flycheck-ruff)
  )

;; https://github.com/flycheck/flycheck/issues/1974
(defun local/setup-flycheck-ruff ()
  (flycheck-define-checker python-ruff
    "A Python syntax and style checker using the ruff utility.
To override the path to the ruff executable, set
`flycheck-python-ruff-executable'.
See URL `http://pypi.python.org/pypi/ruff'."
    :command ("ruff"
              "--format=text"
              (eval (when buffer-file-name
                      (concat "--stdin-filename=" buffer-file-name)))
              "-")
    :standard-input t
    :error-filter (lambda (errors)
                    (let ((errors (flycheck-sanitize-errors errors)))
                      (seq-map #'flycheck-flake8-fix-error-level errors)))
    :error-patterns
    ((warning line-start
              (file-name) ":" line ":" (optional column ":") " "
              (id (one-or-more (any alpha)) (one-or-more digit)) " "
              (message (one-or-more not-newline))
              line-end))
    :modes python-mode)

  (add-to-list 'flycheck-disabled-checkers 'python-flake8)

  (add-to-list 'flycheck-checkers 'python-ruff))

(add-hook 'python-mode-hook #'local/setup-flycheck-for-py)

(provide 'init-python)
