;;; -*- coding: utf-8; lexical-binding: t; -*-

;;; eglot
(require 'eglot)
(require 'eldoc-box)

;; hook
(dolist
    (hook
     '(
       python-mode-hook
       rust-mode-hook
       go-mode-hook
       js-mode-hook
       typescript-mode-hook
       ruby-mode-hook
       ))
  (add-hook hook (lambda () (eglot-ensure))))

(add-hook 'eldoc-box-buffer-hook (lambda () (unless truncate-lines (toggle-truncate-lines))))

(setq eglot-stay-out-of '(imenu))

(add-to-list 'eglot-server-programs '(go-mode . ("gopls" "-remote=auto")))
(add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio")))

(define-key eglot-mode-map (kbd "C-c l h") #'eldoc-box-eglot-help-at-point)
(define-key eglot-mode-map (kbd "C-c l r") #'eglot-rename)
(define-key eglot-mode-map (kbd "C-c l a") #'eglot-code-actions)
(define-key eglot-mode-map (kbd "C-c l f") #'eglot-format-buffer)
(define-key eglot-mode-map (kbd "C-c l d") #'eglot-find-typeDefinition)
(define-key eglot-mode-map (kbd "C-c l i") #'eglot-find-implementation)
(define-key eglot-mode-map (kbd "C-c l R") #'eglot-reconnect)

(with-eval-after-load 'js-mode
  (define-key js-mode-map (kbd "M-.") #'eglot-find-typeDefinition))

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "M-.") #'citre-jump+))

(add-hook 'eglot-managed-mode-hook #'local/setup-eglot)

(defun local/setup-eglot ()
  (setq-local eldoc-echo-area-use-multiline-p 1)

  (flymake-mode -1)

  (local/setup-capf)

  (local/setup-xref)

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

;; ruby
;; gem install solargraph


(provide 'init-lsp)
