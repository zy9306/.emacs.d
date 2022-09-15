;;; -*- coding: utf-8; lexical-binding: t; -*-

(require-package 'corfu)
(require-package 'corfu-doc)
(require-package 'cape)

(defun local/setup-corfu ()
  (use-package corfu
    :custom
    (corfu-auto t)
    (corfu-auto-prefix 1)
    (corfu-auto-delay 0.2)
    (corfu-quit-no-match t)
    (corfu-preview-current nil)
    (corfu-preselect-first t)
    (corfu-on-exact-match nil)
    (corfu-echo-documentation nil)
    (corfu-scroll-margin 5)
    :bind
    (:map corfu-map
          ;; use default corfu-separator and corfu-quit-at-boundary
          ("M-SPC" . corfu-insert-separator)
          ([return] . corfu-insert)
          ([tab] . corfu-next)
          ([backtab] . corfu-previous))
    :config
    (global-corfu-mode))

  (use-package corfu-history
    :config
    (corfu-history-mode))

  (use-package corfu-indexed
    :config
    (corfu-indexed-mode))

  (use-package corfu-info)

  (use-package cape
    :init
    (setq dabbrev-case-replace nil)

    :config
    (require 'cape-keyword)

    (global-set-key (kbd "M-/") 'cape-dabbrev)

    (dolist (hook '(yaml-mode-hook
                    text-mode-hook
                    ))
      (add-hook hook
                (lambda ()
                  (setq-local completion-at-point-functions
                              (list
                               (cape-capf-buster
                                (cape-super-capf
                                 #'cape-file
                                 #'cape-dabbrev
                                 #'cape-keyword
                                 #'cape-abbrev
                                 #'cape-symbol
                                 )
                                'equal))))))

    (add-to-list 'completion-at-point-functions #'cape-file)
    (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (add-to-list 'completion-at-point-functions #'cape-keyword)
    (add-to-list 'completion-at-point-functions #'cape-abbrev)
    (add-to-list 'completion-at-point-functions #'cape-symbol))

  (use-package dabbrev
    :bind (("M-/" . dabbrev-completion)
           ("C-M-/" . dabbrev-expand))
    :custom
    (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'"))))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (partial-completion))))))

(add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

(defun corfu-enable-in-minibuffer ()
  (when (where-is-internal #'completion-at-point (list (current-local-map)))
    (corfu-mode 1)))


(local/setup-corfu)


(provide 'init-corfu)
