;; -*- coding: utf-8; lexical-binding: t; -*-

;; Copy from https://github.com/nashamri/spacemacs-theme/blob/master/spacemacs-common.el

(defun true-color-p ()
  (or
   (display-graphic-p)
   (= (tty-display-color-cells) 16777216)))

(setq local/variant 'light)

(setq miku-color "#39C5BB")

(setq
;; generic
 local-color/act1          (if (eq local/variant 'dark) (if (true-color-p) "#222226" "#121212") (if (true-color-p) "#e7e5eb" "#d7dfff"))
 local-color/act2          (if (eq local/variant 'dark) (if (true-color-p) "#5d4d7a" "#444444") (if (true-color-p) "#d3d3e7" "#afafd7"))
 local-color/base          (if (eq local/variant 'dark) (if (true-color-p) "#b2b2b2" "#b2b2b2") (if (true-color-p) "#655370" "#5f5f87"))
 local-color/base-dim      (if (eq local/variant 'dark) (if (true-color-p) "#686868" "#585858") (if (true-color-p) "#a094a2" "#afafd7"))
 local-color/bg1           (if (eq local/variant 'dark) (if (true-color-p) "#292b2e" "#262626") (if (true-color-p) "#fbf8ef" "#ffffff"))
 local-color/bg2           (if (eq local/variant 'dark) (if (true-color-p) "#212026" "#1c1c1c") (if (true-color-p) "#efeae9" "#e4e4e4"))
 local-color/bg3           (if (eq local/variant 'dark) (if (true-color-p) "#100a14" "#121212") (if (true-color-p) "#e3dedd" "#d0d0d0"))
 local-color/bg4           (if (eq local/variant 'dark) (if (true-color-p) "#0a0814" "#080808") (if (true-color-p) "#d2ceda" "#bcbcbc"))
 local-color/bg-alt        (if (eq local/variant 'dark) (if (true-color-p) "#42444a" "#353535") (if (true-color-p) "#efeae9" "#e4e4e4"))
 local-color/border        (if (eq local/variant 'dark) (if (true-color-p) "#5d4d7a" "#111111") (if (true-color-p) "#b3b9be" "#b3b9be"))
 local-color/cblk          (if (eq local/variant 'dark) (if (true-color-p) "#cbc1d5" "#b2b2b2") (if (true-color-p) "#655370" "#5f5f87"))
 local-color/cblk-bg       (if (eq local/variant 'dark) (if (true-color-p) "#2f2b33" "#262626") (if (true-color-p) "#e8e3f0" "#ffffff"))
 local-color/cblk-ln       (if (eq local/variant 'dark) (if (true-color-p) "#827591" "#af5faf") (if (true-color-p) "#9380b2" "#af5fdf"))
 local-color/cblk-ln-bg    (if (eq local/variant 'dark) (if (true-color-p) "#373040" "#333333") (if (true-color-p) "#ddd8eb" "#dfdfff"))
 local-color/cursor        (if (eq local/variant 'dark) (if (true-color-p) "#e3dedd" "#d0d0d0") (if (true-color-p) "#100a14" "#121212"))
 local-color/const         (if (eq local/variant 'dark) (if (true-color-p) "#a45bad" "#d75fd7") (if (true-color-p) "#4e3163" "#8700af"))
 local-color/comment       (if (eq local/variant 'dark) (if (true-color-p) "#2aa1ae" "#008787") (if (true-color-p) "#2aa1ae" "#008787"))
 local-color/comment-light (if (eq local/variant 'dark) (if (true-color-p) "#2aa1ae" "#008787") (if (true-color-p) "#a49da5" "#008787"))
 local-color/comment-bg    (if (eq local/variant 'dark) (if (true-color-p) "#292e34" "#262626") (if (true-color-p) "#ecf3ec" "#ffffff"))
 local-color/comp          (if (eq local/variant 'dark) (if (true-color-p) "#c56ec3" "#d75fd7") (if (true-color-p) "#6c4173" "#8700af"))
 local-color/err           (if (eq local/variant 'dark) (if (true-color-p) "#e0211d" "#e0211d") (if (true-color-p) "#e0211d" "#e0211d"))
 local-color/func          (if (eq local/variant 'dark) (if (true-color-p) "#bc6ec5" "#d75fd7") (if (true-color-p) "#6c3163" "#8700af"))
 local-color/head1         (if (eq local/variant 'dark) (if (true-color-p) "#4f97d7" "#268bd2") (if (true-color-p) "#3a81c3" "#268bd2"))
 local-color/head1-bg      (if (eq local/variant 'dark) (if (true-color-p) "#293239" "#262626") (if (true-color-p) "#edf1ed" "#ffffff"))
 local-color/head2         (if (eq local/variant 'dark) (if (true-color-p) "#2d9574" "#2aa198") (if (true-color-p) "#2d9574" "#2aa198"))
 local-color/head2-bg      (if (eq local/variant 'dark) (if (true-color-p) "#293235" "#262626") (if (true-color-p) "#edf2e9" "#ffffff"))
 local-color/head3         (if (eq local/variant 'dark) (if (true-color-p) "#67b11d" "#67b11d") (if (true-color-p) "#67b11d" "#5faf00"))
 local-color/head3-bg      (if (eq local/variant 'dark) (if (true-color-p) "#293235" "#262626") (if (true-color-p) "#edf2e9" "#ffffff"))
 local-color/head4         (if (eq local/variant 'dark) (if (true-color-p) "#b1951d" "#875f00") (if (true-color-p) "#b1951d" "#875f00"))
 local-color/head4-bg      (if (eq local/variant 'dark) (if (true-color-p) "#32322c" "#262626") (if (true-color-p) "#f6f1e1" "#ffffff"))
 local-color/highlight     (if (eq local/variant 'dark) (if (true-color-p) "#444155" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff"))
 local-color/highlight-dim (if (eq local/variant 'dark) (if (true-color-p) "#3b314d" "#444444") (if (true-color-p) "#e7e7fc" "#d7d7ff"))
 local-color/keyword       (if (eq local/variant 'dark) (if (true-color-p) "#4f97d7" "#268bd2") (if (true-color-p) "#3a81c3" "#268bd2"))
 local-color/lnum          (if (eq local/variant 'dark) (if (true-color-p) "#44505c" "#444444") (if (true-color-p) "#a8a8bf" "#af87af"))
 local-color/mat           (if (eq local/variant 'dark) (if (true-color-p) "#86dc2f" "#86dc2f") (if (true-color-p) "#ba2f59" "#af005f"))
 local-color/meta          (if (eq local/variant 'dark) (if (true-color-p) "#9f8766" "#af875f") (if (true-color-p) "#da8b55" "#df5f5f"))
 local-color/str           (if (eq local/variant 'dark) (if (true-color-p) "#2d9574" "#2aa198") (if (true-color-p) "#2d9574" "#2aa198"))
 local-color/suc           (if (eq local/variant 'dark) (if (true-color-p) "#86dc2f" "#86dc2f") (if (true-color-p) "#42ae2c" "#00af00"))
 local-color/ttip          (if (eq local/variant 'dark) (if (true-color-p) "#9a9aba" "#888888") (if (true-color-p) "#8c799f" "#5f5f87"))
 local-color/ttip-sl       (if (eq local/variant 'dark) (if (true-color-p) "#5e5079" "#333333") (if (true-color-p) "#c8c6dd" "#afafff"))
 local-color/ttip-bg       (if (eq local/variant 'dark) (if (true-color-p) "#34323e" "#444444") (if (true-color-p) "#e2e0ea" "#dfdfff"))
 local-color/type          (if (eq local/variant 'dark) (if (true-color-p) "#ce537a" "#df005f") (if (true-color-p) "#ba2f59" "#af005f"))
 local-color/var           (if (eq local/variant 'dark) (if (true-color-p) "#7590db" "#8787d7") (if (true-color-p) "#715ab1" "#af5fd7"))
 local-color/war           (if (eq local/variant 'dark) (if (true-color-p) "#dc752f" "#dc752f") (if (true-color-p) "#dc752f" "#dc752f"))

 ;; colors
 local-color/aqua          (if (eq local/variant 'dark) (if (true-color-p) "#2d9574" "#2aa198") (if (true-color-p) "#2d9574" "#2aa198"))
 local-color/aqua-bg       (if (eq local/variant 'dark) (if (true-color-p) "#293235" "#262626") (if (true-color-p) "#edf2e9" "#ffffff"))
 local-color/green         (if (eq local/variant 'dark) (if (true-color-p) "#67b11d" "#67b11d") (if (true-color-p) "#67b11d" "#5faf00"))
 local-color/green-bg      (if (eq local/variant 'dark) (if (true-color-p) "#293235" "#262626") (if (true-color-p) "#edf2e9" "#ffffff"))
 local-color/green-bg-s    (if (eq local/variant 'dark) (if (true-color-p) "#29422d" "#262626") (if (true-color-p) "#dae6d0" "#ffffff"))
 local-color/cyan          (if (eq local/variant 'dark) (if (true-color-p) "#28def0" "#00ffff") (if (true-color-p) "#21b8c7" "#008080"))
 local-color/red           (if (eq local/variant 'dark) (if (true-color-p) "#f2241f" "#d70000") (if (true-color-p) "#f2241f" "#d70008"))
 local-color/red-bg        (if (eq local/variant 'dark) (if (true-color-p) "#3c2a2c" "#262626") (if (true-color-p) "#faede4" "#ffffff"))
 local-color/red-bg-s      (if (eq local/variant 'dark) (if (true-color-p) "#512e31" "#262626") (if (true-color-p) "#eed9d2" "#ffffff"))
 local-color/blue          (if (eq local/variant 'dark) (if (true-color-p) "#4f97d7" "#268bd2") (if (true-color-p) "#3a81c3" "#268bd2"))
 local-color/blue-bg       (if (eq local/variant 'dark) (if (true-color-p) "#293239" "#262626") (if (true-color-p) "#edf1ed" "#d7d7ff"))
 local-color/blue-bg-s     (if (eq local/variant 'dark) (if (true-color-p) "#2d4252" "#262626") (if (true-color-p) "#d1dcdf" "#d7d7ff"))
 local-color/magenta       (if (eq local/variant 'dark) (if (true-color-p) "#a31db1" "#af00df") (if (true-color-p) "#a31db1" "#800080"))
 local-color/yellow        (if (eq local/variant 'dark) (if (true-color-p) "#b1951d" "#875f00") (if (true-color-p) "#b1951d" "#875f00"))
 local-color/yellow-bg     (if (eq local/variant 'dark) (if (true-color-p) "#32322c" "#262626") (if (true-color-p) "#f6f1e1" "#ffffff")))

(provide 'init-face-common)
