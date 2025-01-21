# Dotfiles

## Index

- [Stow](#stow)
- [Tmux](#tmux)
- [Starship](#starship)
- [Bash](#bash)

## Stow

You need GNU Stow to auto-deploy files to your environment.

```bash
sudo zypper in stow # opensuse tumbleweed
```  

See more info [here](https://www.gnu.org/software/stow/manual/stow.html).

## Tmux

You need Tmux as a terminal multiplexer.

```bash
sudo zypper in tmux # opensuse tumbleweed

# after installed, download TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

See more info [here](https://github.com/tmux/tmux/wiki/Installing).

## Starship

You need Starship as your shell prompt

```bash
sudo zypper in starship # opensuse tumbleweed
```

See more info [here](https://starship.rs/guide/).

## Bash

Bash is your shell interpreter. To have the full experience, you'll need:

- eza; [Installation](https://github.com/eza-community/eza/blob/main/INSTALL.md)
- lazygit; [Installation](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation)
- fzf; [Installation](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
- bat; [Installation](https://github.com/sharkdp/bat?tab=readme-ov-file#installation)
- zoxide; [Installation](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation)
