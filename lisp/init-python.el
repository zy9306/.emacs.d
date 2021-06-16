;; -*- coding: utf-8; lexical-binding: t; -*-

(setenv "WORKON_HOME" "~/Envs")

;; (with-eval-after-load 'auto-virtualenv
;;   ;; add .python-version file to project root, then add path of virtualenv eg:~/Envs/venv36/
;;   (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
;;   ;; Activate on changing buffers
;;   (add-hook 'window-configuration-change-hook 'auto-virtualenv-set-virtualenv)
;;   ;; Activate on focus in
;;   (add-hook 'focus-in-hook 'auto-virtualenv-set-virtualenv)
;;   ;; (add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv)
;;   )


;; 下载 Microsoft.Python.LanguageServer
;; nox 也有类似的函数
;; (defun mspyls-latest-nupkg-url ()
;;   ;; https://github.com/emacs-lsp/lsp-python-ms/blob/master/lsp-python-ms.el#L172
;;   ;; 进入python-mode时会自动下载mspyls，如果不能正常下载，手动获取url进行下载
;;   ;; 将下载的文件解压到~/.emacs.d/.cache/lsp/mspyls/
;;   ;; 二进制文件为~/.emacs.d/.cache/lsp/mspyls/Microsoft.Python.LanguageServer
;;   ;; 确实Microsoft.Python.LanguageServer在unix环境下有执行权限
;;   (interactive)
;;   (lsp)
;;   (message "%s" (lsp-python-ms-latest-nupkg-url "stable")))


;; START anaconda-mode
;; (use-package anaconda-mode
;;   :ensure t
;;   :defer t
;;   :ensure company-anaconda

;;   :diminish anaconda-mode

;;   :hook ((python-mode . anaconda-mode)
;;          )

;;   :config
;;   (require 'rx)
;;   (eval-after-load "company"
;;     '(add-to-list 'company-backends 'company-anaconda))

;;   (global-set-key (kbd "C-c M-r") 'anaconda-mode-find-references)

;;   (setq anaconda-eldoc-mode nil)
;;   )
;; END anaconda-mode


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


(provide 'init-python)
