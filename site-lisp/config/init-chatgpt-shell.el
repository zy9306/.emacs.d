(use-package chatgpt-shell
  :commands
  (chatgpt-shell dall-e-shell)

  :bind
  (
   :map chatgpt-shell-map
   ("<RET>" . nil)
   ("C-c <RET>" . chatgpt-shell-return))

  :config
  (setq chatgpt-shell-openai-key (getenv "OPENAI_API_KEY")))
