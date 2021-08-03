;;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/ubolonton/tree-sitter-langs/releases/tag/0.10.1
;; ensure BUNDLE-VERSION exists!
(when *linux*
  (setq local/tree-sitter-lang-dir (expand-file-name "tree-sitter/langs/linux/" user-emacs-directory)))

(when *win*
  (setq local/tree-sitter-lang-dir (expand-file-name "tree-sitter/langs/windows/" user-emacs-directory)))

(when *mac*
  (setq local/tree-sitter-lang-dir (expand-file-name "tree-sitter/langs/darwin/" user-emacs-directory)))


(setq tree-sitter-langs--dir local/tree-sitter-lang-dir)
(setq tree-sitter-langs-grammar-dir tree-sitter-langs--dir)


;; https://github.com/ubolonton/emacs-tree-sitter/releases/tag/0.15.1
;; ensure DYN-VERSION exists!
(setq tsc--dir (expand-file-name "tree-sitter/tsc-dyn/" user-emacs-directory))
(setq tsc-dyn-dir tsc--dir)


(when (file-directory-p (expand-file-name "tree-sitter/" user-emacs-directory))
  (require-package 'tree-sitter)
  (require-package 'tree-sitter-langs)

  (require 'tree-sitter)
  (require 'tree-sitter-langs)

  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  )


(provide 'init-tree-sitter)
