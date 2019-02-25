function _opengit() {
    git remote >/dev/null 2>&1

    if [ $? != 0 ];then
        echo "\nNot in git repo"
        return
    fi
    count=${#words}
    case $count in
        2)
            _values print `git remote`
            ;;
        3)
            _values print `git branch -a|grep "remotes/${words[2]}/"|sed -n "s/remotes\/${words[2]}\///p"`
            ;;
    esac
}

compdef _opengit opengit
