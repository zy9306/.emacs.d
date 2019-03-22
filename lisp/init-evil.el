;; -*- coding: utf-8; lexical-binding: t; -*-


;; (use-package use-package-chords
;;   :ensure t
;;   :config (key-chord-mode 1)
;; )

(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  (define-key evil-normal-state-map (kbd "C-c") 'evil-force-normal-state)
  (define-key evil-visual-state-map (kbd "C-c") 'evil-change-to-previous-state)
  (define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
  (define-key evil-replace-state-map (kbd "C-c") 'evil-normal-state)

  (modify-syntax-entry ?_ "w")
  )

(use-package evil-tutor
  :ensure t)


(use-package general
  :ensure t)


(general-evil-setup)
(general-nmap
  :prefix "SPC"
  "xf" 'counsel-find-file
  "xd" 'dired
  "x1" 'delete-other-windows
  "x2" 'split-window-below
  "x3" 'split-window-right
  "x0" 'delete-window
  "xo" 'other-window
  "xb" 'switch-to-buffer
  "x4f" 'find-file-other-window
  "tf" 'toggle-frame-maximized
  "aw" 'ace-window
  "as" 'ace-swap-window
  "si" 'swiper
  "cg" 'counsel-git
  "cj" 'counsel-git-grep
  "ck" 'counsel-git-ag)


(general-nmap
  :prefix ";"
  "'" 'avy-goto-char-2
  ";" 'avy-goto-char
  "l" 'avy-goto-line
)

(provide 'init-evil)
