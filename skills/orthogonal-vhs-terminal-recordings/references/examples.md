# VHS Tape Examples

## Example 1: Simple CLI Demo

```tape
# Simple CLI demo
Output simple-demo.gif

Set Shell "zsh"
Set FontSize 18
Set Width 900
Set Height 500
Set Theme "Catppuccin Frappe"
Set Padding 20
Set BorderRadius 10

Hide
Type "clear"
Enter
Show

Type "echo 'Hello, World!'"
Sleep 500ms
Enter
Sleep 2s

Type "ls -la"
Sleep 500ms
Enter
Sleep 2s

Sleep 1s
```

## Example 2: API Demo with Auth

```tape
# API Demo
Output api-demo.gif

Set Shell "zsh"
Set FontSize 18
Set Width 900
Set Height 500
Set Theme "Catppuccin Frappe"
Set Padding 20
Set Margin 40
Set BorderRadius 10

# Hidden setup
Hide
Type "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
Enter
Type "export API_KEY=sk_live_xxxxxxxxxxxxx"
Enter
Type "cd ~/projects/my-cli"
Enter
Type "clear"
Enter
Show

# Demo: Search
Type "mycli search 'find users'"
Sleep 500ms
Enter
Sleep 3s

# Demo: Execute
Type "mycli run users/list --limit 5"
Sleep 500ms
Enter
Sleep 4s

Sleep 1s
```

## Example 3: Multi-step Workflow

```tape
# Multi-step workflow demo
Output workflow-demo.gif

Set Shell "zsh"
Set FontSize 18
Set Width 1000
Set Height 600
Set Theme "Catppuccin Mocha"
Set Padding 20

Hide
Type "clear"
Enter
Show

# Step 1: Initialize
Type "# Step 1: Initialize project"
Sleep 300ms
Enter
Sleep 500ms
Type "npx create-my-app my-project"
Sleep 500ms
Enter
Sleep 3s

# Step 2: Navigate
Type "cd my-project"
Sleep 500ms
Enter
Sleep 500ms

# Step 3: Run
Type "# Step 2: Start development server"
Sleep 300ms
Enter
Sleep 500ms
Type "npm run dev"
Sleep 500ms
Enter
Sleep 4s

Sleep 1s
```

## Example 4: Code Generation

```tape
# Code generation demo
Output codegen-demo.gif

Set Shell "zsh"
Set FontSize 16
Set Width 1000
Set Height 700
Set Theme "Catppuccin Frappe"
Set Padding 20
Set BorderRadius 10

Hide
Type "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
Enter
Type "clear"
Enter
Show

# Generate code
Type "orth code olostep /v1/scrape --format typescript"
Sleep 500ms
Enter
Sleep 4s

# Show the generated file
Type "cat olostep-scrape.ts"
Sleep 500ms
Enter
Sleep 3s

Sleep 1s
```

## Example 5: x402 Payment Flow

```tape
# x402 payment flow demo
Output x402-demo.gif

Set Shell "zsh"
Set FontSize 18
Set Width 900
Set Height 500
Set Theme "Catppuccin Frappe"
Set Padding 20
Set BorderRadius 10

Hide
Type "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
Enter
Type "export ORTHOGONAL_API_KEY=orth_live_xxx"
Enter
Type "clear"
Enter
Show

# Show balance
Type "orth account"
Sleep 500ms
Enter
Sleep 2s

# Make paid API call
Type "orth run olostep /v1/scrape url=https://news.ycombinator.com"
Sleep 500ms
Enter
Sleep 5s

# Check balance again
Type "orth account"
Sleep 500ms
Enter
Sleep 2s

Sleep 1s
```
