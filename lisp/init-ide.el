;; -*- coding: utf-8; lexical-binding: t; -*-


;; (use-package find-file-in-project
;;   :ensure t
;;   :config
;;   (when (eq system-type 'windows-nt) (setq ffip-find-executable "C:\\\\Program Files\\\\Git\\\\usr\\\\bin"))  ;; install git bash for windows
;;   (global-set-key (kbd "C-c p f") 'find-file-in-project)  ;; is slow when 10K+ files 但是可以实时显示结果
;;   (global-set-key (kbd "C-c p s f") 'find-file-in-project-by-selected)  ;; 性能好，但是需要按回车
;;   (global-set-key (kbd "C-c p d") 'find-directory-in-project)
;;   (global-set-key (kbd "C-c p s d") 'find-directory-in-project-by-selected)
;;   (global-set-key (kbd "C-c p c") 'find-file-in-current-directory-by-selected)
;;   (global-set-key (kbd "C-c p 2 f") 'ffip-split-window-horizontally)
;;   (global-set-key (kbd "C-c p 3 f") 'ffip-split-window-vertically)
;;   (global-set-key (kbd "C-c p i") 'ffip-insert-file)
;;   (global-set-key (kbd "C-c p r") 'find-relative-path)
;; )


(use-package projectile
  :ensure t
  :ensure counsel-projectile
  :config
  (projectile-mode +1)
  (counsel-projectile-mode t)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line-function '(lambda () (format " Proj[%s]" (projectile-project-name))))


(provide 'init-ide)
