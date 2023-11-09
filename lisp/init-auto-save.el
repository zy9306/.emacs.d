;;; -*- coding: utf-8; lexical-binding: t; -*-

                                        ; real-auto-save ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package real-auto-save
;;   :defer 10)
;; (with-eval-after-load 'real-auto-save
;;   (diminish 'real-auto-save-mode)
;;   (setq real-auto-save-interval 30)
;;   (dolist (hook '(text-mode-hook
;;                   python-mode-hook
;;                   go-mode-hook
;;                   yaml-mode-hook
;;                   conf-mode-hook
;;                   elisp-mode-hook))
;;     (add-hook hook 'real-auto-save-mode)))


                                        ; backup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; backup
(make-directory "~/.emacs.d/autosaves/" t)
(make-directory "~/.emacs.d/backups/" t)
(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/autosaves/" t)))
(setq version-control t)
(setq vc-make-backup-files t)
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq delete-by-moving-to-trash t)
(setq kept-old-versions 0)
(setq kept-new-versions 20)

(setq create-lockfiles nil)

(defun local/backup-on-save ()
  (let ((buffer-backed-up nil))
    (if (<= (buffer-size) (* 1 1024 1024))  ;; 1 MB
        (progn
          (message "Made per save backup of %s." (buffer-name))
          (backup-buffer))
      (message "WARNING: File %s too large to backup." (buffer-name)))))

(add-hook 'before-save-hook 'local/backup-on-save)

                                        ; auto-save ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'auto-save)
(auto-save-enable)
(setq auto-save-silent t)

(provide 'init-auto-save)
