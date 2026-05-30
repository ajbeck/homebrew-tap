# ajbeck's Homebrew Tap

Homebrew tap for shipping tools.

## How do I install these formulae?

```bash
brew install ajbeck/tap/<formula>
```

Or `brew tap ajbeck/tap` and then `brew install <formula>`.

Or, in a `brew bundle` Brewfile:

```ruby
tap "ajbeck/tap"
brew "<formula>"
```

## Available Packages

- **md2adf** - CLI tool to convert Markdown to Atlassian Document Format (ADF)
- **scut** - CLI toolkit for LLM agents, Claude Code hooks, status lines, and formatting

## Updating Formulae

The `update formula` workflow can update configured formulae from a released version:

```bash
gh workflow run "update formula" -f formula=scut -f version=v0.3.0
```

Release workflows in upstream repos can trigger the same workflow with a `repository_dispatch` event of type `update-formula` and a payload like:

```json
{ "formula": "scut", "version": "v0.3.0" }
```

Configure `TAP_UPDATE_TOKEN` if PR branches created by the workflow should trigger normal pull request CI. Without it, the workflow falls back to `GITHUB_TOKEN`.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
