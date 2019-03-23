;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package find-file-in-project
  :ensure t
  :config
  (when (eq system-type 'windows-nt) (setq ffip-find-executable "c:\\\\cygwin64\\\\bin\\\\find"))
  (global-set-key (kbd "C-c p f") 'find-file-in-project)  ;; is slow when 10K+ files 但是可以实时显示结果
  (global-set-key (kbd "C-c p s f") 'find-file-in-project-by-selected)  ;; 性能好，但是需要按回车
  (global-set-key (kbd "C-c p d") 'find-directory-in-project)
  (global-set-key (kbd "C-c p s d") 'find-directory-in-project-by-selected)
  (global-set-key (kbd "C-c p c") 'find-file-in-current-directory-by-selected)
  (global-set-key (kbd "C-c p 2 f") 'ffip-split-window-horizontally)
  (global-set-key (kbd "C-c p 3 f") 'ffip-split-window-vertically)
  (global-set-key (kbd "C-c p i") 'ffip-insert-file)
  (global-set-key (kbd "C-c p r") 'find-relative-path)
)


(provide 'init-ffip)

