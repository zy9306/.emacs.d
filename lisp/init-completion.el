;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package company
  :ensure t
  :defer t
  ;; :diminish company-mode " co"
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay 0.05)
  (setq company-tooltip-idle-delay 0.05)
  (setq company-minimum-prefix-length 2)
  ;; origin
  ;; (company-bbdb
  ;;  company-eclim
  ;;  company-semantic
  ;;  company-clang
  ;;  company-xcode
  ;;  company-cmake
  ;;  company-capf
  ;;  company-files
  ;;  (company-dabbrev-code company-gtags company-etags company-keywords)
  ;;  company-oddmuse company-dabbrev)
  (setq company-backends
        ;; 同一组(即同一括号)中的backends能同时被用到
        ;; The CAPF back-end provides a bridge to the standard completion-at-point-functions facility
        '(company-capf
          company-files
          (company-dabbrev-code company-keywords)
          company-dabbrev))
  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-other-backend)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))


;; https://github.com/sebastiencs/company-box/
;; mac下图标异常
;; (use-package company-box
;;   :ensure t
;;   :defer t
;;   :diminish company-box-mode
;;   :hook (company-mode . company-box-mode)
;;   :init
;;   (setq company-box-doc-enable nil))


;; https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (yas-global-mode 1)
  )


(use-package yasnippet-snippets)


(provide 'init-completion)
