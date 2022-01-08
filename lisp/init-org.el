;;; -*- coding: utf-8; lexical-binding: t; -*-

;; hook
(with-eval-after-load 'org
  (require 'init-org-list)
  (add-hook 'org-mode-hook 'local/org-list-prettify-mode)

  ;; https://github.com/tonyaldon/org-bars
  (require 'org-bars)
  (add-hook 'org-mode-hook #'org-bars-mode)
  )


;; https://orgmode.org/manual/Dynamic-Headline-Numbering.html
;; 如果用 hook，#+startup: nonum 可能会不起作用
(setq org-startup-numerated t)

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

;; [[link]] 显示方括号
(setq org-link-descriptive nil)

;; 始终启用缩进
(add-hook 'org-mode-hook 'org-indent-mode)

(add-hook 'org-mode-hook #'(lambda () (display-line-numbers-mode -1)))

;; 默认收起所有代码块，shift + tab也不展开
;; org-show-block-all展开所有代码块
(add-hook 'org-mode-hook 'org-hide-block-all)


;; like C-j
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "<RET>") 'org-return-indent))


(setq org-todo-keywords
      '((sequence
         "TODO(t)"
         "CONTINUE(c)"
         "DONE(d)"
         )))

(setq org-todo-keyword-faces
      '(("TODO" . "black")
        ("CONTINUE" . "pink")
        ("DONE" . "purple")
        ))

;; 显示时间格式为 2019-01-25 Fri 14:55 ，若不设，星期会显示为中文
(setq system-time-locale "C")


(use-package toc-org
  :defer t
  :hook ((org-mode . toc-org-mode)
         (markdown-mode . toc-org-mode)))


;;; babel
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
     (shell . t))
   )

  (setq org-babel-default-header-args:shell '((:results . "output") (:session . "sh"))
        org-babel-default-header-args:python '((:results . "output") (:session . "py"))
        org-babel-default-header-args:emacs-lisp '((:results . "output") (:session . "elisp"))
        ))


;;; Capture
;; http://www.zmonster.me/2018/02/28/org-mode-capture.html
;; https://orgmode.org/manual/Capture-templates.html
;; see C-h v org-capture-templates for more info

(when *win*
  (setq local/cloud-dir
        (expand-file-name
         (format "%s/OneDrive" user-login-name)
         "c:/Users")))
(when (or *linux* *mac*)
  (setq local/cloud-dir "~/OneDrive"))

(let (
      (task (format "%s/Illyasviel/task.org" local/cloud-dir))
      (Illyasviel (format "%s/Illyasviel/Illyasviel.org" local/cloud-dir))
      (journal (format "%s/Illyasviel/journal.org" local/cloud-dir))
      )
  (setq org-capture-templates
        `(
          ("t" "Todo" entry (file ,task)
           "* %u %?" :prepend t :empty-lines-after 2)

          ("c" "Illyasviel" entry (file+headline ,Illyasviel "Illyasviel")
           "* %u %?" :prepend t :empty-lines-after 2)

          ("j" "Journal" entry (file+datetree ,journal)
           "* %?\nEntered on %U\n  %i\n  %a")
          )
        ))

(define-key global-map (kbd "C-c c t")
  (lambda () (interactive) (org-capture nil "t")))
(define-key global-map (kbd "C-c c c")
  (lambda () (interactive) (org-capture nil "c")))


;;; org-download
;; https://github.com/abo-abo/org-download/tree/master
(with-eval-after-load 'org
  (require 'org-download)

  ;; 默认 0，会以一级标题建子文件夹，好处是利于分类，坏处是如果改了标
  ;; 题，路径就不对了
  (setq-default org-download-heading-lvl nil)

  (let ((dir (format "%s/Tsukihi/image/bed" local/cloud-dir)))
    (setq-default org-download-image-dir dir))

  (put 'org-download-image-dir 'safe-local-variable #'stringp))


;;; read_only start
;; 标题加 read_only 标签，使该标签下的所有内容变成只读
;; (defun org-mark-all-readonly ()
;;   (interactive)
;;   ;; 先强制移除所有只读状态
;;   (org-remove-all-readonly)
;;   (let ((buf-mod (buffer-modified-p)))
;;     (org-map-entries
;;      (lambda ()
;;        (let* ((element (org-element-at-point))
;;               (begin (org-element-property :begin element))
;;               (end (org-element-property :end element)))
;;          (add-text-properties begin (- end 1) '(read-only t))))
;;      "read_only")
;;     (unless buf-mod
;;       (set-buffer-modified-p nil)))
;;   (message "Mark all read only!"))

;; ;; 移除所有 read_only tag 只读状态
;; (defun org-remove-all-readonly ()
;;   (interactive)
;;   (let ((buf-mod (buffer-modified-p)))
;;     (org-map-entries
;;      (lambda ()
;;        (let* ((element (org-element-at-point))
;;               (begin (org-element-property :begin element))
;;               (end (org-element-property :end element))
;;               (inhibit-read-only t))
;;          (remove-text-properties begin (- end 1) '(read-only t))))
;;      "read_only")
;;     (unless buf-mod
;;       (set-buffer-modified-p nil)))
;;   (message "Cancel all read only!"))

;; ;; 只移除当前光标所在区块的只读状态
;; (defun org-remove-readonly ()
;;   (interactive)
;;   (let ((buf-mod (buffer-modified-p)))
;;     (let* ((element (org-element-at-point))
;;            (begin (org-element-property :begin element))
;;            (end (org-element-property :end element))
;;            (inhibit-read-only t))
;;       (remove-text-properties begin (- end 1) '(read-only t)))
;;     (unless buf-mod
;;       (set-buffer-modified-p nil)))
;;   (message "Cancel current read only!"))

;; (add-hook 'org-mode-hook #'org-mark-all-readonly)
;;; read_only end


;;; formatter start
(require 'cl-lib)

(defvar org-blank-lines-after-heading 1
  "Number of blank lines to separate a heading from the content.")

(defvar org-blank-lines-after-content (cons 2 4)
  "Cons cell for the number of blank lines after content in a heading.
The car is for when the next heading is at the same level, and
the cdr is for when the next heading is at a different level.
This is for the body specific to the headline, not counting
subheadings.")

(defun org-format-heading-blank-lines ()
  "Make sure each headline has exactly
`org-blank-lines-after-heading' after the heading, and
`org-blank-lines-after-content' blank lines at the end of its
content. Only works when point is in a headline."
  (interactive)
  (when (org-at-heading-p)
    (let ((current-level (nth 0 (org-heading-components)))
          next-level)
      (save-excursion
        (org-end-of-meta-data)
        ;; chomp blank lines then add what you want back.
        (while (and (not (eobp)) (looking-at "^[[:space:]]*$"))
          (kill-line))
        (insert (cl-loop for i from 0 below org-blank-lines-after-heading concat "\n")))

      ;; Now go to the end of content and insert lines if needed.
      (save-excursion
        (when (outline-next-heading)
          (setq next-level (nth 0 (org-heading-components)))
          ;; chomp lines back then reinsert them.
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
      (message nil)
      (goto-char (point-min))
      (while (re-search-forward org-heading-regexp nil t)
        (org-format-heading-blank-lines)))))
;;; formatter end


;;; hide src block
(defvar local/org-blocks-toggle-flag nil)

(defun local/org-toggle-blocks ()
  (interactive)
  (if local/org-blocks-toggle-flag
      (org-show-block-all)
    (org-hide-block-all))
  (setq-local local/org-blocks-toggle-flag (not local/org-blocks-toggle-flag)))

(with-eval-after-load 'org
  (add-hook 'org-mode-hook 'local/org-toggle-blocks)
  (define-key org-mode-map (kbd "C-c t") 'local/org-toggle-blocks))



(provide 'init-org)
