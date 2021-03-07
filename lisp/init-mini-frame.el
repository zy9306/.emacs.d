;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/mini-frame-mode ()
  (setq mini-frame-show-parameters
        '((alpha . (70 70)) (left . 0.5) (top . 0.2) (width . 0.75) (height . 10)
          (background-color . "#ffffff")))
  (setq mini-frame-internal-border-color "#39c5bb")
  ;; 固定高度为 10, 禁用自动调整，否则会闪烁
  (setq mini-frame-resize nil)
  (mini-frame-mode +1))


(add-hook 'after-init-hook #'local/mini-frame-mode)


(provide 'init-mini-frame)
