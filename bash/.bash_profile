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

# Git completion
# From https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
if [ -f ~/dotfiles/bin/git-completion.bash ]; then
  . ~/dotfiles/bin/git-completion.bash
fi

# Wakatime
if [ -f ~/Workspace/GitHub/bash-wakatime/bash-wakatime.sh ]; then
    . ~/Workspace/GitHub/bash-wakatime/bash-wakatime.sh;
fi;

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
