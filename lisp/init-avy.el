;;; -*- coding: utf-8; lexical-binding: t; -*-

(with-eval-after-load 'avy
  (avy-setup-default)

  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2)
  (global-set-key (kbd "M-g f") 'avy-goto-line)
  ;; a char in a word
  (global-set-key (kbd "M-g w") 'avy-goto-word-1)
  ;; a char begin of word
  (global-set-key (kbd "M-g e") 'avy-goto-word-0)
  (global-set-key (kbd "C-c C-j") 'avy-resume)

  ;; (with-eval-after-load 'key-chord
  ;;   (key-chord-define-global "jf" 'avy-goto-char-2)
  ;;   (key-chord-define-global "jj" 'avy-goto-line))
  )

(local/after-init-hook 'avy)


;; https://github.com/Dewdrops/isearch-dabbrev
(eval-after-load "isearch"
  '(progn
     (require 'isearch-dabbrev)
     (define-key isearch-mode-map (kbd "<tab>") 'isearch-dabbrev-expand)))

(provide 'init-avy)
