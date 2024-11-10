if status is-interactive
    # Commands to run in interactive sessions can go here
end
############################################
function fish_greeting
	colorscript random
end 	
# ~/.config/fish/functions/fzf.fish
function fzf --wraps="fzf"
    # Paste contents of preferred variant here
     set -Ux FZF_DEFAULT_OPTS "
	--color=fg:#908caa,bg:#232136,hl:#ea9a97
	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
	--color=border:#44415a,header:#3e8fb0,gutter:#232136
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
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
############
 function wifi
	 rofi-wifi-menu.sh
 end
##                   ##                        ##
alias kbd='sudo kanata -c ~/.config/kanata.kbd'
alias inv='nvim $(fzf --preview="bat {}")'
alias r='ranger'
alias cls='clear'
alias rsh='redshift -l 33.38545:6.80422'
#alias rofi-wifi-menu.sh='wifi'
##########################################
set fish_greeting
zoxide init fish | source
starship init fish | source
thefuck --alias | source
set -gx EDITOR nvim 
