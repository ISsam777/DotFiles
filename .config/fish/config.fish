if status is-interactive
    # Commands to run in interactive sessions can go here
end
############################################

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
#

zoxide init fish | source
starship init fish | source
#fzf --fish | source
alias inv='nvim $(fzf --preview="bat {}")'
thefuck --alias | source
