(use-package chatgpt-shell)
(use-package dall-e-shell)

(use-package shell-maker
  :commands
  (chatgpt-shell dall-e-shell)

  :bind
  (
   :map shell-maker-map
   ("<RET>" . nil)
   ("C-c <RET>" . shell-maker-return))

  :config
  (setq chatgpt-shell-openai-key (getenv "OPENAI_API_KEY")))
