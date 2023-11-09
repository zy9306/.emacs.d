(require 'lsp-bridge)
(setq lsp-bridge-disable-backup nil)
(setq lsp-bridge-enable-auto-format-code nil)
(setq lsp-bridge-enable-hover-diagnostic t)

(dolist (hook '(text-mode-hook
                yaml-mode-hook))
  (add-hook hook (lambda () (setq-local lsp-bridge-enable-signature-help nil))))

(setq acm-backend-lsp-enable-auto-import nil)
(setq acm-enable-doc nil)
(setq acm-enable-yas nil)
(setq acm-enable-tabnine t)
(setq acm-enable-citre nil)
(setq acm-backend-lsp-candidate-max-length 60)

(if (image-type-available-p 'svg)
    (setq acm-enable-icon t)
  (setq acm-enable-icon nil))

(setq-default lsp-bridge-python-command *python*)

(dolist (item '("copilot-accept-completion" "yank"))
  (add-to-list 'lsp-bridge-completion-stop-commands item))

;; (with-eval-after-load 'dart-mode
;;   (add-hook 'dart-mode-hook (lambda () (lsp-bridge-mode 1))))

;; (dolist (hook '())
;;   (add-hook hook (lambda () (lsp-bridge-mode 1))))

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

;; (local/after-init-hook 'lsp-bridge)

(add-hook 'after-init-hook 'global-lsp-bridge-mode)

(provide 'init-lsp-bridge)
