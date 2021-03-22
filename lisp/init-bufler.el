;;; -*- coding: utf-8; lexical-binding: t; -*-


(global-set-key (kbd "C-x C-S-b") 'list-buffers)


(defun local/bufler ()
  (interactive)
  (bufler)
  (let ((buffer-window (get-buffer-window "*Bufler*")))
    (set-window-parameter buffer-window 'no-delete-other-windows t)
    (set-window-dedicated-p buffer-window t)))

(with-eval-after-load 'bufler
  (global-set-key [remap list-buffers] 'local/bufler)

  (with-eval-after-load 'key-chord
    (key-chord-define-global "jk" 'local/bufler))
  )

(local/after-init-hook 'bufler)


(provide 'init-bufler)
