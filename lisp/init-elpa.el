;; -*- coding: utf-8; lexical-binding: t; -*-

;; set package dir, should before (package-initialize)
(let ((versioned-package-dir
       (expand-file-name (format "elpa-%s.%s" emacs-major-version emacs-minor-version)
                         user-emacs-directory)))
  (setq package-user-dir versioned-package-dir))

(defun initialize-package ()
  (unless nil ;package--initialized
    ;; optimization, no need to activate all the packages so early
    (setq package-enable-at-startup nil)
    (package-initialize)))

(initialize-package)

;; https://mirrors.tuna.tsinghua.edu.cn/help/elpa/
;; https://elpa.gnu.org/packages/
;; https://melpa.org/packages/
;; or use local
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; On-demand installation of packages
(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (cond
   ((package-installed-p package min-version)
    t)
   ((or (assoc package package-archive-contents) no-refresh)
    (package-install package))
   (t
    (package-refresh-contents)
    (require-package package min-version t))))

;; config use-package
;; This is only needed once, near the top of the file
(require-package 'use-package)
(eval-when-compile
  (require 'use-package))

(provide 'init-elpa)
