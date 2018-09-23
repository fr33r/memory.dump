alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias ll='ls -alFG'

#https://unix.stackexchange.com/questions/105958/terminal-prompt-not-wrapping-correctly
#https://www.howtogeek.com/307701/how-to-customize-and-colorize-your-bash-prompt/
export PS1="\[\e[36m\][\u][\w][\!] \$ \[\e[00m\]"
export PS2="\[\e[36m\]--> \[\e[00m\]"
