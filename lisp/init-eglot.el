;;; -*- coding: utf-8; lexical-binding: t; -*-


;;; START NOX 
;; fork of eglot
;; https://github.com/manateelazycat/nox
;; https://manateelazycat.github.io/emacs/nox/2020/03/29/nox.html

(setq nox-optimization-p nil)
(setq nox-autoshutdown t)

(defun local/nox-ensure ()
  (nox-ensure)
  (local/config-company-backends))
;;; END NOX



;;; START EGLOT
;; (defun local/eglot-server-programs ()
;;   (require 'eglot)

;;   (defvar local/eglot-pyright-langserver '(python-mode . ("pyright-langserver" "--stdio")))
;;   (if (not (member local/eglot-pyright-langserver eglot-server-programs))
;;       (add-to-list 'eglot-server-programs local/eglot-pyright-langserver)))

;; (defun local/eglot-ensure ()
;;   (local/eglot-server-programs)
;;   (setq eldoc-echo-area-use-multiline-p nil)
;;   (flycheck-mode -1)
;;   (eglot-ensure))
;;; END EGLOT 



(provide 'init-eglot)
