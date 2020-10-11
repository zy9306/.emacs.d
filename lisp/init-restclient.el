;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/pashky/restclient.el/tree/master
;; example: https://github.com/pashky/restclient.el/blob/master/examples/httpbin

(require-package 'restclient)
(require-package 'know-your-http-well)
(require-package 'company-restclient)


(with-eval-after-load 'restclient-mode
  (add-to-list 'company-backends 'company-restclient))


(provide 'init-restclient)
