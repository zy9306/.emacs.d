;;; -*- coding: utf-8; lexical-binding: t; -*-


(require-package 'undo-fu)
(require-package 'undo-tree)
(require-package 'goto-chg)
(require-package 'evil-surround)


(setq evil-disable-insert-state-bindings t)


(with-eval-after-load 'evil
  (require 'general)
  (require 'key-chord)

  (evil-mode 1)
  (general-evil-setup)
  (key-chord-mode 1)

  (modify-syntax-entry ?_ "w")

  (evil-set-undo-system 'undo-fu)

  (setq evil-normal-state-cursor '(box "#39c5bb")
        evil-insert-state-cursor '(box "#FB7299")
        evil-visual-state-cursor '(box "#DB7093"))

  (general-imap "j"
    (general-key-dispatch 'self-insert-command
      :timeout 0.25
      "j" 'evil-normal-state))

  (general-define-key
   :states '(normal visual)
   :keymaps 'override
   "U" 'string-inflection-all-cycle)

  (general-define-key
   :states '(normal
             motion)
   "C-c" 'evil-normal-state)

  (general-define-key
   :states '(visual
             operator
             insert)
   "C-c" 'evil-normal-state)

  (local/evil-init)
  (local/setup-prefix)
  (local/setup-org)

  (local/evil-surround)
  (local/evil-browse-kill-ring))


(defun local/evil-init ()
  (evil-set-initial-state 'imenu-list-major-mode 'emacs)
  (evil-set-initial-state 'ivy-occur-grep-mode 'emacs)
  (evil-set-initial-state 'ivy-occur-mode 'emacs))


(defun local/setup-prefix ()
  (general-define-key
   :states '(normal motion visual)
   :prefix ";"
   :keymaps 'override

   "X" (general-simulate-key "C-x")
   "S" (general-simulate-key "C-u C-x s")
   "Q" (general-simulate-key "C-x C-q")

   "x" 'counsel-M-x
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

   "w" 'easy-kill  ;; w -> word, b -> fullfile, 0 -> filename, - -> dirname

   "s" 'save-buffer

   "$" 'toggle-truncate-lines

   "pf" 'projectile-find-file
   "pk" 'projectile-kill-buffers
   "ps" 'projectile-ripgrep'
   "pp" 'projectile-switch-project

   "\"" 'imenu-list-smart-toggle

   "i" 'swiper-isearch
   ";" 'avy-goto-char-2
   "'" 'avy-goto-char
   "l" 'avy-goto-line

   "e" 'er/expand-region
   "r" 'query-replace
   "R" 'query-replace-regexp
   "y" 'browse-kill-ring

   "g" 'revert-buffer-no-confirm

   "m" 'magit-blame
   "vu" 'vc-revert

   "hb" 'describe-bindings
   "hv" 'counsel-describe-variable
   "hf" 'counsel-describe-function))


(defun local/evil-surround ()
  (require 'evil-surround)

  (global-evil-surround-mode 1))


(defun local/evil-browse-kill-ring ()
  (evil-set-initial-state 'browse-kill-ring-mode 'normal)
  (general-define-key
   :states 'normal
   :keymaps 'browse-kill-ring-mode-map
   "C-g" 'browse-kill-ring-quit
   "RET" 'browse-kill-ring-insert-and-quit
   "a" 'browse-kill-ring-append-insert
   "b" 'browse-kill-ring-prepend-insert
   "d" 'browse-kill-ring-delete
   "e" 'browse-kill-ring-edit
   "j" 'browse-kill-ring-forward
   "k" 'browse-kill-ring-previous
   "q" 'browse-kill-ring-quit
   "r" 'browse-kill-ring-search-backward
   "s" 'browse-kill-ring-search-forward))


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
