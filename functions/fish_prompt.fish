function fish_prompt --description "Write out the prompt"
    set -l last_status $status

    set CMD_DURATION_PERSIST $CMD_DURATION

    set -l color_cwd
    set -l suffix
    set -l blackle_color_time 888888\x1eyellow
    set -l blackle_color_git 888888\x1eyellow

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
    echo -n '┌ ' 

    set_color normal
    set_color -u 
    echo -n -s "$USER" @ (hostname)
    set_color normal

    set_color $blackle_color_time
    echo -n -s ' | ' (date +"%a %b %d") ' ' (date +"%l:%M %p" | sed 's/^ //')

    if [ "$CMD_DURATION_PERSIST" != "0" -a "$CMD_DURATION_PERSIST" != "" ]
    	echo -n -s " | " (milli2user "$CMD_DURATION_PERSIST")
    end

    if [ "$last_status" != "0" ]
		    echo -n -s " | " (set_color -b red white) "($last_status)"
    end

    set_color normal

    set_color $blackle_color_time
    echo
    echo -n '└ '

    set_color normal
    echo -n -s (set_color $color_cwd) (prompt_pwd) (set_color normal) 

    if git rev-parse --git-dir > /dev/null ^ /dev/null
        set git_master (and git rev-parse --abbrev-ref HEAD ^ /dev/null)
        set_color $blackle_color_git
        echo -n ":$git_master"
        set_color normal
    end

    echo -n "$suffix "
    set_color normal
end
