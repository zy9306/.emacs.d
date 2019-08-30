;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package use-package-chords
  :ensure key-chord
  :ensure t
  :config (key-chord-mode 1)
)

;; must before load evil
(setq evil-disable-insert-state-bindings t)

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


(general-define-key
 :states '(visual normal operator motion insert)
 "C-c" 'evil-normal-state
 "S-RET" 'newline-at-end-of-line
 )


(general-define-key
 :states '(normal insert)
 :keymaps 'python-mode-map
 "C-]" 'anaconda-mode-find-definitions)


(general-define-key
 :states '(normal insert)
  "TAB" 'indent-for-tab-command)


(general-define-key
 :states 'normal
 "9" 'scroll-down-line
 "0" 'scroll-up-line
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
  "k" 'kill-buffer
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
  "y" 'browse-kill-ring
  "i" 'indent-rigidly
  "x" 'counsel-M-x
  "hb" 'describe-bindings
  "hv" 'counsel-describe-variable
  "hf" 'counsel-describe-function
  "g" 'revert-buffer-no-confirm
  )


(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(provide 'init-evil)
