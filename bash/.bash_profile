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
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . $(brew --prefix)/etc/bash_completion
fi;

# WP-CLI completion
if  [ -f ~/dotfiles/bin/wp-completion.bash ]; then
    . ~/dotfiles/bin/wp-completion.bash;
fi;

# Wakatime
if  [ -f ~/Workspace/GitHub/bash-wakatime/bash-wakatime.sh ]; then
    . ~/Workspace/GitHub/bash-wakatime/bash-wakatime.sh;
fi;

# rupa/z
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/profile.d/z.sh" ]; then
    . "$(brew --prefix)/etc/profile.d/z.sh";
fi

# Google Cloud SDK
if  [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ]; then
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
fi;

if  [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc ]; then
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
fi;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
