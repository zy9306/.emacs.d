;;; -*- coding: utf-8; lexical-binding: t; -*-

;; TODO to slow when init
;; (with-eval-after-load 'rg
;;   (rg-define-search rg-project-all
;;     :files "all"
;;     :dir project)

;;   (rg-define-search search-everything-at-home
;;     :query ask
;;     :format literal
;;     :files "all"
;;     :flags ("--hidden")
;;     :dir (getenv "HOME")
;;     :menu ("Search" "h" "Home"))
;;   )

(with-eval-after-load 'rg
  (setq rg-show-header t)
  (setq rg-group-result nil)
  (setq rg-command-line-flags '("-z"))
  (setq rg-buffer-name 'my-rg-buffer-name)

  (define-key rg-mode-map (kbd "z") #'rg-occur-hide-lines-matching)
  (define-key rg-mode-map (kbd "/") #'rg-occur-hide-lines-not-matching)

  (defun my-rg-buffer-name ()
    (let ((p (project-current)))
      (if p
          (format "rg %s" (nth 2 (project-current)))
        "rg")))

  (defun rg-occur-hide-lines-not-matching (search-text)
    "Hide lines that don't match the specified regexp."
    (interactive "MHide lines not matched by regexp: ")
    (set (make-local-variable 'line-move-ignore-invisible) t)
    (save-excursion
      (goto-char (point-min))
      (forward-line 5)
      (let ((inhibit-read-only t)
            line)
        (while (not (looking-at-p "^\nrg finished "))
          (setq line (buffer-substring-no-properties (point) (point-at-eol)))
          (if (string-match-p search-text line)
              (forward-line)
            (when (not (looking-at-p "^\nrg finished "))
              (delete-region (point) (1+ (point-at-eol)))))))))

  (defun rg-occur-hide-lines-matching  (search-text)
    "Hide lines matching the specified regexp."
    (interactive "MHide lines matching regexp: ")
    (set (make-local-variable 'line-move-ignore-invisible) t)
    (save-excursion
      (goto-char (point-min))
      (forward-line 5)
      (let ((inhibit-read-only t)
            line)
        (while (not (looking-at-p "^\nrg finished "))
          (setq line (buffer-substring-no-properties (point) (point-at-eol)))
          (if (not (string-match-p search-text line))
              (forward-line)
            (when (not (looking-at-p "^\nrg finished "))
              (delete-region (point) (1+ (point-at-eol)))))))))
  )


(provide 'init-rg)
