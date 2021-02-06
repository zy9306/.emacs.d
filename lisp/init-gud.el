;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Debuggers.html


(defhydra hydra-gud-menu (:color pink :hint nil)
  ("b" gud-break "break")
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

  ("G" dlv-current-func "dlv-current-func")

  ("q" quit-window "quit" :color blue))

(global-set-key (kbd "C-x C-a h") 'hydra-gud-menu/body)

(with-eval-after-load 'go-mode
  (require 'go-dlv))


(provide 'init-gud)
