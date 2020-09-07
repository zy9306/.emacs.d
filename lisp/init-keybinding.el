;; -*- coding: utf-8; lexical-binding: t; -*-

(require-package 'key-chord)
(require-package 'general)

;; unset
(global-unset-key (kbd "C-x C-b"))

;; disable run-python binding
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-p"))))

(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-l"))))

(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-f"))))

;; lsp
(add-hook 'lsp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c l i") 'lsp-ivy-workspace-symbol)
            (local-set-key (kbd "C-c l I") 'lsp-ivy-global-workspace-symbol)
            ))
(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "M-*") 'lsp-signature-activate))

;; bm (bookmark)
(global-set-key (kbd "C-c j") 'bm-next)
(global-set-key (kbd "C-c k") 'bm-previous)
(global-set-key (kbd "C-^") 'bm-toggle)
(global-set-key (kbd "C-x m") 'bm-show)
(global-set-key (kbd "C-x M") 'bm-show-all)

;; buffers
(global-set-key (kbd "C-x C-S-b") 'list-buffers)

;; mark
(global-set-key (kbd "C-x C-S-x") 'exchange-point-and-mark)
(global-set-key (kbd "C-x C-x") 'local/set-mark-set-mark)

;; scroll
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

;; Horizontal scrolling mouse events should actually scroll left and right.
(global-set-key (kbd "<mouse-6>")
                (lambda () (interactive)
                  (if truncate-lines (scroll-right 1))))
(global-set-key (kbd "<mouse-7>")
                (lambda () (interactive)
                  (if truncate-lines (scroll-left 1))))

;; projectile
(global-set-key (kbd "C-S-S") 'projectile-ripgrep)

;; swipper
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-c C-s") 'isearch-forward)

;; edit
(global-set-key (kbd "M-P") 'move-text-up)
(global-set-key (kbd "M-N") 'move-text-down)
(global-set-key (kbd "C-M-p") 'backward-list)
(global-set-key (kbd "C-M-n") 'forward-list)
(global-set-key (kbd "C-x <?\\t>") 'indent-rigidly)  ;; 缩进选区
(global-set-key "\C-c$" 'toggle-truncate-lines)
(global-set-key (kbd "S-<return>") 'newline-at-end-of-line)
(global-set-key (kbd "M-y") 'browse-kill-ring)
(global-set-key (kbd "C-,") 'goto-last-change)
(global-set-key (kbd "C-.") 'goto-last-change-reverse)


;; imenu
(global-set-key (kbd "C-x \"") #'imenu-list-smart-toggle)
(global-set-key (kbd "C-\"") #'counsel-imenu)

(with-eval-after-load 'symbol-overlay
  (define-key symbol-overlay-mode-map (kbd "M-i") 'symbol-overlay-put)
  (define-key symbol-overlay-mode-map (kbd "M-I") 'symbol-overlay-remove-all)
  (define-key symbol-overlay-mode-map (kbd "M-n") 'symbol-overlay-jump-next)
  (define-key symbol-overlay-mode-map (kbd "M-p") 'symbol-overlay-jump-prev))

(with-eval-after-load 'dired-subtree
  (define-key dired-mode-map (kbd "C-<return>") 'dired-subtree-toggle))

;; mc
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)
(global-set-key (kbd "C-c M-g") 'magit-file-dispatch)

;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

;; snippet
(global-set-key (kbd "C-x j") 'yas-insert-snippet)

;; python
(global-set-key (kbd "C-c C-y") 'yapfify-region)
(global-set-key (kbd "C-c C-b") 'python-black-region)
(global-set-key (kbd "C-c C-l") 'highlight-indent-guides-mode)

(with-eval-after-load 'key-chord
  ;; (key-chord-define-global "rr" 'revert-buffer)
  ;; (key-chord-define-global "yy" 'yank)
  )
(with-eval-after-load 'general
  (key-chord-mode 1)
  ;; (general-define-key (general-chord "cc") (general-simulate-key "C-c"))
  ;; (general-define-key (general-chord "  ") (general-simulate-key "C-c"))
  ;; (general-define-key (general-chord "xx") (general-simulate-key "C-x"))
  ;; (general-define-key (general-chord "ee") (general-simulate-key "C-e"))
  ;; (general-define-key (general-chord "aa") (general-simulate-key "C-a"))
  ;; (general-define-key (general-chord "mm") (general-simulate-key "C-@"))
  ;; (general-define-key (general-chord "ww") (general-simulate-key "M-w"))
  ;; (general-define-key (general-chord "kk") (general-simulate-key "C-w"))
  ;; (general-define-key (general-chord "dd") (general-simulate-key "<C-S-backspace>"))
  )
(local/after-init-hook 'general)


(provide 'init-keybinding)
