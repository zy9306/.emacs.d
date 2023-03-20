(use-package gptel
  :commands
  (gptel gptel-send gptel-send-menu)

  :config
  (use-package markdown-mode)
  (use-package gptel-curl)
  (use-package gptel-transient)

  (setq gptel-default-mode 'markdown-mode)
  (setq gptel-api-key (getenv "OPENAI_API_KEY")))

(add-hook 'gptel-mode-hook (lambda () (org-num-mode -1)))

(defun local/gptel-programming ()
  (interactive)
  (let ((buffer-name "*ChatGPT: Programming*"))
    (if (get-buffer buffer-name)
        (switch-to-buffer buffer-name)
      (gptel buffer-name gptel-api-key)
      )
    (with-current-buffer buffer-name
      (transient:gptel-system-prompt:Programming))
    ))

(defun local/gptel-chat ()
  (interactive)
  (let ((buffer-name "*ChatGPT: Chat*"))
    (if (get-buffer buffer-name)
        (switch-to-buffer buffer-name)
      (gptel buffer-name gptel-api-key)
      )
    (with-current-buffer buffer-name
      (transient:gptel-system-prompt:Chat))
    ))


(provide 'init-gptel)
