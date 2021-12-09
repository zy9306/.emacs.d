(load-file (expand-file-name "site-lisp/load.el" user-emacs-directory))
(load-file (expand-file-name "theme/load.el" user-emacs-directory))

(require-package 'quelpa)
(setq quelpa-update-melpa-p nil)

(require-package 'swiper)
(require-package 'ivy)
(require-package 'counsel)
(require-package 'company)
(require-package 'projectile)
(require-package 'counsel-projectile)

(require-package 'anzu)
(require-package 'auto-virtualenv)
(require-package 'avy)
(require-package 'browse-kill-ring)
(require-package 'bufler)
(require-package 'company-flx)
(require-package 'company-fuzzy)
(require-package 'company-prescient)
(require-package 'company-restclient)
(require-package 'company-tabnine)
(require-package 'consult)
(require-package 'counsel-etags)
(require-package 'counsel-gtags)
(require-package 'deadgrep)
(require-package 'diff-hl)
(require-package 'diminish)
(require-package 'dired-subtree)
(require-package 'dir-treeview)
(require-package 'easy-kill)
(require-package 'eglot)
(require-package 'embrace)
(require-package 'evil)
(require-package 'exec-path-from-shell)
(require-package 'expand-region)
(require-package 'flycheck)
(require-package 'format-all)
(require-package 'general)
(require-package 'general)
(require-package 'git-auto-commit-mode)
(require-package 'go-dlv)
(require-package 'go-mode)
(require-package 'golden-ratio)
(require-package 'goto-chg)
(require-package 'highlight-indent-guides)
(require-package 'hydra)
(require-package 'imenu-list)
(require-package 'isearch-dabbrev)
(require-package 'ivy-hydra)
(require-package 'ivy-prescient)
(require-package 'js2-mode)
(require-package 'key-chord)
(require-package 'key-chord)
(require-package 'know-your-http-well)
(require-package 'lsp-mode)
(require-package 'lsp-pyright)
(require-package 'lsp-python-ms)
(require-package 'magit)
(require-package 'memoize)
(require-package 'mini-frame)
(require-package 'minimap)
(require-package 'move-text)
(require-package 'multiple-cursors)
(require-package 'org-download)
(require-package 'powerline)
(require-package 'prescient)
(require-package 'prescient)
(require-package 'project)
(require-package 'project-root)
(require-package 'pytest)
(require-package 'pyvenv)
(require-package 'rainbow-delimiters)
(require-package 'real-auto-save)
(require-package 'recentf)
(require-package 'restclient)
(require-package 'rg)
(require-package 'selectrum)
(require-package 'selectrum-prescient)
(require-package 'smex)
(require-package 'string-inflection)
(require-package 'symbol-overlay)
(require-package 'tide)
(require-package 'toc-org)
(require-package 'transwin)
(require-package 'undo-tree)
(require-package 'undo-tree)
(require-package 'visible-mark)
(require-package 'wgrep)
(require-package 'which-key)
(require-package 'xclip)
(require-package 'yapfify)
(require-package 'yasnippet)
