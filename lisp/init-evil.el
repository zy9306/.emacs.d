;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package use-package-chords
  :ensure key-chord
  :ensure t
  :config (key-chord-mode 1)
)

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (modify-syntax-entry ?_ "w")
  )

(use-package general
  :ensure t
  :config
  (general-evil-setup)
  )


(general-imap "j"
              (general-key-dispatch 'self-insert-command
                :timeout 0.25
                "j" 'evil-normal-state))

(general-nmap
  :prefix "SPC"
  "f" 'counsel-find-file
  "d" 'dired
  "1" 'delete-other-windows
  "2" 'split-window-below
  "3" 'split-window-right
  "0" 'delete-window
  "o" 'other-window
  "b" 'switch-to-buffer
  "4f" 'find-file-other-window
  "aw" 'ace-window
  "as" 'ace-swap-window
  "s" 'swiper
  "pf" 'projectile-find-file
  "pk" 'projectile-kill-buffers
  "ps" 'projectile-ripgrep' ;; or projectile-ag
  "pp" 'projectile-switch-project
  ";" 'avy-goto-char-2
  "'" 'avy-goto-char
  "l" 'avy-goto-line
  "e" 'er/expand-region
  "r" 'query-replace
  "R" 'query-replace-regexp
  )


;; (general-nmap
;;   :prefix ";"
;; )

(provide 'init-evil)
