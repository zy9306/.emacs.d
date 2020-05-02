;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package anaconda-mode
  :ensure t
  :defer t
  :ensure company-anaconda

  :diminish anaconda-mode

  :hook ((python-mode . anaconda-mode)
         (python-mode . anaconda-eldoc-mode))

  :config
  (require 'rx)
  (eval-after-load "company"
    '(add-to-list 'company-backends 'company-anaconda))

  (global-set-key (kbd "C-c M-r") 'anaconda-mode-find-references)

  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt"))


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


(defun my-python-mode-hook ()
  (modify-syntax-entry ?_ "w"))
(add-hook 'python-mode-hook 'my-python-mode-hook)


;; disable run-python binding
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-p"))))


;; todo maybe need highlight-indentation


(provide 'init-python)
