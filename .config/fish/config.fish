if status is-interactive
    # Commands to run in interactive sessions can go here
end
############################################
function fish_greeting
	#colorscript random
end 	
# ~/.config/fish/functions/fzf.fish
function fzf --wraps="fzf"
    # Paste contents of preferred variant here
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
    command fzf
end
####################################
######### Aliasles #######################
#ex archiver#
   function ex -a file
    if test -f "$file"
        switch "$file"
            case "*.tar.bz2"
                tar xjf $file
            case "*.tar.gz"
                tar xzf $file
            case "*.bz2"
                bunzip2 $file
            case "*.rar"
                unrar x $file
            case "*.gz"
                gunzip $file
            case "*.tar"
                tar xf $file
            case "*.tbz2"
                tar xjf $file
            case "*.tgz"
                tar xzf $file
            case "*.zip"
                unzip $file
            case "*.Z"
                uncompress $file
            case "*.7z"
                7z x $file
            case "*"
                echo "'$file' cannot be extracted via ex()"
        end
    else
        echo "'$file' is not a valid file"
    end
end
##                  ##                        ##

alias kbd='sudo kanata -c ~/.config/kanata.kbd'
alias y='yazi'
alias cls='clear'
alias rsh='redshift -l 33.38545:6.80422'
alias copy='xclip -sel clip < '
##########################################
# Set up fzf key bindings
set fish_greeting
zoxide init fish | source
starship init fish | source
thefuck --alias | source
set -gx EDITOR nvim 

