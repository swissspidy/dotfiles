# Dotfiles

After using some mixed, inconsistent configuration I eventually decided to clean everything up and put my dotfiles on GitHub.

It's still work in progress, but it's already improved my workflow a lot so I figured i might just as well share it with the public.

## Personal Highlights

* Super useful aliases and functions
* Nicer diffs
* Sensible macOS defaults

## Setup

When switching computers, check out `./migration/backup_old_machine` for some more commands to run on the old machine, step by step.

On the new computer, copy the needed parts from `./migration/setup_new_machine` to install Xcode Command Line Tools, Homebrew, Composer, WP-CLI, et al. Use `./migration/configure_macos` to set some sensible OS defaults.

For Homebrew, the `Brewfile` is used to install packages. Make sure you regularly update this file using `brew bundle dump --force`. This could take a moment, so use `brew bundle check` before hand.

The `stow` command at the end symlinks the bash and Git configuration to the home directory. Check out [this blog post](brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) for more information about `stow`.

Bonus: change the Terminal theme as per [these instructions](https://github.com/paulmillr/dotfiles#additional-steps).

## Credits

This repository has been inspired by the awesome work of these fine folks:

* [paulirish](https://github.com/paulirish/dotfiles)
* [mathiasbynens](https://github.com/mathiasbynens/dotfiles/)
* [paulmillr](https://github.com/paulmillr/dotfiles)
* [gf3](https://github.com/gf3/dotfiles)
* [alrra](https://github.com/alrra/dotfiles)

Also: Stack Overflow, Twitter, and many more resources.