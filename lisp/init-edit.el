(require 's)


(defun local/vi-like-edit ()
  (interactive)
  (save-excursion)
  (let* ((input (read-string ":"))
         (start)
         (end)
         (cur_point (point))
         (count (string-to-number input))
         (action (s-replace (format "%s" count) "" input)))

    (if (or (string= "yj" action) (string= "Dj" action) (string= "dj" action))
        (catch 'ok
          (progn
            (move-beginning-of-line 1)
            (set-mark (point))
            (next-line (+ count 1))
            (move-beginning-of-line 1)
            (setq start (region-beginning))
            (setq end (region-end))

            (if (string= "yj" action)
                (kill-ring-save start end)
              (if (string= "dj" action)
                  (kill-region start end)
                (if (string= "Dj" action)
                    (delete-region start end))))
            (goto-char cur_point)
            (throw 'ok "OK"))))

    (if (or (string= "yk" action) (string= "Dk" action) (string= "dk" action))
        (catch 'ok
          (progn
            (move-end-of-line 1)
            (set-mark (point))
            (previous-line count)
            (move-beginning-of-line 1)
            (setq start (region-beginning))
            (setq end (region-end))

            (if (string= "yk" action)
                (kill-ring-save start end)
              (if (string= "dk" action)
                  (kill-region start end)
                (if (string= "Dk" action)
                    (delete-region start end))))
            (goto-char cur_point)
            (throw 'ok "OK"))))
    ))


(require 'general)
(require 'thing-edit)
(require 'emacs-surround)
(require 'duplicate-line)


(global-unset-key (kbd "C-\\"))

(defhydra hydra-awesome-tab (global-map "C-\\" :exit t)
  ("yw" thing-copy-word)
  ("yp" thing-copy-parentheses)
  ("yn" thing-copy-number)
  ("ys" thing-copy-symbol)
  ("yy" thing-copy-line)
  ("ya" thing-copy-to-line-beginning)
  ("ye" thing-copy-to-line-end)

  ("dw" thing-cut-word)
  ("dp" thing-cut-parentheses)
  ("dn" thing-cut-number)
  ("ds" thing-cut-symbol)
  ("dd" thing-cut-line)
  ("da" thing-cut-to-line-beginning)
  ("de" thing-cut-to-line-end)

  ("rw" thing-replace-word)
  ("rp" thing-replace-parentheses)
  ("rs" thing-replace-symbol)

  ("pp" duplicate-line-or-region-above :exit nil)
  ("nn" duplicate-line-or-region-below :exit nil)
  ("PP" duplicate-line-above-comment :exit nil)
  ("NN" duplicate-line-below-comment :exit nil)

  ("'" 'embrace-commander)
  ("\"" 'emacs-surround))



(provide 'init-edit)
