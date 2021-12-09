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


(require 'pretty-hydra)
(require 'hydra-posframe)
(require 'thing-edit)
(require 'emacs-surround)
(require 'duplicate-line)

(add-hook 'after-init-hook 'hydra-posframe-mode)

(pretty-hydra-define local/Illyasviel (:foreign-keys warn :title "Thing edit." :exit t)
  ("Copy Cut Replace"
   (("yw" thing-copy-word "copy-word")
    ("yp" thing-copy-parentheses "copy-parentheses")
    ("yn" thing-copy-number "copy-number")
    ("ys" thing-copy-symbol "copy-symbol")
    ("yy" thing-copy-line "copy-line")
    ("ya" thing-copy-to-line-beginning "copy-to-line-beginning")
    ("ye" thing-copy-to-line-end "copy-to-line-end")

    ("dw" thing-cut-word "cut-word")
    ("dp" thing-cut-parentheses "cut-parentheses")
    ("dn" thing-cut-number "cut-number")
    ("ds" thing-cut-symbol "cut-symbol")
    ("dd" thing-cut-line "cut-line")
    ("da" thing-cut-to-line-beginning "cut-to-line-beginning")
    ("de" thing-cut-to-line-end "cut-to-line-end")

    ("rw" thing-replace-word "replace-word")
    ("rp" thing-replace-parentheses "replace-parentheses")
    ("rs" thing-replace-symbol "replace-symbol")

    ("v" local/vi-like-edit "vi like copy cut delete"))

    "Duplicate line"
    (("pp" duplicate-line-or-region-above "duplicate-line-or-region-above" :exit nil)
     ("nn" duplicate-line-or-region-below "duplicate-line-or-region-below" :exit nil)
     ("PP" duplicate-line-above-comment   "duplicate-line-above-comment" :exit nil)
     ("NN" duplicate-line-below-comment   "duplicate-line-below-comment" :exit nil))

   "Surround"
   (("'" embrace-commander "embrace-commander")
    ("\"" emacs-surround "emacs-surround"))
   ))


(add-hook 'after-init-hook (lambda () (global-set-key (kbd "C-\\") 'local/Illyasviel/body)))


(provide 'init-edit)
