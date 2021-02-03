;; -*- coding: utf-8; lexical-binding: t; -*-


;; start hooks
;; eglot
;; (add-hook 'go-mode-hook #'local/eglot-ensure)
;; nox
(add-hook 'python-mode-hook #'local/nox-ensure)
(add-hook 'rust-mode-hook #'local/nox-ensure)
(add-hook 'go-mode-hook #'local/nox-ensure)
;; end hooks 



;; start eglot
(defun local/eglot-server-programs ()
  (require 'eglot)

  (defvar local/eglot-pyright-langserver '(python-mode . ("pyright-langserver" "--stdio")))
  (if (not (member local/eglot-pyright-langserver eglot-server-programs))
      (add-to-list 'eglot-server-programs local/eglot-pyright-langserver)))

(defun local/eglot-ensure ()
  (local/eglot-server-programs)
  (setq eldoc-echo-area-use-multiline-p nil)
  (flycheck-mode -1)
  (eglot-ensure))
;; end eglot 



;; start nox 
;; fork of eglot
;; https://github.com/manateelazycat/nox
;; https://manateelazycat.github.io/emacs/nox/2020/03/29/nox.html
(defun local/nox-ensure ()
  ;; 自行设置 gc-cons-threshold，不通过 nox
  (setq nox-optimization-p nil)
  (setq nox-autoshutdown t)
  ;; sudo npm install -g pyright
  (setq nox-python-server "pyright")
  (add-hook 'pyvenv-post-activate-hooks
            '(lambda ()
               (setq nox-python-path (executable-find "python"))))
  (nox-ensure)
  (local/config-company-backends))

;; config mspyls
;; 1. nox-print-mspyls-download-url
;; 2. ~/.emacs.d/nox/mspyls/
;; 3. 保证这个目录下面可以直接找到 Microsoft.Python.LanguageServer 这个文件
;; (setq nox-python-server-dir "~/.emacs.d/.cache/lsp/mspyls/")
;; end nox



(provide 'init-eglot)
