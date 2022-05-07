(require-package 'undo-tree)
(require-package 'goto-chg)
(require-package 'evil-surround)
(require-package 'evil-matchit)
(require-package 'evil-textobj-line)


(setq evil-disable-insert-state-bindings t)


(with-eval-after-load 'evil
  (require 'general)
  (require 'key-chord)

  (evil-mode 1)
  (general-evil-setup)
  (key-chord-mode 1)

  (modify-syntax-entry ?_ "w")

  (if (version<= "28.0" emacs-version)
      (evil-set-undo-system 'undo-redo))

  ;; (setq evil-normal-state-cursor '(box "#39c5bb")
  ;;       evil-insert-state-cursor '(box "#FB7299")
  ;;       evil-visual-state-cursor '(box "#DB7093"))

  (general-imap "j"
    (general-key-dispatch 'self-insert-command
      :timeout 0.25
      "j" 'evil-normal-state))

  (general-define-key
   :states '(normal visual)
   :keymaps 'override
   "U" 'string-inflection-all-cycle)

  (local/evil-init)
  (local/setup-prefix)
  (local/setup-org)

  (local/evil-surround)
  (local/evil-matchit)
  (local/evil-textobj-line)
  (local/evil-browse-kill-ring))


(defun local/evil-init ()
  (evil-set-initial-state 'imenu-list-major-mode 'emacs)
  (evil-set-initial-state 'ivy-occur-grep-mode 'emacs)
  (evil-set-initial-state 'ivy-occur-mode 'emacs))


(defun local/setup-prefix ()
  (general-define-key
   :states '(normal motion visual)
   :prefix "SPC"
   :keymaps 'override

   "X" (general-simulate-key "C-x")
   "c" (general-simulate-key "C-c")
   "S" (general-simulate-key "C-u C-x s")
   "q" (general-simulate-key "C-x C-q")

   "x" 'counsel-M-x
   "f" 'counsel-find-file
   "1" 'delete-other-windows
   "2" 'split-window-below
   "3" 'split-window-right
   "0" 'delete-window
   "o" 'ace-window
   "W" 'ace-swap-window
   "b" 'switch-to-buffer
   "k" 'kill-this-buffer
   "40" 'kill-buffer-and-window
   "4f" 'find-file-other-window

   "e" 'er/expand-region
   "r" 'query-replace
   "R" 'query-replace-regexp
   "y" 'browse-kill-ring
   "w" 'easy-kill

   "s" 'save-buffer
   "G" 'revert-buffer-no-confirm

   "." 'xref-find-definitions
   "4." 'xref-find-definitions-other-window
   "," 'xref-pop-marker-stack

   "$" 'toggle-truncate-lines

   "pf" 'projectile-find-file
   "pk" 'projectile-kill-buffers
   "ps" 'projectile-ripgrep
   "pp" 'projectile-switch-project

   "gs" 'swiper-isearch
   "gi" 'imenu-list-smart-toggle
   "gb" 'local/toggle-bufler
   "gc" 'avy-goto-char
   "gg" 'avy-goto-char-2
   "gl" 'avy-goto-line

   "hb" 'describe-bindings
   "hv" 'counsel-describe-variable
   "hf" 'counsel-describe-function))

(defun local/evil-surround ()
  (require 'evil-surround)

  (global-evil-surround-mode 1))

(defun local/evil-matchit ()
  (require 'evil-matchit)
  (global-evil-matchit-mode 1))

(defun local/evil-textobj-line ()
  (require 'evil-textobj-line))

(defun local/evil-browse-kill-ring ()
  (evil-set-initial-state 'browse-kill-ring-mode 'normal)
  (general-define-key
   :states 'normal
   :keymaps 'browse-kill-ring-mode-map
   "C-g" 'browse-kill-ring-quit
   "RET" 'browse-kill-ring-insert-and-quit
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
