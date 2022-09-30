;;; -*- coding: utf-8; lexical-binding: t; -*-

(with-eval-after-load 'lsp-bridge
  (setq lsp-bridge-disable-backup nil)
  (setq lsp-bridge-enable-diagnostics nil)
  (setq lsp-bridge-diagnostics-fetch-idle 5)
  (setq lsp-bridge-enable-signature-help t)

  (dolist (hook '(text-mode-hook
                  yaml-mode-hook))
    (add-hook hook (lambda () (setq-local lsp-bridge-enable-signature-help nil))))

  (setq acm-backend-lsp-enable-auto-import nil)
  (setq acm-enable-doc nil)
  (setq acm-enable-dabbrev t)
  (setq acm-dabbrev-min-length 2)
  (setq acm-backend-lsp-candidate-max-length 50)
  (setq acm-candidate-match-function 'orderless-flex)
  (setq acm-enable-search-words nil)

  (if (image-type-available-p 'svg)
      (setq acm-enable-icon t)
    (setq acm-enable-icon nil))

  (when (or *mac* *unix*)
    (setq-default lsp-bridge-python-command "/usr/local/bin/python3"))

  (add-to-list 'lsp-bridge-single-lang-server-extension-list
               '(("json") . "javascript"))

  (dolist (item '("dabbrev-completion"
                  "corfu-insert"))
    (add-to-list 'lsp-bridge-completion-stop-commands item))

  (add-hook 'lsp-bridge-mode-hook (lambda () (setq-local corfu-auto nil)))

  (setq lsp-bridge-default-mode-hooks
        '(c++-mode-hook
          c-mode-hook
          css-mode-hook
          dart-mode-hook
          elixir-mode-hook
          ;; go-mode-hook
          js-mode-hook
          js2-mode-hook
          lua-mode-hook
          ;; python-mode-hook
          rjsx-mode-hook
          ruby-mode-hook
          rust-mode-hook
          rustic-mode-hook
          typescript-mode-hook
          typescript-tsx-mode-hook))

  (global-lsp-bridge-mode)

  (define-key lsp-bridge-mode-map (kbd "M-.") #'lsp-bridge-find-def)
  (define-key lsp-bridge-mode-map (kbd "C-x 4 .") #'lsp-bridge-find-def-other-window)
  (define-key lsp-bridge-mode-map (kbd "M-,") #'lsp-bridge-return-from-def)
  (define-key lsp-bridge-mode-map (kbd "C-c l h") #'lsp-bridge-lookup-documentation)
  (define-key lsp-bridge-mode-map (kbd "C-c l i") #'lsp-bridge-find-impl)
  (define-key lsp-bridge-mode-map (kbd "C-c l 4 i") #'lsp-bridge-find-impl-other-window)
  (define-key lsp-bridge-mode-map (kbd "C-c l r") #'lsp-bridge-rename)
  (define-key lsp-bridge-mode-map (kbd "C-c l R") #'lsp-bridge-restart-process)

;;; python virtual env
  ;; (defun local/lsp-bridge-get-single-lang-server-by-project (project-path filepath)
  ;;   (let* ((json-object-type 'plist)
  ;;          (custom-dir (expand-file-name ".cache/lsp-bridge/pyright" user-emacs-directory))
  ;;          (custom-config (expand-file-name "pyright.json" custom-dir))
  ;;          (default-config (json-read-file (expand-file-name "repo/lsp-bridge/langserver/pyright.json" user-emacs-directory)))
  ;;          (settings (plist-get default-config :settings)))

  ;;     (plist-put settings :pythonPath (executable-find "python"))

  ;;     (plist-put settings :python.analysis (plist-put (plist-get settings :python.analysis) :autoImportCompletions json-false))

  ;;     (make-directory (file-name-directory custom-config) t)

  ;;     (with-temp-file custom-config
  ;;       (insert (json-encode default-config)))

  ;;     custom-config))

  ;; (add-hook 'python-mode-hook (lambda () (setq-local lsp-bridge-get-single-lang-server-by-project 'local/lsp-bridge-get-single-lang-server-by-project)))

  ;; (add-hook 'pyvenv-post-activate-hooks
  ;;           (lambda ()
  ;;             (lsp-bridge-restart-process)))
  )

(local/after-init-hook 'lsp-bridge)


;;; eglot
(require 'eglot)
(require 'eldoc-box)

;; hook
(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

;; eldoc-box
(add-hook 'eldoc-box-buffer-hook (lambda () (unless truncate-lines (toggle-truncate-lines))))

;; disable lsp imenu
(setq eglot-stay-out-of '(imenu))

;; custom lsp command
(add-to-list 'eglot-server-programs '(go-mode . ("gopls" "-remote=auto")))
(add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio")))

;; key binding
(define-key eglot-mode-map (kbd "C-c l h") #'eldoc-box-eglot-help-at-point)
(define-key eglot-mode-map (kbd "C-c l r") #'eglot-rename)
(define-key eglot-mode-map (kbd "C-c l a") #'eglot-code-actions)
(define-key eglot-mode-map (kbd "C-c l i") #'eglot-find-implementation)

;; after eglot start
(add-hook 'eglot-managed-mode-hook #'local/setup-eglot)

(defun local/setup-eglot ()
  ;; (eldoc-mode -1)
  (setq-local eldoc-echo-area-use-multiline-p 1)

  (flymake-mode -1)

  (local/setup-capf)

  (setq completion-category-overrides '((eglot (styles orderless))))
  (setq-local completion-category-defaults nil)
  )

(defun local/lsp-result ()
  (ignore-errors (eglot-completion-at-point)))

(defun lsp-with-citre-capf ()
  (let ((lsp-result (local/lsp-result)))
    (if (ignore-errors (and lsp-result
                            (try-completion
                             (buffer-substring (nth 0 lsp-result)
                                               (nth 1 lsp-result))
                             (nth 2 lsp-result))))
        lsp-result
      (citre-completion-at-point))))

(defun local/setup-xref ()
  (add-hook 'citre-mode-hook
            (lambda () (dolist (xref-backend '(eglot-xref-backend))
                         (if (member xref-backend xref-backend-functions)
                             (progn
                               (setq xref-backend-functions (remove xref-backend xref-backend-functions))
                               (add-to-list 'xref-backend-functions xref-backend)))))))

(defun local/setup-capf ()
  (setq-local completion-at-point-functions nil)
  (add-hook 'completion-at-point-functions 'lsp-with-citre-capf nil t))


;;; lsp server install
;; py
;; npm install -g pyright

;; ts,js
;; npm install -g typescript-language-server typescript

;; go
;; go install golang.org/x/tools/gopls@latest

;; rust
;; curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
;; chmod +x ~/.local/bin/rust-analyzer
;; rustup component add rust-src

(provide 'init-lsp)
