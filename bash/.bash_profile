# Load our dotfiles like ~/.bash_prompt, etc…
#   ~/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && . "$file"
done
unset file

# Hide bash -> zsh warning
# TODO: switch to zsh completely, using chsh -s /bin/zsh
export BASH_SILENCE_DEPRECATION_WARNING=1

# Load the default .profile
[[ -s "$HOME/.profile" ]] && . "$HOME/.profile"

# Bash completion
# From https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

# WP-CLI completion
# From https://raw.githubusercontent.com/wp-cli/wp-cli/master/utils/wp-completion.bash
if [ -f ~/dotfiles/bin/wp-completion.bash ]; then
    . ~/dotfiles/bin/wp-completion.bash;
fi;

# Composer completion
# From https://getcomposer.org/doc/03-cli.md#bash-completions
if [ -f ~/dotfiles/bin/composer-completion.bash ]; then
    . ~/dotfiles/bin/composer-completion.bash;
fi;

# Git completion
# From https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
if [ -f ~/dotfiles/bin/git-completion.bash ]; then
  . ~/dotfiles/bin/git-completion.bash
fi

# rupa/z
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/profile.d/z.sh" ]; then
    . "$(brew --prefix)/etc/profile.d/z.sh";
fi

# Google Cloud SDK
if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ]; then
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
fi;

if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc ]; then
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
fi;

# Homebrew gpatch support
export PATH="/opt/homebrew/opt/gpatch/libexec/gnubin:$PATH"

# Emscripten
# Run before nvm so nvm takes precedence
if [ -f ~/Workspace/GitHub/emsdk/emsdk_env.sh ]; then
    export EMSDK_QUIET=1
    . ~/Workspace/GitHub/emsdk/emsdk_env.sh
fi;

# pnpm
export PNPM_HOME="/Users/pascalb/Library/pnpm"
export PATH="$PNPM_HOME/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# phpvm
export PHPVM_DIR="/Users/pascalb/.phpvm"
export PATH="$PHPVM_DIR/bin:$PATH"
# [ -s "$PHPVM_DIR/phpvm.sh" ] && . "$PHPVM_DIR/phpvm.sh"

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Remove colon from the list of word breaking characters. Fixes issues with npm script bash completion.
export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

# Rust
[[ -s "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Holds WP-CLI and such.
export PATH="$PATH:/Users/pascalb/.local/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Command not found handler

command_not_found_handle() {
  # If the command has 3 or more words, pass it to Gemini's interactive prompt.
  if [ "$#" -ge 3 ]; then
    gemini --prompt-interactive="$*"
    return $?
  fi

  # Otherwise, attempt to use Homebrew's command-not-found handler.
  local HOMEBREW_COMMAND_NOT_FOUND_HANDLER
  # Check if the 'brew' command exists before trying to use it.
  if command -v brew >/dev/null; then
    HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
    if [ -f "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER" ]; then
      source "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER"
    fi
  fi

  # After attempting to source the handler, check if the function is now defined.
  if declare -f "homebrew_command_not_found_handle" >/dev/null; then
    # If it exists, call it with the original command and arguments.
    homebrew_command_not_found_handle "$*"
    return $?
  else
    # If the Homebrew handler isn't available, print a standard error.
    printf "bash: %s: command not found\n" "$1" >&2
    return 127
  fi
}
