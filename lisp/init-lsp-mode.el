;;; -*- coding: utf-8; lexical-binding: t; -*-

(setq lsp-keymap-prefix "C-c l")

(setq dap-auto-configure-mode nil)

(use-package lsp-mode
  :custom
  (lsp-log-io nil)
  (lsp-idle-delay 0.500)
  (lsp-completion-provider :capf)
  (lsp-enable-file-watchers nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-auto-guess-root t)
  (lsp-enable-imenu nil)
  (lsp-signature-auto-activate nil)
  (lsp-signature-render-documentation nil)
  (lsp-signature-doc-lines 1)
  (lsp-keep-workspace-alive nil)
  (lsp-enable-folding nil)
  (lsp-enable-links nil)
  (lsp-enable-symbol-highlighting nil)

  :config
  (define-key lsp-mode-map [remap xref-find-definitions] 'lsp-find-definition)
  (define-key lsp-mode-map [remap xref-find-references] 'lsp-find-references)

  (defun local/replace-lsp-completion-at-point ()
    (setq-local completion-at-point-functions nil)
    (add-hook 'completion-at-point-functions 'lsp-citre-capf-function nil t))

  (add-hook 'lsp-completion-mode-hook 'local/replace-lsp-completion-at-point)

  (defun local/lsp-deferred ()
    (lsp-deferred)
    (local/config-company-backends)
    (add-hook 'completion-at-point-functions 'lsp-citre-capf-function nil t))

  (defun local/lsp-result ()
    (ignore-errors (lsp-completion-at-point)))

  (defun lsp-citre-capf-function ()
    (let ((lsp-result (local/lsp-result)))
      (if (ignore-errors (and lsp-result
                              (try-completion
                               (buffer-substring (nth 0 lsp-result)
                                                 (nth 1 lsp-result))
                               (nth 2 lsp-result))))
          lsp-result
        (citre-completion-at-point))))
  )


;;; client
;; for ruff-lsp diagnostics: /usr/local/bin/python3.10 -m pip install ruff-lsp
(defun local/lsp-python ()
  (require 'lsp-pyright)
  (setq lsp-pyright-typechecking-mode "off")
  (local/lsp-deferred))


(defun local/lsp-go ()
  (require 'lsp-go)
  (local/lsp-deferred))


(when (executable-find "pyright-langserver")
  (add-hook 'python-mode-hook 'local/lsp-python))


(with-eval-after-load 'go-mode
  (add-hook 'go-mode-hook 'local/lsp-go))



(provide 'init-lsp-mode)
