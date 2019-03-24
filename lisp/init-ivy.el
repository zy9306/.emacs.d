;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://oremacs.com/swiper/

(use-package ivy
  :ensure t
  :ensure swiper
  :ensure counsel

  :diminish ivy-mode
  :diminish counsel-mode

  :config
  (ivy-mode 1)
  (counsel-mode 1)
  
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-height 20)
  
  ;; Ivy-based interface to standard commands
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)

  ;; Ivy-based interface to shell and system tools
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)

  ;; ivy-resume resumes the last Ivy-based completion
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "C-c C-o") 'ivy-occur))


;; todo C-o (hydra-ivy/body)


;; https://github.com/mhayashi1120/Emacs-wgrep/tree/master
;; work with ivy-occur
(use-package wgrep
  :ensure t
  :defer t)


(use-package smex
  ;; M-x时优先列出使用过的命令
  :ensure t
  :config
  ;; (smex-initialize)
  (setq-default smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
  )


(provide 'init-ivy)
