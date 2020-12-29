;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package yafolding
  ;; C-RET: toggle-element  C-S-RET: hide-parent-element  C-M-RET: toggle-all
  :ensure t
  ;; :config
  ;; (add-hook 'prog-mode-hook 'yafolding-mode)
  )

(defun local/hs-minor-mode ()
  (hs-minor-mode t)
  (define-key hs-minor-mode-map (kbd "<C-return>") 'hs-toggle-hiding)
  (define-key hs-minor-mode-map [left-fringe mouse-1] 'hs-toggle-hiding)
  (define-key hs-minor-mode-map (kbd "<C-M-return>") 'hs-hide-all)
  (define-key hs-minor-mode-map (kbd "C-u <C-M-return>") 'hs-show-all)
  )
(add-hook 'prog-mode-hook #'local/hs-minor-mode)

(use-package vimish-fold
  :ensure t
  ;; :config
  ;; (vimish-fold-global-mode t)
  ;; (global-set-key (kbd "C-c v f") #'vimish-fold)
  ;; (global-set-key (kbd "C-c v v") #'vimish-fold-delete)
  ;; (global-set-key (kbd "C-c v t") #'vimish-fold-toggle)  ;; also C-`
  )

(provide 'init-folding)
