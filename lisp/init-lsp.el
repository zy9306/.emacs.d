;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/emacs-lsp/lsp-mode
;; https://emacs-lsp.github.io/lsp-mode/


;; lsp-auto-guess-root为t时
;; 通过.git等版本控制相关文件夹确定项目目录
;; 也可通过.projectile文件确定项目目录
;; 如果该目录不是一个项目目录，则lsp不会启动，也无法手动启动
;; 不要将大目录作为项目目录，因为lsp会分析目录
;; 可建立一个单独的带有.projectile的文件夹作为项目之外的编码使用

;; 当lsp-auto-guess-root为nil时
;; 每进入一个无法确定是项目目录的文件夹时会询问
;; 可选择手动导入或者直接将当前目录作为项目目录（不推荐）
;; 也可以永久忽悠该目录
;; lsp-workspace-blacklist-remove可以移除忽略的目录
;; 如果一个目录被忽略，其子目录也会被忽悠，即使新建了.projectile等文件

;; 相关问题
;; 当lsp-auto-guess-root为t时，以mspyls为例，M-.从项目目录查找
;; 定义进入python虚拟环境目录时如果使用lsp-find-definition可能导致lsp
;; 不在进入的文件启动M-.默认是xref-find-definitions，将其remap到
;; lsp-find-definition即可解决问题


(require-package 'lsp-mode)
(require-package 'lsp-python-ms)

(setq lsp-keymap-prefix "s-l")

(setq dap-auto-configure-mode nil)

(with-eval-after-load 'lsp-mode
  (setq lsp-auto-guess-root t)
  (setq lsp-completion-provider :capf)
  (setq lsp-enable-imenu nil)
  ;; minibuffer不显示文档，只显示签名
  (setq lsp-signature-auto-activate t
        lsp-signature-render-documentation nil
        lsp-signature-doc-lines 2)
  (setq lsp-keep-workspace-alive t)
  (define-key lsp-mode-map [remap xref-find-definitions] #'lsp-find-definition)
  (define-key lsp-mode-map [remap xref-find-references] #'lsp-find-references)

  (setq lsp-enable-folding nil)

  ;; no real time syntax check
  (setq lsp-diagnostics-provider :none)

  (setq lsp-enable-links nil)
  )

;; 不需要 lsp-ui
;; (with-eval-after-load 'lsp-ui
;;   (add-hook 'lsp-mode-hook 'lsp-ui-mode)
;;   (setq lsp-ui-mode nil)
;;   (setq lsp-ui-doc-mode nil)
;;   (setq lsp-eldoc-hook nil)
;;   (setq lsp-ui-sigeline-enable nil)
;;   (setq lsp-ui-imenu-enable nil)
;;   (setq lsp-ui-peek-enable nil)

;;   (setq lsp-ui-sideline-show-symbol nil
;;         lsp-ui-sideline-show-hover nil
;;         lsp-ui-sideline-show-flycheck nil
;;         lsp-ui-sideline-show-diagnostics nil
;;         lsp-ui-sideline-show-code-actions nil)
;;   )


;; START lsp-python-ms
(with-eval-after-load 'python
  (require 'lsp-python-ms)
  (add-hook 'python-mode-hook 'lsp-deferred)
  )
;; END lsp-python-ms

(provide 'init-lsp)
