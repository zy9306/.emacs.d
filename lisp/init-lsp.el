;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/emacs-lsp/lsp-mode
;; https://emacs-lsp.github.io/lsp-mode/
;; https://github.com/emacs-lsp/lsp-ui


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
(require-package 'lsp-ui)
(require-package 'lsp-ivy)

(setq lsp-keymap-prefix "C-c l")

(with-eval-after-load 'lsp-mode
  (setq lsp-auto-guess-root t)
  (setq lsp-prefer-capf t)
  (setq lsp-enable-imenu nil)
  ;; minibuffer不显示文档，只显示签名
  (setq lsp-signature-auto-activate t
        lsp-signature-render-documentation nil
        lsp-signature-doc-lines 2)
  (setq lsp-keep-workspace-alive t)
  (define-key lsp-mode-map [remap xref-find-definitions] #'lsp-find-definition)
  (define-key lsp-mode-map [remap xref-find-references] #'lsp-find-references)

  (setq lsp-enable-file-watchers nil)
  (setq lsp-enable-snippet t)

  ;; http://blog.binchen.org/posts/how-to-speed-up-lsp-mode.html

  ;; enable log only for debug
  (setq lsp-log-io nil)

  (setq lsp-enable-folding nil)

  ;; no real time syntax check
  (setq lsp-diagnostic-package :none)

  ;; turn off for better performance
  (setq lsp-enable-symbol-highlighting nil)

  (setq lsp-enable-links nil)

  ;; auto restart lsp
  (setq lsp-restart 'auto-restart)

  ;; don't ping LSP lanaguage server too frequently
  (defvar lsp-on-touch-time 0)
  (defadvice lsp-on-change (around lsp-on-change-hack activate)
    ;; don't run `lsp-on-change' too frequently
    (when (> (- (float-time (current-time))
                lsp-on-touch-time) 30) ;; 30 seconds
      (setq lsp-on-touch-time (float-time (current-time)))
      ad-do-it))

  (require 'lsp-ui)
  )

(with-eval-after-load 'lsp-ui
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'lsp-mode-hook 'flycheck-mode)
  (setq lsp-ui-mode t)
    ;; sideline
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-symbol t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-flycheck t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-code-actions nil)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-imenu-enable nil)
  (setq lsp-ui-peek-enable nil)
  ;; keymap
  ;; (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  ;; (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  )

;; lsp-prefer-capf经常不能补全
;; (use-package company-lsp
;;   :ensure t
;;   :defer t
;;   :config
;;   (setq company-lsp-cache-candidates 'auto)
;;   (setq company-lsp-async t)
;;   (setq company-lsp-enable-snippet t)
;;   (setq company-lsp-enable-recompletion t)
;;   )

(provide 'init-lsp)
