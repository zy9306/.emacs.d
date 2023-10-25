;;; -*- coding: utf-8; lexical-binding: t; -*-

(setq gc-cons-percentage 0.1)
;; 100mb
(setq gc-cons-threshold (* 100 1024 1024))

(when (boundp 'read-process-output-max)
  (setq read-process-output-max (* 1024 1024)))

;; 设置 emacs-lisp 的限制
(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 10000)


;; long line
(setq-default bidi-display-reordering nil)
(setq bidi-inhibit-bpa t
      long-line-threshold 1000
      large-hscroll-threshold 1000
      syntax-wholeline-max 1000)


;; fringe
(set-face-attribute
 'fringe nil
 :background "gray94")


;; (setq mouse-drag-copy-region t)

(setq xref-history-storage 'xref-window-local-history)

;; (add-hook 'after-init-hook 'pixel-scroll-precision-mode)


(setq original-y-or-n-p 'y-or-n-p)
(defalias 'original-y-or-n-p (symbol-function 'y-or-n-p))
(defun default-yes-sometimes (prompt)
  "automatically say y when buffer name match following string"
  (if (or
       (string-match "has a running process" prompt)
       (string-match "does not exist; create" prompt)
       (string-match "modified; kill anyway" prompt)
       (string-match "Delete buffer using" prompt)
       (string-match "Kill buffer of" prompt)
       (string-match "still connected.  Kill it?" prompt)
       (string-match "Shutdown the client's kernel" prompt)
       (string-match "kill them and exit anyway" prompt)
       (string-match "Revert buffer from file" prompt)
       (string-match "Kill Dired buffer of" prompt)
       (string-match "delete buffer using" prompt)
       (string-match "Kill all pass entry" prompt))
      t
    (original-y-or-n-p prompt)))
(defalias 'yes-or-no-p 'default-yes-sometimes)
(defalias 'y-or-n-p 'default-yes-sometimes)

;; don't ask me "Active processes exist; kill them and exit anyway?"
(setq-default confirm-kill-processes nil)

(setq warning-suppress-types '((comp)))

;; register
(setq register-preview-delay 0)

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

(set-default 'message-truncate-lines t)

(when (version<= "26.0.50" emacs-version)
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode))


;; version>=28
(setq dired-kill-when-opening-new-dired-buffer nil)


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
  (setq mac-option-modifier 'super)
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


;; read-only
(dir-locals-set-class-variables 'read-only
                                '((nil . ((buffer-read-only . t)))))
(dolist (dir (list "~/Envs"
                   "/usr"
                   "~/.cargo"
                   "~/.rustup"
                   "/Library/Frameworks/Python.framework"
                   "/nix"))
  (dir-locals-set-directory-class (file-truename dir) 'read-only))

;; revert settings
;; profiler 测试发现比较耗 cpu
(setq auto-revert-check-vc-info t)
(add-hook 'prog-mode (lambda () (auto-revert-mode 1)))


;; buildin command keybinding

(global-set-key (kbd "C-;") 'set-mark-command)


;; set persist file
;; NOTE: expand-file-name 比直接设置路径要慢
(setq local/persist-dir (expand-file-name ".persist" user-emacs-directory))
(setq tramp-persistency-file-name (expand-file-name "tramp" local/persist-dir))
(setq bookmark-default-file (expand-file-name "bookmarks" local/persist-dir))
(setq recentf-save-file (expand-file-name "recentf" local/persist-dir))
(setq smex-save-file (expand-file-name ".smex-items" local/persist-dir))
(setq mc/list-file (expand-file-name ".mc-lists.el" local/persist-dir))
(setq projectile-cache-file (expand-file-name "projectile.cache" local/persist-dir))
(setq projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" local/persist-dir))
(setq lsp-session-file (expand-file-name ".lsp-session-v1" local/persist-dir))
(setq vimish-fold-dir (expand-file-name "vimish-fold" local/persist-dir))
(setq project-list-file (expand-file-name "projects" local/persist-dir))

(let ((undo-tree-history-dir (expand-file-name "undo-tree-history" local/persist-dir)))
  (setq undo-tree-history-directory-alist `((".*" . ,undo-tree-history-dir))))

(setq save-place-file (expand-file-name ".cache/places" user-emacs-directory))

(defun local/modify-syntax-entry ()
  (modify-syntax-entry ?_ "w"))
(add-hook 'prog-mode-hook 'local/modify-syntax-entry)

;; ;; 当分屏后至少有 500 列时，垂直分屏，nil 表示禁止垂直分屏，此处设得大一些，以倾向于水平分屏
;; (setq split-width-threshold 500)
;; ;; 当分屏后至少有 20 行时，水平分屏，nil 表示禁止水平分屏，此处设得小一些，以倾向于水平分屏
;; (setq split-height-threshold 20)


;; 调整鼠标滚动速度
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(1))


(provide 'init-option)
