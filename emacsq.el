(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))

(package-initialize)

(load-file (expand-file-name "site-lisp/load.el" user-emacs-directory))
(load-file (expand-file-name "theme/load.el" user-emacs-directory))
(load-file (expand-file-name "repo/load.el" user-emacs-directory))

(setq local/persist-dir (expand-file-name ".persist" user-emacs-directory))
(setq project-list-file (expand-file-name "projects" local/persist-dir))
(setq smex-save-file (expand-file-name ".smex-items" local/persist-dir))

(require 'project)
(define-key ctl-x-map "p" 'nil)
(define-key mode-specific-map "p" project-prefix-map)

(when (eq system-type 'darwin)
  (let ((gls (executable-find "/usr/local/bin/gls")))
    (when gls (setq insert-directory-program "/usr/local/bin/gls")))
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))


(require 'ivy)
(require 'swiper)
(require 'counsel)
(require 'wgrep)

(ivy-mode)
(counsel-mode)

(global-set-key (kbd "C-s") 'swiper-isearch)
