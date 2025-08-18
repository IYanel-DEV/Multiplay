# 🎮 MultiPlay - Godot Multiplayer Test Runner

> **Beautiful multiplayer testing made easy!** Launch multiple game instances instantly for local multiplayer development and testing.

![Godot Version](https://img.shields.io/badge/Godot-4.4+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Plugin](https://img.shields.io/badge/Type-Editor%20Plugin-purple.svg)

## ✨ Features

**🚀 One-Click Multiplayer Testing**
- Launch 2-8 game instances simultaneously with a single click
- Perfect for testing multiplayer mechanics without multiple devices
- Automatic process management and cleanup

**🎨 Beautiful & Intuitive Interface**
- Sleek toolbar button integrated next to Godot's play button
- Gorgeous popup panel with modern glass-morphism design  
- Smooth animations and visual feedback throughout
- Professional color scheme that matches Godot's dark theme

**⚡ Smart & Efficient**
- Lightweight plugin with minimal performance impact
- Automatic process tracking and management
- Staggered instance launching for stability
- Real-time status updates with emoji feedback

**🛠️ Developer Friendly**
- Simple installation - just drop in addons folder
- No configuration required - works out of the box
- Clean, documented code structure
- Easy to customize and extend

## 📸 Screenshots

<img width="599" height="489" alt="image" src="https://github.com/user-attachments/assets/cfc65f8e-5542-423a-8095-2a852183fb9e" />


## 🚀 Installation

### Method 1: Manual Installation
1. Download or clone this repository
2. Copy the `multiplay` folder to your project's `addons/` directory:
   ```
   your_project/
   └── addons/
	   └── multiplay/
		   ├── plugin.cfg
		   ├── plugin.gd
		   └── multiplay_panel.gd
   ```
3. Go to `Project Settings → Plugins`
4. Find "MultiPlay - Multiplayer Test Runner" and enable it
5. You'll see a new "🎮 MultiPlay" button in the toolbar!

### Method 2: Asset Library *(Coming Soon)*
*Will be available on Godot Asset Library once published*

## 🎯 How to Use

1. **Open the Panel**: Click the "🎮 MultiPlay" button in the toolbar (next to the play button)

2. **Set Instance Count**: Use the spinner to choose how many game instances to launch (2-8 players)

3. **Launch Testing**: Click "🚀 Launch Test Instances" to spawn multiple game windows

4. **Test Your Game**: Each instance runs independently - perfect for multiplayer testing!

5. **Clean Up**: Click "🛑 Close All" to terminate all instances, or just close the panel

## 🔧 Technical Details

- **Godot Version**: 4.4+
- **Plugin Type**: EditorPlugin with custom toolbar integration
- **Process Management**: Uses `OS.create_process()` for instance spawning
- **UI Framework**: Modern Godot 4.x Control nodes with custom styling
- **Performance**: Minimal overhead, runs only in editor

## 🤝 Contributing

We welcome contributions! Here's how you can help:

- 🐛 **Bug Reports**: Found an issue? Please open a GitHub issue
- 💡 **Feature Requests**: Have an idea? We'd love to hear it!
- 🔧 **Pull Requests**: Code improvements and new features welcome
- 📖 **Documentation**: Help improve our docs and examples

### Development Setup
1. Fork this repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Test with Godot 4.4+
4. Commit your changes: `git commit -m 'Add amazing feature'`
5. Push to the branch: `git push origin feature/amazing-feature`
6. Open a Pull Request

## 📝 Changelog

### v1.0.0
- ✨ Initial release
- 🎮 Toolbar button integration
- 🎨 Beautiful popup interface
- 🚀 Multi-instance launching (2-8 players)
- 🛑 Process management and cleanup
- ⚡ Real-time status updates

## 🐛 Known Issues

- None currently known! Please report any issues you encounter.

## 📋 Roadmap

- [ ] Custom scene selection for instances
- [ ] Window positioning options
- [ ] Command-line arguments support
- [ ] Export preset integration
- [ ] Saved configuration profiles
- [ ] Network testing utilities

## 🙏 Acknowledgments

- Thanks to the Godot community for inspiration and feedback
- Built with ❤️ for indie game developers
- Special thanks to multiplayer game developers who need this tool!

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🌟 Support the Project

If this plugin helps your game development:
- ⭐ **Star this repository** to show your support
- 🐦 **Share it** with other Godot developers
- 🔗 **Link to it** in your projects
- ☕ **Consider sponsoring** for continued development

---

**Made with 💙 for the Godot community**
