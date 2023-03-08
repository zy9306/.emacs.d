;;; -*- coding: utf-8; lexical-binding: t; -*-

;;; hook
(with-eval-after-load 'org
  ;; https://github.com/tonyaldon/org-bars和 org-modern 一起用会闪烁
  ;; (require 'org-bars)
  ;; (add-hook 'org-mode-hook #'org-bars-mode)

  (require 'org-modern)
  (setq org-modern-keyword nil)
  (add-hook 'org-mode-hook #'org-modern-mode)

  (require 'ox-hugo)
  (require 'org-hugo-auto-export-mode))

;;; org-download
(with-eval-after-load 'org
  (require 'org-download)

  ;; 默认 0，会以一级标题建子文件夹，好处是利于分类，坏处是如果改了标题，路径就不对了
  (setq-default org-download-heading-lvl nil)

  (let ((dir (format "%s/Chtholly/image/bed" local/cloud-dir)))
    (setq-default org-download-image-dir dir))

  (put 'org-download-image-dir 'safe-local-variable #'stringp))

;;; hugo
(with-eval-after-load 'ox
  (require 'ox-hugo))

;;; toc
(use-package toc-org
  :defer t
  :hook ((org-mode . toc-org-mode)
         (markdown-mode . toc-org-mode)))

;; 始终启用缩进
;; 和 org-modern 冲突了
;; (add-hook 'org-mode-hook 'org-indent-mode)

;; 调整内联图片的显示大小
(setq org-image-actual-width 600)

;; 如果用 hook，#+startup: nonum 可能会不起作用
(setq org-startup-numerated t)

(setq org-fontify-quote-and-verse-blocks t)

;; 打开文件时收起所有结点
(setq org-startup-folded t)

;; 代码语法高亮
(setq org-src-fontify-natively t)

(setq org-M-RET-may-split-line '((default . nil)))

;; src 块自动缩进的空格数
(setq org-edit-src-content-indentation 0)

;; tab 和在对应 major-mode 下表现一致
(setq org-src-tab-acts-natively t)

;; show all the character like * / etc...
(setq org-hide-emphasis-markers nil)

;; show all level marks *
(setq org-hide-leading-stars nil)
(setq org-indent-mode-turns-on-hiding-stars nil)

;; 在有子树的结点上执行 C-k 时，提示是否删除子树
(setq org-ctrl-k-protect-subtree t)

;; [[link]]
(setq org-link-descriptive t)

(add-hook 'org-mode-hook #'(lambda () (display-line-numbers-mode -1)))

;; 导出时不要执行代码块
(setq org-export-babel-evaluate nil)

(setq org-pretty-entities t)

;; 显示时间格式为 2019-01-25 Fri 14:55
(setq system-time-locale "C")

(setq org-todo-keywords
      '((sequence "TODO(t)" "CONTINUE(c)" "DONE(d)")))

(setq org-todo-keyword-faces
      '(("TODO" . "black")
        ("CONTINUE" . "pink")
        ("DONE" . "purple")))

;; make RET like C-j
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "<RET>") 'org-return-indent))

;;; BABEL
;; https://orgmode.org/manual/Results-of-Evaluation.html
;; https://orgmode.org/manual/Environment-of-a-Code-Block.html
;; 所有带有 :session py 的代码块都会在同一进程中执行，否则每个代码块都
;; 会创建一个进程 :results output 表示原样输出标准输出的内容
;; #+begin_src python :results output :session py
;; print(">>>")
;; #+end_src
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t)))

  (setq org-babel-default-header-args:shell '((:results . "output") (:session . "sh"))
        org-babel-default-header-args:python '((:results . "output") (:session . "py"))
        org-babel-default-header-args:emacs-lisp '((:results . "output") (:session . "elisp"))))

;;; capture
(when *win*
  (setq local/cloud-dir
        (expand-file-name
         (format "%s/OneDrive" user-login-name)
         "c:/Users")))
(when (or *linux* *mac*)
  (setq local/cloud-dir "~/OneDrive"))

(let ((task (format "%s/Illyasviel/task.org" local/cloud-dir))
      (Illyasviel (format "%s/Illyasviel/Chtholly.org" local/cloud-dir))
      (journal (format "%s/Illyasviel/journal.org" local/cloud-dir)))
  (setq org-capture-templates
        `(
          ("t" "Task" entry (file+headline ,task "Task")
           "* %u %?" :prepend t :empty-lines-after 2)

          ("c" "Chtholly" entry (file+headline ,Illyasviel "Chtholly")
           "* %u %?" :prepend t :empty-lines-after 2)

          ("j" "Journal" entry (file+datetree ,journal)
           "* %?\nEntered on %U\n  %i\n  %a")
          )))

(define-key global-map (kbd "C-c c t")
  (lambda () (interactive) (org-capture nil "t")))
(define-key global-map (kbd "C-c c c")
  (lambda () (interactive) (org-capture nil "c")))

;;; FORMATTER START
(require 'cl-lib)

(defvar org-blank-lines-after-heading 1)

(defvar org-blank-lines-after-content (cons 2 2))

(defun org-format-heading-blank-lines ()
  (interactive)
  (when (org-at-heading-p)
    (let ((current-level (nth 0 (org-heading-components)))
          next-level)
      (save-excursion
        (org-end-of-meta-data)
        (while (and (not (eobp)) (looking-at "^[[:space:]]*$"))
          (kill-line))
        (insert (cl-loop for i from 0 below org-blank-lines-after-heading concat "\n")))

      (save-excursion
        (when (outline-next-heading)
          (setq next-level (nth 0 (org-heading-components)))
          (previous-line)
          (while (looking-at "^[[:space:]]*$")
            (kill-line)
            (previous-line))
          (unless (eobp) (end-of-line))
          (insert (cl-loop for i from 0 below (if (= current-level next-level)
                                                  (car org-blank-lines-after-content)
                                                (cdr org-blank-lines-after-content))
                           concat "\n")))))))

(defun org-format-headings (arg)
  (interactive "P")
  (save-excursion
    (org-save-outline-visibility t
      (org-cycle '(64))
      (goto-char (point-min))
      (while (re-search-forward org-heading-regexp nil t)
        (org-format-heading-blank-lines))))
  (save-buffer)
  (revert-buffer-no-confirm))
;;; FORMATTER END


;;; HIDE SRC BLOCK

;; 默认收起所有代码块，shift + tab也不展开
;; org-show-block-all展开所有代码块
;; (add-hook 'org-mode-hook 'org-hide-block-all)

(defvar local/org-blocks-toggle-flag nil)

(defun local/org-toggle-blocks ()
  (interactive)
  (if local/org-blocks-toggle-flag
      (org-show-block-all)
    (org-hide-block-all))
  (setq-local local/org-blocks-toggle-flag (not local/org-blocks-toggle-flag)))

(with-eval-after-load 'org
  ;; 暂时禁用
  ;; (add-hook 'org-mode-hook 'local/org-toggle-blocks)
  (define-key org-mode-map (kbd "C-c t") 'local/org-toggle-blocks))


(provide 'init-org)
