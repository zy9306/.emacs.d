;;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/mini-frame-mode ()
  (interactive)
  (require 'mini-frame)
  (setq mini-frame-show-parameters
        '((top . 0.5)
          (left . 0.5)
          (width . 0.5)
          (height . 0.5)
          ;; linux xfce4 环境下无法法透明
          (alpha . (75 75))))

  (add-to-list 'mini-frame-show-parameters '(background-color . "#ffffff"))

  (setq mini-frame-internal-border-color "#39c5bb")

  ;; 固定高度为 10, 禁用自动调整，否则会闪烁，好像已经解决了
  ;; (setq mini-frame-resize nil)

  ;; 如果为 t， 多 frame 时可能会乱跑
  (setq mini-frame-detach-on-hide nil)

  (mini-frame-mode 1))


(add-hook 'after-init-hook #'local/mini-frame-mode)


(provide 'init-mini-frame)
