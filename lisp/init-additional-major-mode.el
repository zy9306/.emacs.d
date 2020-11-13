;; -*- coding: utf-8; lexical-binding: t; -*-

;; 一些简单的major mode

(use-package markdown-mode
  :ensure t
  :defer t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package markdown-toc
  :ensure t
  :defer t)

(use-package yaml-mode
  :ensure t
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
  (add-hook 'yaml-mode-hook
    '(lambda ()
       (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(use-package dockerfile-mode
  :ensure t
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package protobuf-mode
  :ensure t
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

  (defconst my-protobuf-style
    '((c-basic-offset . 4)
      (indent-tabs-mode . nil)))
  (add-hook 'protobuf-mode-hook
            (lambda () (c-add-style "my-protobuf-style" my-protobuf-style t)))
  )


(provide 'init-additional-major-mode)
