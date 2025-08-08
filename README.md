# gamescope-manager

A very quickly put-together python script to help manage multiple gamescope configurations and select one before launching a game via Steam.

### Installation

1. Move `gamescope-manager` to somewhere in your `$PATH`
2. Run `cp -r .config/gamescope-manager ~/.config/gamescope-manager` to copy the config file into your home folder
3. Done!


### Usage

Edit `~/.config/gamescope-manager/config.json` to add, remove, or change your list of available configurations. I have included an example config for your reference.

All config names need to be unique to each other. You can use `tags` to create game-specific config lists.

#### To add gamescope-manager to your Steam game's launch:
1. Right click the game in Steam
2. Click "Properties"
3. In the Launch Options box, enter:
  1. `$(gamescope-manager) %command%` to list all configurations without tags (default behaviour)
  2. `$(gamescope-manager -t bitcraft) %command%` to list all configurations with the tag `bitcraft` (based on example config provided)
  3. `$(gamescope-manager -t bitcraft -i) %command%` to list all configurations with the tag `bitcraft` AND all configurations without tags
  4. `$(gamescope-manager -t bitcraft othertag yet_another_tag) %command%` to match multiple tags. This means if a configurations has any of the tags specified, it'll be presented before game launch.
