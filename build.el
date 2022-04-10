;;; M-x `eval-buffer' here

;; put `((emacs-lisp-mode . ((no-byte-compile . t))))' in
;; `.dir-locals.el' if don't want to compile

;; find . -type f -name "*.elc" | xargs -I {} rm -f {}

(let ((elpa "~/.emacs.d/elpa")
      (lisp "~/.emacs.d/lisp")
      (site-lisp "~/.emacs.d/site-lisp"))
  (byte-recompile-directory site-lisp 0 nil)
  (byte-recompile-directory elpa 0 nil)
  (byte-recompile-directory lisp 0 nil)

  (if (and (fboundp 'native-comp-available-p)
           (native-comp-available-p))
      `(progn
         (native-compile-async ,site-lisp 'recursively)
         (native-compile-async ,elpa 'recursively)
         (native-compile-async ,lisp 'recursively)

         (while (or comp-files-queue
                    (> (comp-async-runnings) 0))
           (sleep-for 1)))
    (message "Native complation is *not* available")))
