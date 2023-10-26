(use-package chatgpt-shell)
(use-package dall-e-shell)

(use-package shell-maker
  :commands
  (chatgpt-shell dall-e-shell)

  :config
  (setq chatgpt-shell-openai-key (getenv "OPENAI_API_KEY")))
