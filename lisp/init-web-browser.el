;;; xwidget
(add-hook 'xwidget-webkit-mode-hook #'(lambda () (display-line-numbers-mode -1)))

(global-set-key (kbd "C-c b u") #'xwidget-webkit-browse-url)
(global-set-key (kbd "C-c b g") #'xwidget-webkit-google-search)

(with-eval-after-load 'xwidget
  (define-key xwidget-webkit-mode-map (kbd "M-\\") #'xwidget-webkit-clone-and-split-right)
  (define-key xwidget-webkit-mode-map (kbd "M-w") #'xwidget-webkit-copy-selection-as-kill)
  (define-key xwidget-webkit-mode-map (kbd "M-c") #'xwidget-webkit-copy-selection-as-kill)
  (define-key xwidget-webkit-mode-map (kbd "C-s") #'xwidget-webkit-search-forward)
  (define-key xwidget-webkit-mode-map (kbd "c") #'xwidget-webkit-get-current-url)
  )

(defun xwidget-webkit-google-search (text)
  (interactive "sGoogle: " xwidget-webkit-mode)
  (let ((url (url-encode-url (format "https://www.google.com/search?&q=%s" text))))
    (message "%s" url)
    (xwidget-webkit-browse-url url))
  )

(defun xwidget-webkit-search-forward (text)
  "Search forward of `text'"
  (interactive "sSearch: " xwidget-webkit-mode)
  (xwidget-webkit-execute-script
   (xwidget-webkit-current-session)
   (format "window.find(\"%s\");" text)))

(defun xwidget-webkit-get-current-url ()
  (interactive)
  (xwidget-webkit-execute-script
   (xwidget-webkit-current-session)
   "window.location.href"
   (lambda (text) (kill-new text))))

;;; xwidget end


(provide 'init-web-browser)
