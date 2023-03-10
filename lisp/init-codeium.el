(use-package codeium
  :init
  (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
  (add-hook 'emacs-startup-hook (lambda () (run-with-timer 0.5 nil #'codeium-init)))
  )


(provide 'init-codeium)
