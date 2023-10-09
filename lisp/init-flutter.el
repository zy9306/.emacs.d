(use-package dart-mode
  :defer t
  :mode "\\.dart\\'"
  :config
  (add-hook 'dart-mode-hook 'lsp))


(provide 'init-flutter)
