;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md

(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; START
;; use nox instead of lsp-mode
;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md

;; (with-eval-after-load 'go-mode
;;   (require 'lsp-mode)
;;   (require 'yasnippet)
;;   (lsp-register-custom-settings
;;    '(("gopls.completeUnimported" nil nil)
;;      ("gopls.staticcheck" t t)))
;;   (add-hook 'go-mode-hook 'lsp-deferred)
;;   (yas-minor-mode)
;;   )
;; END

;; 实时保存可能会造成卡顿
;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
;; use apheleia instead
;; (defun go-mode-save-hooks ()
;;   (setq gofmt-show-errors 'echo)
;;   (setq gofmt-command "goimports")
;;   (add-hook 'before-save-hook 'gofmt-before-save))
;; (add-hook 'go-mode-hook #'go-mode-save-hooks)

(defun local/go-test-current-func ()
  (interactive)
  (let (current-test-name current-bench-name current-func-loc)
    (save-excursion
      (when (go-beginning-of-defun)
        (setq current-func-loc (format "%s:%d" buffer-file-name (line-number-at-pos)))
        (when (looking-at go-func-regexp)
          (let ((func-name (match-string 1)))
            (when (string-match-p "_test\.go$" buffer-file-name)
              (cond
               ((string-match-p "^Test\\|^Example" func-name)
                (setq current-test-name func-name))
               ((string-match-p "^Benchmark" func-name)
                (setq current-bench-name func-name))))))))

    (if current-func-loc
        (let (go-test-buffer-name go-test-command)
          (cond
           (current-test-name
            (setq go-test-buffer-name "*go-test*")
            (setq go-test-command (concat "go" " test -run " current-test-name)))
           (current-bench-name
            (setq go-test-buffer-name "*go-test*")
            (setq go-test-command (concat "go" " test -- -test.run='^$' -test.bench=" current-bench-name))))

          (let ((go-test-buffer (get-buffer go-test-buffer-name)))
            (when go-test-buffer (kill-buffer go-test-buffer)))
          ;; or use start-process
          (async-shell-command go-test-command go-test-buffer-name))
      (error "Not in function"))))


(provide 'init-go)
