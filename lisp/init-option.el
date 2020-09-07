;; -*- coding: utf-8; lexical-binding: t; -*-


(setq gc-cons-percentage 0.1)

;; https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold (* 100 1024 1024)) ;; 100mb

;; read-process-output-max is only available on recent
;; development builds of Emacs 27 and above
(when (boundp 'read-process-output-max)
  (setq read-process-output-max (* 1024 1024)))

;; don't ask me "Active processes exist; kill them and exit anyway?"
(setq-default confirm-kill-processes nil)


;; Suppress GUI features
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
;; Show a marker in the left fringe for lines not in the buffer
(setq indicate-empty-lines t)

;; NO tool bar
(if (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
;; no scroll bar
(if (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))
;; no menu bar
(if (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

;; set frame title to filename with short path
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(setq-default cursor-type 'box)  ;; box 方块


(delete-selection-mode t)
(electric-pair-mode t)
(push '(?\' . ?\') electric-pair-pairs)
(push '(?\" . ?\") electric-pair-pairs)
(push '(?` . ?`) electric-pair-pairs)

(show-paren-mode t)
(column-number-mode t)
(global-hl-line-mode t)

(set-default 'truncate-lines t)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; TODO: this don't work
(setq show-paren-when-point-inside-paren t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(when *mac*
  ;; Prefer g-prefixed coreutils version of standard utilities when available
  ;; brew install coreutils for mac
  (let ((gls (executable-find "/usr/local/bin/gls")))
    (when gls (setq insert-directory-program "/usr/local/bin/gls")))
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none)
  (global-set-key (kbd "M-ƒ") 'toggle-frame-fullscreen))

(when *win*
  ;; need git bash mingw environment
  ;; https://git-scm.com/download/win
  (setq ls-lisp-use-insert-directory-program t)
  (setq insert-directory-program "C:/Program Files/Git/usr/bin/ls.exe"))

(setq dired-listing-switches "-al -h --group-directories-first --color=auto")

;; backup
(make-directory "~/.emacs.d/autosaves/" t)
(make-directory "~/.emacs.d/backups/" t)
(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/autosaves/" t)))

;; read-only
(dir-locals-set-class-variables 'read-only
 '((nil . ((buffer-read-only . t)))))
(dolist (dir (list "~/Envs"
                   "/usr"
                   "~/.cargo"
                   "~/.rustup"
                   "/Library/Frameworks/Python.framework"))
  (dir-locals-set-directory-class (file-truename dir) 'read-only))

;; revert settings
;; (auto-revert-mode t)
(global-auto-revert-mode t)
(setq auto-revert-check-vc-info t)


(provide 'init-option)