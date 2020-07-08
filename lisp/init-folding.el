;; -*- coding: utf-8; lexical-binding: t; -*-


;; (use-package yafolding
;;   ;; C-RET: toggle-element  C-S-RET: hide-parent-element  C-M-RET: toggle-all
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook 'yafolding-mode))


(use-package vimish-fold
  :ensure t
  :config
  (vimish-fold-global-mode t)
  (global-set-key (kbd "C-c v f") #'vimish-fold)
  (global-set-key (kbd "C-c v v") #'vimish-fold-delete)
  (global-set-key (kbd "C-c v t") #'vimish-fold-toggle))  ;; also C-`


;; https://github.com/wbolster/dotfiles/blob/master/Emacs/init.el

(use-package origami
  :custom
  (origami-show-fold-header t)

  ;; :custom-face
  ;; (origami-fold-replacement-face ((t (:inherit magit-diff-context-highlight))))
  ;; (origami-fold-fringe-face ((t (:inherit magit-diff-context-highlight))))

  :commands
  w--origami-parser-imenu-flat

  :config
  (global-origami-mode t)

  (face-spec-reset-face 'origami-fold-header-face)

  (defun w--origami-mode-toggle ()
    (interactive)
    (origami-mode 'toggle)
    (when origami-mode
      (if (> (point) 1)
          (origami-show-only-node (current-buffer) (point))
        (origami-close-all-nodes (current-buffer)))))

  (defun w--origami-parser-imenu-flat (create)
    "Origami parser producing folds for each imenu entry, without nesting."
    (lambda (content)
      (let ((orig-major-mode major-mode))
        (with-temp-buffer
          (insert content)
          (funcall orig-major-mode)
          (let* ((items
                  (-as-> (imenu--make-index-alist t) items
                         (-flatten items)
                         (-filter 'listp items)))
                 (positions
                  (-as-> (-map #'cdr items) positions
                         (-filter 'identity positions)
                         (-map-when 'markerp 'marker-position positions)
                         (-filter 'natnump positions)
                         (cons (point-min) positions)
                         (-snoc positions (point-max))
                         (-sort '< positions)
                         (-uniq positions)))
                 (ranges
                  (-zip-pair positions (-map '1- (cdr positions))))
                 (fold-nodes
                  (--map
                   (-let*
                       (((range-beg . range-end) it)
                        (line-beg
                         (progn (goto-char range-beg)
                                (line-beginning-position)))
                        (offset
                         (- (min (line-end-position) range-end) line-beg))
                        (fold-node
                         (funcall create line-beg range-end offset nil)))
                     fold-node)
                   ranges)))
            fold-nodes)))))

  (setq origami-parser-alist
        '(
         (java-mode . origami-java-parser)
         (c-mode . origami-c-parser)
         (c++-mode . origami-c-style-parser)
         (perl-mode . origami-c-style-parser)
         (cperl-mode . origami-c-style-parser)
         (js-mode . origami-c-style-parser)
         (js2-mode . origami-c-style-parser)
         (js3-mode . origami-c-style-parser)
         (go-mode . origami-c-style-parser)
         (php-mode . origami-c-style-parser)
         (python-mode . w--origami-parser-imenu-flat)
         (emacs-lisp-mode . origami-elisp-parser)
         (lisp-interaction-mode . origami-elisp-parser)
         (clojure-mode . origami-clj-parser)
         )
        )

  (global-set-key (kbd "<C-return>") 'origami-toggle-node)
  (global-set-key (kbd "<C-M-return>") 'origami-toggle-all-nodes))


(provide 'init-folding)
