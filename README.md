[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GPL3 License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
[![Ask Me Anything][ask-me-anything]][personal-page]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/stiliajohny/commitron">
    <img src="https://raw.githubusercontent.com/stiliajohny/commitron/master/.assets/logo-new.png" alt="Main Logo" width="80" height="80">
  </a>

  <h3 align="center">commitron</h3>

  <p align="center">
    AI-driven CLI tool that generates optimal, context-aware commit messages, streamlining your version control process with precision and efficiency
    <br />
    <a href="./README.md"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/stiliajohny/commitron/issues/new?labels=i%3A+bug&template=1-bug-report.md">Report Bug</a>
    ·
    <a href="https://github.com/stiliajohny/commitron/issues/new?labels=i%3A+enhancement&template=2-feature-request.md">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->

## Table of Contents

- [Commitron](#commitron)
  - [Features](#features)
  - [Example output](#example-output)
  - [Installation](#installation)
    - [Using Homebrew (macOS)](#using-homebrew-macos)
    - [Manual Installation](#manual-installation)
  - [Usage](#usage)
  - [Configuration](#configuration)
  - [API Keys](#api-keys)
  - [License](#license)
    - [Built With](#built-with)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation-1)
  - [Usage](#usage-1)
  - [Roadmap](#roadmap)
  - [Contributing](#contributing)
  - [License](#license-1)
  - [Contact](#contact)
  - [Acknowledgements](#acknowledgements)

<!-- ABOUT THE PROJECT -->

## About The Project

<!-- [![commitron Screen Shot][product-screenshot]](./.assets/screenshot.png) -->

# Commitron

Commitron is a CLI tool that generates AI-powered commit messages based on your staged changes in a git repository.

## Features

- 🤖 **AI-Powered Commit Messages**: Uses AI to generate meaningful, structured commit messages
- 🔄 **Automatic File Staging**: Automatically stages tracked modified files when no files are staged
- 🎯 **Smart File Detection**: Only stages tracked files, ignores untracked files for clean commits
- 📝 **Structured Output**: Generates commit messages with bullet-point descriptions of changes
- 🚀 **No User Confirmation**: Automatically commits with generated messages for streamlined workflow
- 🧩 **Multiple AI Providers**:
  - OpenAI (ChatGPT)
  - Google Gemini
  - Ollama (local inference)
  - Anthropic Claude
- 📋 **Commit Conventions**:
  - [Conventional Commits](https://www.conventionalcommits.org/) (recommended)
  - Plain text
  - Custom templates
- ⚙️ **Fully Configurable**: Customizable settings via configuration file
- 🛠️ **Easy Build System**: Makefile support with custom Go path configuration

## Example output

Commitron now works seamlessly without manual intervention. Here's what you'll see:

**When you have unstaged changes:**
```bash
$ commitron
⚠️  No staged files found. Automatically staging all modified files...
✓ Staged 4 files

🤖 Analyzing changes...

💬 Generated Commit Message
────────────────────────
fix: Resolve blocking issue in damage check worker

- Increased prefetch_count from 1 to 10 to allow concurrent job processing
- Made job processing non-blocking using asyncio.create_task()
- Created dedicated process_damage_check_job() function for isolated job handling
- Jobs now process concurrently instead of sequentially blocking each other
────────────────────────

💾 Creating commit... ✓ complete
```

**When you already have staged files:**
```bash
$ commitron
🤖 Analyzing changes...

💬 Generated Commit Message
────────────────────────
feat(auth): add JWT token refresh mechanism

- Implemented automatic token refresh before expiration
- Added refresh token storage in secure HTTP-only cookies
- Created token validation middleware for protected routes
- Updated login flow to return both access and refresh tokens
────────────────────────

💾 Creating commit... ✓ complete
```

The commit is automatically created with the AI-generated message - no manual confirmation needed!

## Installation

### Using Homebrew (macOS)

```bash
# Add the tap directly from the commitron repository
brew tap stiliajohny/commitron https://github.com/stiliajohny/commitron.git

# Then install commitron
brew install commitron
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/johnstilia/commitron.git

# Navigate to the directory
cd commitron

# Build using Make (recommended)
make build

# Or build with Go directly
go build -o bin/commitron ./cmd/commitron

# Add to your PATH or copy to a directory in your PATH
cp bin/commitron /usr/local/bin/  # or your preferred location
```

**Note:** If Go is not in your PATH, the Makefile will automatically use the Go installation at `/home/pzhu/software/go/bin/go`. You can modify the `GO_PATH` variable in the Makefile to match your Go installation.

## Usage

Commitron is designed to be simple and automatic:

```bash
# Basic usage - automatically stages tracked files and commits
commitron

# Or manually stage files first (traditional approach)
git add .
commitron

# Use with a custom config file
commitron --config /path/to/custom/config.yaml
# or using shorthand flags
commitron -c /path/to/custom/config.yaml
```

### Available Commands

```bash
commitron                     # Generate and commit (default command)
commitron generate            # Generate and commit (explicit)
commitron init                # Initialize a new configuration file
commitron version             # Show version information

# Command options
commitron generate --dry-run  # Preview message without committing
commitron generate -d         # Shorthand for --dry-run
commitron init --force        # Overwrite existing config
commitron init -f             # Shorthand for --force

# Get help for any command
commitron --help
commitron [command] --help
```

### Auto-Staging Behavior

- **Tracked files only**: Only stages files that are already tracked by Git (shown in "Changes not staged for commit")
- **Ignores untracked**: Never stages new files (shown in "Untracked files")
- **Smart detection**: If you have staged files, uses those; if not, automatically stages modified tracked files
- **Clean workflow**: No manual staging required for existing files

### Build Commands

```bash
make build                    # Build for current platform
make build-all               # Build for all supported platforms  
make test                    # Run tests
make clean                   # Clean build artifacts
make help                    # Show available targets
```

## Configuration

Commitron looks for a configuration file at `~/.commitronrc`. This is a YAML file that allows you to customize how the tool works.

Example configuration:

```yaml
# AI provider configuration
ai:
  provider: openai           # openai, gemini, ollama, claude
  api_key: your-api-key-here  # Not needed for ollama
  model: gpt-3.5-turbo       # Model to use

# Commit message configuration
commit:
  convention: conventional   # conventional, none, custom
  include_body: true        # Generate bullet-point descriptions
  max_length: 72           # Maximum subject line length
  max_body_length: 500     # Maximum body length

# Context settings for AI analysis
context:
  include_file_names: true      # Include file names in analysis
  include_diff: true           # Include git diff in analysis
  max_context_length: 4000     # Maximum context to send to AI
  include_file_stats: false    # Include file statistics
  include_file_summaries: false # Include file type summaries

# UI settings
ui:
  enable_tui: true            # Enable text UI formatting
  confirm_commit: false       # Auto-commit without confirmation (recommended)
```

**Key Settings for Best Experience:**
- Set `include_body: true` for structured bullet-point commit messages
- Set `confirm_commit: false` for automatic commits without manual confirmation
- Use `conventional` convention for standardized commit formats

See [example.commitronrc](example.commitronrc) for a complete example with all available options.

## API Keys

To use Commitron, you'll need API keys for your chosen AI provider:

- OpenAI: <https://platform.openai.com/api-keys>
- Google Gemini: <https://aistudio.google.com/app/apikey>
- Anthropic Claude: <https://console.anthropic.com/keys>

For Ollama, you need to have it running locally. See [Ollama documentation](https://github.com/ollama/ollama) for more information.

## Key Improvements

This version of Commitron includes several enhancements for a better developer experience:

### 🔄 Automatic File Staging
- No need to manually run `git add` before committing
- Automatically detects and stages tracked modified files
- Ignores untracked files to prevent accidental commits
- Uses `git add -u` to stage only tracked files

### 📝 Enhanced Commit Messages
- Generates structured commit messages with bullet-point descriptions
- Follows conventional commit format by default
- AI generates direct commit messages without explanatory preamble
- Example format:
  ```
  fix: Resolve blocking issue in damage check worker
  
  - Increased prefetch_count from 1 to 10 to allow concurrent job processing
  - Made job processing non-blocking using asyncio.create_task()
  - Created dedicated process_damage_check_job() function for isolated job handling
  ```

### 🚀 Streamlined Workflow
- No user confirmation required - commits automatically
- Clean output with colored progress indicators
- Displays generated message before committing
- Supports dry-run mode for testing (`--dry-run`)

### 🛠️ Improved Build System
- Custom Makefile with Go path detection
- Support for non-standard Go installations
- Multiple build targets (current platform, all platforms)
- Easy development workflow

## License

See [LICENSE.txt](LICENSE.txt) for details.

### Built With

<!--
This section should list any major frameworks that you built your project using. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.

- [Bootstrap](https://getbootstrap.com)
- [JQuery](https://jquery.com)
- [Laravel](https://laravel.com)
-->

---

<!-- GETTING STARTED -->

## Getting Started

<!--
This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.
-->

### Prerequisites

<!--

This is an example of how to list things you need to use the software and how to install them.

- npm

```sh
npm install npm@latest -g
```
-->

### Installation

<!--
1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo

```sh
git clone https://github.com/your_username_/Project-Name.git
```

3. Install NPM packages

```sh
npm install
```

4. Enter your API in `config.js`

```JS
const API_KEY = 'ENTER YOUR API';
```
-->

---

<!-- USAGE EXAMPLES -->

## Usage

<!--
Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_
-->

---

<!-- ROADMAP -->

## Roadmap

See the [open issues](https://github.com/stiliajohny/commitron/issues) for a list of proposed features (and known issues).

---

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

<!-- LICENSE -->

## License

Distributed under the GPLv3 License. See `LICENSE` for more information.

<!-- CONTACT -->

## Contact

John Stilia - <stilia.johny@gmail.com>

<!--
Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)
-->

---

<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements

- [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
- [Img Shields](https://shields.io)
- [Choose an Open Source License](https://choosealicense.com)
- [GitHub Pages](https://pages.github.com)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/stiliajohny/commitron.svg?style=for-the-badge
[contributors-url]: https://github.com/stiliajohny/commitron/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/stiliajohny/commitron.svg?style=for-the-badge
[forks-url]: https://github.com/stiliajohny/commitron/network/members
[stars-shield]: https://img.shields.io/github/stars/stiliajohny/commitron.svg?style=for-the-badge
[stars-url]: https://github.com/stiliajohny/commitron/stargazers
[issues-shield]: https://img.shields.io/github/issues/stiliajohny/commitron.svg?style=for-the-badge
[issues-url]: https://github.com/stiliajohny/commitron/issues
[license-shield]: https://img.shields.io/github/license/stiliajohny/commitron?style=for-the-badge
[license-url]: https://github.com/stiliajohny/commitron/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/johnstilia/
[ask-me-anything]: https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg?style=for-the-badge
[personal-page]: https://github.com/stiliajohny
