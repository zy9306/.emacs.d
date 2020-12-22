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

(defun local/nox-ensure ()
  (nox-ensure)
  (local/config-company-backends)
  )

(use-package nox
  :ensure posframe
  :config
  ;; 自行设置 gc-cons-threshold，不通过 nox
  (setq nox-optimization-p nil)
  (setq nox-autoshutdown t)
  (setq nox-python-server-dir "~/.emacs.d/.cache/lsp/mspyls/")

  (add-hook 'pyvenv-post-activate-hooks '(lambda () (setq nox-python-path (executable-find "python"))))

  (dolist (hook (list
                 'rust-mode-hook
                 'go-mode-hook
                 ))
    (add-hook hook '(lambda () (local/nox-ensure))))
  )

(provide 'init-nox)
