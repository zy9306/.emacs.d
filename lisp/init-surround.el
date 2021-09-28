;;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/cute-jumper/embrace.el
;; https://github.com/ganmacs/emacs-surround


(require 'emacs-surround)

(global-set-key (kbd "M-\"") 'emacs-surround)

(global-set-key (kbd "M-]") #'embrace-commander)



;;; my surround

(setq local/pairs
      '(("(" . ")")
        ("[" . "]")
        ("{" . "}")
        ("<" . ">")
        ("'" . "'")
        ("\"" . "\"")
        ("~" . "~")
        ("`" . "`")
        ))


(defun local/chtholly ()
  "
   c/C -> copy, e.g. C' will copy text in '' with ''，C'' alse work.

   d/D -> delete, e.g. D' will delete text in '' with ''，D'' alse work.

   k/K -> kill, e.g. K' will kill text in '' with ''，K'' will be in kill-ring, alse work.

   ds -> delete pair, e.g. ds' will delete ', ds'' also work

   cs -> change pair, e.g. cs]) will replace the ] with )，cs()[] alse work

   sw -> add pair to word, e.g. sw' will wrap word with '

   sr -> add pair to region

   other will add in future."

  (interactive)
  (let* ((input (delete-dups (split-string (read-string ":") "")))
         (_ (pop input))
         (action (nth 0 input))
         (char (nth 1 input))
         (new_char))

    (if (string= "d" (nth 0 input))
        (if (string= "s" (nth 1 input))
            (progn
              (setq action "ds")
              (setq char (nth 2 input)))))

    (if (string= "c" (nth 0 input))
        (if (string= "s" (nth 1 input))
            (progn
              (setq action "cs")
              (setq char (nth 2 input))
              (setq new_char (nth 3 input)))))

    (if (string= "s" (nth 0 input))
        (progn
          (setq type (nth 1 input))
          (setq char (nth 2 input))
          (local/surround type char)
          (setq char nil)
          ))

    (catch 'ok
      (dolist (pp local/pairs)
        (when (or (string= char (car pp)) (string= char (cdr pp)))
          (local/pair action (car pp) (cdr pp) new_char)
          (throw 'ok "OK"))))))


(defun local/surround (type char)
  (interactive)
  (save-excursion)
  (let ((cur_point (point))
        (start)
        (end)
        )
    (if (string= "w" type)
        (progn
          (er/mark-word)
          (setq start (region-beginning))
          (setq end (region-end))
          (catch 'ok
            (dolist (pp local/pairs)
              (when (or (string= char (car pp)) (string= char (cdr pp)))
                (goto-char end)
                (insert (cdr pp))
                (goto-char start)
                (insert (car pp))
                (goto-char cur_point)
                (throw 'ok "OK"))))))

    (if (string= "r" type)
        (progn
          (setq start (region-beginning))
          (setq end (region-end))
          (catch 'ok
            (dolist (pp local/pairs)
              (when (or (string= char (car pp)) (string= char (cdr pp)))
                (goto-char end)
                (insert (cdr pp))
                (goto-char start)
                (insert (car pp))
                (goto-char cur_point)
                (throw 'ok "OK"))))))
    ))


(defun local/pair (action c1 c2 new_char)
  "action c/C -> copy
   action d/D -> delete
   action k/K -> kill"
  (interactive)
  (save-excursion)
  (let ((cur_point (point))
        (start)
        (end)
        (cur_char (char-to-string (char-after)))
        )
    (if (string= c1 cur_char)
        (forward-char))
    (if (string= c2 cur_char)
        (backward-char))

    (setq start (search-backward c1))
    (forward-sexp)
    (setq end (point))
    (goto-char cur_point)

    (if (string= action "ds")
        (progn
          (delete-region (- end 1) end)
          (delete-region start (+ start 1))))

    (if (string= action "cs")
        (catch 'ok
          (dolist (pp local/pairs)
            (when (or (string= new_char (car pp)) (string= new_char (cdr pp)))
              (delete-region (- end 1) end)
              (goto-char (- end 1))
              (insert (cdr pp))
              (delete-region start (+ start 1))
              (goto-char start)
              (insert (car pp))
              (goto-char cur_point)
              (throw 'ok "OK")))))

    (if (s-lowercase-p action)
        (progn
          (setq start (+ start 1))
          (setq end (- end 1))))

    (setq action (downcase action))
    (if (string= action "c")
        (kill-ring-save start end))
    (if (string= action "d")
        (delete-region start end))
    (if (string= action "k")
        (kill-region start end))
    ))

(add-hook 'after-init-hook (lambda () (global-set-key (kbd "C-\\") #'local/chtholly)))



(provide 'init-surround)
