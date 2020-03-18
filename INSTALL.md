# Install Emacs

## use ppa on ubuntu（建议）

`sudo add-apt-repository ppa:kelleyk/emacs`

`sudo apt-get update`

`sudo apt install emacs26`

or other version already in https://launchpad.net/~kelleyk/+archive/ubuntu/emacs

## or build from source

download latest version from https://mirrors.syringanetworks.net/gnu/emacs/

### how to install dep

#### 先安装旧版本的依赖，编译新版本时报错再安装提示缺少的部分（建议）

`sudo apt-get build-dep emacs`

#### 或者手动安装依赖，以下列出了可能需要的依赖

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
- libncurses5-dev or libncurses-dev # tmux编译时已安装ncurses，暂时先不用装试试


## 注意事项

- .zshrc或.bashrc需添加`export LC_CTYPE="zh_CN.UTF-8"`，否则通过终端打开无法输入中文
- `~/.profile`中需添加`export LC_CTYPE="zh_CN.UTF-8"`，否则正常打开时无法输入中文
