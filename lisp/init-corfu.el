;;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/setup-corfu ()
  (use-package corfu
    :custom
    (corfu-auto t)
    (corfu-auto-prefix 1)
    (corfu-auto-delay 0.2)
    ;; (corfu-separator ?\s) ;; uncomment to use space for orderless fuzzy
    ;; (corfu-quit-at-boundary nil) ;; uncomment to use orderless fuzzy
    (corfu-quit-no-match t)
    (corfu-preview-current nil)
    (corfu-preselect-first t)
    (corfu-on-exact-match nil)
    (corfu-echo-documentation nil)
    (corfu-scroll-margin 5)
    :bind
    (:map corfu-map
          ([return] . corfu-insert)
          ([tab] . corfu-next)
          ([backtab] . corfu-previous)
          ("M-SPC" . corfu-insert-separator))
    :config
    (global-corfu-mode))

  (use-package corfu-history
    :config
    (corfu-history-mode))

  (with-eval-after-load 'corfu
    (require 'cape)
    (require 'cape-keyword)

    (setq dabbrev-case-replace nil)

    (global-set-key (kbd "M-/") 'cape-dabbrev)

    (add-to-list 'completion-at-point-functions #'cape-file)
    (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (add-to-list 'completion-at-point-functions #'cape-keyword)
    (add-to-list 'completion-at-point-functions #'cape-abbrev)
    (add-to-list 'completion-at-point-functions #'cape-symbol))

  (use-package orderless
    :init
    (setq completion-styles '(orderless basic))
    (setq completion-category-defaults nil)
    (setq completion-category-overrides '((file (styles . (partial-completion))))))

  (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

  (use-package dabbrev
    :bind (("M-/" . dabbrev-completion)
           ("C-M-/" . dabbrev-expand))
    :custom
    (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'"))))

(defun corfu-enable-in-minibuffer ()
  (when (where-is-internal #'completion-at-point (list (current-local-map)))
    (corfu-mode 1)))


(local/setup-corfu)


(provide 'init-corfu)
