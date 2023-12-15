# Phoenix Development Setup Script

This script automates the setup of a Phoenix development environment. It configures Zsh as the default shell, installs Oh My Zsh, Homebrew, necessary extensions, and sets up a productive coding environment with Visual Studio Code and PostgreSQL. Additionally, it installs Erlang, Elixir, Node.js, and the Phoenix project generator.

## Prerequisites

- macOS operating system (for now)
- Administrator access to install software
- Internet connection for downloading necessary tools

## Features

- Sets Zsh as the default shell.
- Installs and configures Oh My Zsh.
- Installs Homebrew, the macOS package manager.
- Configures Zsh with useful extensions and aliases.
- Sets up a development environment with Visual Studio Code, iTerm2, DBeaver Community, and PostgreSQL.
- Installs and configures Elixir, Erlang, and Node.js using asdf version manager.
- Installs the Phoenix project generator.

## Usage

- Open the Terminal.
- Clone this repo and enter it
- `cd scripts`
- Make the script executable with the command: `chmod +x mac_setup.sh` (replace mac_setup.sh with the name of your script file if not on mac).
- Run the script: `./mac_setup.sh.`
- Follow any on-screen instructions during the setup process.
- Restart your terminal for all changes to take effect, especially for Zsh configuration.

## Post-Installation

Now you can generate a new project and your editor should be configured. The command below will generate a project called `hello_world` and will open the project in Visual Studio Code. 

```bash
mix phx.new hello_world && cd hello_world && code .
```

## Contributions

Feedback and contributions to improve this script are welcome. Please feel free to fork, modify, and send pull requests or open an issue in the repository if you have suggestions or find bugs.

## Future Plans

- Add Neovim setup option. Prompt user for vscode or neovim.
- Add other operating systems