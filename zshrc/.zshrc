# Ghostty shell integration for dynamic titles
# This will work with Ghostty's built-in shell integration
if [[ -n "$GHOSTTY_SHELL_INTEGRATION" ]]; then
    # Let Ghostty handle title updates through shell integration
    function chpwd() {
        # Ghostty will automatically update title with shell integration
        true
    }
fi
