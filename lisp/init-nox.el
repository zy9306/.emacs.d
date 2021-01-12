;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/manateelazycat/nox
;; https://manateelazycat.github.io/emacs/nox/2020/03/29/nox.html

(push (expand-file-name "~/.emacs.d/repo/nox") load-path)

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

(dolist (hook (list
               'rust-mode-hook
               'go-mode-hook
               'python-mode-hook))
  (add-hook hook #'local/nox-ensure))

;; config mspyls
;; 1. nox-print-mspyls-download-url
;; 2. ~/.emacs.d/nox/mspyls/
;; 3. 保证这个目录下面可以直接找到 Microsoft.Python.LanguageServer 这个文件
;; 4. sudo chmod +x ~/.emacs.d/nox/mspyls
;; (setq nox-python-server-dir "~/.emacs.d/.cache/lsp/mspyls/")

(provide 'init-nox)
