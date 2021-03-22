;;; -*- coding: utf-8; lexical-binding: t; -*-


(global-set-key (kbd "C-x C-S-b") 'list-buffers)


(with-eval-after-load 'bufler
  (global-set-key [remap list-buffers] 'bufler)

  (with-eval-after-load 'key-chord
    (key-chord-define-global "jk" 'bufler))
  )

(local/after-init-hook 'bufler)


(provide 'init-bufler)
