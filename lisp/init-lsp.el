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



(setq lsp-keymap-prefix "C-c l")

(use-package lsp-mode
  :ensure t
  :defer t
  ;; 已禁用which-key
  ;; :hook
  ;; (
  ;;  (lsp-mode . lsp-enable-which-key-integration)
  ;;  )
  :commands lsp
  :config
  (setq lsp-auto-guess-root t)
  (setq lsp-prefer-capf nil)
  (setq lsp-enable-imenu nil)
  ;; keymap
  (define-key lsp-mode-map [remap xref-find-definitions] #'lsp-find-definition)
  (define-key lsp-mode-map [remap xref-find-references] #'lsp-find-references)
  )

(use-package company-lsp
  :ensure t
  :defer t
  :config
  (setq company-lsp-cache-candidates 'auto)
  (setq company-lsp-async t)
  (setq company-lsp-enable-snippet t)
  (setq company-lsp-enable-recompletion t)
  )

(use-package lsp-ui
  :ensure t
  :defer t
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'lsp-mode-hook 'flycheck-mode)
  :commands lsp-ui-mode
  :config
  ;; lsp ui
  (setq lsp-ui-sideline-enable t)
  ;; keymap
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-imenu-enable nil)
  (setq lsp-ui-peek-enable nil)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-mode nil)
  )

(use-package lsp-ivy
  :ensure t
  :defer t
  :config
  (global-set-key (kbd "C-c l i") 'lsp-ivy-workspace-symbol)
  (global-set-key (kbd "C-c l I") 'lsp-ivy-global-workspace-symbol)
  )


(provide 'init-lsp)
