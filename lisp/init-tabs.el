;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package centaur-tabs
  :ensure t
  :config
  (centaur-tabs-headline-match)
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-height 32)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-close-button "X")
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-modified-marker "*")
  (centaur-tabs-change-fonts "Source Code Pro" 160)
  )


(provide 'init-tabs)
