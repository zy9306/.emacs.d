;; -*- coding: utf-8; lexical-binding: t; -*-

(defun local/ivy ()
  (require 'ivy)
  (require 'swiper)
  (require 'counsel)
  (require 'ivy-hydra)
  (require 'wgrep)

  (ivy-mode)
  (diminish 'ivy-mode)
  (counsel-mode)
  (diminish 'counsel-mode))

(defun local/dimish-counsel ()
  (diminish 'counsel-mode))

(add-hook 'after-init-hook #'local/dimish-counsel)

(with-eval-after-load 'ivy
  (local/ivy)

  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-height 10)
  ;; recentf 显示相对路径，而不是只显示文件名
  (setq ivy-virtual-abbreviate 'abbreviate)

  (setq ivy-initial-inputs-alist nil)
  (setq counsel-search-engine 'google)

  (global-set-key (kbd "C-s") 'swiper)
  (add-to-list 'ivy-height-alist '(swiper . 15))
  (define-key swiper-map (kbd "C-r") 'previous-line)

  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)

  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-x l") 'counsel-locate)

  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "C-c C-o") 'ivy-occur)

  (define-key ivy-occur-grep-mode-map (kbd "z") 'ivy-occur-hide-lines-matching)
  (define-key ivy-occur-grep-mode-map (kbd "/") 'ivy-occur-hide-lines-not-matching))

(use-package avy
  :commands (avy-goto-char avy-goto-char-2))
(with-eval-after-load 'avy
  (avy-setup-default))

(eval-after-load "isearch"
  '(progn
     (require 'isearch-dabbrev)
     (define-key isearch-mode-map (kbd "<tab>") 'isearch-dabbrev-expand)))

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


(defun local/ivy-occur-next-and-press ()
  (interactive)
  (next-line)
  (ivy-occur-press))

(defun local/ivy-occur-previous-and-press ()
  (interactive)
  (previous-line)
  (ivy-occur-press))

(with-eval-after-load 'ivy
  (define-key ivy-occur-grep-mode-map (kbd "p") #'local/ivy-occur-previous-and-press)
  (define-key ivy-occur-grep-mode-map (kbd "n") #'local/ivy-occur-next-and-press))

(with-eval-after-load 'ivy
  (defun local/ivy-switch-buffer (regex-list)
    (let ((ivy-ignore-buffers regex-list))
      (ivy-switch-buffer)))

  (defun local/ivy-switch-buffer-ignore-star-buffers ()
    (interactive)
    (local/ivy-switch-buffer (append ivy-ignore-buffers `("^\*"))))

  (global-set-key (kbd "C-<tab>") 'local/ivy-switch-buffer-ignore-star-buffers)

  (define-key ivy-switch-buffer-map (kbd "C-<tab>") 'next-line)
  (define-key ivy-switch-buffer-map (kbd "C-S-<tab>") 'previous-line))


(provide 'init-abo-abo)
