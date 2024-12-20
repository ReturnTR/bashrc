# 纯linux命令，与任何内容无关，主要为工具

alias hg="history | grep "
alias gr="grep -rn"
alias fn="find . -type d -o -type f -iname "

# git命令
# git commit --amend
alias git_push="git push origin master:refs/for/master"
alias git_push2="git push origin HEAD:refs/for/stable"
alias git_reset="git reset --soft origin/master"

# jupyter
alias start_jupyter="nohup jupyter notebook --ip 10.25.74.208 --port 8888 > ~/log/jupyter.log 2>&1 &"
alias check_jupyter="ps -ef | grep jupyter"
alias stop_jupyter="ps -ef | grep jupyter | awk '{print $2}' | xargs kill"

# httpserver
alias httpserver="python -m SimpleHTTPServer 8012"

# 允许所有用户读写
alias allow="sudo chmod -R a+rw"

# pip install
alias pip_install_tsinghua="pip install -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple"
alias pip_install_baidu="pip install -i http://pip.baidu.com/pypi/simple --trusted-host pip.baidu.com"


du_ls(){
    # 显示该文件夹下所有文件或文件夹的大小

    # du_ls 文件夹路径 （没有参数默认当前文件夹）
    if [ -z "$1" ]; then
        dir=.
    else
        dir=$1
    fi

    # 添加'/'变为合法
    if [[ ${dir} != */ ]]; then
        dir=${dir}/
    fi

    files=($(find $1 -maxdepth 1 -mindepth 1 -print0 | xargs -0))
    for file in "${files[@]}"; do
        du -sh ${file}
    done
}

gunzip_ls(){
    # 获取所有以.gz结尾的文件(不是tar.gz)，并执行gunzip(会删除原始文件)
    dir=$1

    if [[ ${dir} != */ ]]; then
        dir=${dir}/
    fi

    readarray -t files < <(ls ${dir})

    for file in "${files[@]}"; do  
        if [[ ${file} == *.gz ]]; then  
            gunzip ${dir}${file}
        fi
    done
}

process_subfolders() {
    # 过该文件夹下的所有次级子文件夹执行特定命令

    # 检查传入的参数
    if [ $# -ne 2 ]; then
        echo "Usage: process_subfolders <folder_path> <command>"
        return 1
    fi
    # 使用find命令查找该文件夹下所有的子文件夹（-type d表示查找目录类型）
    # 然后对找到的每个子文件夹路径，执行后续的自定义命令操作
    find "$1" -maxdepth 1 -mindepth 1 -type d | while read subfolder; do
        # 在这里替换为你实际想要执行的命令，下面只是示例，输出子文件夹的路径
        echo "$2 $subfolder"
        "$2" "$subfolder"
    done
}

ps_kill(){
    # 杀掉所有符合条件的进程，谨慎使用 
    pids=$(ps -ef | grep "${1}" | awk '{print $2}')  
    for pid in $pids; do  
        echo "Killing PID $pid"  
        kill -9 $pid  
    done
}

nh(){
    # 方便后台运行
    nohup ${1} >nohup_`date +"%Y%m%d%H%M%S"`.log 2>&1 &
}

function sed_change(){
    # 修改配置文件
    # sed_change ./dsl.conf "seq_begin_day" "=" "20241024"
    local path=$1
    local key=$2
    local sep=$3
    local value=$4
    value=`echo "$value" | sed 's/\\//\\\\\//g'`
    sed -i 's/^'"$key"' *'"$sep"'.*/'"$key$sep$value"'/g' $path
}
