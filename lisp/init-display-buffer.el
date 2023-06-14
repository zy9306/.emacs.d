;;; https://depp.brause.cc/shackle/

(use-package shackle
  :ensure t
  :defer t
  :init
  (setq shackle-rules
        '(("*Buffer List*"
           :regexp nil
           :select t
           :align right
           :size 0.33)

          ("*Async Shell Command*"
           :regexp nil
           :ignore t)

          ("*Bufler*"
           :regexp nil
           :select t
           :align left
           :inhibit-window-quit t
           :size 0.20)

          ("\\*Flycheck errors\\*.*"
           :regexp t
           :inhibit-window-quit t
           :same t)

          ("\\*Flycheck checker\\*"
           :regexp t
           :inhibit-window-quit t
           :select nil
           :ignore t)

          ("*VC-history*"
           :regexp nil
           :inhibit-window-quit t
           :select t
           :other t)

          ("\\*ivy-occur.*\\*"
           :regexp t
           :select t
           :align below
           :size 0.33)

          ("\\*Org Src.*\\*"
           :regexp t
           :select t
           :same t)

          ("\\*.*\\*"
           :regexp t
           :select t
           :align below
           :size 0.33)
          ))

  (add-hook 'after-init-hook (lambda () (shackle-mode 1))))


(provide 'init-display-buffer)
