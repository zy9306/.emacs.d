;;; -*- coding: utf-8; lexical-binding: t; -*-


(require-package 'undo-fu)
(require-package 'undo-tree)
(require-package 'goto-chg)
(require-package 'evil-mc)
(require-package 'evil-surround)


(with-eval-after-load 'evil
  (require 'general)
  (require 'key-chord)

  (evil-mode 1)
  (general-evil-setup)
  (key-chord-mode 1)

  (modify-syntax-entry ?_ "w")

  (evil-set-undo-system 'undo-fu)

  (local/evil-init)
  (local/setup-normal)
  (local/setup-visual)
  (local/setup-insert)
  (local/setup-org)

  (local/evil-mc)
  (local/evil-surround)

  (general-define-key
   :state 'normal
   :keymaps 'override
   "U" 'string-inflection-all-cycle)

  (general-define-key
   :states '(normal
             motion)
   "C-c C-c" 'evil-normal-state)

  (general-define-key
   :states '(visual
             operator
             insert)
   "C-c" 'evil-normal-state))


(defun local/evil-init ()
  (evil-set-initial-state 'imenu-list-major-mode 'emacs)
  (evil-set-initial-state 'ivy-occur-grep-mode 'normal)
  (evil-set-initial-state 'ivy-occur-mode 'normal))


(defun local/setup-normal ()
  (general-define-key
   :states '(normal motion)
   :prefix ";"
   :keymaps 'override

   "c" (general-simulate-key "C-c")
   "f" 'counsel-find-file
   "1" 'delete-other-windows
   "2" 'split-window-below
   "3" 'split-window-right
   "0" 'delete-window
   "o" 'ace-window
   "b" 'switch-to-buffer
   "k" 'kill-this-buffer
   "40" 'kill-buffer-and-window
   "4f" 'find-file-other-window
   "as" 'ace-swap-window

   "q" 'read-only-mode
   "w" 'save-buffer

   "$" 'toggle-truncate-lines

   "pf" 'projectile-find-file
   "pk" 'projectile-kill-buffers
   "ps" 'projectile-ripgrep'
   "pp" 'projectile-switch-project
   "\"" 'imenu-list-smart-toggle

   "s" 'swiper-isearch
   ";" 'avy-goto-char-2
   "'" 'avy-goto-char
   "l" 'avy-goto-line

   "e" 'er/expand-region
   "r" 'query-replace
   "R" 'query-replace-regexp
   "y" 'browse-kill-ring

   "g" 'revert-buffer-no-confirm
   "x" 'counsel-M-x

   "m" 'magit-blame
   "vu" 'vc-revert

   "hb" 'describe-bindings
   "hv" 'counsel-describe-variable
   "hf" 'counsel-describe-function))


(defun local/setup-visual ()
  (general-vmap
    :prefix "SPC"
    :keymaps 'override
    "i" 'indent-rigidly))


(defun local/setup-insert ()
  (general-define-key
   :states 'insert
   :keymaps 'override
   (kbd "C-f") 'forward-char
   (kbd "C-b") 'backward-char
   (kbd "C-d") 'delete-char
   (kbd "C-n") 'company-dabbrev
   (kbd "C-<RET>") 'company-tabnine
   )

  (general-imap "j"
    (general-key-dispatch 'self-insert-command
      :timeout 0.25
      "j" 'evil-normal-state)))


(defun local/evil-mc ()
  (require 'evil-mc)

  (global-evil-mc-mode 1)

  (evil-define-key 'visual evil-mc-key-map
    "A" #'evil-mc-make-cursor-in-visual-selection-end
    "I" #'evil-mc-make-cursor-in-visual-selection-beg))


(defun local/evil-surround ()
  (require 'evil-surround)

  (global-evil-surround-mode 1))


(defun local/setup-org ()
  (general-define-key
   :states 'normal
   :keymaps 'org-mode-map
   "TAB" 'org-cycle
   "S-TAB" 'org-shifttab
   ">" 'org-metaright
   "<" 'org-metaleft
   "M-j" 'org-metadown
   "M-k" 'org-metaup
   "O" 'org-insert-heading
   "M-o" 'org-insert-subheading
   "C-,"  'org-insert-structure-template))


(local/after-init-hook 'evil)


(provide 'init-evil-v3)
