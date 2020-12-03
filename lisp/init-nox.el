;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/manateelazycat/nox
;; https://manateelazycat.github.io/emacs/nox/2020/03/29/nox.html

;; config mspyls

;; 1. nox-print-mspyls-download-url
;; 2. ~/.emacs.d/nox/mspyls/
;; 3. 保证这个目录下面可以直接找到 Microsoft.Python.LanguageServer 这个文件
;; 4. sudo chmod +x ~/.emacs.d/nox/mspyls

;; 如果要切换回 pyls ， 直接设置 (setq nox-python-server “pyls”) 即可


(require-package 'posframe)


(require 'nox)

(setq nox-autoshutdown t)

(dolist (hook (list
               'rust-mode-hook
               'python-mode-hook
               'sh-mode-hook
               'go-mode-hook
               ))
  (add-hook hook '(lambda () (nox-ensure))))


;; python


(setq nox-python-server-dir "~/.emacs.d/.cache/lsp/mspyls/")

(add-hook 'pyvenv-post-activate-hooks '(lambda () (setq nox-python-path (executable-find "python"))))


(provide 'init-nox)
