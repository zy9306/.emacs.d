;;; init-elpa.el --- Settings and helpers for package.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; copy from https://github.com/bbatsov/prelude/blob/master/core/prelude-packages.el
;; and https://github.com/purcell/emacs.d/blob/master/lisp/init-elpa.el

(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defvar local/packages
  '(
    )
  "A list of packages to ensure are installed at launch.")

(let ((versioned-package-dir
       (expand-file-name (format "elpa-%s.%s" emacs-major-version emacs-minor-version)
                         user-emacs-directory)))
  (setq package-user-dir versioned-package-dir))

(setq package-enable-at-startup nil)
(package-initialize)

(setq package-archives
      '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(defun local/packages-installed-p ()
  "Check if all packages in `local/packages' are installed."
  (every #'package-installed-p local/packages))

(defun local/require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package local/packages)
    (add-to-list 'local/packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun local/require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'local/require-package packages))

(define-obsolete-function-alias 'local/ensure-module-deps 'local/require-packages)

(defun local/install-packages ()
  "Install all packages listed in `local/packages'."
  (unless (local/packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (local/require-packages local/packages)))

;; run package installation
(local/install-packages)


(provide 'init-package)
