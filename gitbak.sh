#!/bin/bash

# Backup configurations
echo "Copying configuration files..."

# Define sanitization function
sanitize_files() {
    local matches="$1"
    
    echo ""
    echo "⚠️  WARNING: Sensitive data detected!"
    echo "You will be prompted to sanitize each occurrence."
    echo ""
    
    # Process each match line-by-line
    # Use file descriptor 3 to avoid stdin conflict
    while IFS= read -r match <&3; do
        # Parse: file:line_number:line_content
        file=$(echo "$match" | cut -d: -f1)
        line_num=$(echo "$match" | cut -d: -f2)
        line_content=$(echo "$match" | cut -d: -f3-)
        
        echo "════════════════════════════════════════"
        echo "📄 File: $file"
        echo "📍 Line $line_num: $line_content"
        echo ""
        echo "Options:"
        echo "  [r] Replace - edit this line (default)"
        echo "  [d] Delete - remove this line entirely"
        echo "  [s] Skip - keep as is"
        echo "  [a] Abort - stop the backup"
        echo ""
        read -p "Action [r/d/s/a] (default: replace): " action
        
        # Default to replace if empty input
        action=${action:-r}
        
        case "$action" in
            r|R)
                echo ""
                echo "────────────────────────────────────────"
                echo "Current line:"
                echo "  $line_content"
                echo "────────────────────────────────────────"
                echo "Enter new line (or press Enter to keep as-is):"
                read -e -p "> " new_line
                
                # If empty, keep original
                if [ -z "$new_line" ]; then
                    new_line="$line_content"
                    echo "✓ Line kept unchanged"
                else
                    # Escape special characters for sed
                    escaped_new_line=$(printf '%s\n' "$new_line" | sed 's/[&/\]/\\&/g')
                    
                    # Replace the specific line in the file
                    sed -i.bak "${line_num}s/.*/${escaped_new_line}/" "$file"
                    rm -f "${file}.bak"
                    echo "✓ Line replaced"
                fi
                ;;
            d|D)
                echo ""
                echo "🗑️  Deleting line $line_num from $file"
                # Delete the specific line
                sed -i.bak "${line_num}d" "$file"
                rm -f "${file}.bak"
                echo "✓ Line deleted"
                ;;
            s|S)
                echo "⊘ Skipped - line kept as is"
                ;;
            a|A)
                echo ""
                echo "❌ Backup aborted by user."
                exit 1
                ;;
            *)
                echo "⚠️  Invalid option. Treating as replace..."
                # Same as replace
                echo ""
                echo "────────────────────────────────────────"
                echo "Current line:"
                echo "  $line_content"
                echo "────────────────────────────────────────"
                echo "Enter new line (or press Enter to keep as-is):"
                read -e -p "> " new_line
                
                if [ -z "$new_line" ]; then
                    new_line="$line_content"
                    echo "✓ Line kept unchanged"
                else
                    escaped_new_line=$(printf '%s\n' "$new_line" | sed 's/[&/\]/\\&/g')
                    sed -i.bak "${line_num}s/.*/${escaped_new_line}/" "$file"
                    rm -f "${file}.bak"
                    echo "✓ Line replaced"
                fi
                ;;
        esac
        echo ""
    done 3<<< "$matches"
}

cp -r ~/.config/kitty ~/git_backup
cp -r ~/.config/nvim ~/git_backup

cp ~/.tmux.conf ~/git_backup
cp ~/.taskrc ~/git_backup
cp  ~/.zshrc ~/git_backup

cd ~/git_backup

# Security check: Scan for sensitive data before committing
echo "Running security checks on copied files..."

SENSITIVE_PATTERNS="password|token|secret|api[_-]key|swisscom|Swisscom"

# Scan for sensitive patterns
matches=$(grep -E -i -r -n "$SENSITIVE_PATTERNS" . \
    --exclude=".gitignore" \
    --exclude="README.md" \
    --exclude="LICENSE" \
    --exclude="gitbak.sh" \
    --exclude-dir=".git" 2>/dev/null)

# Main sanitization loop
while [ -n "$matches" ]; do
    # Call sanitization function
    sanitize_files "$matches"
    
    # Re-run security check to verify
    echo "Re-running security check..."
    matches=$(grep -E -i -r -n "$SENSITIVE_PATTERNS" . \
        --exclude=".gitignore" \
        --exclude="README.md" \
        --exclude="LICENSE" \
        --exclude="gitbak.sh" \
        --exclude-dir=".git" 2>/dev/null)
    
    if [ -n "$matches" ]; then
        echo ""
        echo "⚠️  WARNING: Sensitive patterns still detected!"
        echo ""
        echo "Remaining issues:"
        # Show file:line + content for each remaining match
        # Use file descriptor 3 to avoid stdin conflict
        while IFS= read -r match <&3; do
            file=$(echo "$match" | cut -d: -f1)
            line_num=$(echo "$match" | cut -d: -f2)
            line_content=$(echo "$match" | cut -d: -f3-)
            echo "  • $file:$line_num"
            echo "    → $line_content"
        done 3<<< "$matches"
        echo ""
        echo "Options:"
        echo "  [e] Edit again - sanitize remaining items (default)"
        echo "  [c] Continue - proceed with backup anyway"
        echo "  [a] Abort - stop the backup"
        echo ""
        read -p "Action [e/c/a] (default: edit again): " post_action
        
        # Default to edit again if empty input
        post_action=${post_action:-e}
        
        case "$post_action" in
            e|E)
                echo "Re-entering sanitization mode..."
                echo ""
                # Loop continues with remaining matches
                ;;
            c|C)
                echo "⚠️  Continuing with backup despite warnings..."
                break  # Exit the while loop, proceed to git operations
                ;;
            a|A)
                echo ""
                echo "❌ Backup aborted."
                exit 1
                ;;
            *)
                echo "⚠️  Invalid option. Re-entering sanitization mode..."
                echo ""
                # Loop continues (treat invalid as default)
                ;;
        esac
    else
        echo "✓ All sensitive data sanitized."
        break  # Exit the while loop
    fi
done

if [ -z "$matches" ]; then
    echo "✓ Security check passed - no sensitive data detected."
fi

echo ""

# Add all files (including .gitignore)
git add --all
git commit -m "regular update"
git push

echo "Backup completed successfully."
