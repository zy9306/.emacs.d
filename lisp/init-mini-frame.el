;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/mini-frame-mode ()
  (setq mini-frame-show-parameters
        '((top . 0.2)
          (left . 0.5)
          (width . 0.7)
          (height . 10)
          ;; linux xfce4 环境下无法法透明
          (alpha . (90 90))))

  ;; mac 下无法显示 border，背景色用默认的，白色的对比度太低（emacsmacport 版本解决了此问题）
  ;; (when *linux*
  ;;   (add-to-list 'mini-frame-show-parameters '(background-color . "#ffffff")))

  (add-to-list 'mini-frame-show-parameters '(background-color . "#ffffff"))

  (setq mini-frame-internal-border-color "#39c5bb")

  ;; 固定高度为 10, 禁用自动调整，否则会闪烁
  (setq mini-frame-resize nil)
  (mini-frame-mode +1))


(add-hook 'after-init-hook #'local/mini-frame-mode)


(provide 'init-mini-frame)
