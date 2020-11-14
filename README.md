<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Emacs](#emacs)
    - [安装](#安装)
        - [使用 nix 安装gccEmacs （建议）](#使用-nix-安装gccemacs-建议)
        - [Debian 系](#debian-系)
        - [源代码编译](#源代码编译)
        - [一些可能的问题](#一些可能的问题)

<!-- markdown-toc end -->

# Emacs

## 安装

### 使用 nix 安装gccEmacs （建议）

emacs 开发分支中的 `feature/native-comp` 引入了将 el 编译成可直接运行的
eln native code 的特性，性能上有较大提升，目前使用下来没有发现不稳定，
推荐使用

nix 安装可参考：https://github.com/zy9306/nix-home ，缓存仓库
`arcueid` 中已包含有编译 mac 和 linux 下编译好的二进制可直接使用

### Debian 系

```
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt install emacs26
# or other version already in https://launchpad.net/~kelleyk/+archive/ubuntu/emacs
```

### 源代码编译


1. 下载源码

> <https://mirrors.syringanetworks.net/gnu/emacs/>


2. 安装依赖 （只适用 Debian 系，其它系统可查阅相关资料）

    1.  先安装旧版本的依赖，编译新版本时报错再安装提示缺少的部分（建议）

    `sudo apt-get build-dep emacs`

    2.  或者手动安装依赖，以下列出了可能需要的依赖

        - libgtk-3-dev
        - libxpm-dev
        - gnutls-dev
        - libx11-dev
        - libjpeg-dev
        - libpng-dev
        - libgif-dev
        - libtiff-dev
        - libgtk2.0-dev
        - texinfo
        - libncurses5-dev or libncurses-dev （可暂时先不用装试试）


### 一些可能的问题

- `.zshrc` 或 `.bashrc` 需添加 `export LC _CTYPE="zh _CN.UTF-8"` ，否
    则通过终端打开无法输入中文

- `~/.profile` 中需添加 `export LC_CTYPE="zh_CN.UTF-8"` ，否则正常打开
    时无法输入中文

- `~/.profile` 中需添加 `export LC_TIME="en_US.UTF-8"` ，否则dired默认
    的正则 `directory-listing-before-filename-regexp` 会因中文日期出现
    问题

- `projectile-toggle-project-read-only` 会在当前项目目录下新建
    `.dir-locals.el` 文件，并将 `buffer-read-only` 打开，如果
    `.emacs.d` 目录被设置为只读，则安装 `package` 时会因为目录不可写导
    致报错，直接删除 `.dir-locals.el` 中的内容或再次运行
    `projectile-toggle-project-read-only` 即可

- 修改完 `~/.profile` 需要重启

