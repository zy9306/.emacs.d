(use-package reformatter
  :config
  (reformatter-define go-template-format
    :program "prettier"
    :args (list "--parser" "go-template" "--plugin" "prettier-plugin-go-template" input-file))

  (reformatter-define black-format
    :program "black"
    :args '("-t" "py310" "-"))

  (reformatter-define isort-format
    :program "isort"
    :args '("-")))


(setq sh-basic-offset 2)
(setq shfmt-arguments (list "-i" "2"))
(add-hook 'sh-mode-hook 'shfmt-on-save-mode)


(with-eval-after-load 'prettier
  ;; npm install -g prettier
  (delete 'python prettier-enabled-parsers)
  (delete 'sh prettier-enabled-parsers))


(provide 'init-formatter)
