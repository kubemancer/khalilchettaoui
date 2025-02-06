---
title: "Moving to NeoVIM"
weight: 3
draft: false
description: "My experience switching to NVIM as my main editor"
tags: ["lazyvim", "lua", "neovim"]
# series: ["Documentation"]
series_order: 3
---

For the longest time, I was a dedicated VS Code user. Microsoft's popular editor provided me with an intuitive GUI, a rich extension ecosystem, and a smooth developer experience. However, over time, VS Code became too cumbersome, too tied to the Microsoft ecosystem, and increasingly reliant on AI. While there is an alternative in **VSCodium**, I decided to give a terminal-based editor a chance—and I'm happy with the change.

## The Appeal of Neovim

Neovim is more than just an improved version of Vim—it’s a modern, extensible, and performance-oriented text editor. Here are the main reasons why I made the switch:

### 1. **Escaping the Microsoft Ecosystem**

While VS Code offers a lot, its deep integration with Microsoft's services and AI-driven features started to feel like too much. I wanted something leaner and more under my control, which led me to explore Neovim.

### 2. **A Terminal-Based Workflow for Efficiency**

Switching to keybindings and a keyboard-centric workflow was initially confusing, but I soon found it to be incredibly intuitive. Without needing a mouse, my workflow became much faster and more efficient.

### 3. **More Control and Customization**

Neovim gives you the ability to customize everything about your editor, from themes to key mappings to plugins. Unlike VS Code, where extensions work within predefined constraints, Neovim allows for a deeper level of customization.

### 4. **LSP Plugins Make Coding Feel Familiar**

Once I integrated **LSP (Language Server Protocol) plugins**, the coding experience started to feel very similar to what you would expect in a traditional GUI-based editor. This made the transition much smoother.

### 5. **Better Performance & Lower RAM Usage**

One of the biggest advantages of Neovim is its efficiency. Unlike VS Code, which can be resource-heavy, Neovim runs much leaner and consumes significantly less RAM. This makes it an excellent choice for performance-conscious developers.

### 6. **Learning Lua for Configuration**

Unlike Vim, which relies on Vimscript, Neovim supports **Lua** as its primary configuration language. This not only makes scripting and automation easier but also gives you an opportunity to learn a new, lightweight programming language.

### 7. **Choosing LazyVim as My Distribution**

There are many Neovim distributions available, but I decided to go with **LazyVim**. Here’s why:

- **Easy Setup** – LazyVim provides a great starting point with sane defaults.
- **Popular & Actively Maintained** – It’s one of the most widely used distributions, ensuring good community support.
- **Optimized Plugin Management** – LazyVim uses `lazy.nvim`, an efficient plugin manager that speeds up startup time and makes managing plugins seamless.

## Final Thoughts

Making the switch from VS Code to Neovim wasn’t easy—it required learning new keybindings, setting up configurations, and getting used to a new workflow. But once I crossed that initial hurdle, I found my development experience significantly improved. The efficiency, flexibility, and control I now have over my editor make the transition completely worth it.

If you're considering switching to Neovim, I highly recommend giving it a shot! Start with a distribution like LazyVim to ease the learning curve, and soon enough, you’ll wonder how you ever used anything else.
