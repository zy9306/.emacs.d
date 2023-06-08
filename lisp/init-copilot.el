(use-package copilot
  :diminish copilot-mode
  :hook
  (prog-mode . copilot-mode)
  (yaml-mode . copilot-mode)
  (go-mode . copilot-mode)

  :custom
  (copilot-idle-delay 0.5)

  :bind
  (
   :map copilot-completion-map
   ("<right>" . copilot-accept-completion)
   ("M-f" . copilot-accept-completion-by-word)
   ("M-n" . copilot-next-completion)
   ("M-p" . copilot-previous-completion)
   )

  :config
  (set-face-attribute
   'copilot-overlay-face nil
   :foreground "#bf616a"
   )
  )

(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))


(provide 'init-copilot)
