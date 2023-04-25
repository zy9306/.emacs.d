;;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/after-init-hook (package)
  (add-hook 'after-init-hook (lambda () (require package))))

(with-eval-after-load 'prescient
  (setq prescient-save-file (concat "~/.emacs.d/.persist/" "prescient-save.el"))
  (prescient-persist-mode 1))

(with-eval-after-load 'exec-path-from-shell
  (setq exec-path-from-shell-arguments nil)
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))
(local/after-init-hook 'exec-path-from-shell)


(local/after-init-hook 'smex)


(add-hook 'after-init-hook (lambda () (save-place-mode)))


(use-package goggles
  :diminish goggles-mode
  :hook ((prog-mode
          text-mode
          yaml-mode)
         . goggles-mode)
  :config
  (setq-default goggles-pulse t))


;;; fill-column-indicator
(setq-default fill-column 100)
(global-display-fill-column-indicator-mode)


;; 自带的使用上有点问题，先继续用 undo-tree
(if (and nil (version<= "28.0" emacs-version))
    (progn
      (global-set-key (kbd "C-/") 'undo)
      (global-set-key (kbd "M-_") 'undo-redo))
  (progn
    (with-eval-after-load 'undo-tree
      ;; 也可以试试这个可视化包 https://github.com/casouri/vundo
      (diminish 'undo-tree-mode)
      ;; 不需要持久化
      (setq undo-tree-auto-save-history nil)
      (global-undo-tree-mode)
      ;; also C-_
      (global-set-key (kbd "C-/") 'undo-tree-undo)
      ;; alse C-?
      (global-set-key (kbd "M-_") 'undo-tree-redo))
    (local/after-init-hook 'undo-tree)))


(add-hook 'after-init-hook (lambda () (require 'vundo)))


;; see also https://www.emacswiki.org/emacs/AutoSave `auto-save-visited-mode`
(with-eval-after-load 'real-auto-save
  (diminish 'real-auto-save-mode)
  (setq real-auto-save-interval 30)
  (dolist (hook '(text-mode-hook
                  python-mode-hook
                  go-mode-hook
                  yaml-mode-hook
                  conf-mode-hook
                  elisp-mode-hook))
    (add-hook hook 'real-auto-save-mode)))
(local/after-init-hook 'real-auto-save)


(with-eval-after-load 'which-key
  (diminish 'which-key-mode)
  (which-key-setup-side-window-bottom)
  (which-key-mode))
(local/after-init-hook 'which-key)


(with-eval-after-load 'imenu-list
  (setq imenu-list-auto-resize nil)
  (setq imenu-list-position 'right)
  (setq imenu-list-size 0.2)
  (setq imenu-max-item-length 120)
  (setq imenu-list-focus-after-activation t))

(with-eval-after-load 'key-chord
  (key-chord-define-global "II" #'imenu-list-smart-toggle))

(local/after-init-hook 'imenu-list)


(when (or *linux* *mac*)
  (with-eval-after-load 'flycheck
    (setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc))
    (global-flycheck-mode))
  (local/after-init-hook 'flycheck))

(with-eval-after-load 'flymake
  (define-key flymake-mode-map (kbd "C-c ! p") 'flymake-show-project-diagnostics)
  (define-key flymake-mode-map (kbd "C-c ! b") 'flymake-show-buffer-diagnostics))

(with-eval-after-load 'diff-hl
  (global-diff-hl-mode)
  (diff-hl-margin-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (add-hook 'after-revert-hook 'diff-hl-reset-reference-rev))
(local/after-init-hook 'diff-hl)


(with-eval-after-load 'symbol-overlay
  (diminish 'symbol-overlay-mode)
  (dolist (hook '(prog-mode-hook
                  html-mode-hook
                  conf-mode-hook
                  text-mode-hook
                  protobuf-mode-hook
                  yaml-mode-hook))
    (add-hook hook 'symbol-overlay-mode)))

(with-eval-after-load 'symbol-overlay
  (define-key symbol-overlay-mode-map (kbd "M-i") 'symbol-overlay-put)
  (define-key symbol-overlay-mode-map (kbd "M-I") 'symbol-overlay-remove-all)
  (define-key symbol-overlay-mode-map (kbd "M-n") 'symbol-overlay-jump-next)
  (define-key symbol-overlay-mode-map (kbd "M-p") 'symbol-overlay-jump-prev))

(local/after-init-hook 'symbol-overlay)


(with-eval-after-load 'anzu
  ;; 实时显示搜索及替换结果
  (setq anzu-mode-lighter "")
  (global-anzu-mode)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace))
(local/after-init-hook 'anzu)


(defun local/config-ace-isearch()
  (require 'ace-isearch)
  (global-ace-isearch-mode +1)
  (diminish 'ace-isearch-mode)
  ;; 默认输入超过 ace-isearch-input-length 个字符触发 swiper，禁用
  (setq ace-isearch-use-function-from-isearch nil)
  (setq ace-isearch-use-jump nil)
  (setq ace-isearch-input-length 99))
(add-hook 'after-init-hook #'local/config-ace-isearch)


;; To yank from the kill-rings of every cursor use yank-rectangle, normally found at C-x r y
(local/after-init-hook 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


(local/after-init-hook 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


(with-eval-after-load 'rainbow-delimiters
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(local/after-init-hook 'rainbow-delimiters)


(lazy-load-global-keys
 '(("C-x g" . magit-status))
 "magit")
(with-eval-after-load 'magit
  (define-key magit-hunk-section-map (kbd "RET") 'magit-diff-visit-file-other-window)
  (define-key magit-file-section-map (kbd "RET") 'magit-diff-visit-file-other-window)
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x M-g") 'magit-dispatch)
  (global-set-key (kbd "C-c M-g") 'magit-file-dispatch))


(with-eval-after-load 'browse-kill-ring
  (setq browse-kill-ring-highlight-current-entry t)
  (setq browse-kill-ring-highlight-inserted-item t)
  (setq browse-kill-ring-maximum-display-length 99)
  (setq browse-kill-ring-show-preview t))
(local/after-init-hook 'browse-kill-ring)

(global-set-key (kbd "M-y") 'browse-kill-ring)


(with-eval-after-load 'recentf
  (recentf-mode t)
  (setq-default recentf-max-saved-items 50)
  (setq recentf-filename-handlers
        (append '(abbreviate-file-name) recentf-filename-handlers)))
(local/after-init-hook 'recentf)


(local/after-init-hook 'goto-chg)
(global-set-key (kbd "C-,") 'goto-last-change)
(global-set-key (kbd "C-.") 'goto-last-change-reverse)


(local/after-init-hook 'move-text)
(global-set-key (kbd "M-P") 'move-text-up)
(global-set-key (kbd "M-N") 'move-text-down)


(with-eval-after-load 'dired-subtree
  (setq dired-subtree-use-backgrounds nil)
  (setq dired-subtree-line-prefix "  ↳"))

(with-eval-after-load 'dired-subtree
  (define-key dired-mode-map (kbd "C-<return>") 'dired-subtree-toggle))

(add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode)))

(with-eval-after-load 'diredfl
  (diredfl-global-mode))

(local/after-init-hook 'dired-subtree)
(local/after-init-hook 'diredfl)


(with-eval-after-load 'highlight-indent-guides
  (setq highlight-indent-guides-method 'bitmap))
(global-set-key (kbd "C-c C-l") 'highlight-indent-guides-mode)


(with-eval-after-load 'golden-ratio
  (global-set-key (kbd "M--") 'golden-ratio))
(local/after-init-hook 'golden-ratio)


(defun local/setup-terminal ()
  (unless (display-graphic-p)
    (xclip-mode)
    (xterm-mouse-mode 1)

    (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
    (global-set-key (kbd "<mouse-5>") 'scroll-up-line)))

(add-hook 'after-init-hook 'local/setup-terminal)


;; (with-eval-after-load 'better-jumper
;;   (better-jumper-mode +1)
;;   (global-set-key (kbd "M-*") 'better-jumper-set-jump)
;;   (global-set-key (kbd "M-<left>") 'better-jumper-jump-backward)
;;   (global-set-key (kbd "M-<right>") 'better-jumper-jump-forward))
;; (local/after-init-hook 'better-jumper)


;; bm
(setq bm-highlight-style 'bm-highlight-only-fringe)
(setq bm-in-lifo-order t)

(defun local/bm-toggle (x)
  (interactive "P")
  (cond
   ((equal x nil)
    (call-interactively 'bm-toggle))
   ((equal x '(4))
    (call-interactively 'bm-remove-all-current-buffer))
   (t (message "nothing to do."))))

(global-set-key (kbd "C-x m") 'local/bm-toggle)
(global-set-key (kbd "M-<up>") 'bm-previous)
(global-set-key (kbd "M-<down>") 'bm-next)

(autoload 'bm-toggle   "bm" "Toggle bookmark in current buffer." t)
(autoload 'bm-next     "bm" "Goto bookmark."                     t)
(autoload 'bm-previous "bm" "Goto previous bookmark."            t)


(with-eval-after-load 'xref
  (setq xref-marker-ring-length 100)
  (setq xref-search-program 'ripgrep)
  (global-set-key (kbd "M-<left>") 'xref-go-back)
  (global-set-key (kbd "M-<right>") 'xref-go-forward))


;;; easy-kill
(global-set-key [remap kill-ring-save] 'easy-kill)
(with-eval-after-load 'easy-kill
  (require 'extra-things)
  (add-to-list 'easy-kill-alist '(?W  WORD " ") t)
  (add-to-list 'easy-kill-alist '(?\' squoted-string "") t)
  (add-to-list 'easy-kill-alist '(?\" dquoted-string "") t)
  (add-to-list 'easy-kill-alist '(?\` bquoted-string "") t)
  (add-to-list 'easy-kill-alist '(?q  quoted-string "") t)
  (add-to-list 'easy-kill-alist '(?Q  quoted-string-universal "") t)
  (add-to-list 'easy-kill-alist '(?\) parentheses-pair-content "\n") t)
  (add-to-list 'easy-kill-alist '(?\( parentheses-pair "\n") t)
  (add-to-list 'easy-kill-alist '(?\] brackets-pair-content "\n") t)
  (add-to-list 'easy-kill-alist '(?\[ brackets-pair "\n") t)
  (add-to-list 'easy-kill-alist '(?}  curlies-pair-content "\n") t)
  (add-to-list 'easy-kill-alist '(?{  curlies-pair "\n") t)
  (add-to-list 'easy-kill-alist '(?>  angles-pair-content "\n") t)
  (add-to-list 'easy-kill-alist '(?<  angles-pair "\n") t))
;;; easy-kill end

;;; string-inflection
(global-set-key (kbd "C-c C-u") 'string-inflection-all-cycle)
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-u") 'string-inflection-ruby-style-cycle)))
(add-hook 'java-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-u") 'string-inflection-java-style-cycle)))
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-u") 'string-inflection-python-style-cycle)))
(add-hook 'protobuf-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-u") 'string-inflection-all-cycle)))
;;; string-inflection end


(global-unset-key (kbd "C-x C-b"))

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

(global-set-key (kbd "C-M-p") 'backward-list)
(global-set-key (kbd "C-M-n") 'forward-list)

(global-set-key (kbd "C-x <?\\t>") 'indent-rigidly)

(global-set-key "\C-c$" 'toggle-truncate-lines)

(global-set-key (kbd "S-<return>") 'newline-at-end-of-line)

(with-eval-after-load 'key-chord
  (key-chord-define-global "JJ" 'read-only-mode))

(with-eval-after-load 'general
  (key-chord-mode 1)
  ;; (general-define-key (general-chord "cc") (general-simulate-key "C-c"))
  )
(local/after-init-hook 'general)


;;; format
(setq sh-basic-offset 2)
(setq shfmt-arguments (list "-i" "2"))
(add-hook 'sh-mode-hook 'shfmt-on-save-mode)

;; npm install -g prettier
(with-eval-after-load 'prettier
  (delete 'python prettier-enabled-parsers)
  (delete 'sh prettier-enabled-parsers))


(global-set-key (kbd "<mouse-2>") 'yank)
(global-set-key (kbd "<mouse-3>") 'kill-ring-save)


;;; pasteex-mode
(with-eval-after-load 'markdown-mode
  (require 'pasteex-mode)
  (define-key markdown-mode-map (kbd "C-x p i") #'pasteex-image)
  (define-key markdown-mode-map (kbd "C-x p d") #'pasteex-delete-img-link-and-file-at-line)
  )


(provide 'init-basic)
