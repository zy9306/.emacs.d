(require 'go-translate)

(setq gts-translate-list '(("en" "zh")))

(setq gts-default-translator
      (gts-translator
       :picker (gts-prompt-picker)
       :engines (list (gts-google-engine) (gts-bing-engine))
       :render (gts-posframe-pop-render :backcolor "#f2e6ce" :forecolor "#333333")))


(provide 'init-translate)
