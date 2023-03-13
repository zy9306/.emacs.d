;;; -*- coding: utf-8; lexical-binding: t; -*-

(defconst *mac* (eq system-type 'darwin))
(defconst *win* (eq system-type 'windows-nt))
(defconst *cygwin* (eq system-type 'cygwin))
(defconst *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)))
(defconst *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)))

(if *win*
    (progn
      (defconst *python* (expand-file-name ".venv/Scripts/python.exe" user-emacs-directory))
      (defconst *pip* (expand-file-name ".venv/Scripts/pip.exe" user-emacs-directory)))
  (progn
    (defconst *python* (expand-file-name ".venv/bin/python" user-emacs-directory))
    (defconst *pip* (expand-file-name ".venv/bin/pip" user-emacs-directory))))


(provide 'init-constant)
