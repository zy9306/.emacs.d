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
   "hf" 'counsel-describe-function)

  (local/evil-ivy-setup)
  (local/minibuffer-setup))


(defun local/evil-ivy-setup ()
  (dolist (map '(ivy-occur-mode-map
                 ivy-occur-grep-mode-map
                 ivy-minibuffer-map
                 ))
    (evil-define-key 'normal map
      [mouse-1] 'ivy-occur-click
      (kbd "RET") 'ivy-occur-press-and-switch
      "j" 'ivy-occur-next-line
      "k" 'ivy-occur-previous-line
      "h" 'evil-backward-char
      "l" 'evil-forward-char
      "g" nil
      "gg" 'evil-goto-first-line
      "gf" 'ivy-occur-press
      "ga" 'ivy-occur-read-action
      "go" 'ivy-occur-dispatch
      "gc" 'ivy-occur-toggle-calling
      "gr" 'ivy-occur-revert-buffer
      "D" 'ivy-occur-delete-candidate
      "q" 'quit-window))

  (evil-define-key 'visual ivy-occur-grep-mode-map
    "j" 'evil-next-line
    "k" 'evil-previous-line)

  (evil-define-key 'normal ivy-minibuffer-map
    (kbd "<escape>") 'abort-recursive-edit
    (kbd "RET") 'ivy-done
    "q" 'quit-window
    "j" 'ivy-next-line
    "k" 'ivy-previous-line
    "go" 'ivy-occur)

  (evil-define-key 'insert ivy-minibuffer-map
    [backspace] 'ivy-backward-delete-char
    (kbd "C-r") 'ivy-reverse-i-search
    (kbd "C-o") 'ivy-occur
    (kbd "C-n") 'ivy-next-line
    (kbd "C-p") 'ivy-previous-line
    (kbd "RET") 'ivy-done))


(defun local/evil-minibuffer-insert ()
  (set (make-local-variable 'evil-echo-state) nil)
  (evil-insert 1))


(defun local/minibuffer-setup ()
  (dolist (map '(minibuffer-local-map
                 minibuffer-local-ns-map
                 minibuffer-local-completion-map
                 minibuffer-local-must-match-map
                 minibuffer-local-isearch-map))
    (evil-define-key 'normal map
      (kbd "<escape>") 'abort-recursive-edit
      "q" 'exit-minibuffer))

  (add-hook 'minibuffer-setup-hook 'local/evil-minibuffer-insert)

  ;; (evil-define-key 'normal evil-ex-completion-map
  ;;   (kbd "<escape>") 'abort-recursive-edit
  ;;   (kbd "C-p") 'previous-history-element
  ;;   (kbd "C-n") 'next-history-element)

  ;; (evil-define-key 'insert evil-ex-completion-map
  ;;   (kbd "C-p") 'previous-history-element
  ;;   (kbd "C-n") 'next-history-element)
  )

(require 'evil)

(provide 'init-evil-v2)
