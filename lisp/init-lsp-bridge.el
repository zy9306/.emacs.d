(require 'lsp-bridge)
(setq lsp-bridge-disable-backup nil)
(setq lsp-bridge-enable-diagnostics nil)
(setq lsp-bridge-diagnostic-fetch-idle 5)
(setq lsp-bridge-enable-auto-format-code nil)

(dolist (hook '(text-mode-hook
                yaml-mode-hook))
  (add-hook hook (lambda () (setq-local lsp-bridge-enable-signature-help nil))))

(setq acm-backend-lsp-candidate-min-length 2)
(setq acm-backend-codeium-candidate-min-length 2)
(setq acm-backend-search-file-words-candidate-min-length 2)
(setq acm-backend-lsp-enable-auto-import nil)
(setq acm-enable-doc nil)
(setq acm-enable-yas nil)
(setq acm-enable-tabnine nil)
(setq acm-enable-citre nil)
(setq acm-backend-lsp-candidate-max-length 60)
(setq acm-enable-quick-access t)
(setq acm-quick-access-use-number-select t)

(setq-default lsp-bridge-python-command *python*)

(dolist (item '("copilot-accept-completion" "yank"))
  (add-to-list 'lsp-bridge-completion-stop-commands item))

(add-hook 'pyvenv-post-activate-hooks (lambda () (lsp-bridge-restart-process)))

(define-key lsp-bridge-mode-map (kbd "M-.") #'lsp-bridge-find-def)
(define-key lsp-bridge-mode-map (kbd "C-x 4 .") #'lsp-bridge-find-def-other-window)
(define-key lsp-bridge-mode-map (kbd "M-,") #'lsp-bridge-find-def-return)
(define-key lsp-bridge-mode-map (kbd "C-c l h") #'lsp-bridge-popup-documentation)
(define-key lsp-bridge-mode-map (kbd "C-c l i") #'lsp-bridge-find-impl)
(define-key lsp-bridge-mode-map (kbd "C-c l 4 i") #'lsp-bridge-find-impl-other-window)
(define-key lsp-bridge-mode-map (kbd "C-c l r") #'lsp-bridge-rename)
(define-key lsp-bridge-mode-map (kbd "C-c l a") #'lsp-bridge-code-action)
(define-key lsp-bridge-mode-map (kbd "C-c l R") #'lsp-bridge-restart-process)

(add-hook 'after-init-hook 'global-lsp-bridge-mode)

(provide 'init-lsp-bridge)
