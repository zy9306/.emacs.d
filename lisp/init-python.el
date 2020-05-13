;; -*- coding: utf-8; lexical-binding: t; -*-

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


;; https://github.com/emacs-lsp/lsp-python-ms

(use-package lsp-python-ms
  :ensure t
  :defer t
  :hook
  (python-mode . (lambda ()
                   (require 'lsp-python-ms)
                   (lsp)))  ; or lsp-deferred
  )


(defun mspyls-latest-nupkg-url ()
  ;; https://github.com/emacs-lsp/lsp-python-ms/blob/master/lsp-python-ms.el#L172
  ;; 进入python-mode时会自动下载mspyls，如果不能正常下载，手动获取url进行下载
  ;; 将下载的文件解压到~/.emacs.d/.cache/lsp/mspyls/
  ;; 二进制文件为~/.emacs.d/.cache/lsp/mspyls/Microsoft.Python.LanguageServer
  ;; 确实Microsoft.Python.LanguageServer在unix环境下有执行权限
  (interactive)
  (lsp)
  (message "%s" (lsp-python-ms-latest-nupkg-url "stable")))


(use-package pyvenv
  :ensure t
  :defer t
  :config
  (setenv "WORKON_HOME" "~/Envs"))


(use-package auto-virtualenv
  :ensure t
  :defer t
  :init
  ;; add .python-version file to project root, then add path of virtualenv eg:~/Envs/venv36/
  (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
  
  ;; Activate on changing buffers
  (add-hook 'window-configuration-change-hook 'auto-virtualenv-set-virtualenv)
  
  ;; Activate on focus in
  (add-hook 'focus-in-hook 'auto-virtualenv-set-virtualenv)
  
  ;; (add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv)
)


;; pip install yapf
(use-package yapfify
  :ensure t
  :diminish yapf-mode
  :defer t)
(global-set-key (kbd "C-c C-y") 'yapfify-region)


(use-package flycheck-pycheckers
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup))
  (setq flycheck-pycheckers-checkers '(flake8)))


(defun my-python-mode-hook ()
  (modify-syntax-entry ?_ "w"))
(add-hook 'python-mode-hook 'my-python-mode-hook)


;; disable run-python binding
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-p"))))

(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-l"))))


;; todo maybe need highlight-indentation

(use-package highlight-indent-guides
  :ensure t
  :defer t
  :config
  (setq highlight-indent-guides-method 'bitmap))
(global-set-key (kbd "C-c C-l") 'highlight-indent-guides-mode)


(provide 'init-python)
