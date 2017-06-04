function fish_prompt --description "Write out the prompt"
    set -l last_status $status
		set -l last_duration $CMD_DURATION
    set -l color_cwd
    set -l suffix
    set -l blackle_color_time 666666\x1eyellow
    set -l blackle_color_git 666666\x1eyellow

    switch $USER
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '$'
    end

    set_color $blackle_color_time
    echo -n -s '┌ ' (date +"%a %b %d") (date +"%l:%M %p")

    if [ "$last_duration" != "0" ]
    	echo -n " - "
    	milli2user "$last_duration"
    end

    set_color normal

    set_color $blackle_color_time
    echo
    echo -n '├ '

    set_color normal

    set_color -u 
    echo -n -s "$USER" @ (hostname) 

    set_color normal
    echo -n -s (set_color $color_cwd) ' ' (prompt_pwd) (set_color normal) 

    if git rev-parse --git-dir > /dev/null ^ /dev/null
        set git_master (and git rev-parse --abbrev-ref HEAD ^ /dev/null)
        set_color $blackle_color_git
        echo -n ":$git_master"
        set_color normal
    end


    set_color $blackle_color_time
    echo
    echo -n '└ '


    if [ "$last_status" != "0" ]
        set_color -b red white
        echo -n "($last_status)"
        set_color normal
        echo -n " "
    end

    echo -n "\$ "
    set_color normal

end
