;; -*- coding: utf-8; lexical-binding: t; -*-


;; TODO key太复杂，考虑优化

(global-set-key (kbd "C-c f g g") 'find-grep)
(global-set-key (kbd "C-c f g d") 'find-grep-dired)


;; ag config
(use-package ag
  :ensure t
  :config
  (setq ag-highlight-search t)
  (when *win*
    (setq ag-executable "C:/Wherever/I/Installed/Ag/ag.exe"))
  (setq ag-reuse-buffers 't)  ;; 所有的ag搜索使用同一buffer

  (global-set-key (kbd "C-c f a a") 'ag)
  (global-set-key (kbd "C-c f a f") 'ag-files)
  (global-set-key (kbd "C-c f a r") 'ag-regexp)
  (global-set-key (kbd "C-c f a p a") 'ag-project)
  (global-set-key (kbd "C-c f a p f") 'ag-project-files)
  (global-set-key (kbd "C-c f a p r") 'ag-project-regexp)
  (global-set-key (kbd "C-c f a p d") 'ag-project-dired)
  (global-set-key (kbd "C-c f a p D") 'ag-project-dired-regexp)

  (global-set-key (kbd "C-c f a d") 'ag-dired)
  (global-set-key (kbd "C-c f a D") 'ag-dired-regexp))


;; setup exec path for mac
;; or use https://github.com/purcell/exec-path-from-shell
;; maybe slow emacs
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when *is-a-mac*
  (set-exec-path-from-shell-PATH))


(provide 'init-find)
