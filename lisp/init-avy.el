;; -*- coding: utf-8; lexical-binding: t; -*-

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

  (with-eval-after-load 'key-chord
    (key-chord-define-global "jj" 'avy-goto-char-2)))
(local/after-init-hook 'avy)

(defun local/config-ace-isearch()
  (global-ace-isearch-mode +1)
  ;; 默认输入超过 ace-isearch-input-length 个字符触发 swiper，禁用
  (setq ace-isearch-use-function-from-isearch nil)
  (setq ace-isearch-use-jump nil)
  (define-key isearch-mode-map (kbd "C-'") 'ace-isearch-jump-during-isearch))
(use-package ace-isearch
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook #'local/config-ace-isearch))

;; https://github.com/Dewdrops/isearch-dabbrev
(eval-after-load "isearch"
  '(progn
     (require 'isearch-dabbrev)
     (define-key isearch-mode-map (kbd "<tab>") 'isearch-dabbrev-expand)))

(defun local/config-avy-zap()
  (global-set-key (kbd "M-z") 'avy-zap-to-char-dwim)
  (global-set-key (kbd "M-Z") 'avy-zap-up-to-char-dwim))
(use-package avy-zap
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook #'local/config-avy-zap))

(provide 'init-avy)
