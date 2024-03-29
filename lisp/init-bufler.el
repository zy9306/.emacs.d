(global-set-key (kbd "C-x C-S-b") 'list-buffers)

(defun local/toggle-bufler ()
  (interactive)
  (let ((buffer-window (get-buffer-window "*Bufler*")))
    (if buffer-window
        (progn
          (delete-window buffer-window)
          (kill-buffer "*Bufler*"))
      (progn
        (bufler)
        (set-window-parameter buffer-window 'no-delete-other-windows t)
        (set-window-dedicated-p buffer-window t)
        (window-preserve-size buffer-window t t)
        (window-resize
         buffer-window
         (- 25 (window-size buffer-window t nil))
         t t nil)))))

(with-eval-after-load 'bufler
  (global-set-key [remap list-buffers] 'local/toggle-bufler)

  (with-eval-after-load 'key-chord
    (key-chord-define-global "BB" 'local/toggle-bufler))

  (bufler-define-buffer-command switch "Switch to buffer."
    (lambda (buffer)
      (let ((bufler-window (selected-window)))
        (select-window (ace-display-buffer buffer display-buffer-alist))))
    :refresh-p nil))

(local/after-init-hook 'bufler)



(provide 'init-bufler)
