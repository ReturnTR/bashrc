export CLICOLOR=1
export PS1="%B%F{magenta}%D %*%f [%F{green}%n@%m:%f%F{blue}%d%f] $%b"
alias hg="history | grep "

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

ps_kill(){
    # 杀掉所有符合条件的进程   
    pids=$(ps -ef | grep "${1}" | awk '{print $2}')  
    for pid in $pids; do  
        echo "Killing PID $pid"  
        kill -9 $pid  
    done
}
