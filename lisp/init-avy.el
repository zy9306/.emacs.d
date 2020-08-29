;; -*- coding: utf-8; lexical-binding: t; -*-

(require-package 'avy)

(with-eval-after-load 'avy
  (avy-setup-default)

  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2)
  (global-set-key (kbd "M-g f") 'avy-goto-line)
  ;; a char in a word
  (global-set-key (kbd "M-g w") 'avy-goto-word-1)
  ;; a char begin of word
  (global-set-key (kbd "M-g e") 'avy-goto-word-0)
  (global-set-key (kbd "C-c C-j") 'avy-resume))

(local/after-init-hook 'avy)

(provide 'init-avy)
