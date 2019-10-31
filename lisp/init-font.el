;; -*- coding: utf-8; lexical-binding: t; -*-

;; only work for english
;; (if (display-graphic-p)
;;     (progn
;;       (set-face-attribute 'default nil :font
;;                           "Source Code Pro 14")
;;       (setq default-frame-alist
;;             (append '((font . "Source Code Pro 14")) default-frame-alist))
;;       ))


;; Setting English Font
(when *linux*
  (set-face-attribute 'default nil :font "Ubuntu Mono 13")
)

(when *win*
  (set-face-attribute 'default nil :font "Ubuntu Mono 13")
)

;; mac dpi is too high, so enlarge font
(when *is-a-mac*
  (set-face-attribute 'default nil :font "Source Code Pro 19")
)

;; Chinese Font
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     charset (font-spec :family "思源黑体"
;;                                        :size 16)))
;; fix: 不设:size,而是改用倍数缩放,如果直接设置字号,则页面缩放时只能缩放英文
;; 中文字体在-nw时都会报错
(if (display-graphic-p)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset (font-spec :family "FZKai-Z03"))))
(if (display-graphic-p)
    ;; select a chinese font and type C-u C-x = what font used for chinese
    ;; 中英文等宽可调至1.2左右，1.0即为等高，等宽等高二选一
    (setq face-font-rescale-alist '(("FZKai-Z03" . 1.0))))

;; 调整倍数使以下中文和英文长度相等
;; 你你你你你你你你你你你你你你你你你你你你
;; aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa


;; 设置字符集
;; 如果一个非 UTF-8 编码, 比如 GBK 编码的文件打开, 会乱码, 这时候 M-x revert-buffer-with-coding-system 选择 gbk 即可.
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

;; 避免复制粘贴乱码
;; (set-next-selection-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (set-clipboard-coding-system 'utf-8)

(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(when *win*
  (set-default 'process-coding-system-alist
               '(("[pP][lL][iI][nN][kK]" gbk-dos . gbk-dos)
                 ("[cC][mM][dD][pP][rR][oO][xX][yY]" gbk-dos . gbk-dos))))


(provide 'init-font)
