;;; -*- coding: utf-8; lexical-binding: t; -*-


;; fork of eglot
;; https://github.com/manateelazycat/nox
;; https://manateelazycat.github.io/emacs/nox/2020/03/29/nox.html


(setq nox-optimization-p nil)
(setq nox-autoshutdown t)


(defun local/nox-xref ()
  (if (member 'nox-xref-backend xref-backend-functions)
      (progn
        (setq xref-backend-functions (remove 'nox-xref-backend xref-backend-functions))
        (add-to-list 'xref-backend-functions 'nox-xref-backend))))


(defun local/nox-ensure ()
  (nox-ensure)

  (local/nox-xref)
  (local/config-company-backends))



(provide 'init-nox)
