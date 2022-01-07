;;; https://github.com/Kinneyzhang/gkroam/blob/develop/gkroam.el#L1782-L1889

(defvar local/org-list-re
  "^ *\\([0-9]+[).]\\|[*+-]\\) \\(\\[[ X-]\\] \\)?"
  "Org list bullet and checkbox regexp.")

(defun local/org-fontify-org-checkbox (notation)
  "Highlight org checkbox with NOTATION."
  (add-text-properties
   (match-beginning 2) (1- (match-end 2)) `(display ,notation)))

(defun local/org-fontify-org-list ()
  "Highlight org list, including bullet and checkbox."
  (with-silent-modifications
    (add-text-properties
     (match-beginning 1) (match-end 1)
     '(display "•"))
    (when (match-beginning 2)
      (pcase (match-string-no-properties 2)
        ("[-] " (local/org-fontify-org-checkbox "☐"))
        ("[ ] " (local/org-fontify-org-checkbox "☐"))
        ("[X] " (local/org-fontify-org-checkbox "☑"))))))

(defun local/org-list-fontify (beg end)
  "Highlight org list bullet between BEG and END."
  (save-excursion
    (goto-char beg)
    (while (re-search-forward local/org-list-re end t)
      (if (string= (match-string-no-properties 1) "*")
          (unless (= (match-beginning 0) (match-beginning 1))
            (local/org-fontify-org-list))
        (local/org-fontify-org-list)))))


;;;###autoload
(define-minor-mode local/org-list-prettify-mode
  "Minor mode for prettifying list."
  :lighter ""
  :keymap nil
  (if local/org-list-prettify-mode
      (progn
        (jit-lock-register #'local/org-list-fontify)
        (local/org-list-fontify (point-min) (point-max)))
    (jit-lock-unregister #'local/org-list-fontify)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward local/org-list-re nil t)
        (with-silent-modifications
          (remove-text-properties (match-beginning 0) (match-end 0)
                                  '(display nil))))))
  (jit-lock-refontify))


(provide 'init-org-list)
