;;; -*- coding: utf-8; lexical-binding: t; -*-


(with-eval-after-load 'awesome-tab
  (require 'awesome-tab)

  (setq awesome-tab-show-tab-index t)
  (setq awesome-tab-active-bar-height 25)

  (global-set-key (kbd "s-1") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-2") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-3") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-4") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-5") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-6") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-7") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-8") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-9") 'awesome-tab-select-visible-tab)
  (global-set-key (kbd "s-0") 'awesome-tab-select-visible-tab)

  ;; (global-set-key (kbd "M-<right>") 'awesome-tab-forward-tab)
  ;; (global-set-key (kbd "M-<left>") 'awesome-tab-backward-tab)

  (global-unset-key (kbd "C-<tab>"))
  (global-set-key (kbd "C-<tab>") 'awesome-tab-forward-group)

  (global-set-key (kbd "M-S-<right>") 'awesome-tab-move-current-tab-to-right)
  (global-set-key (kbd "M-S-<left>") 'awesome-tab-move-current-tab-to-left)

  (global-set-key [tab-line mouse-2] 'local/close-tab-by-click)

  (awesome-tab-mode t)

  ;; override awesome-tab-buffer-groups
  (defun awesome-tab-buffer-groups ()
    (list
     (cond
      ((string-equal "*" (substring (buffer-name) 0 1))
       "Emacs")
      ((derived-mode-p 'eshell-mode)
       "EShell")
      ((derived-mode-p 'emacs-lisp-mode)
       "Elisp")
      ((memq major-mode '(org-mode org-agenda-mode diary-mode))
       "OrgMode")
      (t
       (awesome-tab-get-group-name (current-buffer)))))))


(defun local/close-tab-by-click (event)
  (interactive "e")
  (let* ((pos (posn-string (event-start event)))
         (visible-tabs (awesome-tab-view awesome-tab-current-tabset))
         (raw (string-trim (car pos)))
         (_ (set-text-properties 0 (length raw) nil raw))
         (s_l (split-string raw))
         (index (car (last s_l)))
         (tab)
         (buffer_name))
    (setq index (string-remove-prefix "[" index))
    (setq index (string-remove-suffix "]" index))
    (setq index (string-to-number index))
    (setq tab (nth (- index 1) visible-tabs))
    (setq buffer_name (car tab))
    (kill-buffer buffer_name)
    (message "Killed: <%s>" buffer_name)))


(local/after-init-hook 'awesome-tab)



(provide 'init-tabs)
