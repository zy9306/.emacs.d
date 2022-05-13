;;; -*- coding: utf-8; lexical-binding: t; -*-

;;; nox
(setq nox-optimization-p nil)
(setq nox-autoshutdown t)

(defun local/nox-xref ()
  (if (member 'nox-xref-backend xref-backend-functions)
      (progn
        (setq xref-backend-functions (remove 'nox-xref-backend xref-backend-functions))
        (add-to-list 'xref-backend-functions 'nox-xref-backend))))

(defun local/nox-ensure ()
  (nox-ensure)
  (local/nox-xref)
  (local/config-company-backends))


;;; lsp-mode
(setq lsp-keymap-prefix "s-l")

(setq dap-auto-configure-mode nil)

(with-eval-after-load 'lsp-mode
  (setq lsp-log-io nil)
  (setq lsp-ui-mode nil)
  (setq lsp-idle-delay 0.500)

  ;; 启用 :capf 时会将 company-capf 插入到
  ;; `local/config-company-backends' 设置的组的前面，如果禁用则结果排
  ;; 序会有问题，暂时禁用
  ;; (setq lsp-completion-provider :none)

  (setq lsp-enable-file-watchers nil)

  (setq lsp-headerline-breadcrumb-enable nil)

  (setq lsp-auto-guess-root t)
  (setq lsp-enable-imenu nil)

  (setq lsp-signature-auto-activate nil)
  (setq lsp-signature-render-documentation nil)
  (setq lsp-signature-doc-lines 1)

  (setq lsp-keep-workspace-alive nil)

  (define-key lsp-mode-map [remap xref-find-definitions] 'lsp-find-definition)
  (define-key lsp-mode-map [remap xref-find-references] 'lsp-find-references)

  (setq lsp-enable-folding nil)
  (setq lsp-diagnostics-provider :none)
  (setq lsp-enable-links nil)
  (setq lsp-enable-symbol-highlighting nil))

(defun local/replace-lsp-completion-at-point ()
  (setq-local completion-at-point-functions nil)
  (add-hook 'completion-at-point-functions 'lsp-citre-capf-function nil t))

(add-hook 'lsp-completion-mode-hook 'local/replace-lsp-completion-at-point)

(defun local/lsp-deferred ()
  (lsp-deferred)
  (local/config-company-backends)

  (add-hook 'citre-mode-hook
            (lambda ()   (dolist (xref-backend '(nox-xref-backend))
                           (if (member xref-backend xref-backend-functions)
                               (progn
                                 (setq xref-backend-functions (remove xref-backend xref-backend-functions))
                                 (add-to-list 'xref-backend-functions xref-backend))))))
  (add-hook 'completion-at-point-functions 'lsp-citre-capf-function nil t))


;;; client
(defun local/lsp-python ()
  (require 'lsp-pyright)

  (lsp-register-custom-settings
   `(("pyright.disableLanguageServices" lsp-pyright-disable-language-services t)
     ("pyright.disableOrganizeImports" lsp-pyright-disable-organize-imports t)
     ("python.analysis.autoImportCompletions" lsp-pyright-auto-import-completions t)
     ("python.analysis.typeshedPaths" lsp-pyright-typeshed-paths)
     ("python.analysis.stubPath" lsp-pyright-stub-path)
     ("python.analysis.useLibraryCodeForTypes" lsp-pyright-use-library-code-for-types t)
     ("python.analysis.diagnosticMode" lsp-pyright-diagnostic-mode)
     ("python.analysis.typeCheckingMode" lsp-pyright-typechecking-mode)
     ("python.analysis.logLevel" lsp-pyright-log-level)
     ("python.analysis.autoSearchPaths" lsp-pyright-auto-search-paths t)
     ("python.analysis.extraPaths" lsp-pyright-extra-paths)
     ("python.pythonPath" lsp-pyright-locate-python)
     ("python.venvPath" (lambda () (or lsp-pyright-venv-path "")))))

  (local/lsp-deferred))


(defun local/lsp-go ()
  (require 'lsp-go)
  (lsp-register-custom-settings
   '(("gopls.usePlaceholders" lsp-go-use-placeholders t)
     ("gopls.hoverKind" lsp-go-hover-kind "NoDocumentation")
     ("gopls.buildFlags" lsp-go-build-flags)
     ("gopls.env" lsp-go-env nil)
     ("gopls.linkTarget" lsp-go-link-target)
     ("gopls.codelenses" lsp-go-codelenses)
     ("gopls.linksInHover" lsp-go-links-in-hover t)
     ("gopls.gofumpt" lsp-go-use-gofumpt nil)
     ("gopls.local" lsp-go-goimports-local)
     ("gopls.directoryFilters" lsp-go-directory-filters)
     ("gopls.analyses" lsp-go-analyses nil)
     ("gopls.importShortcut" lsp-go-import-shortcut)
     ("gopls.symbolMatcher" lsp-go-symbol-matcher "FastFuzzy")
     ("gopls.symbolStyle" lsp-go-symbol-style)))

  (local/lsp-deferred))


;;; citre
(defun local/nox-result ()
  (ignore-errors (nox-completion-at-point)))

(defun local/lsp-result ()
  (ignore-errors (lsp-completion-at-point)))

(defun lsp-citre-capf-function ()
  (let ((lsp-result (local/lsp-result)))
    (if (ignore-errors (and lsp-result
                            (try-completion
                             (buffer-substring (nth 0 lsp-result)
                                               (nth 1 lsp-result))
                             (nth 2 lsp-result))))
        lsp-result
      (citre-completion-at-point))))


;;; python
(add-hook 'pyvenv-post-activate-hooks
          (lambda ()
            (setq nox-python-path (executable-find "python"))))

(setq nox-python-server "pyright")
(setq nox-python-server-dir (expand-file-name ".cache/lsp/mspyls/" user-emacs-directory))

(defun local/pyls ()
  (interactive)
  (let ((choices '("pyright" "mspyls")))
    (setq nox-python-server (completing-read "Swith to:" choices))))

(when (executable-find "pyright-langserver")
  (add-hook 'python-mode-hook 'local/lsp-python))


;;; rust
(add-hook 'rust-mode-hook #'local/nox-ensure)

;; rust-analyzer 表现优于 rls，racer 是非 lsp 方案中较快的，但目前没有处于积极维护状态
;; rustup component add rust-src 安装标准库源码，不手动安装的话，rust-analyzer 也会尝试自动下载
;; https://github.com/rust-analyzer/rust-analyzer/releases 下载二进制
(with-eval-after-load 'nox
  (add-to-list 'nox-server-programs
               `(rust-mode . ("rust-analyzer"))))


;;; go
;; NOX
;; (add-hook 'go-mode-hook #'local/nox-ensure)

;; lsp
(with-eval-after-load 'go-mode
  (add-hook 'go-mode-hook 'local/lsp-go))



(provide 'init-lsp-deprecated)
