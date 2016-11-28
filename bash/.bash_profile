# Load our dotfiles like ~/.bash_prompt, etc…
#   ~/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && . "$file"
done
unset file

# added by travis gem
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

# hub completion
if  which hub > /dev/null; then
    . "$(brew --prefix)/etc/bash_completion.d/hub.bash_completion.sh";
fi;

# WP-CLI completion
if  [ -f ~/dotfiles/bin/wp-completion.bash ]; then
    . ~/dotfiles/bin/wp-completion.bash;
fi;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;