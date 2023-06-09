(use-package devil
  :init
  (add-hook 'after-init-hook 'global-devil-mode)

  :config
  (devil-set-key (kbd "j"))

  ;; https://susam.github.io/devil/#custom-devil-key
  (define-key devil-mode-map (kbd ",") #'devil)
  (add-to-list 'devil-special-keys `(", ," . ,(devil-key-executor ",")))
  (dolist (item '((", ," . ",")
		          ("," . "M-")))
    (add-to-list 'devil-translations item))

  (dolist (item (list ", f" ", b" ", n" ", p" "%k >" "%k <"))
    (add-to-list 'devil-repeatable-keys item))
  )
