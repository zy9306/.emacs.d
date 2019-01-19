;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package anaconda-mode
  :ensure t
  :ensure company-anaconda

  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode)

  (require 'rx)
  (eval-after-load "company"
    '(add-to-list 'company-backends 'company-anaconda))

  (global-set-key (kbd "C-c M-r") 'anaconda-mode-find-references)

  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt")
  )


(use-package pyvenv
  :ensure t

  :config
  (setenv "WORKON_HOME" "~/Envs"))


(use-package auto-virtualenv
  :ensure t

  :init
  ;; add .python-version file to project root, then add path of virtualenv eg:~/Envs/venv36/
  (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
  
  ;; Activate on changing buffers
  (add-hook 'window-configuration-change-hook 'auto-virtualenv-set-virtualenv)
  
  ;; Activate on focus in
  (add-hook 'focus-in-hook 'auto-virtualenv-set-virtualenv)
  
  ;; (add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv)
)


(defun my-python-mode-hook ()
  (modify-syntax-entry ?_ "w"))
(add-hook 'python-mode-hook 'my-python-mode-hook)


;; todo maybe need highlight-indentation


(provide 'init-python)
