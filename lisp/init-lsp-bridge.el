;;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'lsp-bridge)
(require 'lsp-bridge-icon)

(require 'citre)

(setq lsp-bridge-enable-auto-import nil)

(add-to-list 'lsp-bridge-lang-server-extension-list
             '(("json") . "javascript"))

(when (or *mac* *unix*)
  (setq-default lsp-bridge-python-command "/usr/local/bin/python3"))

(defun lsp-bridge-capf-citre-capf-function ()
  (let ((lsp-result (lsp-bridge-capf)))
    (if (ignore-errors (and lsp-result
                            (try-completion
                             (buffer-substring (nth 0 lsp-result)
                                               (nth 1 lsp-result))
                             (nth 2 lsp-result))))
        lsp-result
      (citre-completion-at-point))))

(add-hook
 'lsp-bridge-mode-hook
 (lambda ()
   (progn
     (setq-local corfu-auto nil)
     (setq-local corfu-auto-prefix 1)

     (setq-local completion-at-point-functions
                 (list
                  (cape-capf-buster
                   (cape-super-capf
                    #'lsp-bridge-capf-citre-capf-function
                    ;; Need good cpu.
                    ;; #'tabnine-completion-at-point
                    #'cape-file
                    #'cape-dabbrev)
                   'equal)))

     (with-eval-after-load 'company
       (company-mode -1)))))

(dolist (hook (list
               'emacs-lisp-mode-hook))
  (add-hook hook (lambda ()
                   (setq-local corfu-auto t))))

;; npm install -g pyright
;; npm install -g typescript-language-server typescript
;; go install golang.org/x/tools/gopls@latest
;; rust
;; curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
;; chmod +x ~/.local/bin/rust-analyzer
;; rustup component add rust-src

(dolist (hook (list
               'python-mode-hook
               'rust-mode-hook
               'go-mode-hook
               'typescript-mode-hook
               'js2-mode-hook
               'js-mode-hook))
  (add-hook hook (lambda ()
                   (setq-local corfu-auto nil)
                   (setq-local corfu-auto-prefix 1)
                   (lsp-bridge-mode 1))))

(define-key lsp-bridge-mode-map (kbd "M-.") 'lsp-bridge-find-def)
(define-key lsp-bridge-mode-map (kbd "C-x 4 .") 'lsp-bridge-find-def-other-window)
(define-key lsp-bridge-mode-map (kbd "M-,") 'lsp-bridge-return-from-def)
(define-key lsp-bridge-mode-map (kbd "C-c l d") 'lsp-bridge-lookup-documentation)
(define-key lsp-bridge-mode-map (kbd "C-c l R") 'lsp-bridge-restart-process)


;;; fix python Path
(defcustom lsp-bridge-current-python-command ""
  ""
  :type 'string)

(defun lsp-bridge-set-current-python-command ()
  (setq lsp-bridge-current-python-command (executable-find "python")))

(add-hook 'pyvenv-post-activate-hooks
          (lambda ()
            (lsp-bridge-set-current-python-command)
            (lsp-bridge-restart-process)))


(provide 'init-lsp-bridge)
