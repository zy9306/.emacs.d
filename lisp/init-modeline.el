;;; awesome-tray
(with-eval-after-load 'awesome-tray
  (require 'awesome-tray)

  (awesome-tray-mode 1)

  ;; see awesome-tray-module-alist
  (setq awesome-tray-active-modules
        '("location"
          "awesome-tab"
          "belong"
          "buffer-name"
          "buffer-read-only"
          "mode-name"
          "git"
          "battery"
          "date")))
(local/after-init-hook 'awesome-tray)



;;; spaceline
(with-eval-after-load 'spaceline
  (setq spaceline-minor-modes-p nil)

  (require 'spaceline-config)
  (require 'spaceline-segments)

  ;; override spaceline--theme
  (defun spaceline--theme (left second-left &rest additional-segments)
    (spaceline-compile
      `(,left
        auto-compile
        ,second-left
        (which-function :priority 99)
        (major-mode :priority 79)
        (process :when active)
        ((flycheck-error flycheck-warning flycheck-info)
         :when active
         :priority 89)
        (minor-modes :when active
                     :priority 9)
        (mu4e-alert-segment :when active)
        (erc-track :when active)
        (version-control :when active
                         :priority 78)
        (org-pomodoro :when active)
        (org-clock :when active)
        nyan-cat)
      `((python-pyvenv :fallback python-pyenv)
        (purpose :priority 94)
        (battery :when active)
        (selection-info :priority 95)
        input-method
        ((buffer-encoding-abbrev
          point-position
          line-column)
         :separator " | "
         :priority 96)
        (global :when active)
        ,@additional-segments
        (buffer-position :priority 99)
        (hud :priority 99)))

    (setq-default mode-line-format '("%e" (:eval (spaceline-ml-main)))))

  (spaceline-spacemacs-theme)

  (set-face-attribute
   'mode-line nil
   :background "#e7e7e7" :box '(:line-width 1 :color "grey75"))
  )
;; (local/after-init-hook 'spaceline)



(provide 'init-modeline)
