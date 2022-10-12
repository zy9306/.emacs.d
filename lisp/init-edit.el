(require 'thing-edit)
(require 'emacs-surround)
(require 'duplicate-line)

(defun local/thing-edit-internal (object-beg object-end &optional kill-conditional)
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

(defun local/inside-pairs (kill-conditional)
  (save-excursion)
  (let ((cur_point (point))
        (start)
        (end))
    (er/mark-inside-pairs)
    (setq start (region-beginning))
    (setq end (region-end))
    (local/thing-edit-internal start end kill-conditional)
    (if (string= kill-conditional "copy")
        (goto-char cur_point))))

(defun local/inside-pairs-cut ()
  (interactive)
  (local/inside-pairs "cut"))

(defun local/inside-pairs-copy ()
  (interactive)
  (local/inside-pairs "copy"))

(defun local/inside-pairs-delete ()
  (interactive)
  (local/inside-pairs "delete"))


(defun local/outside-pairs (kill-conditional)
  (save-excursion)
  (let ((cur_point (point))
        (start)
        (end))
    (er/mark-outside-pairs)
    (setq start (region-beginning))
    (setq end (region-end))
    (local/thing-edit-internal start end kill-conditional)
    (if (string= kill-conditional "copy")
        (goto-char cur_point))))

(defun local/outside-pairs-cut ()
  (interactive)
  (local/outside-pairs "cut"))

(defun local/outside-pairs-copy ()
  (interactive)
  (local/outside-pairs "copy"))

(defun local/outside-pairs-delete ()
  (interactive)
  (local/outside-pairs "delete"))


(defun local/inside-quotes (kill-conditional)
  (save-excursion)
  (let ((cur_point (point))
        (start)
        (end))
    (er/mark-inside-quotes)
    (setq start (region-beginning))
    (setq end (region-end))
    (local/thing-edit-internal start end kill-conditional)
    (if (string= kill-conditional "copy")
        (goto-char cur_point))))

(defun local/inside-quotes-cut ()
  (interactive)
  (local/inside-quotes "cut"))

(defun local/inside-quotes-copy ()
  (interactive)
  (local/inside-quotes "copy"))

(defun local/inside-quotes-delete ()
  (interactive)
  (local/inside-quotes "delete"))


(defun local/outside-quotes (kill-conditional)
  (save-excursion)
  (let ((cur_point (point))
        (start)
        (end))
    (er/mark-outside-quotes)
    (setq start (region-beginning))
    (setq end (region-end))
    (local/thing-edit-internal start end kill-conditional)
    (if (string= kill-conditional "copy")
        (goto-char cur_point))))

(defun local/outside-quotes-cut ()
  (interactive)
  (local/outside-quotes "cut"))

(defun local/outside-quotes-copy ()
  (interactive)
  (local/outside-quotes "copy"))

(defun local/outside-quotes-delete ()
  (interactive)
  (local/outside-quotes "delete"))


(defun local/word (kill-conditional)
  (save-excursion)
  (let ((cur_point (point))
        (start)
        (end))
    (er/mark-word)
    (setq start (region-beginning))
    (setq end (region-end))
    (local/thing-edit-internal start end kill-conditional)
    (if (string= kill-conditional "copy")
        (goto-char cur_point))))

(defun local/word-cut ()
  (interactive)
  (local/word "cut"))

(defun local/word-copy ()
  (interactive)
  (local/word "copy"))

(defun local/word-delete ()
  (interactive)
  (local/word "delete"))


(defun local/symbol (kill-conditional)
  (save-excursion)
  (let ((cur_point (point))
        (start)
        (end))
    (er/mark-symbol)
    (setq start (region-beginning))
    (setq end (region-end))
    (local/thing-edit-internal start end kill-conditional)
    (if (string= kill-conditional "copy")
        (goto-char cur_point))))

(defun local/symbol-cut ()
  (interactive)
  (local/symbol "cut"))

(defun local/symbol-copy ()
  (interactive)
  (local/symbol "copy"))

(defun local/symbol-delete ()
  (interactive)
  (local/symbol "delete"))


(defun local/defun (kill-conditional)
  (save-excursion)
  (let ((cur_point (point))
        (start)
        (end))
    (er/mark-defun)
    (setq start (region-beginning))
    (setq end (region-end))
    (local/thing-edit-internal start end kill-conditional)
    (if (string= kill-conditional "copy")
        (goto-char cur_point))))

(defun local/defun-cut ()
  (interactive)
  (local/defun "cut"))

(defun local/defun-copy ()
  (interactive)
  (local/defun "copy"))

(defun local/defun-delete ()
  (interactive)
  (local/defun "delete"))


(defun local/replace-word ()
  (interactive)
  (thing-replace-word))

(defun local/replace-parentheses ()
  (interactive)
  (thing-replace-parentheses))

(defun local/replace-symbol ()
  (interactive)
  (thing-replace-symbol))

(defun local/copy-line ()
  (interactive)
  (thing-copy-line))


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

(defun local/puni-kill-line ()
  (interactive)
  (let ((bounds (puni-bounds-of-list-around-point)))
    (if (eq (car bounds) (cdr bounds))
        (when-let ((sexp-bounds (puni-bounds-of-sexp-around-point)))
          (puni-delete-region (car sexp-bounds) (cdr sexp-bounds) 'kill))
      (if (eq (point) (cdr bounds))
          (puni-backward-kill-line)
        (puni-kill-line)))))

(define-key puni-mode-map (kbd "C-k") 'local/puni-kill-line)

(define-key puni-mode-map (kbd "C-d") nil)
(define-key puni-mode-map (kbd "C-S-k") nil)


(provide 'init-edit)
