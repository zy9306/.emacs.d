;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/abo-abo/hydra

(require-package 'hydra)


(require 'hydra)

(defhydra hydra-dired-menu (:color pink
                            :hint nil)
  "
  ^Mark^                             ^Actions^
  ------------------------------------------------------------------------------------
  _m_: mark                           _x_: execute
  _d_: mark for delete                _i_: insert subdir below
  _t_: toggle mark for all file       _Q_: query-replace-regexp
  _#_: mark auto save files           _(_: hide detail mode
  _~_: mark backup files              _R_: dired do rename
  _u_: mark                           _D_: dired do delete
  _U_: unmark all                     _&_: dired do async shell command
  ^ ^                                 _$_: hide subdir
  ^ ^                                 _C_: copy
  "
  ("m" dired-mark)
  ("d" dired-flag-file-deletion)
  ("t" dired-toggle-marks)
  ("#" dired-flag-auto-save-files)
  ("~" dired-flag-backup-files)
  ("u" dired-unmark)
  ("U" dired-unmark-all-marks)
  ("x" dired-do-flagged-delete)
  ("i" dired-insert-subdir)
  ("Q" dired-do-find-regexp-and-replace)
  ("(" dired-hide-details-mode)
  ("R" dired-do-rename)
  ("D" dired-do-delete)
  ("&" dired-do-async-shell-command)
  ("$" dired-hide-subdir)
  ("C" dired-do-copy)
  ("c" nil "cancel")
  ("q" quit-window "quit" :color blue)
  )


(require 'dired)
(define-key dired-mode-map "," 'hydra-dired-menu/body)



(provide 'init-hydra)
