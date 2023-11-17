;;; -*- lexical-binding: t -*-

(dolist (hook '(python-ts-mode-hook
                go-ts-mode-hook
                yaml-ts-mode-hook))
  (add-hook hook (lambda() (local-set-key (kbd "RET") 'electric-newline-and-maybe-indent))))


(provide 'init-last)
