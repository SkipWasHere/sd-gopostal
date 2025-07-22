# Skipsdev GoPostal Job for QBCore

discord - https://discord.gg/q444DTHYdb

A modern, feature-rich GoPostal job for FiveM QBCore servers. Includes teams, leaderboard, route optimization, customization, immersive delivery, and a beautiful NUI.

## Features
- Modern NUI with tabs for Job, Team, Leaderboard, and Customization
- Team system: create, invite, join, and leave teams
- Leaderboard: see top postal workers by deliveries and money earned
- Route optimization: view best delivery order
- Multiple depots and delivery locations
- Customizable van liveries and uniforms (configurable)
- Progress bar and immersive delivery actions
- Cooldown and anti-exploit logic
- Fully configurable via `config.lua`

## Installation
1. Download or clone this repository to your `resources` folder.
2. Add `ensure sd-gopostal` to your `server.cfg`.
3. Add GoPostal job and item to your QBCore shared files (see below).
4. Configure `config.lua` as needed.

### Job Setup
Add to your jobs config (e.g. `qb-core/shared/jobs.lua`):
```lua
gopostal = {
    label = 'GoPostal',
    type = 'gopostal',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        ['0'] = { name = 'Recruit', payment = 50 },
    },
},
```

### Item Setup
Add to your items config (e.g. `qb-core/shared/items.lua`):
```lua
gopostalpapers = { name = 'gopostal_papers', label = 'GoPostal Papers', weight = 1000, type = 'item', image = 'gopostal.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'This is the GoPostal Papers' },
```

### Cityhall Setup
Add to `Config.AvailableJobs` in `qb-cityhall`:
```lua
['gopostal'] = { ['label'] = 'GoPostal', ['isManaged'] = false }
```

### Inventory Setup
Add `gopostal.png` to `[qb]/qb-inventory/html/images`.

## Configuration
Edit `config.lua` to:
- Add/modify depots and delivery locations
- Set pay, bonuses, cooldown, uniforms, van liveries, and more

## Usage
- Go to a GoPostal depot and sign in
- Use `/gopostal` to open the UI (must be on duty)
- Create or join a team, view your route, check the leaderboard, and customize your experience
- Deliver all packages, return the van, and earn your bonus

## Customization
- Add new van liveries and uniforms in `config.lua`
- Add more depots and delivery points for variety
- Tweak pay, bonuses, and job flow to fit your server

## Credits
- Script by Skipsdev
- UI and feature upgrades by [YourNameHere]
- QBCore Framework: https://github.com/qbcore-framework

## Support
For help, join the Discord: [https://discord.gg/GB3QJRDSEx](https://discord.gg/TwfWs6wmMt)

---
Enjoy delivering with style!
