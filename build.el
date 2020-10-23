(native-compile-async
 '("~/.emacs.d/elpa-28.0"
   "~/.emacs.d/nox"
   "~/.emacs.d/lisp"
   )
 'recursively)

;; block until native compilation has finished
(while (or comp-files-queue
           (> (comp-async-runnings) 0))
  (sleep-for 1))
