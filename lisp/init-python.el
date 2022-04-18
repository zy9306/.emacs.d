;;; -*- coding: utf-8; lexical-binding: t; -*-

(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-p"))))
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-l"))))
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-f"))))


(setenv "WORKON_HOME" "~/Envs")

;;; START NOX

(add-hook 'pyvenv-post-activate-hooks
          (lambda ()
            (setq nox-python-path (executable-find "python"))))

;; For pyright
;; sudo npm install -g pyright
(setq nox-python-server "pyright")

;; For mspyls
;; nox-print-mspyls-download-url and download then extract to nox-python-server-dir
(setq nox-python-server-dir (expand-file-name ".cache/lsp/mspyls/" user-emacs-directory))

;; Switch pyls
(defun local/pyls ()
  (interactive)
  (let ((choices '("pyright" "mspyls")))
    (setq nox-python-server (completing-read "Swith to:" choices))))

;; (when (executable-find "pyright-langserver")
;;   (add-hook 'python-mode-hook 'local/nox-ensure))


(when (executable-find "pyright-langserver")
  (add-hook 'python-mode-hook #'local/lsp-python))

;;; END NOX


;;; keybindings
(global-set-key (kbd "C-c C-y") 'yapfify-region)
(global-set-key (kbd "C-c C-b") 'python-black-region)


(defun local/pytest-original-cmd ()
  (interactive)
  (setq pytest-global-name "py.test --no-cov")
  (message pytest-global-name))


(defun local/pytest-shanbay-flask ()
  (interactive)
  (setenv "PROC_ENV" "flask")
  (setq pytest-global-name "flask test --no-cov")
  (message pytest-global-name))


(defun local/pytest-shanbay-sea ()
  (interactive)
  (setenv "PROC_ENV" "sea")
  (setq pytest-global-name "sea test --no-cov")
  (message pytest-global-name))


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


;; copy test function path for pytest
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
    (add-to-list 'flycheck-disabled-checkers 'python-mypy)
    (let (
          (flake8 (executable-find "flake8"))
          )
      (when flake8
        (flycheck-select-checker 'python-flake8))
      ))

  (add-hook 'python-mode-hook #'local/setup-flycheck-for-py))


(provide 'init-python)
