;; -*- coding: utf-8; lexical-binding: t; -*-

;; set package dir, should before (package-initialize)
(let ((versioned-package-dir
       (expand-file-name (format "elpa-%s.%s" emacs-major-version emacs-minor-version)
                         user-emacs-directory)))
  (setq package-user-dir versioned-package-dir))

;; usually no need melpa-stable
;; todo tsinghua mirrors Failed to download ‘melpa’ archive
(setq package-archives
      '(;; ("localelpa" . "~/.emacs.d/localelpa/")
        ;; ("gnu" . "https://elpa.gnu.org/packages/")
        ;; ("melpa" . "https://melpa.org/packages/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")

        ;; Use either 163 or tsinghua mirror repository when official melpa
        ;; is too slow or shutdown.

        ("gnu" . "https://mirrors.163.com/elpa/gnu/")
        ("melpa" . "https://mirrors.163.com/elpa/melpa/")
        ;; ("melpa-stable" . "https://mirrors.163.com/elpa/melpa-stable/")

        ;; @see https://mirror.tuna.tsinghua.edu.cn/help/elpa/ on usage:
        ;; ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ;; ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ;; ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
))

(package-initialize)

(defun require-package (package &optional min-version no-refresh)
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
	(require-package package min-version t)))))

;; config use-package
;; This is only needed once, near the top of the file
(require-package 'use-package)
(eval-when-compile
  (require 'use-package))

(provide 'init-elpa)
