# ✨ My Terminal Dotfiles

> Because life's too short for ugly terminals 🎨

A collection of my personal terminal configurations.👾

## 🛠️ What's Inside

This repo contains configs for:

- **[Ghostty](https://github.com/ghostty-org/ghostty)** 👻 - GPU-accelerated terminal with sick shader effects
- **[Wezterm](https://wezfurlong.org/wezterm/)** 🖥️ - Cross-platform terminal goodness
- **[Starship](https://starship.rs/)** 🚀 - The blazing-fast prompt that makes you look productive
- **Zsh** 🐚 - Shell integration magic

## 🎯 Quick Start

```bash
# Clone it
git clone https://github.com/ashwinjohn3/dotfiles.git ~/dotfiles

# Symlink what you need
ln -sf ~/dotfiles/ghostty ~/.config/ghostty
ln -sf ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
ln -sf ~/dotfiles/starship/starship.toml ~/.config/starship.toml

# Add zsh integration (optional)
cat ~/dotfiles/zshrc/.zshrc >> ~/.zshrc
```

## ⚡ Features

- 🎨 **Visual Effects** - Custom GLSL shaders for Ghostty (fireworks, galaxy, cursor trails!)
- 🪟 **Glass Mode** - Modern transparency and blur effects
- ⬅️ **Arrow Key Navigation** - Intuitive split navigation with arrow keys
- 🎯 **Synced Keybindings** - Same shortcuts across Ghostty and Wezterm
- 🌈 **Clean Prompt** - Minimal Starship config that stays out of your way
- 📊 **Git Integration** - Know your repo status at a glance

## 🎮 Keybindings Preview

Both Ghostty and Wezterm share the same shortcuts:
- `Cmd+D` for splits (right) / `Cmd+Shift+D` (down)
- `Cmd+Arrow Keys` to navigate splits
- `Cmd+1-9` to jump between tabs
- `Cmd+Alt+Arrow Keys` to resize splits

Full list inside the configs 📝

## 🌟 Credits

Shoutout to the awesome folks whose code I've borrowed:
- [chardskarth](https://gist.github.com/chardskarth/95874c54e29da6b5a36ab7b50ae2d088) - Cursor blaze shader
- [The Art of Code](https://www.shadertoy.com/view/lscGRl) - Fireworks shader
- [Crackerfracks](https://github.com/Crackerfracks/Synesthaxia.glsl) - Synesthaxia shader
- Everyone whose dotfiles I've stalked on GitHub 👀

## 💬 Contributing

Found something cool? Spotted a bug? PRs and issues welcome!

Or just fork it and make it yours. 🚀

**Got your own dotfiles?** Share them! I'd love to see what you've built and learn from your setup too! 💡

---

Happy hacking! 💻✨
