;;; -*- coding: utf-8; lexical-binding: t; -*-


;;; rename-current-buffer-file
(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let* ((name (buffer-name))
        (filename (buffer-file-name))
        (basename (file-name-nondirectory filename)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " (file-name-directory filename) basename nil basename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(global-set-key (kbd "C-c r")  #'rename-current-buffer-file)


;;; sudo-save
(defun sudo-save ()
  (interactive)
  (if (not buffer-file-name)
      (write-file (concat "/sudo:root@localhost:" (ido-read-file-name "File:")))
    (write-file (concat "/sudo:root@localhost:" buffer-file-name))))


;;; revert-buffer
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
        (revert-buffer t t) )))
  (message "Refreshed open files.") )

(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)
(global-set-key (kbd "<C-f5>") 'revert-all-buffers)


;;; newline-at-end-of-line
(defun newline-at-end-of-line ()
  ;; shift+return
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))


;;; scroll
(defun scroll-half-page-down ()
  "scroll down half the page"
  (interactive)
  (scroll-down (/ (window-body-height) 2)))

(defun scroll-half-page-up ()
  "scroll up half the page"
  (interactive)
  (scroll-up (/ (window-body-height) 2)))

(global-set-key (kbd "C-v") 'scroll-half-page-up)
(global-set-key (kbd "M-v") 'scroll-half-page-down)


;;; git-short-file-path
(defun local/git-short-file-path (&optional filename)
  (let ((fname (if filename filename (buffer-file-name))))
    (file-relative-name fname (locate-dominating-file fname ".git"))))

(with-eval-after-load 'git-auto-commit-mode
  (setq gac-default-message 'local/git-short-file-path)
  ;; disable auto commit on save.
  (git-auto-commit-mode -1))


;;; git-auto-commit
(defun local/git-auto-commit ()
  (interactive)
  (require 'git-auto-commit-mode)
  (gac-after-save-func)
  (diff-hl-reset-reference-rev))


;;; which-function
;; use breadcrumb instead
;; (defun local/which-function ()
;;   (interactive)
;;   (require 'which-func)
;;   (let ((current-function (which-function)))
;;     (if current-function
;;         (message (which-function)))))
;; (add-hook 'after-init-hook (lambda () (which-function-mode)))


;;; show function signature
;; 鼠标点击或光标移动时调用 local/which-function 显示当前函数信息，有性能问题
;; (defvar local/last-point-position 0)
;; (make-variable-buffer-local 'local/last-point-position)
;; (defun local/show-current-function-post-command ()
;;   (let ((current-position (point)))
;;     (if (not (equal current-position local/last-point-position))
;;         (local/which-function)
;;       (if (eq this-command 'mouse-set-point)
;;           (local/which-function)))
;;     (setq local/last-point-position current-position)))
;; (add-hook 'post-command-hook #'local/show-current-function-post-command)


(defun query-replace-no-case ()
  (interactive)
  (let ((case-replace nil)
        (case-fold-search nil))
    (call-interactively 'anzu-query-replace)))


(provide 'init-utils)
