;; -*- coding: utf-8; lexical-binding: t; -*-


;; https://github.com/pashky/restclient.el/tree/master
;; example: https://github.com/pashky/restclient.el/blob/master/examples/httpbin

(with-eval-after-load 'restclient-mode
  (add-to-list 'company-backends 'company-restclient))


(provide 'init-restclient)
