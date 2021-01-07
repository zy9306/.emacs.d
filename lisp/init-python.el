;; -*- coding: utf-8; lexical-binding: t; -*-

(setenv "WORKON_HOME" "~/Envs")

(defun my-python-mode-hook ()
  (modify-syntax-entry ?_ "w"))
(add-hook 'python-mode-hook 'my-python-mode-hook)


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

(provide 'init-python)
