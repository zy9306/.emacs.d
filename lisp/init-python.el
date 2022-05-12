;;; lsp
(setenv "WORKON_HOME" "~/Envs")

(add-hook 'pyvenv-post-activate-hooks
          (lambda ()
            (setq nox-python-path (executable-find "python"))))

(setq nox-python-server "pyright")
(setq nox-python-server-dir (expand-file-name ".cache/lsp/mspyls/" user-emacs-directory))

(defun local/pyls ()
  (interactive)
  (let ((choices '("pyright" "mspyls")))
    (setq nox-python-server (completing-read "Swith to:" choices))))

;; (when (executable-find "pyright-langserver")
;;   (add-hook 'python-mode-hook 'local/lsp-python))


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

(when (or *linux* *mac*)
  (defun local/setup-flycheck-for-py ()
    (require 'flycheck)
    (add-to-list 'flycheck-disabled-checkers 'python-mypy)
    (let (
          (flake8 (executable-find "flake8"))
          )
      (when flake8
        (flycheck-select-checker 'python-flake8))
      ))

  (add-hook 'python-mode-hook #'local/setup-flycheck-for-py))


(provide 'init-python)
