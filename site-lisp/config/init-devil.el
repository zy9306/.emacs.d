(use-package devil
  :init
  (add-hook 'after-init-hook 'global-devil-mode)

  :config
  (devil-set-key (kbd "j"))

  ;; https://susam.github.io/devil/#custom-devil-key
  (define-key devil-mode-map (kbd "k") #'devil)
  (add-to-list 'devil-special-keys `("k k" . ,(devil-key-executor "k")))
  (dolist (item '(("k k" . "k")
		          ("k" . "M-")))
    (add-to-list 'devil-translations item))

  (dolist (item (list "k f" "k b" "k n" "k p" "k _" "%k >" "%k <" "%k _"))
    (add-to-list 'devil-repeatable-keys item))
  )
