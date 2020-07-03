;;; init-package.el --- Install all packages listed in `local/packages' -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; copy from https://github.com/bbatsov/prelude/blob/master/core/prelude-packages.el
;; and https://github.com/purcell/emacs.d/blob/master/lisp/init-elpa.el

(defvar local/packages
  '(
    ace-window
    ag
    anaconda-mode
    anzu
    auto-virtualenv
    avy
    browse-kill-ring
    buffer-move
    company
    company-box
    company-go
    company-lsp
    diff-hl
    diminish
    dired-subtree
    dockerfile-mode
    evil
    evil-surround
    exec-path-from-shell
    expand-region
    flycheck
    flycheck-pycheckers
    flycheck-rust
    format-all
    general
    general
    go-eldoc
    go-mode
    goto-chg
    highlight-indent-guides
    imenu-list
    ivy
    ivy-rich
    key-chord
    keyfreq
    lsp-ivy
    lsp-mode
    lsp-python-ms
    lsp-ui
    magit
    markdown-mode
    move-text
    multiple-cursors
    neotree
    org-download
    ox-qmd
    page-break-lines
    projectile
    protobuf-mode
    python-black
    pyvenv
    ra-emacs-lsp
    racer
    rainbow-delimiters
    real-auto-save
    recentf
    rust-mode
    shackle
    smex
    spacemacs-theme
    symbol-overlay
    toc-org
    undo-tree
    use-package-chords
    vimish-fold
    wgrep
    which-key
    yafolding
    yaml-mode
    yapfify
    yasnippet
    )
  "A list of packages to ensure are installed at launch.")

(let ((versioned-package-dir
       (expand-file-name (format "elpa-%s.%s" emacs-major-version emacs-minor-version)
                         user-emacs-directory)))
  (setq package-user-dir versioned-package-dir))

(setq package-enable-at-startup nil)
(package-initialize)

(setq package-archives
      '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(defun local/packages-installed-p ()
  "Check if all packages in `local/packages' are installed."
  (every #'package-installed-p local/packages))

(defun local/require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package local/packages)
    (add-to-list 'local/packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun local/require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'local/require-package packages))

(define-obsolete-function-alias 'local/ensure-module-deps 'local/require-packages)

(defun local/install-packages ()
  "Install all packages listed in `local/packages'."
  (unless (local/packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (local/require-packages local/packages)))

;; run package installation
(local/install-packages)


(provide 'init-package)
