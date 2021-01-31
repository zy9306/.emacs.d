;; -*- coding: utf-8; lexical-binding: t; -*-

;; 代码语法高亮
(setq org-src-fontify-natively t)

;; show all the character like * / etc...
(setq org-hide-emphasis-markers nil)
;; show all level marks *
(setq org-hide-leading-stars nil)
(setq org-indent-mode-turns-on-hiding-stars nil)

;; 在有子树的结点上执行 C-k 时，提示是否删除子树
(setq org-ctrl-k-protect-subtree t)

;; 始终启用缩进
(add-hook 'org-mode-hook 'org-indent-mode)

;; 默认收起所有代码块，shift + tab也不展开
;; org-show-block-all展开所有代码块
(add-hook 'org-mode-hook 'org-hide-block-all)

(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(c)" "BLOCKED(b)" "REVIEW(r)" "|" "DONE(d)" "ARCHIVED(a)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("DOING" . "pink")
        ("BLOCKED" . "red")
        ("REVIEW" . "orange")
        ("DONE" . "purple")
        ("ARCHIVED" . "black")))

;; 显示时间格式为 2019-01-25 Fri 14:55 ，若不设，星期会显示为中文
(setq system-time-locale "C")

;; https://github.com/snosov1/toc-org
(use-package toc-org
  :ensure t
  :defer t
  :hook ((org-mode . toc-org-mode)
         (markdown-mode . toc-org-mode)))

;; Capture
;; http://www.zmonster.me/2018/02/28/org-mode-capture.html
;; https://orgmode.org/manual/Capture-templates.html
;; see C-h v org-capture-templates for more info
;; (global-set-key (kbd "C-c c") 'org-capture)
;; (setq org-capture-templates
;;       '(
;;         ("t" "TODO" entry (file "~/Nutstore/gtd/TODO.org")
;;          "* TODO %?\n  %i\n  %a")

;;         ("s" "snippet")

;;         ("sp" "Python" entry (file+headline "~/Nutstore/gtd/snippet.org" "Python")
;;          "** Python %?\n#+BEGIN_SRC python\n\n#+END_SRC" :empty-lines 1)

;;         ("sl" "Linux" entry (file+headline "~/Nutstore/gtd/snippet.org" "Linux")
;;          "** Linux %?\n  %i\n  %a" :empty-lines 1)
;;         ))
;; (setq org-agenda-files (file-expand-wildcards "~/Nutstore/gtd/*.org"))


;; https://github.com/abo-abo/org-download/tree/master
;; -*- mode: Org; org-download-image-dir: "~/Pictures/foo"; -*-  to set dir for file
;; or (setq-default org-download-image-dir "~/Pictures/foo") for all
;; (use-package org-download
;;   :ensure t
;;   :config
;;   (global-set-key (kbd "C-c y") 'org-download-yank))


;; 标题加 read_only 标签，使该标签下的所有内容变成只读
;; 该版本有个问题，打开文件时，文件会显示为已修改状态
;; https://kitchingroup.cheme.cmu.edu/blog/2014/09/13/Make-some-org-sections-read-only/
;; 该版本改进了文件会显示为已修改状态的问题，但是使用了 org-mark-subtree ，会导致无法在只读标题下新建标题
;; https://emacs.stackexchange.com/questions/62495/how-can-i-mark-sections-of-a-very-large-org-agenda-file-as-read-only
;; 结合两者的修改版
(defun org-mark-all-readonly ()
  (interactive)
  ;; 先强制移除所有只读状态
  (org-remove-all-readonly)
  (let ((buf-mod (buffer-modified-p)))
    (org-map-entries
     (lambda ()
       (let* ((element (org-element-at-point))
              (begin (org-element-property :begin element))
              (end (org-element-property :end element)))
         (add-text-properties begin (- end 1) '(read-only t))))
     "read_only")
    (unless buf-mod
      (set-buffer-modified-p nil)))
 (message "Mark all read only!"))

;; 移除所有 read_only tag 只读状态
(defun org-remove-all-readonly ()
  (interactive)
  (let ((buf-mod (buffer-modified-p)))
    (org-map-entries
     (lambda ()
       (let* ((element (org-element-at-point))
              (begin (org-element-property :begin element))
              (end (org-element-property :end element))
              (inhibit-read-only t))
         (remove-text-properties begin (- end 1) '(read-only t))))
     "read_only")
    (unless buf-mod
      (set-buffer-modified-p nil)))
  (message "Cancel all read only!"))

;; 只移除当前光标所在区块的只读状态
(defun org-remove-readonly ()
  (interactive)
  (let ((buf-mod (buffer-modified-p)))
    (let* ((element (org-element-at-point))
           (begin (org-element-property :begin element))
           (end (org-element-property :end element))
           (inhibit-read-only t))
      (remove-text-properties begin (- end 1) '(read-only t)))
    (unless buf-mod
      (set-buffer-modified-p nil)))
  (message "Cancel current read only!"))

(add-hook 'org-mode-hook #'org-mark-all-readonly)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c b") #'org-mark-all-readonly)
  (define-key org-mode-map (kbd "C-c J") #'org-remove-all-readonly)
  (define-key org-mode-map (kbd "C-c j") #'org-remove-readonly))


(provide 'init-org)
