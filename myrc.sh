# bashrc层级
# 1. ~/.bashrc，软件环境，除了安装软件自动在里面添加内容之外尽量不要在里面添加内容，目前需要添加两个
#   a. 配色方案：export PS1='[\[\033[01;32m\]\u@\H:\[\033[01;34m\]`pwd`:\[\033[01;35m\]\t\[\033[00m\]]\n$'
#   b. 自定义的rc内容：在结尾添加source ~/bashrc/myrc.sh
# 2. ~/bashrc/myrc.sh，自定义rc的入口
# 3. ~/bashrc/toolrc.sh纯工具，与环境无关
# 4. ~/bashrc/envrc.sh与目录有关的环境，包括alias、快捷命令等

source ~/bashrc/toolrc.sh
source ~/bashrc/envrc.sh
