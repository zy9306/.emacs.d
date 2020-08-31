;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://github.com/emacs-lsp/lsp-python-ms

(require-package 'lsp-python-ms)
(require-package 'pyvenv)
(require-package 'auto-virtualenv)
(require-package 'yapfify)
(require-package 'flycheck-pycheckers)

(setenv "WORKON_HOME" "~/Envs")

(with-eval-after-load 'python
  (require 'lsp-python-ms)
  (require 'pyvenv)
  (require 'yapfify)
  (yapf-mode)
  (add-hook 'python-mode-hook 'lsp-deferred)
  )

;; (with-eval-after-load 'flycheck
;;   (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup)
;;   (setq flycheck-pycheckers-checkers '(flake8)))

;; (with-eval-after-load 'auto-virtualenv
;;   ;; add .python-version file to project root, then add path of virtualenv eg:~/Envs/venv36/
;;   (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
;;   ;; Activate on changing buffers
;;   (add-hook 'window-configuration-change-hook 'auto-virtualenv-set-virtualenv)
;;   ;; Activate on focus in
;;   (add-hook 'focus-in-hook 'auto-virtualenv-set-virtualenv)
;;   ;; (add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv)
;;   )

(defun my-python-mode-hook ()
  (modify-syntax-entry ?_ "w"))
(add-hook 'python-mode-hook 'my-python-mode-hook)

(defun mspyls-latest-nupkg-url ()
  ;; https://github.com/emacs-lsp/lsp-python-ms/blob/master/lsp-python-ms.el#L172
  ;; 进入python-mode时会自动下载mspyls，如果不能正常下载，手动获取url进行下载
  ;; 将下载的文件解压到~/.emacs.d/.cache/lsp/mspyls/
  ;; 二进制文件为~/.emacs.d/.cache/lsp/mspyls/Microsoft.Python.LanguageServer
  ;; 确实Microsoft.Python.LanguageServer在unix环境下有执行权限
  (interactive)
  (lsp)
  (message "%s" (lsp-python-ms-latest-nupkg-url "stable")))


;; anaconda-mode old config

;; (use-package anaconda-mode
;;   :ensure t
;;   :defer t
;;   :ensure company-anaconda

;;   :diminish anaconda-mode

;;   :hook ((python-mode . anaconda-mode)
;;          (python-mode . anaconda-eldoc-mode))

;;   :config
;;   (require 'rx)
;;   (eval-after-load "company"
;;     '(add-to-list 'company-backends 'company-anaconda))

;;   (global-set-key (kbd "C-c M-r") 'anaconda-mode-find-references)

;;   (setq python-shell-interpreter "ipython"
;;         python-shell-interpreter-args "-i --simple-prompt"))

(provide 'init-python)
