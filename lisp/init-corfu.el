;;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/setup-corfu ()
  (use-package corfu
    :custom
    (corfu-auto t)
    (corfu-auto-prefix 1)
    (corfu-separator ?\s)
    (corfu-quit-at-boundary nil)
    (corfu-quit-no-match t)
    (corfu-preview-current nil)
    (corfu-preselect-first t)
    (corfu-on-exact-match nil)
    (corfu-echo-documentation nil)
    (corfu-scroll-margin 5)
    :bind
    (:map corfu-map
          ("RET" . corfu-insert)
          ("TAB" . corfu-next)
          ("S-TAB" . corfu-previous))
    :init
    (global-corfu-mode))

  (with-eval-after-load 'corfu
    (require 'cape)
    (require 'cape-keyword)

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


(with-eval-after-load 'corfu
  (local/setup-corfu))


(local/after-init-hook 'corfu)


(provide 'init-corfu)
