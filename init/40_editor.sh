apm stars --install

# VS Code Specific setup
VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code"
mkdir -p "$VSCODE_SETTINGS_DIR"
rm -rf "$VSCODE_SETTINGS_DIR/User"
ln -s "$DOTFILES/config/vscode" "$VSCODE_SETTINGS_DIR/User"
