;;; -*- coding: utf-8; lexical-binding: t; -*-


;;; START HOOKS

;; EGLOT

;; (add-hook 'go-mode-hook #'local/eglot-ensure)

;; NOX

(add-hook 'python-mode-hook #'local/nox-ensure)
(add-hook 'rust-mode-hook #'local/nox-ensure)
(add-hook 'go-mode-hook #'local/nox-ensure)

;; END HOOKS 



;;; START EGLOT

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

;;; END EGLOT 



;;; START NOX 
;; fork of eglot
;; https://github.com/manateelazycat/nox
;; https://manateelazycat.github.io/emacs/nox/2020/03/29/nox.html

(setq nox-optimization-p nil)
(setq nox-autoshutdown t)
(add-hook 'pyvenv-post-activate-hooks
          '(lambda ()
             (setq nox-python-path (executable-find "python"))))

(defun local/nox-ensure ()
  (nox-ensure)
  (local/config-company-backends))

;; for pyright
;; sudo npm install -g pyright
(setq nox-python-server "pyright")

;; for mspyls
;; nox-print-mspyls-download-url and download then extract to nox-python-server-dir
(setq nox-python-server-dir (expand-file-name ".cache/lsp/mspyls/" user-emacs-directory))


;; switch pyls
(defun local/pyls ()
  (interactive)
  (let (
        (choices '("pyright" "mspyls"))
        )
    (setq nox-python-server (completing-read "Swith to:" choices)))
  )



;;; END NOX



(provide 'init-eglot)
