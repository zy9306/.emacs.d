;;; -*- coding: utf-8; lexical-binding: t; -*-


(with-eval-after-load 'snails
  (require 'snails)

  (setq snails-show-with-frame nil)
  (global-set-key (kbd "M-[") 'snails))


(local/after-init-hook 'snails)

(provide 'init-snails)
