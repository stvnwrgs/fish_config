
set orange f47d44
set red e46764
set yellow ffd600
set blue 006bb6
set hemlock 9eccb3

set fish_git_dirty_color red
set fish_git_not_dirty_color $blue
set root_user_color $orange


function parse_username
  if [ (whoami) = root ]
    echo (set_color $root_user_color)(whoami)
  else
    echo (whoami)
  end
end

function parse_hostname
  set -l hostcode (hostname|cut -d . -f 1)
  switch $hostcode
        case '*prod*'
            echo (set_color $fish_git_dirty_color)$hostcode(set_color normal)
        case '*staging*'
            echo (set_color $orange)$hostcode(set_color normal)
        case 'srv'
            echo (set_color $orange)$hostcode(set_color normal)
        case '*'
            echo (set_color $hemlock)$hostcode(set_color normal)
    end
end

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_diff (git diff)
  set -l git_dirty_count (git status --porcelain  | wc -l | sed "s/ //g")

  if test -n "$git_diff"
    echo (set_color $fish_git_dirty_color)$branch:$git_dirty_count(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
end

function fish_prompt
  if test -d .git
    printf '%s@%s %s%s%s:%s> ' (parse_username) (parse_hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s@%s %s%s%s> ' (parse_username) (parse_hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
end
