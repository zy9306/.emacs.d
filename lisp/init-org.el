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
(global-set-key (kbd "C-c c") 'org-capture)
;; http://www.zmonster.me/2018/02/28/org-mode-capture.html
;; https://orgmode.org/manual/Capture-templates.html
;; see C-h v org-capture-templates for more info
(setq org-capture-templates
      '(
        ("t" "TODO")
        ("t1" "TODO1" entry (file "~/Nutstore/gtd/TODO.org")
         "* TODO %?\n  %i\n  %a")
        ("t2" "TODO2" entry (file "~/Nutstore/gtd/TODO2.org")
         "* TODO %?\n  %i\n  %a")
        ("t3" "TODO3" entry (file "~/Nutstore/gtd/TODO3.org")
         "* TODO %?\n  %i\n  %a")
        ))
(setq org-agenda-files (file-expand-wildcards "~/Nutstore/gtd/*.org"))

(provide 'init-org)
