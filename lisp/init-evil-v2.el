;; -*- coding: utf-8; lexical-binding: t; -*-


(require-package 'evil)
(require-package 'general)
(require-package 'key-chord)
(require-package 'goto-chg)
(require-package 'undo-tree)


(with-eval-after-load 'evil
  (require 'general)
  (require 'key-chord)
  
  (evil-mode 1)

  (modify-syntax-entry ?_ "w")

  (general-evil-setup)
  (key-chord-mode 1)

  (evil-set-initial-state 'ivy-occur-grep-mode 'normal)

  (general-define-key
   :states '(visual normal operator motion insert emacs)
   "C-c" 'evil-normal-state
   "S-RET" 'newline-at-end-of-line)

  (general-define-key
   :states '(normal insert)
   "TAB" 'indent-for-tab-command)

  (general-imap "j"
                (general-key-dispatch 'self-insert-command
                  :timeout 0.25
                  "j" 'evil-normal-state))

  (general-emap "j"
                (general-key-dispatch 'self-insert-command
                  :timeout 0.25
                  "j" 'evil-normal-state))

  ;; C-x/C-c -> SPC
  (general-nmap
   :prefix "SPC"
   "f" 'counsel-find-file
   "1" 'delete-other-windows
   "2" 'split-window-below
   "3" 'split-window-right
   "0" 'delete-window
   "o" 'other-window
   "b" 'switch-to-buffer
   "k" 'kill-buffer
   "4f" 'find-file-other-window
   "pf" 'projectile-find-file
   "pk" 'projectile-kill-buffers
   "ps" 'projectile-ripgrep'
   "pp" 'projectile-switch-project
   "as" 'ace-swap-window
   "s" 'swiper
   ";" 'avy-goto-char-2
   "'" 'avy-goto-char
   "l" 'avy-goto-line
   "e" 'er/expand-region
   "r" 'query-replace
   "R" 'query-replace-regexp
   "y" 'browse-kill-ring
   "i" 'indent-rigidly
   "g" 'revert-buffer-no-confirm
   "x" 'counsel-M-x
   "hb" 'describe-bindings
   "hv" 'counsel-describe-variable
   "hf" 'counsel-describe-function
   )
  )

(require 'evil)

(provide 'init-evil-v2)
