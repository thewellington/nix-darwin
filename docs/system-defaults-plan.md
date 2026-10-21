# nix-darwin system defaults plan

Ideas from the “what else can I configure?” pass. Already applied items are checked.

## Done

- [x] `dock.mru-spaces = false` — Spaces don’t rearrange by recent use
- [x] `NSGlobalDomain.KeyRepeat` / `InitialKeyRepeat` — faster key repeat
- [x] `NSGlobalDomain.ApplePressAndHoldEnabled = false` — hold repeats keys (no accent popup)
- [x] `NSGlobalDomain.AppleInterfaceStyle = "Dark"`
- [x] `finder.FXRemoveOldTrashItems = false` — Hazel manages Trash
- [x] `finder.FXPreferredViewStyle = "Nlsv"` — list view
- [x] `finder.AppleShowAllExtensions = false` — hide extensions
- [x] `dock.autohide-delay = 0.2` — stock default (was unset)
- [x] `dock.autohide-time-modifier = 0.5` — stock default (was unset)
- [x] `dock.minimize-to-application = true`
- [x] Expanded save/print panels (`NSNavPanelExpandedStateForSaveMode` / `PMPrintingExpandedStateForPrint` + `…2`)
- [x] `dock.scroll-to-open = true` — scroll Dock icon for App Exposé / stacks

## Everyday UX

- [ ] **Caps Lock remap** — `system.keyboard.enableKeyMapping` + `remapCapsLockToEscape` (or Control)
- [ ] **Hot corners** — `dock.wvous-tl-corner` / `tr` / `bl` / `br` (+ modifier options if needed)
  - Common: Mission Control, Desktop, Lock Screen, Launchpad, Sleep Display
- [ ] **Screenshots**
  - `screencapture.location` — dedicated folder (e.g. `~/Screenshots`)
  - `screencapture.type` — e.g. `png` / `jpg`
  - `screencapture.disable-shadow`
  - `screencapture.show-thumbnail`
- [ ] **Finder polish**
  - `finder._FXSortFoldersFirst = true`
  - `finder.FXDefaultSearchScope = "SCcf"` — search current folder
- [ ] **Disable “helpful” typing**
  - `NSAutomaticCapitalizationEnabled = false`
  - `NSAutomaticDashSubstitutionEnabled = false`
  - `NSAutomaticPeriodSubstitutionEnabled = false`
  - `NSAutomaticQuoteSubstitutionEnabled = false`
  - `NSAutomaticSpellingCorrectionEnabled = false`
  - `NSAutomaticInlinePredictionEnabled = false` — optional

## Appearance & windows

- [ ] **Window tiling (Sequoia+)** — `WindowManager.EnableTilingByEdgeDrag`, `EnableTiledWindowMargins`, `EnableTilingOptionAccelerator`, `EnableTopTilingByEdgeDrag`
- [ ] **Don’t default-save to iCloud** — `NSDocumentSaveNewDocumentsToCloud = false`

## Control Center / menu bar

Already: `controlcenter.BatteryShowPercentage`.

- [ ] `controlcenter.Bluetooth`
- [ ] `controlcenter.Sound`
- [ ] `controlcenter.AirDrop`
- [ ] `controlcenter.FocusModes`
- [ ] `controlcenter.NowPlaying`
- [ ] `controlcenter.Display`

(Check nix-darwin docs for each value: often show-in-menu-bar vs Control Center only.)

## Escape hatch

- [ ] Keep using `CustomUserPreferences` for prefs nix-darwin doesn’t model
  - Workflow: change something by hand → `defaults read com.apple.…` → lock it into config
  - Candidates already commented in `system-defaults.nix` (Finder glass/sidebar radius, etc.)

## Outside `system.defaults`

- [x] **`homebrew.masApps`** — App Store apps pinned (excludes brew casks / Nix packages)
- [ ] **`launchd.user.agents`** — login/background jobs you’d otherwise set in Login Items
- [ ] **Home Manager** — more app/dotfile config still edited by hand (`xdg.configFile`, editors, shell)

## Suggested next batches

1. **Finder + screenshots** — high visibility, low risk  
2. **Typing / Caps Lock** — daily feel  
3. **Dock minimize-to-app + hot corners** — workflow  
4. **Control Center tiles + tiling / save panels** — polish  

Tick items here as they land in `nix-modules/system-defaults.nix` (or related modules).
