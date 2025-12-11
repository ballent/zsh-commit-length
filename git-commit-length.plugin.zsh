autoload -Uz add-zle-hook-widget

# Remove any existing hooks
add-zle-hook-widget -d line-pre-redraw count_git_message 2>/dev/null

count_git_message() {
  local buf="$BUFFER"

  if [[ $buf =~ "git commit.*-m ['\"]([^'\"]*)" ]]; then
    local msg="${match[1]}"

    RPROMPT="%F{cyan}[${#msg} chars]%f"
  else
    RPROMPT=""
  fi
  zle reset-prompt
}

clear_count() {
  RPROMPT=""
  zle reset-prompt
}

zle -N count_git_message
add-zle-hook-widget line-pre-redraw count_git_message

autoload -Uz add-zsh-hook
_init_rprompt() {
  RPROMPT=""
}
add-zsh-hook precmd _init_rprompt
