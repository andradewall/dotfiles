# Dotfiles

## Requirements

- [Stow](#stow)
- [Tmux](#tmux)

### Stow

You need GNU Stow to auto-deploy files to your environment.

```bash
sudo zypper in stow # opensuse tumbleweed
```  

See more info [here](https://www.gnu.org/software/stow/manual/stow.html).

### Tmux

You need Tmux as a terminal multiplexer.

```bash
sudo zypper in tmux # opensuse tumbleweed

# after installed, download TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
See more info [here](https://github.com/tmux/tmux/wiki/Installing).

