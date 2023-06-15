(use-package wrap-region
  :init
  (add-hook 'after-init-hook 'wrap-region-global-mode)

  :config
  (wrap-region-add-wrappers
   '(("~" "~" "~" org-mode)
     ("`" "`" nil (markdown-mode ruby-mode)))))
