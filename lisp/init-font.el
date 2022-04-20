;; -*- coding: utf-8; lexical-binding: t; -*-


(setq
 local/font-size-daemonp 16
 local/font-size-linux 16
 local/font-size-win 16
 local/font-size-mac 16
 )


(if (daemonp)
    ;; fix emacs --daemon
    (add-to-list 'default-frame-alist '(font . (format "Source Code Pro %d" local/font-size-daemonp))))

;; English Font
(when *linux*
  (set-face-attribute 'default nil :font (format "Source Code Pro %d" local/font-size-linux))
)
(when *win*
  (set-face-attribute 'default nil :font (format "Source Code Pro %d" local/font-size-win))

  (set-default 'process-coding-system-alist
               '(("[pP][lL][iI][nN][kK]" gbk-dos . gbk-dos)
                 ("[cC][mM][dD][pP][rR][oO][xX][yY]" gbk-dos . gbk-dos))))
(when *mac*
  ;; mac dpi is too high, so enlarge font
  (set-face-attribute 'default nil :font (format "Source Code Pro %d" local/font-size-mac))
)

;; CJK Font
(when (display-graphic-p)
  ;; 中文字体在 -nw 时都会报错
  ;; 不要在 font-spec 中设置倍数，而是改用倍数缩放,如果直接设置字号,则页
  ;; 面缩放时只能缩放英文(font-spec :family "思源黑体" :size 16)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset (font-spec :family "FZKai-Z03")))

    ;; C-u C-x = 查看当前选中的字符所用的字体
    ;; 中英文等宽可调至1.2左右，1.0即为等高，等宽等高二选一
    ;; 调整倍数使以下中文和英文长度相等（等宽）
    ;; 你你你你你你你你你你你你你你你你你你你你
    ;; aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
  (setq face-font-rescale-alist '(("FZKai-Z03" . 1.0))))


;; 设置字符集，如果一个非 UTF-8 编码, 比如 GBK 编码的文件打开, 会乱码,
;; 这时候 M-x revert-buffer-with-coding-system 选择 gbk 即可.
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


(provide 'init-font)
