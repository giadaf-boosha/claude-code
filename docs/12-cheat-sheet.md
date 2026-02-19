# Claude Code Cheat Sheet

> Reference: [bhancockio/claude-code-cheat-sheet](https://github.com/bhancockio/claude-code-cheat-sheet)

A comprehensive guide to setting up and using Claude Code efficiently with a keyboard-first workflow.

## 0. First Time Setup: Login

**IMPORTANT**: Before anything else, make sure you're logged in correctly to get the best experience.

### Login Instructions

1. Open Claude Code in your terminal
2. You'll be prompted to log in
3. Choose the authentication method attached to your Claude subscription plan (not API)
4. If you have Claude Pro or Claude Max, use your Anthropic account login
5. This ensures you get the full benefits of your subscription plan
6. Verify you're logged in by running `/cost` - you should see your subscription info

**Why This Matters**: Logging in with your subscription plan (vs API) gives you better rate limits, access to the latest models, and no per-request costs if you have Claude Max.

## 1. Claude Code Setup

Configure Claude Code for an optimal development experience. Follow these setup steps in order.

### Step 1: Shift+Enter Support (Essential First Step)

The most important setup - enables submitting messages to Claude with SHIFT + ENTER.

**Setup Instructions**: Run `/terminal-setup` in Claude Code, which will automatically configure your terminal settings.

**Manual Setup Alternative**:
1. Open Cursor/VS Code settings
2. Search for "Terminal > Integrated: Send Keybindings To Shell"
3. Uncheck this option

**Fallback**: If Shift+Enter isn't working, use `\\ + ENTER` (backslash + enter) to submit messages.

### Step 2: Settings Customization

Customize Claude Code behavior through `.claude/settings.json` in your project root.

```json
{
  "model": "claude-sonnet-4-5-20250929",
  "autoApprovalSettings": {
    "enabled": true,
    "patterns": [
      "Read(//Users/yourname/**)",
      "Bash(npm run lint)",
      "Bash(git log:*)"
    ]
  },
  "statusLine": {
    "enabled": true,
    "template": "{{model}} | {{tokens}}"
  }
}
```

Key Settings to Know:
- **model**: Choose which Claude model to use
- **autoApprovalSettings**: Auto-approve specific tool uses to speed up workflow
- **statusLine**: Show model and token usage in status bar
- **hooks**: Configure shell commands that run on events (see Step 4)

### Step 3: MCP Server Configuration

MCP (Model Context Protocol) servers extend Claude Code with specialized capabilities.

**What MCP Servers Provide**:
- **Supabase**: Database operations, migrations, logs
- **Context7**: Up-to-date library documentation
- **Time**: Timezone conversions and current time
- **Custom servers**: Build your own integrations

Setup via `.mcp.json`:

```json
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp-server"]
    }
  }
}
```

### Step 4: Hooks Configuration

Hooks run shell commands automatically in response to events.

**Common Hook: Noise When Claude Finishes**

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Pop.aiff"
          }
        ]
      }
    ]
  }
}
```

**Available Hooks**:
- `UserPromptSubmit`: Runs when you submit a message
- `Stop`: Runs when Claude stops/finishes responding
- `PreToolUse`: Runs before tool execution (with optional matcher)
- `PostToolUse`: Runs after tool execution (with optional matcher)
- `SessionStart` / `SessionEnd`: Runs at session lifecycle events
- `SubagentStop`: Runs when a subagent stops
- `PreCompact`: Runs before conversation compaction
- `Notification`: Runs on notification events

**Example: Validate Bash Commands Before Execution**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python3 /path/to/validator.py"
          }
        ]
      }
    ]
  }
}
```

**Example: Lint After Edits**

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "npm run lint"
          }
        ]
      }
    ]
  }
}
```

**Windows/Linux Alternative for Sounds**:

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "powershell -c (New-Object Media.SoundPlayer 'C:\\\\Windows\\\\Media\\\\Windows Ding.wav').PlaySync()"
          }
        ]
      }
    ]
  }
}
```

## 2. Editor Setup (Cursor/VS Code)

Master these shortcuts to keep your hands on the keyboard and navigate efficiently.

### Terminal Management

| Action | macOS | Windows/Linux | Custom Setup Required | Example Use |
|--------|-------|---------------|----------------------|-------------|
| Create Terminal in Editor Area | `CMD + SHIFT + C` | `CTRL + SHIFT + C` | Yes* | Open a new terminal as a tab in the editor |
| Rename Terminal | `CMD + SHIFT + R` | `CTRL + SHIFT + R` | Yes* | Label terminals by purpose |
| Navigate Terminal Tabs | `CMD + SHIFT + [ / ]` | `CTRL + SHIFT + [ / ]` | Yes* | Switch between multiple terminal instances |

*Note: These shortcuts require custom keybinding setup.

### Window & Pane Navigation

| Action | macOS | Windows/Linux | Example Use |
|--------|-------|---------------|-------------|
| Toggle Sidebar | `CMD + B` | `CTRL + B` | Hide/show file explorer |
| Focus File Explorer | `CMD + SHIFT + E` | `CTRL + SHIFT + E` | Open and focus the file explorer sidebar |
| Toggle Terminal | `` CTRL + ` `` | `` CTRL + ` `` | Open/close the integrated terminal |
| Toggle Bottom Panel | `CMD + J` | `CTRL + J` | Show/hide bottom panel |
| Open Source Control | `CMD + SHIFT + G` | `CTRL + SHIFT + G` | View git changes |
| Go to Line | `CMD + G` | `CTRL + G` | Jump to a specific line number |
| Split Editor Pane | `CMD + \\` | `CTRL + \\` | View multiple files side-by-side |
| Focus Specific Pane | `CMD + 1/2/3` | `CTRL + 1/2/3` | Jump to first, second, or third editor pane |
| Close Current Pane | `CMD + W` | `CTRL + W` | Close the currently focused editor pane |
| Quick Open File | `CMD + P` | `CTRL + P` | Open files by name |
| Command Palette | `CMD + SHIFT + P` | `CTRL + SHIFT + P` | Access all VS Code/Cursor commands |

### File Operations

| Action | How To | Example Use |
|--------|--------|-------------|
| Drag & Drop Images | Hold SHIFT while dragging | Add screenshots to Claude Code conversations |

### Custom Keybinding Setup

1. Open Command Palette: `CMD/CTRL + SHIFT + P`
2. Type "Preferences: Open Keyboard Shortcuts (JSON)"
3. Add custom keybindings to `keybindings.json`

```json
[
  {
    "key": "cmd+shift+c",
    "command": "workbench.action.terminal.newInActiveWorkspace",
    "args": { "location": "editor" }
  },
  {
    "key": "cmd+shift+r",
    "command": "workbench.action.terminal.rename"
  },
  {
    "key": "cmd+shift+[",
    "command": "workbench.action.terminal.focusPrevious"
  },
  {
    "key": "cmd+shift+]",
    "command": "workbench.action.terminal.focusNext"
  }
]
```

For Windows/Linux: Replace `cmd` with `ctrl` in the keybindings above.

## 3. Claude Code Interface & Commands

### 3.1 Text Editing Shortcuts

| Action | macOS | Windows/Linux | When to Use |
|--------|-------|---------------|-------------|
| New Line | `SHIFT + ENTER` | `SHIFT + ENTER` | Add line breaks in your prompt |
| Go to Beginning of Line | `CTRL + A` | `HOME` or `CTRL + A` | Jump to start |
| Go to End of Line | `CTRL + E` | `END` or `CTRL + E` | Jump to end |
| Delete Entire Line | `CTRL + U` | `CTRL + U` | Clear current line quickly |
| Move Back One Word | `OPTION + ←` | `CTRL + ←` | Navigate backward word by word |
| Delete Previous Word | `OPTION + DELETE` | `CTRL + BACKSPACE` | Remove word at a time |
| Stop Current AI Run | `ESC` | `ESC` | Stop Claude from continuing |
| Revert to Previous Step | `ESC ESC` (double tap) | `ESC ESC` (double tap) | Undo Claude's last action |

### 3.2 Claude Code-Specific Panels

| Action | Shortcut | When to Use |
|--------|----------|-------------|
| Show Tasks Panel | `CTRL + T` | View current tasks and todos |
| View Thinking | `CTRL + O` | Open Claude's reasoning and thought process |
| Toggle Thinking Mode | `TAB` | Show/hide Claude's reasoning |

### 3.3 Common Claude Code Commands

| Command | What It Does | When to Use |
|---------|-------------|-------------|
| `/help` | Show all available commands | Get quick reference |
| `/terminal-setup` | Configure terminal for Shift+Enter | First-time setup |
| `/model` | Switch between Claude models | Use Haiku for speed, Opus for complex reasoning |
| `/context` | Show current context size and token usage | Check context before hitting limits |
| `/clear` | Start a new conversation | Switch tasks or need fresh context |
| `/compact` | Compress conversation history | When approaching context limits |
| `/cost` | Show usage and subscription info | Monitor your usage |
| `/usage` | Show detailed usage statistics | View token usage across conversations |
| `/rewind` | Undo the last assistant message | When Claude makes a mistake |
| `/resume` | Resume the last conversation | Continue where you left off |

### 3.4 Custom ShipKit Commands

#### Prep Setup Commands (Run in order for new projects)

| Command | What It Does |
|---------|-------------|
| `/01_generate_master_idea` | Generate comprehensive master idea document |
| `/02_generate_app_name` | AI-powered app name generation with market research |
| `/03_generate_ui_theme` | Create cohesive, professional color themes |
| `/04_chatgpt_logo_generation` | Generate 10 unique logo prompts |
| `/05_generate_app_pages_and_functionality` | Blueprint your application structure |
| `/06_generate_wireframe` | Create wireframes for your app |
| `/07_generate_initial_data_models` | Design strategic database models |
| `/08_generate_system_design` | Make smart architectural decisions |
| `/09_generate_build_order` | Generate development roadmap |

#### Development Workflow Commands

| Command | What It Does |
|---------|-------------|
| `/task_template` | Create comprehensive task documents |
| `/bugfix` | Quick bug triage and fix workflow |
| `/diff` | Analyze code changes with before/after comparisons |
| `/cleanup` | Comprehensive codebase cleanup analysis |
| `/git_workflow_commit` | Analyze changes and create meaningful commits |
| `/pr_review` | Systematic code review checklist |

#### Database Commands

| Command | What It Does |
|---------|-------------|
| `/drizzle_down_migration` | Generate down migrations from up migrations |
| `/drizzle-rollback-workflow` | Guide through complete migration rollback |

#### UI/Design Commands

| Command | What It Does |
|---------|-------------|
| `/improve_ui` | Transform generic UI into professional design |
| `/generate_landing_page` | Create high-converting landing page |
| `/generate_diagram` | Create comprehensive Mermaid diagrams |

#### Deployment & Infrastructure

| Command | What It Does |
|---------|-------------|
| `/setup_auth` | Guide through OAuth setup (Google & GitHub) |
| `/update_template_workflow` | Safely update with upstream template improvements |
| `/gcp_debugging_template` | Debug GCP deployment issues |

#### Advanced/Specialized Commands

| Command | What It Does |
|---------|-------------|
| `/python_task_template` | Task template for Python development |
| `/cleanup_python` | Comprehensive cleanup analysis for Python |
| `/adk_task_template` | Task template for Google ADK agent systems |
| `/adk_bottleneck_analysis` | Analyze performance bottlenecks in ADK agents |
| `/agent_orchestrator` | Design and build Google ADK workflow projects |

## 4. Development Workflows

### Quick Review of Changes

A typical workflow for reviewing changes after working with Claude:

1. **Open Source Control** - `CMD/CTRL + SHIFT + G` → Review all file changes Claude made, see git diff
2. **Open File Explorer** - `CMD/CTRL + SHIFT + E` → Navigate to specific files, browse project structure
3. **Close Sidebar** - `CMD/CTRL + B` → Hide file explorer when done to maximize screen space

This workflow keeps your hands on the keyboard and lets you efficiently review Claude's changes before committing.
