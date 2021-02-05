;; -*- coding: utf-8; lexical-binding: t; -*-

(with-eval-after-load 'ivy
  (require 'ivy)
  (require 'swiper)
  (require 'counsel)
  (require 'ivy-hydra)
  (require 'wgrep)

  (diminish 'ivy-mode)
  (diminish 'counsel-mode)
  (ivy-mode)
  (counsel-mode)
  ;; (ivy-prescient-mode)

  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-height 10)
  ;; recentf 显示相对路径，而不是只显示文件名
  (setq ivy-virtual-abbreviate 'abbreviate)

  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)

  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)

  ;; Ivy-based interface to shell and system tools
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)

  ;; ivy-resume resumes the last Ivy-based completion
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "C-c C-o") 'ivy-occur)

  (define-key ivy-occur-grep-mode-map (kbd "z") 'ivy-occur-hide-lines-matching)
  (define-key ivy-occur-grep-mode-map (kbd "/") 'ivy-occur-hide-lines-not-matching)

  (define-key swiper-map (kbd "C-r") 'previous-line)
  )

;;;###autoload
(defun ivy-occur-hide-lines-not-matching (search-text)
  "Hide lines that don't match the specified regexp."
  (interactive "MHide lines not matched by regexp: ")
  (set (make-local-variable 'line-move-ignore-invisible) t)
  (save-excursion
    (goto-char (point-min))
    (forward-line 4)
    (let ((inhibit-read-only t)
          (start-position (point))
          (pos (re-search-forward search-text nil t)))
      (while pos
        (beginning-of-line)
        (delete-region start-position (point))
        (forward-line 1)
        (setq start-position (point))
        (if (eq (point) (point-max))
            (setq pos nil)
          (setq pos (re-search-forward search-text nil t))))
              (delete-region start-position (point-max) ))))

;;;###autoload
(defun ivy-occur-hide-lines-matching  (search-text)
  "Hide lines matching the specified regexp."
  (interactive "MHide lines matching regexp: ")
  (set (make-local-variable 'line-move-ignore-invisible) t)
  (save-excursion
    (goto-char (point-min))
    (forward-line 4)
    (let ((inhibit-read-only t)
          (pos (re-search-forward search-text nil t))
          start-position)
      (while pos
        (beginning-of-line)
        (setq start-position (point))
        (end-of-line)
        (delete-region start-position (+ 1 (point)))
        (if (eq (point) (point-max))
            (setq pos nil)
          (setq pos (re-search-forward search-text nil t)))))))

(provide 'init-ivy)
