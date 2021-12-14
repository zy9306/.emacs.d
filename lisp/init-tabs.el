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

  (awesome-tab-mode t))

(local/after-init-hook 'awesome-tab)

(provide 'init-tabs)
