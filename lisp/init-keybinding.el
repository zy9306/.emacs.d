;;; -*- coding: utf-8; lexical-binding: t; -*-

(global-unset-key (kbd "C-x C-b"))


(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-p"))))
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-l"))))
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-f"))))


(global-set-key (kbd "C-S-v") 'scroll-up-command)
(global-set-key (kbd "M-S-v") 'scroll-down-command)
(global-unset-key (kbd "C-9"))
(global-unset-key (kbd "C-0"))
(global-set-key (kbd "C-0") (lambda () (interactive) (next-line 2)))
(global-set-key (kbd "C-9") (lambda () (interactive) (previous-line 2)))
(global-set-key (kbd "C-(") (lambda () (interactive) (scroll-down-line 2)))
(global-set-key (kbd "C-)") (lambda () (interactive) (scroll-up-line 2)))
(global-set-key (kbd "C-*") (lambda () (interactive) (scroll-left 1)))
(global-set-key (kbd "C-&") (lambda () (interactive) (scroll-right 1)))
(global-set-key (kbd "C-}") (lambda () (interactive) (scroll-left)))
(global-set-key (kbd "C-{") (lambda () (interactive) (scroll-right)))


(global-set-key (kbd "<mouse-6>")
                (lambda () (interactive)
                  (if truncate-lines (scroll-right 1))))
(global-set-key (kbd "<mouse-7>")
                (lambda () (interactive)
                  (if truncate-lines (scroll-left 1))))


(global-set-key (kbd "M-P") 'move-text-up)
(global-set-key (kbd "M-N") 'move-text-down)
(global-set-key (kbd "C-M-p") 'backward-list)
(global-set-key (kbd "C-M-n") 'forward-list)
(global-set-key (kbd "C-x <?\\t>") 'indent-rigidly)
(global-set-key "\C-c$" 'toggle-truncate-lines)
(global-set-key (kbd "S-<return>") 'newline-at-end-of-line)
(global-set-key (kbd "M-y") 'browse-kill-ring)
(global-set-key (kbd "C-,") 'goto-last-change)
(global-set-key (kbd "C-.") 'goto-last-change-reverse)


(global-set-key (kbd "C-x \"") #'imenu-list-smart-toggle)


(with-eval-after-load 'symbol-overlay
  (define-key symbol-overlay-mode-map (kbd "M-i") 'symbol-overlay-put)
  (define-key symbol-overlay-mode-map (kbd "M-I") 'symbol-overlay-remove-all)
  (define-key symbol-overlay-mode-map (kbd "M-n") 'symbol-overlay-jump-next)
  (define-key symbol-overlay-mode-map (kbd "M-p") 'symbol-overlay-jump-prev))


(with-eval-after-load 'dired-subtree
  (define-key dired-mode-map (kbd "C-<return>") 'dired-subtree-toggle))


(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)
(global-set-key (kbd "C-c M-g") 'magit-file-dispatch)


(global-set-key (kbd "C-=") 'er/expand-region)


(global-set-key (kbd "C-x j") 'yas-insert-snippet)


(global-set-key (kbd "C-c C-l") 'highlight-indent-guides-mode)


(with-eval-after-load 'key-chord
  (key-chord-define-global "JJ" 'read-only-mode))


(with-eval-after-load 'general
  (key-chord-mode 1)
  ;; (general-define-key (general-chord "cc") (general-simulate-key "C-c"))
  )
(local/after-init-hook 'general)


(provide 'init-keybinding)
