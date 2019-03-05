(use-package elpa-mirror

  ;; https://github.com/redguardtoo/elpa-mirror
  ;; M-x elpamr-create-mirror-for-installed to create local repository.
  ;; M-x elpamr-create-mirror-for-installed command again for update
  
  :ensure t

  :config
  (setq elpamr-default-output-directory "~/myelpa/"))


(provide 'init-elpa-mirror)

