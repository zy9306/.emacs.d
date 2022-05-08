(require-package 'undo-tree)
(require-package 'goto-chg)
(require-package 'evil-surround)
(require-package 'evil-matchit)
(require-package 'evil-textobj-line)
(require-package 'evil-multiedit)
(require-package 'evil-mc)


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

  (add-hook 'evil-insert-state-exit-hook #'local/save-buffer-if-file-exists)
  (add-hook 'evil-emacs-state-exit-hook #'local/save-buffer-if-file-exists)

  (evil-define-key 'normal 'global
    "*" #'symbol-overlay-jump-next
    "#" #'symbol-overlay-jump-prev)

  (general-define-key
   :states '(normal visual)
   :keymaps 'override
   "U" 'string-inflection-all-cycle)

  (local/setup-prefix)
  (local/setup-org)
  (local/setup-xref)
  (local/setup-imenu)
  (local/setup-bufler)
  (local/setup-ivy)
  (local/setup-some-mode)

  (local/evil-surround)
  (local/evil-matchit)
  (local/evil-textobj-line)
  (local/evil-multiedit)
  (local/evil-mc)
  (local/evil-browse-kill-ring))


(defun local/save-buffer-if-file-exists ()
  (let ((filename (buffer-file-name (current-buffer))))
    (if (and filename (file-exists-p filename))
        (save-buffer))))


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

   "gf" 'whitespace-cleanup
   "gF" 'format-all-buffer

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

(defun local/setup-xref ()
  (general-define-key
   :states '(normal visual)
   :keymaps 'xref--xref-buffer-mode-map
   "gj" 'xref-next-line
   "gk" 'xref-prev-line
   "q" 'quit-window
   (kbd "RET") 'xref-goto-xref
   (kbd "TAB") 'xref-quit-and-goto-xref))

(defun local/setup-imenu ()
  (general-define-key
   :states '(normal visual)
   :keymaps 'imenu-list-major-mode-map
   "<mouse-1>" 'imenu-list-display-entry
   (kbd "RET") 'imenu-list-goto-entry
   "d" 'imenu-list-display-entry
   "gr" 'imenu-list-refresh
   "q" 'imenu-list-quit-window))

(defun local/setup-bufler ()
  (require 'bufler)
  (general-define-key
   :states '(normal visual)
   :keymaps 'bufler-list-mode-map
   (kbd "RET") 'bufler-list-buffer-switch
   "K" 'bufler-list-buffer-kill
   "q" 'quit-window))

(defun local/evil-multiedit ()
  (require 'evil-multiedit)

  (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

  (define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
  (define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
  (define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)

  (define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
  (define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)

  (define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

  (define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)

  (define-key evil-multiedit-mode-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
  (define-key evil-multiedit-mode-map (kbd "C-n") 'evil-multiedit-next)
  (define-key evil-multiedit-mode-map (kbd "C-p") 'evil-multiedit-prev)
  (define-key evil-multiedit-mode-map (kbd "C-n") 'evil-multiedit-next)
  (define-key evil-multiedit-mode-map (kbd "C-p") 'evil-multiedit-prev))

(defun local/evil-mc ()
  ;; note: jj does not work properly, use ESC instead.
  ;; maybe C-z use origin emacs mc is the best solution.
  (require 'evil-mc)

  (add-hook
   'evil-mc-mode-hook
   (lambda ()
     (progn
       (general-define-key
        :states '(normal visual)
        :keymaps 'override
        (kbd "C-n") #'evil-mc-make-and-goto-next-match
        (kbd "C-p") #'evil-mc-make-and-goto-prev-match
        (kbd "M-n") #'evil-mc-make-cursor-move-next-line
        (kbd "M-p") #'evil-mc-make-cursor-move-prev-line
        "grm" #'evil-mc-make-all-cursors
        "grq" #'evil-mc-undo-all-cursors
        "grI" #'evil-mc-make-cursor-in-visual-selection-beg
        "grA" #'evil-mc-make-cursor-in-visual-selection-end
        "gru" #'evil-mc-undo-last-added-cursor)

       (general-define-key
        :states '(normal visual)
        :keymaps 'evil-mc-key-map
        (kbd "C-g") #'evil-mc-undo-all-cursors)
       )))

  (global-evil-mc-mode 1))

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


(defun local/setup-ivy ()
  (evil-set-initial-state 'ivy-occur-mode 'normal)
  (evil-set-initial-state 'ivy-occur-grep-mode 'normal)

  (general-define-key
   :states 'normal
   :keymaps 'wgrep-mode-map
   "ZQ" 'wgrep-abort-changes
   "ZZ" 'wgrep-finish-edit)

  (general-define-key
   :states '(normal visual motion)
   :keymaps 'ivy-occur-mode-map

   [mouse-1] 'ivy-occur-click
   (kbd "RET") 'ivy-occur-press-and-switch
   "d" 'ivy-occur-delete-candidate
   "j" 'ivy-occur-next-line
   "k" 'ivy-occur-previous-line
   "J" 'local/ivy-occur-next-and-press
   "K" 'local/ivy-occur-previous-and-press

   "gf" 'ivy-occur-press
   "gd" 'ivy-occur-delete-candidate

   "h" 'evil-backward-char
   "l" 'evil-forward-char

   "gr" 'ivy-occur-revert-buffer
   "q" 'quit-window)

  (general-define-key
   :states '(normal visual motion)
   :keymaps 'ivy-occur-grep-mode-map

   [mouse-1] 'ivy-occur-click
   (kbd "RET") 'ivy-occur-press-and-switch

   (kbd "C-x C-") 'ivy-wgrep-change-to-wgrep-mode
   "i" 'ivy-wgrep-change-to-wgrep-mode

   "d" 'ivy-occur-delete-candidate
   "j" 'ivy-occur-next-line
   "k" 'ivy-occur-previous-line
   "J" 'local/ivy-occur-next-and-press
   "K" 'local/ivy-occur-previous-and-press

   "gf" 'ivy-occur-press
   "gd" 'ivy-occur-delete-candidate

   "h" 'evil-backward-char
   "l" 'evil-forward-char

   "gr" 'ivy-occur-revert-buffer
   "q" 'quit-window))

(defun local/setup-some-mode ()
  (general-define-key
   :states '(normal visual motion)
   :keymaps 'messages-buffer-mode-map
   "q" 'quit-window)

  (general-define-key
   :states '(normal visual motion)
   :keymaps 'help-mode-map
   "q" 'quit-window))

(local/after-init-hook 'evil)


(provide 'init-evil-v3)
