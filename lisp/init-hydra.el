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


(defhydra hydra-mc (:color pink :hint nil)
  "
  ^Mark^                                 ^UMark^                               ^Special^
  -----------------------------------------------------------------------------------------------------
  _>_: mc/mark-next-like-this            _}_: mc/skip-to-next-like-this        _n_: mc/insert-numbers
  _<_: mc/mark-previous-like-this        _{_: mc/skip-to-previous-like-this    _l_: mc/insert-letters
  _+_: mc/mark-all-in-region             _]_: mc/unmark-next-like-this
  _d_: mc/mark-all-like-this-in-defun    _[_: mc/unmark-previous-like-this
  _i_: mc/mark-all-dwim

  Tips:
  C-': hide all lines without a cursor, again to unhide.
  C-x r y: yank a rectangle
  C-v/M-v:  scroll the screen to center on each cursor
  C->/C-< and C-c < is origin binding for mark next and previous and all like this.
  "
  (">" mc/mark-next-like-this)
  ("<" mc/mark-previous-like-this)
  ("+" mc/mark-all-in-region)
  ("d" mc/mark-all-like-this-in-defun)
  ("i" mc/mark-all-dwim)
  ("n" mc/insert-numbers)
  ("l" mc/insert-letters)
  ("}" mc/skip-to-next-like-this)
  ("{" mc/skip-to-previous-like-this)
  ("]" mc/unmark-next-like-this)
  ("[" mc/unmark-previous-like-this)
  ("c" nil "cancel")
  ("q" quit-window "quit" :color blue)
  )

(global-unset-key (kbd "C-?"))
(global-set-key (kbd "C-? m") 'hydra-mc/body)

(provide 'init-hydra)
