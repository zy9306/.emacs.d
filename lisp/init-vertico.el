;;; 草稿，目前不会用，以后可能会删除，还是继续用 ivy，ivy 够用了


(defun local/init-vertico ()
  (require 'vertico)
  (require 'orderless)
  (require 'consult)
  (require 'embark)
  (require 'embark-consult)

  (vertico-mode)
  (setq completion-styles '(orderless))

  (setq consult-project-root-function #'project-root)

  (setq prefix-help-command #'embark-prefix-help-command)

  ;; consult
  (global-set-key (kbd "C-c h") 'consult-history)
  (global-set-key (kbd "C-c m") 'consult-mode-command)
  (global-set-key (kbd "C-c b") 'consult-bookmark)
  (global-set-key (kbd "C-x b") 'consult-buffer)
  (global-set-key (kbd "C-x 4 b") 'consult-buffer-other-window)
  (global-set-key (kbd "C-x 5 b") 'consult-buffer-other-frame)
  (global-set-key (kbd "M-g M-g") 'consult-goto-line)
  (global-set-key (kbd "M-g o") 'consult-outline)
  (global-set-key (kbd "M-g m") 'consult-mark)
  (global-set-key (kbd "M-g k") 'consult-global-mark)
  (global-set-key (kbd "M-g i") 'consult-imenu)
  (global-set-key (kbd "M-g I") 'consult-imenu-multi)

  (global-set-key (kbd "M-s g") 'consult-grep)
  (global-set-key (kbd "M-s G") 'consult-git-grep)
  (global-set-key (kbd "C-S-s") 'consult-ripgrep)
  (global-set-key (kbd "C-s") 'consult-line)
  (global-set-key (kbd "M-s L") 'consult-line-multi)
  (global-set-key (kbd "M-s m") 'consult-multi-occur)
  (global-set-key (kbd "M-s k") 'consult-keep-lines)
  (global-set-key (kbd "M-s u") 'consult-focus-lines)

  ;; embark
  (global-set-key (kbd "C-c C-o") 'embark-export)
  (global-set-key (kbd "C-.") 'embark-act)
  (global-set-key (kbd "C-;") 'embark-dwim)
  (global-set-key (kbd "C-h B") 'embark-bindings)

  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))

  (add-hook 'embark-collect-mode-hook 'consult-preview-at-point-mode))


(with-eval-after-load 'vertico
  (local/init-vertico))

(local/after-init-hook 'vertico)


(provide 'init-vertico)
