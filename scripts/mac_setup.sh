#!/bin/zsh
# 
# 1. Install xCode command line tools
#
xcode-select --install
# 
# 2. Set Zsh as the default shell
#
echo 'Verifying Zsh is the default shell...'
current_shell=$(dscl . -read ~/ UserShell | sed 's/UserShell: //')
zsh_path="/bin/zsh"
# Check if the current shell is not Zsh
if [ "$current_shell" != "$zsh_path" ]; then
    echo "Changing default shell to Zsh..."
    brew install zsh
    chsh -s $zsh_path
    echo "Default shell changed to Zsh. You may need to log out and log back in for this to take effect."
else
    echo "Zsh is already the default shell."
fi
#
# 3. Install Oh my Zsh
#
# Check if Oh My Zsh is already installed
echo 'Verifying On My Zsh is installed...'
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo 'Oh My Zsh not found. Installing Oh My Zsh...'
    # Install Oh My Zsh 
    # Run in background so exit doesn't kill script
    nohup /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null 2>&1 &
        
    # Wait for the Oh My Zsh installation to complete
    while [ ! -d "$HOME/.oh-my-zsh" ]; do
        sleep 1
    done

    echo "Oh My Zsh installed."
else
    echo "Oh My Zsh is already installed."
fi
#
# 4. Install Homebrew
#
# Check if Homebrew is already installed
echo 'Verifying Homebrew is installed...'
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source ~/.zshrc
    source ~/.zprofile
else
    echo "Homebrew is already installed."
fi
#
# 5. Zsh configuration and extensions
#
# - <https://github.com/zsh-users/zsh-autosuggestions>
#
# Install extensions
brew install zsh-autosuggestions
echo 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
# Append Zsh aliases
cat << 'EOF' >> ~/.zshrc
# General
alias g2platform="cd ~/work/platform"
alias g2webapp="cd ~/work/webapp"

# Start applications
alias run_minio="minio server --console-address 127.0.0.1:55649 --address 127.0.0.1:9000 ~/work/minio/data"
alias run_webapp="g2webapp && npm run dev"
alias run_platform="g2platform && iexs"

# Start interactive server session w and w/out minio
alias iexs="iex -S mix phx.server"
alias iexsm="USE_MINIO=true iex -S mix phx.server"

# Reset test enviornment only
alias reset_tests="MIX_ENV=test mix ecto.reset"

alias mixcw="mix compile --warnings-as-errors --return-errors"
alias mixxref="mix xref graph --label compile-connected --fail-above 0"
alias mixsobelow="mix sobelow --compact --skip -v"

# Commands to run before pushing
alias prepush="mix format && mixcw && mix test && mixxref && mixsobelow"
EOF
source ~/.zshrc
#
# 6. Setup code editor
#
# Install Terminal, Code Editor and Database Client
brew install coreutils curl git autoconf wxwidgets postgresql asdf -v
brew install --cask iterm2 -v
brew install --cask visual-studio-code -v
brew install --cask dbeaver-community -v
brew services start postgresql
# Install VS Code Extensions
code --install-extension JakeBecker.elixir-ls --force
code --install-extension phoenixframework.phoenix --force
code --install-extension jamilabreu.vscode-phoenix-snippets --force
code --install-extension eamodio.gitlens --force
code --install-extension dbaeumer.vscode-eslint --force
code --install-extension syler.sass-indented --force
# Append zsh configs
cat << 'EOF' >> ~/.zshrc
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='code'
fi

# Code Launcher fix
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
EOF
#
# 7. Install Languages: Elixir Erlang and Node
#
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add nodejs

asdf install erlang latest
asdf install elixir latest
asdf install nodejs latest

asdf global erlang latest
asdf global elixir latest
asdf global nodejs latest

echo '. /opt/homebrew/opt/asdf/libexec/asdf.sh' >> ~/.zshrc
source ~/.zshrc
#
# 8. Install Phoenix Project Generator
#
mix archive.install hex phx_new