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

(global-unset-key (kbd "C-\\"))

(defhydra hydra-awesome-tab (global-map "C-\\" :exit t)
  ;; er copy
  ("yw" (lambda () (interactive) (local/word "copy")))
  ("ys" (lambda () (interactive) (local/symbol "copy")))
  ("yf" (lambda () (interactive) (local/defun "copy")))
  ("yp" (lambda () (interactive) (local/inside-pairs "copy")))
  ("yap" (lambda () (interactive) (local/outside-pairs "copy")))
  ("y'" (lambda () (interactive) (local/inside-quotes "copy")))
  ("ya'" (lambda () (interactive) (local/outside-quotes "copy")))

  ;; er cut
  ("dw" (lambda () (interactive) (local/word "cut")))
  ("ds" (lambda () (interactive) (local/symbol "cut")))
  ("df" (lambda () (interactive) (local/defun "cut")))
  ("dp" (lambda () (interactive) (local/inside-pairs "cut")))
  ("dap" (lambda () (interactive) (local/outside-pairs "cut")))
  ("d'" (lambda () (interactive) (local/inside-quotes "cut")))
  ("da'" (lambda () (interactive) (local/outside-quotes "cut")))

  ;; er delete
  ("Dw" (lambda () (interactive) (local/word "delete")))
  ("Ds" (lambda () (interactive) (local/symbol "delete")))
  ("Df" (lambda () (interactive) (local/defun "delete")))
  ("Dp" (lambda () (interactive) (local/inside-pairs "delete")))
  ("Dap" (lambda () (interactive) (local/outside-pairs "delete")))
  ("D'" (lambda () (interactive) (local/inside-quotes "delete")))
  ("Da'" (lambda () (interactive) (local/outside-quotes "delete")))

  ;; thing at point
  ("yy" thing-copy-line)
  ("yA" thing-copy-to-line-beginning)
  ("yE" thing-copy-to-line-end)

  ("dd" thing-cut-line)
  ("dA" thing-cut-to-line-beginning)
  ("dE" thing-cut-to-line-end)

  ("rw" thing-replace-word)
  ("rp" thing-replace-parentheses)
  ("rs" thing-replace-symbol)

  ;; duplicate-line
  ("pp" duplicate-line-or-region-above :exit nil)
  ("nn" duplicate-line-or-region-below :exit nil)
  ("PP" duplicate-line-above-comment :exit nil)
  ("NN" duplicate-line-below-comment :exit nil)

  ;; surround
  ("'" embrace-commander)
  ("\"" emacs-surround))


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

  (define-key grammatical-edit-mode-map (kbd "M-[") 'local/grammatical-edit-jump-up)
  (define-key grammatical-edit-mode-map (kbd "C-k") 'grammatical-edit-kill))

(defun local/grammatical-edit-jump-up ()
  (interactive)
  (xref--push-markers)
  (grammatical-edit-jump-up))


;;; puni
(require-package 'puni)

(puni-global-mode)

(dolist (hook '(term-mode-hook
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


(provide 'init-edit)
