;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/abo-abo/hydra

(require-package 'hydra)


(require 'hydra)

(defhydra hydra-dired-menu (:color pink
                            :hint nil)
  "
  ^Mark^                                    ^Actions^
  ------------------------------------------------------------------------------------
  _m_: dired-mark                           _x_: dired-do-flagged-delete
  _d_: dired-flag-file-deletion             _i_: dired-insert-subdir
  _t_: dired-toggle-marks                   _Q_: dired-do-find-regexp-and-replace
  _#_: dired-flag-auto-save-files           _(_: dired-hide-details-mode
  _~_: dired-flag-backup-files              _R_: dired-do-rename
  _u_: dired-unmark                         _D_: dired-do-delete
  _U_: dired-unmark-all-marks               _&_: dired-do-async-shell-command
  ^ ^                                       _$_: dired-hide-subdir
  ^ ^                                       _C_: dired-do-copy

  'C-x C-j': dired-jump
  'w': copy file name
  '0 w': copy file full path
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

(add-hook 'dired-mode-hook (lambda () (define-key dired-mode-map "," 'hydra-dired-menu/body)))


(provide 'init-hydra)
