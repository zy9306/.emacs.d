;; install quelpa: https://github.com/quelpa/quelpa

;; GFW !
;; (unless (package-installed-p 'quelpa)
;;   (with-temp-buffer
;;     (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
;;     (eval-buffer)
;;     (quelpa-self-upgrade)))

(require-package 'quelpa)

(setq quelpa-update-melpa-p nil)

(require-package 'posframe)
(require-package 'pyvenv)
(require-package 'auto-virtualenv)
(require-package 'yapfify)
(require-package 'rg)
(require-package 'avy)
(require-package 'embrace)
(require-package 'hydra)
(require-package 'posframe)
(require-package 'ivy-posframe)
(require-package 'restclient)
(require-package 'know-your-http-well)
(require-package 'company-restclient)
(require-package 'key-chord)
(require-package 'general)
(require-package 'js2-mode)
(require-package 'tide)
(require-package 'go-mode)
(require-package 'yasnippet)
(require-package 'company-tabnine)
(require-package 'company-flx)
(require-package 'company-fuzzy)
(require-package 'company-prescient)
(require-package 'ivy-hydra)
(require-package 'ivy-prescient)
(require-package 'diminish)
(require-package 'undo-tree)
(require-package 'real-auto-save)
(require-package 'which-key)
(require-package 'imenu-list)
(require-package 'flycheck)
(require-package 'diff-hl)
(require-package 'symbol-overlay)
(require-package 'anzu)
(require-package 'multiple-cursors)
(require-package 'expand-region)
(require-package 'browse-kill-ring)
(require-package 'magit)
(require-package 'rainbow-delimiters)
(require-package 'move-text)
(require-package 'goto-chg)
(require-package 'recentf)
(require-package 'dired-subtree)
(require-package 'highlight-indent-guides)
(require-package 'wgrep)
(require-package 'smex)
(require-package 'exec-path-from-shell)
(require-package 'prescient)
(require-package 'golden-ratio)
(require-package 'transwin)
(require-package 'easy-kill)
(require-package 'string-inflection)
(require-package 'evil)
(require-package 'general)
(require-package 'key-chord)
(require-package 'goto-chg)
(require-package 'undo-tree)
(require-package 'counsel-gtags)
(require-package 'counsel-etags)
(require-package 'memoize)
(require-package 'project)
(require-package 'project-root)
(require-package 'isearch-dabbrev)
(require-package 'go-dlv)
(require-package 'bufler)
(require-package 'pytest)
(require-package 'mini-frame)
(require-package 'prescient)
(require-package 'selectrum)
(require-package 'selectrum-prescient)
(require-package 'consult)
(require-package 'minimap)

(quelpa
 '(swiper
   :fetcher git
   :commit "71c59ae"
   :url "git@github.com:abo-abo/swiper.git"))

(quelpa
 '(ivy
   :fetcher git
   :commit "71c59ae"
   :url "git@github.com:abo-abo/swiper.git"))

(quelpa
 '(counsel
   :fetcher git
   :commit "71c59ae"
   :url "git@github.com:abo-abo/swiper.git"))

(quelpa
 '(company-mode
   :fetcher git
   :commit "6116c4"
   :url "git@github.com:company-mode/company-mode.git"))

(quelpa
 '(projectile
   :fetcher git
   :commit "c31bd41"
   :url "git@github.com:bbatsov/projectile.git"))

(quelpa
 '(counsel-projectile
   :fetcher git
   :url "git@github.com:ericdanan/counsel-projectile.git"))

(quelpa
 '(treemacs
   :fetcher git
   :commit "16b0819"
   :url "git@github.com:Alexander-Miller/treemacs.git"
   :files (:defaults
           "Changelog.org"
           "icons"
           "src/elisp/treemacs*.el"
           "src/scripts/treemacs*.py"
           (:exclude "src/extra/*"))))

(quelpa
 '(lsp-mode
   :fetcher git
   :commit "69c86db"
   :url "git@github.com:emacs-lsp/lsp-mode.git"))

(quelpa
 '(lsp-pyright
   :fetcher git
   :commit "71ff088"
   :url "git@github.com:emacs-lsp/lsp-pyright.git"))

(quelpa
 '(lsp-python-ms
   :fetcher git
   :commit "c4ebc7a"
   :url "git@github.com:emacs-lsp/lsp-python-ms.git"))

(quelpa
 '(eglot
   :fetcher git
   :commit "0c4daa4"
   :url "git@github.com:zy9306/eglot.git"))

(quelpa
 '(nox
   :fetcher git
   :commit "679327b"
   :url "git@github.com:zy9306/nox.git"))

(quelpa
 '(pyvenv
   :fetcher git
   :commit "9b3678b"
   :url "git@github.com:zy9306/pyvenv.git"))

(quelpa
 '(git-auto-commit-mode
   :fetcher git
   :commit "a6b6e0f"
   :url "git@github.com:zy9306/git-auto-commit-mode.git"))

(quelpa
 '(apheleia
   :fetcher git
   :commit "HEAD"
   :url "git@github.com:raxod502/apheleia.git"))

(quelpa
 '(centaur-tabs
   :fetcher git
   :commit "HEAD"
   :url "git@github.com:zy9306/centaur-tabs.git"))
