;;; -*- coding: utf-8; lexical-binding: t; -*-


(with-eval-after-load 'snails
  (require 'snails)

  (global-set-key (kbd "M-[") 'snails))


(local/after-init-hook 'snails)

(provide 'init-snails)
