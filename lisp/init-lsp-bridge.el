(with-eval-after-load 'lsp-bridge
  (setq lsp-bridge-disable-backup nil)
  (setq lsp-bridge-enable-diagnostics nil)
  (setq lsp-bridge-enable-auto-format-code nil)
  (setq lsp-bridge-diagnostics-fetch-idle 5)
  (setq lsp-bridge-enable-signature-help t)

  (dolist (hook '(text-mode-hook
                  yaml-mode-hook))
    (add-hook hook (lambda () (setq-local lsp-bridge-enable-signature-help nil))))

  (setq acm-backend-lsp-enable-auto-import nil)
  (setq acm-enable-doc nil)
  (setq acm-enable-tabnine nil)
  (setq acm-enable-citre nil)
  (setq acm-enable-dabbrev t)
  (setq acm-enable-search-words nil)
  (setq acm-dabbrev-min-length 2)
  (setq acm-backend-lsp-candidate-max-length 50)
  (setq acm-candidate-match-function 'orderless-flex)

  (if (image-type-available-p 'svg)
      (setq acm-enable-icon t)
    (setq acm-enable-icon nil))

  (when (or *mac* *unix*)
    (setq-default lsp-bridge-python-command "/usr/local/bin/python3"))

  (dolist (item '("dabbrev-completion"
                  "corfu-insert"))
    (add-to-list 'lsp-bridge-completion-stop-commands item))

  (add-hook 'lsp-bridge-mode-hook (lambda () (setq-local corfu-auto nil)))

  (add-to-list 'lsp-bridge-single-lang-server-extension-list
               '(("json") . "javascript"))

  (dolist (hook '())
    (add-hook hook (lambda () (lsp-bridge-mode 1))))

  (define-key lsp-bridge-mode-map (kbd "M-.") #'lsp-bridge-find-def)
  (define-key lsp-bridge-mode-map (kbd "C-x 4 .") #'lsp-bridge-find-def-other-window)
  (define-key lsp-bridge-mode-map (kbd "M-,") #'lsp-bridge-return-from-def)
  (define-key lsp-bridge-mode-map (kbd "C-c l h") #'lsp-bridge-lookup-documentation)
  (define-key lsp-bridge-mode-map (kbd "C-c l i") #'lsp-bridge-find-impl)
  (define-key lsp-bridge-mode-map (kbd "C-c l 4 i") #'lsp-bridge-find-impl-other-window)
  (define-key lsp-bridge-mode-map (kbd "C-c l r") #'lsp-bridge-rename)
  (define-key lsp-bridge-mode-map (kbd "C-c l a") #'lsp-bridge-code-action)
  (define-key lsp-bridge-mode-map (kbd "C-c l R") #'lsp-bridge-restart-process))

(local/after-init-hook 'lsp-bridge)


(provide 'init-lsp-bridge)
