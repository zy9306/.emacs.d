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

  ;; use `local/config-company-backends'
  ;; 只用 local/config-company-backends 结果排序会有问题，暂时禁用
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


(defun local/lsp-deferred ()
  (lsp-deferred)
  (local/config-company-backends))



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


(provide 'init-lsp)
