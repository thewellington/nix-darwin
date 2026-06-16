# nix-darwin configuration

Flake-based [nix-darwin](https://github.com/nix-darwin/nix-darwin) setup for this Mac, with [Home Manager](https://github.com/nix-community/home-manager) and [nix-homebrew](https://github.com/zhaofengli-wip/nix-homebrew) integrated into a single configuration named `doctor-teeth`.

## Layout

| Path | Purpose |
|------|---------|
| `flake.nix` | Flake inputs and `darwinConfigurations.doctor-teeth` |
| `nix-modules/` | System modules (packages, Homebrew, fonts, macOS defaults) |
| `home-manager/home.nix` | User dotfiles and programs |
| `shell.nix` | Optional dev shell (`nix-shell`) for tooling such as `mcp-nixos` |

Home Manager is wired in through nix-darwin, so you do **not** run `home-manager switch` separately.

## Apply configuration changes

After editing any `.nix` file in this repo:

```bash
sudo darwin-rebuild switch --flake ~/.config/nix-darwin#doctor-teeth
```

Other useful commands:

```bash
# Build without activating (check for errors)
darwin-rebuild build --flake ~/.config/nix-darwin#doctor-teeth

# See what would change
darwin-rebuild switch --flake ~/.config/nix-darwin#doctor-teeth --show-trace
```

`darwin-rebuild` must already be on your PATH (installed when nix-darwin was first set up on this machine).

## Update flake inputs

Flake inputs are pinned in `flake.lock`. To refresh them:

```bash
cd ~/.config/nix-darwin

# Update everything
nix flake update

# Or update specific inputs only
nix flake update nixpkgs
nix flake update nix-darwin
nix flake update home-manager
nix flake update nix-homebrew
```

Then apply the new lock file:

```bash
sudo darwin-rebuild switch --flake ~/.config/nix-darwin#doctor-teeth
```

Current input pins (see `flake.nix`):

- **nixpkgs** — `nixpkgs-unstable`
- **nix-darwin** — `master`
- **home-manager** — `release-25.11` (must stay aligned with `home.stateVersion` in `home-manager/home.nix`)
- **nix-homebrew** — default branch, with Homebrew core pinned to `5.1.11`

When bumping Home Manager to a new release, update both the flake input **and** `home.stateVersion` in `home-manager/home.nix` after reading the [Home Manager release notes](https://github.com/nix-community/home-manager/releases).

## What gets updated when

| Change | What to do |
|--------|------------|
| Nix packages, dotfiles, macOS settings | Edit the relevant `.nix` files, then `darwin-rebuild switch` |
| Flake dependencies (nixpkgs, nix-darwin, etc.) | `nix flake update`, then `darwin-rebuild switch` |
| Homebrew formulae/casks in `nix-modules/homebrew.nix` | Edit the module, then `darwin-rebuild switch` (activation runs `brew upgrade` and auto-update) |
| Ad-hoc Homebrew installs | Prefer adding them to `homebrew.nix` so they are managed declaratively |

## Optional dev shell

```bash
cd ~/.config/nix-darwin
nix-shell
```

## Troubleshooting

- **Build errors after `nix flake update`** — Try updating one input at a time, or roll back with `git checkout flake.lock` and rebuild.
- **Home Manager option removed/renamed** — Check release notes; you may need to adjust `home-manager/home.nix`.
- **nix-darwin breaking changes** — Run `darwin-rebuild changelog` for migration notes related to `system.stateVersion`.



nix-collect-garbage -d
sudo nix-collect-garbage --delete-older-than 5d
