;; https://github.com/manateelazycat/lazycat-emacs/blob/master/site-lisp/config/init-easy-nav.el#L92

(defvar easy-nav-map nil
  "Keymap used when popup is shown.")

(setq easy-nav-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "j") #'next-line)
        (define-key map (kbd "k") #'previous-line)
        (define-key map (kbd "h") #'backward-char)
        (define-key map (kbd "l") #'forward-char)

        (define-key map (kbd "g g") #'beginning-of-buffer)
        (define-key map (kbd "G") #'end-of-buffer)

        (define-key map (kbd "b") #'backward-word)
        (define-key map (kbd "w") #'forward-word)

        (define-key map (kbd "S") #'projectile-ripgrep)

        (define-key map (kbd "i") #'symbol-overlay-put)
        (define-key map (kbd "n") #'symbol-overlay-jump-next)
        (define-key map (kbd "p") #'symbol-overlay-jump-prev)

        (define-key map (kbd ",") #'xref-go-back)
        (define-key map (kbd ".") #'xref-find-definitions)

        (define-key map (kbd "<") #'remember-init)
        (define-key map (kbd ">") #'remember-jump)

        (define-key map (kbd "q") #'easy-nav-exist)
        map))

(define-minor-mode easy-nav-mode
  "Easy navigator."
  :keymap easy-nav-map
  :init-value nil)

(defun easy-nav-enter ()
  (interactive)
  (read-only-mode 1)
  (easy-nav-mode 1)
  (message "Enter easy navigator."))

(defun easy-nav-exist ()
  (interactive)
  (read-only-mode -1)
  (easy-nav-mode -1)
  (message "Exit easy navigator."))

(defun remember-init ()
  "Remember current position and setup."
  (interactive)
  (point-to-register 8)
  (message "Have remember one position"))

(defun remember-jump ()
  "Jump to latest position and setup."
  (interactive)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp))
  (message "Have back to remember position"))


(provide 'init-easy-nav)
