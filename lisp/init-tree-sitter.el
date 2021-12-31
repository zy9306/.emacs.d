;;; -*- coding: utf-8; lexical-binding: t; -*-


;; ensure BUNDLE-VERSION exists!
(when *linux*
  (setq local/tree-sitter-lang-dir (expand-file-name "tree-sitter/src/langs/linux/" user-emacs-directory)))

(when *win*
  (setq local/tree-sitter-lang-dir (expand-file-name "tree-sitter/src/langs/windows/" user-emacs-directory)))

(when *mac*
  (setq local/tree-sitter-lang-dir (expand-file-name "tree-sitter/src/langs/macos/" user-emacs-directory)))


(setq tree-sitter-langs--dir local/tree-sitter-lang-dir)
(setq tree-sitter-langs-grammar-dir tree-sitter-langs--dir)


;; ensure DYN-VERSION exists!
(setq tsc--dir (expand-file-name "tree-sitter/src/dyn/" user-emacs-directory))
(setq tsc-dyn-dir tsc--dir)


(push (expand-file-name "tree-sitter/src/elisp-tree-sitter" user-emacs-directory) load-path)
(push (expand-file-name "tree-sitter/src/elisp-tree-sitter/core" user-emacs-directory) load-path)
(push (expand-file-name "tree-sitter/src/tree-sitter-langs" user-emacs-directory) load-path)


(when (file-directory-p (expand-file-name "tree-sitter/src/" user-emacs-directory))
  (require 'tree-sitter)
  (require 'tree-sitter-langs)

  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))


(provide 'init-tree-sitter)
