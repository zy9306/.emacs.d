(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

(setq go-ts-mode-indent-offset 4)

;; setup flycheck
(defun local/setup-flycheck-for-go ()
  (require 'flycheck)
  (dolist (checker (list
                    'go-vet
                    'go-golint
                    'go-gofmt
                    ))
    (add-to-list 'flycheck-disabled-checkers checker)))

(add-hook 'go-mode-hook #'local/setup-flycheck-for-go)
(add-hook 'go-ts-mode-hook #'local/setup-flycheck-for-go)


;;; FORMAT START
;; (defun local/go-mode-save-hooks ()
;;   (setq gofmt-show-errors 'echo)
;;   (setq gofmt-command "goimports")
;;   (add-hook 'before-save-hook 'gofmt-before-save))
;; (add-hook 'go-mode-hook #'local/go-mode-save-hooks)

(defun local/go-test-current-func ()
  (interactive)
  (require 'go-mode)
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

          ;; or use start-process
          (async-shell-command go-test-command go-test-buffer-name))
      (error "Not in function"))))

;; for mac m1
(when *mac*
  (setq go-dlv-command-name "arch -arm64 dlv"))

(provide 'init-go)
