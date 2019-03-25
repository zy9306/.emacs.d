;; -*- coding: utf-8; lexical-binding: t; -*-

;; 代码语法高亮
(setq org-src-fontify-natively t)

;; show all the character like * / etc...
(setq org-hide-emphasis-markers nil)
;; show all level marks *
(setq org-hide-leading-stars nil)
(setq org-indent-mode-turns-on-hiding-stars nil)

;; 始终启用缩进
(add-hook 'org-mode-hook 'org-indent-mode)

;; 默认收起所有代码块，shift + tab也不展开
;; org-show-block-all展开所有代码块
(add-hook 'org-mode-hook 'org-hide-block-all)

;; ox-gfm is also installed by markdown-mode

(use-package ox-qmd
  :ensure t

  :config
  (add-to-list 'ox-qmd-language-keyword-alist '("shell-script" . "sh")))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "CONTINUE(n)" "DONE(d)" "CANCELLED(c)"))))

;; 显示时间格式为 2019-01-25 Fri 14:55 ，若不设，星期会显示为中文
(setq system-time-locale "C")

;; org capture
;; (global-set-key (kbd "C-c c") 'org-capture)
;; ;; http://www.zmonster.me/2018/02/28/org-mode-capture.html
;; ;; https://orgmode.org/manual/Capture-templates.html
;; ;; see C-h v org-capture-templates for more info
;; (setq org-capture-templates
;;       '(
;;         ("t" "TODO")
;;         ("t1" "TODO1" entry (file "~/Nutstore/gtd/TODO.org")
;;          "* TODO %?\n  %i\n  %a")
;;         ("t2" "TODO2" entry (file "~/Nutstore/gtd/TODO2.org")
;;          "* TODO %?\n  %i\n  %a")
;;         ("t3" "TODO3" entry (file "~/Nutstore/gtd/TODO3.org")
;;          "* TODO %?\n  %i\n  %a")

;;         ("s" "snippet")
;;         ("sp" "Python" entry (file+headline "~/Nutstore/gtd/snippet.org" "Python")
;;          "** Python %?\n#+BEGIN_SRC python\n\n#+END_SRC" :empty-lines 1)
;;         ("sl" "Linux" entry (file+headline "~/Nutstore/gtd/snippet.org" "Linux")
;;          "** Linux %?\n  %i\n  %a" :empty-lines 1)
;;         ("sg" "Git" entry (file+headline "~/Nutstore/gtd/snippet.org" "Git")
;;          "** Git %?\n  %i\n  %a" :empty-lines 1)
;;         ("sd" "Docker" entry (file+headline "~/Nutstore/gtd/snippet.org" "Docker")
;;          "** Docker %?\n  %i\n  %a" :empty-lines 1)
;;         ("sm" "Mongo" entry (file+headline "~/Nutstore/gtd/snippet.org" "Mongo")
;;          "** Mongo %?\n  %i\n  %a" :empty-lines 1)
;;         ("sq" "Sql" entry (file+headline "~/Nutstore/gtd/snippet.org" "Sql")
;;          "** Sql %?\n  %i\n  %a" :empty-lines 1)
;;         ("ss" "Skydata" entry (file+headline "~/Nutstore/gtd/snippet.org" "Skydata")
;;          "** Skydata %?\n  %i\n  %a" :empty-lines 1)
;;         ))
;; (setq org-agenda-files (file-expand-wildcards "~/Nutstore/gtd/*.org"))


;; https://github.com/abo-abo/org-download/tree/master
;; -*- mode: Org; org-download-image-dir: "~/Pictures/foo"; -*-  to set dir for file
;; or (setq-default org-download-image-dir "~/Pictures/foo") for all
(use-package org-download
  :ensure t
  :config)
(global-set-key (kbd "C-c y") 'org-download-yank)


(provide 'init-org)
