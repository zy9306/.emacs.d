;;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Debuggers.html


(pretty-hydra-define local/gud (:foreign-keys warn :title "GUD" :quit-key "q")
  ("KEY"
   (("b" gud-break "break")
    ("d" gud-remove "remove")
    ("n" gud-next "next")
    ("s" gud-step "step")
    ("p" gud-print "print")
    ("t" gud-trace "trace")
    ("r" gud-cont "continue")
    ("f" gud-finish "finish")
    ("l" gud-refresh "refresh")
    ("<" gud-up "up")
    (">" gud-down "down")

    ("G" dlv-current-func "dlv-current-func"))))


(global-set-key (kbd "C-x C-a h") 'local/gud)


(with-eval-after-load 'go-mode
  (require 'go-dlv))


(provide 'init-gud)
