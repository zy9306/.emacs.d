(native-compile-async
 '("~/.emacs.d/elpa"
   "~/.emacs.d/lisp"
   "~/.emacs.d/site-lisp"
   )
 'recursively)

;; block until native compilation has finished
(while (or comp-files-queue
           (> (comp-async-runnings) 0))
  (sleep-for 1))
