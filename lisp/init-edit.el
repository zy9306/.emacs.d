(require 'thing-edit)
(require 'emacs-surround)
(require 'duplicate-line)

(defun edit/thing-edit-internal (object-beg object-end &optional kill-conditional)
  (interactive)
  (let ((pulse-iterations 1)
        (pulse-delay thing-edit-flash-line-delay))
    (cond ((string= kill-conditional "cut")
           (when thing-edit-show-message-p
             (message "%s [ %s ]"
                      (propertize "Cut" 'face 'thing-edit-font-lock-action)
                      (buffer-substring object-beg object-end)))
           (kill-region object-beg object-end))
          ((string= kill-conditional "delete")
           (when thing-edit-show-message-p
             (message "%s [ %s ]"
                      (propertize "Delete" 'face 'thing-edit-font-lock-action)
                      (buffer-substring object-beg object-end)))
           (delete-region object-beg object-end))
          ((string= kill-conditional "copy")
           (when thing-edit-show-message-p
             (message "%s [ %s ]"
                      (propertize "Copy" 'face 'thing-edit-font-lock-action)
                      (buffer-substring object-beg object-end)))
           (pulse-momentary-highlight-region object-beg object-end 'thing-edit-font-lock-flash)
           (kill-ring-save object-beg object-end))
          (t
           (message "Nothing to do.")))))

(defun edit/inside-pairs (kill-conditional)
  (save-excursion
    (let ((cur_point (point))
          (start)
          (end))
      (er/mark-inside-pairs)
      (setq start (region-beginning))
      (setq end (region-end))
      (edit/thing-edit-internal start end kill-conditional)
      (if (string= kill-conditional "copy")
          (goto-char cur_point)))))

(defun edit/inside-pairs-cut ()
  (interactive)
  (edit/inside-pairs "cut"))

(defun edit/inside-pairs-copy ()
  (interactive)
  (edit/inside-pairs "copy"))

(defun edit/inside-pairs-delete ()
  (interactive)
  (edit/inside-pairs "delete"))

(defun edit/inside-pairs-replace ()
  (interactive)
  (save-excursion
    (edit/inside-pairs-delete)
    (yank)))


(defun edit/outside-pairs (kill-conditional)
  (save-excursion
    (let ((cur_point (point))
          (start)
          (end))
      (er/mark-outside-pairs)
      (setq start (region-beginning))
      (setq end (region-end))
      (edit/thing-edit-internal start end kill-conditional)
      (if (string= kill-conditional "copy")
          (goto-char cur_point)))))

(defun edit/outside-pairs-cut ()
  (interactive)
  (edit/outside-pairs "cut"))

(defun edit/outside-pairs-copy ()
  (interactive)
  (edit/outside-pairs "copy"))

(defun edit/outside-pairs-delete ()
  (interactive)
  (edit/outside-pairs "delete"))

(defun edit/outside-pairs-replace ()
  (interactive)
  (save-excursion
    (edit/outside-pairs-delete)
    (yank)))


(defun edit/inside-quotes (kill-conditional)
  (save-excursion
    (let ((cur_point (point))
          (start)
          (end))
      (er/mark-inside-quotes)
      (setq start (region-beginning))
      (setq end (region-end))
      (edit/thing-edit-internal start end kill-conditional)
      (if (string= kill-conditional "copy")
          (goto-char cur_point)))))

(defun edit/inside-quotes-cut ()
  (interactive)
  (edit/inside-quotes "cut"))

(defun edit/inside-quotes-copy ()
  (interactive)
  (edit/inside-quotes "copy"))

(defun edit/inside-quotes-delete ()
  (interactive)
  (edit/inside-quotes "delete"))

(defun edit/inside-quotes-replace ()
  (interactive)
  (save-excursion
    (edit/inside-quotes-delete)
    (yank)))


(defun edit/outside-quotes (kill-conditional)
  (save-excursion
    (let ((cur_point (point))
          (start)
          (end))
      (er/mark-outside-quotes)
      (setq start (region-beginning))
      (setq end (region-end))
      (edit/thing-edit-internal start end kill-conditional)
      (if (string= kill-conditional "copy")
          (goto-char cur_point)))))

(defun edit/outside-quotes-cut ()
  (interactive)
  (edit/outside-quotes "cut"))

(defun edit/outside-quotes-copy ()
  (interactive)
  (edit/outside-quotes "copy"))

(defun edit/outside-quotes-delete ()
  (interactive)
  (edit/outside-quotes "delete"))

(defun edit/outside-quotes-replace ()
  (interactive)
  (save-excursion
    (edit/outside-quotes-delete)
    (yank)))


(defun edit/word (kill-conditional)
  (save-excursion
    (let ((cur_point (point))
          (start)
          (end))
      (er/mark-word)
      (setq start (region-beginning))
      (setq end (region-end))
      (edit/thing-edit-internal start end kill-conditional)
      (if (string= kill-conditional "copy")
          (goto-char cur_point)))))

(defun edit/word-cut ()
  (interactive)
  (edit/word "cut"))

(defun edit/word-copy ()
  (interactive)
  (edit/word "copy"))

(defun edit/word-delete ()
  (interactive)
  (edit/word "delete"))

(defun edit/word-replace ()
  (interactive)
  (save-excursion
    (edit/word-delete)
    (yank)))

(defun edit/symbol (kill-conditional)
  (save-excursion
    (let ((cur_point (point))
          (start)
          (end))
      (er/mark-symbol)
      (setq start (region-beginning))
      (setq end (region-end))
      (edit/thing-edit-internal start end kill-conditional)
      (if (string= kill-conditional "copy")
          (goto-char cur_point)))))

(defun edit/symbol-cut ()
  (interactive)
  (edit/symbol "cut"))

(defun edit/symbol-copy ()
  (interactive)
  (edit/symbol "copy"))

(defun edit/symbol-delete ()
  (interactive)
  (edit/symbol "delete"))

(defun edit/symbol-replace ()
  (interactive)
  (save-excursion
    (edit/symbol-delete)
    (yank)))

(defun edit/defun (kill-conditional)
  (save-excursion
    (let ((cur_point (point))
          (start)
          (end))
      (er/mark-defun)
      (setq start (region-beginning))
      (setq end (region-end))
      (edit/thing-edit-internal start end kill-conditional)
      (if (string= kill-conditional "copy")
          (goto-char cur_point)))))

(defun edit/defun-cut ()
  (interactive)
  (edit/defun "cut"))

(defun edit/defun-copy ()
  (interactive)
  (edit/defun "copy"))

(defun edit/defun-delete ()
  (interactive)
  (edit/defun "delete"))


(defun edit/inner-line (kill-conditional)
  (save-excursion
    (let ((cur_point (point))
          (start)
          (end))
      (back-to-indentation)
      (setq start (point))
      (end-of-line)
      (setq end (point))
      (edit/thing-edit-internal start end kill-conditional)
      (if (string= kill-conditional "copy")
          (goto-char cur_point)))))

(defun edit/inner-line-copy ()
  (interactive)
  (edit/inner-line "copy"))

(defun edit/inner-line-delete ()
  (interactive)
  (edit/inner-line "delete"))

(defun edit/inner-line-cut ()
  (interactive)
  (edit/inner-line "cut"))


(global-set-key (kbd "M-d") 'edit/word-delete)

(global-unset-key (kbd "M-s"))
(defhydra hydra-edit (global-map "M-s" :exit t)
  ("wc" edit/word-copy)
  ("wd" edit/word-delete)
  ("wx" edit/word-cut)
  ("wr" edit/word-replace)

  ("qc" edit/inside-quotes-copy)
  ("qd" edit/inside-quotes-delete)
  ("qx" edit/inside-quotes-cut)
  ("qr" edit/inside-quotes-replace)

  ("Qc" edit/outside-quotes-copy)
  ("Qd" edit/outside-quotes-delete)
  ("Qx" edit/outside-quotes-cut)
  ("Qr" edit/outside-quotes-replace)

  ("pc" edit/inside-pairs-copy)
  ("pd" edit/inside-pairs-delete)
  ("px" edit/inside-pairs-cut)
  ("pr" edit/inside-pairs-replace)

  ("Pc" edit/outside-pairs-copy)
  ("Pd" edit/outside-pairs-delete)
  ("Px" edit/outside-pairs-cut)
  ("Pr" edit/outside-pairs-replace)

  ("lc" edit/inner-line-copy)
  ("ld" edit/inner-line-delete)
  ("lx" edit/inner-line-cut)

  ("pp" duplicate-line-or-region-above :exit nil)
  ("nn" duplicate-line-or-region-below :exit nil)
  ("PP" duplicate-line-above-comment :exit nil)
  ("NN" duplicate-line-below-comment :exit nil)
  )

(global-set-key (kbd "M-\"") 'emacs-surround)
(global-set-key (kbd "M-]") #'embrace-commander)


(with-eval-after-load 'tree-sitter
  (require 'grammatical-edit)

  (dolist (hook (list
                 'c-mode-common-hook
                 'c-mode-hook
                 'c++-mode-hook
                 'java-mode-hook
                 'haskell-mode-hook
                 'maxima-mode-hook
                 'ielm-mode-hook
                 'sh-mode-hook
                 'makefile-gmake-mode-hook
                 'php-mode-hook
                 'python-mode-hook
                 'js-mode-hook
                 'go-mode-hook
                 'qml-mode-hook
                 'jade-mode-hook
                 'css-mode-hook
                 'ruby-mode-hook
                 'coffee-mode-hook
                 'rust-mode-hook
                 'qmake-mode-hook
                 'lua-mode-hook
                 'swift-mode-hook
                 'minibuffer-inactive-mode-hook
                 ))
    (add-hook hook (lambda () (grammatical-edit-mode 1))))

  (define-key grammatical-edit-mode-map (kbd "M-[") 'local/grammatical-edit-jump-up))

(defun local/grammatical-edit-jump-up ()
  (interactive)
  (xref--push-markers)
  (grammatical-edit-jump-up))


;;; puni
(require-package 'puni)

(puni-global-mode)

(dolist (hook '(term-mode-hook
                minibuffer-mode-hook
                minibuffer-inactive-mode-hook))
  (add-hook hook #'puni-disable-puni-mode))

(defun edit/puni-kill-line ()
  (interactive)
  (let ((bounds (puni-bounds-of-list-around-point)))
    (if (eq (car bounds) (cdr bounds))
        (when-let ((sexp-bounds (puni-bounds-of-sexp-around-point)))
          (puni-delete-region (car sexp-bounds) (cdr sexp-bounds) 'kill))
      (if (eq (point) (cdr bounds))
          (puni-backward-kill-line)
        (puni-kill-line)))))

(define-key puni-mode-map (kbd "C-k") 'edit/puni-kill-line)

(define-key puni-mode-map (kbd "C-d") nil)
(define-key puni-mode-map (kbd "M-d") nil)
(define-key puni-mode-map (kbd "C-S-k") nil)


(provide 'init-edit)
