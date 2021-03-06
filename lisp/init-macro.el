;; -*- coding: utf-8; lexical-binding: t; -*-


;; 开启宏记录 C-x (
;; 关闭宏记录 C-x )
;; 执行刚刚录制的宏 C-x e
;; 循环执行n次刚刚录制的宏 C-u n C-x e
;; 给刚刚记录的宏记录编辑一个名字 M+x name-last-kbd-marco
;; 把刚刚起名字的宏记录写入到文件里面 M+x insert-kbd-marco

;; 在当前位置设置mark
(fset 'local/set-mark-set-mark
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("  " 0 "%d")) arg)))


(provide 'init-macro)
