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

# Travis CI gem.
[ -f ~/.travis/travis.sh ] && . ~/.travis/travis.sh

# Load the default .profile
[[ -s "$HOME/.profile" ]] && . "$HOME/.profile"

# Homebrew completion
if  which brew > /dev/null; then
    . "$(brew --prefix)/etc/bash_completion.d/brew"
fi;

# Bash completion
if  which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  . "$(brew --prefix)/share/bash-completion/bash_completion";
fi;

# Git completion
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
    . "$(brew --prefix)/etc/bash_completion.d/git-completion.bash";
fi

# hub completion
if which brew > /dev/null && which hub > /dev/null; then
    . "$(brew --prefix)/etc/bash_completion.d/hub.bash_completion.sh";
fi;

# WP-CLI completion
if  [ -f ~/dotfiles/bin/wp-completion.bash ]; then
    . ~/dotfiles/bin/wp-completion.bash;
fi;

# Appflow completion
if  [ -f ~/.appflow_completion ]; then
    . ~/.appflow_completion;
fi;

# Heroku completion
if  [ -f ~/Library/Caches/heroku/autocomplete/bash_setup ]; then
    . ~/Library/Caches/heroku/autocomplete/bash_setup;
fi;

# Wakatime
if  [ -f ~/Workspace/GitHub/bash-wakatime/bash-wakatime.sh ]; then
    . ~/Workspace/GitHub/bash-wakatime/bash-wakatime.sh;
fi;

# rupa/z
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/profile.d/z.sh" ]; then
    . "$(brew --prefix)/etc/profile.d/z.sh";
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
