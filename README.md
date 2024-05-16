# About
A speedrunning practice mod for Black Ops 4 using the Shield client - https://github.com/project-bo4/shield-development

# Installation
- Download the latest [release](https://github.com/Joshr520/BO4-Practice/releases/latest)  
- Find your Black Ops 4 installation directory. This can be done by clicking the gear icon on Battle.net and clicking **"Show in Explorer"**. For example, my directory is **"D:\Call of Duty Black Ops 4"**. Copy that location to use in the next step.  
- Find the zip you downloaded from the latest release. **Right click** &rarr; **Extract All...** &rarr; **Paste the Black Ops 4 directory into the text box** &rarr; **Hit Extract**  
### IT IS SAFE TO REPLACE ANY FILES THAT ALREADY EXIST
You should be all set and can launch the game from Battle.net now.

# Settings Guide
**All settings get refreshed on every level restart!**
## Server Settings Overview
- Located in **project-bo4/saved/server**. Game settings that get executed on the host. These settings dictate what happens for non-player specific events.  
- While server settings aren't player dependent, if the server settings aren't enabled, then no client settings will be loaded.
## Client Settings Overview
- Located in **project-bo4/saved/client**. Player settings that get executed on each client in the game. These settings dictate personal options for each player.  
- Client settings are loaded once the server settings have been successfully processed and all clients are ready in game.
## JSON Structure
The settings file use the JSON file type to store data. The following examples will go over how I'll be explaining the settings.  
### Data Types
- String: A string is just text that is enclosed in quotations.
- Number: Technically decimals are valid JSON, but they are not expected to be used for these settings. What you'd typically see is a whole number greater than or equal to 0.
- Boolean: A boolean is simply true or false. They are not surrounded by quotes.
- Object: An object in JSON is enclosed in {}. You won't have to make or edit any objects to use the settings.
- Array: An array is enclosed in []. The contents of an array can be any of the previous data types, but you won't be expected to create any array that contains more than one type. This is simply a list of data types separated by commas.
### It's important to note that the last value of an array or the last key-value pair of an object should NOT have a comma after it if it's the last piece of data

### Map Codenames
| Voyage of Despair |     IX    | Blood of the Dead | Classified | Dead of the Night | Ancient Evil | Alpha Omega | Tag der Toten |
|:-----------------:|:---------:|:-----------------:|:----------:|:-----------------:|:------------:|:-----------:|:-------------:|
|      zm_zodt8     | zm_towers |     zm_escape     |  zm_office |     zm_mansion    |    zm_red    |   zm_white  |   zm_orange   |

### Map Patches
**zm_zodt8**
  - free_kraken: Start the game on the poop deck, where the free kraken egg is. You will get notified every time you enter or leave the path for the free kraken.

**zm_escape**
  - chals: Start the game on round 12, right before challenges first start. Once you are able to move, you are expected to interact with the book to get your first code.
  - boss: Start the game in the boss fight.

**zm_mansion**
  - lockdown_1: Start the game at the greenhouse lockdown. Interact with the stone to start the lockdown.
  - lockdown_2: Start the game at the cemetery lockdown. Interact with the stone to start the lockdown.
  - lockdown_3: Start the game at the forest lockdown. Interact with the stone to start the lockdown.
  - lamps: Start the game at the greenhouse lockdown. Interacting with the stone will start the lockdown, and then instantly end it. From here you can practice getting your dig folly upgrade part or go straight to lamps to practice that.
  - boss: Start the game in the boss fight.

## Server Files
For the following description of the settings files, the key will be listed on the left with the possible options for the value on the right. A brief description of what the setting does is followed after the |.
### bo4_practice.json
The general settings file for enabling map specific settings  
- "enabled": <true | false>, | Used to enable/disable the practice patch.
- "map": "<map_name>", | Used to set which map the practice patch should apply to. See the [Map Codenames](#map-codenames) for a list of map codenames.
- "patch": "<patch_name>", | Enter the patch name for the map you want. Example patch names are in the json file and in the [Map Patches](#map-patches) section above.
- "timer": <true | false>, | Enables the gauntlet timer on the top right of the screen. Time starts when the hud appears and will sync to the appropriate starting point when doing practice patches.
- "zombie_counter": <true | false>, | Enables a zombie counter in the top right of the screen.
- "maps": [<map_list>], | Lists all the currently supported maps.
- "map_name_patches": [<patch_list>], | Lists the currently supported patches for the specified map.
- "settings": {  
      "zm_mansion": {  
          "pap": {  
              "ghosts": {  
                  "essex": <true | false>, | Enable/disable specified ghost.  
                  "shield": <true | false>, | Enable/disable specified ghost.  
                  "strife": <true | false>, | Enable/disable specified ghost.  
                  "scratches": <true | false>, | Enable/disable specified ghost.  
                  "doll": <true | false>, | Enable/disable specified ghost.  
                  "noose": <true | false>, | Enable/disable specified ghost.  
                  "will": <true | false> | Enable/disable specified ghost.  
              },  
              "clocks": {  
                  "billiards": <true | false>, | Enable/disable specified clock.  
                  "dining": <true | false>, | Enable/disable specified clock.  
                  "main": <true | false> | Enable/disable specified clock.  
              },  
              "vamp_lockdown": {  
                  "cemetary": <true | false>, | Enable/disable specified vamp lockdown.  
                  "greenhouse": <true | false> | Enable/disable specified vamp lockdown.  
              }  
          },  
          "ww_quest": {  
              "dig": {  
                  "close": <true | false>, | Enable/disable the specified dig location  
                  "mid": <true | false>, | Enable/disable the specified dig location  
                  "far": <true | false> | Enable/disable the specified dig location  
              }  
          },  
          "lockdowns": {  
              "scratches": {  
                  "dining": <true | false>, | Enable/disable the specified scratch symbol location  
                  "library": <true | false>, | Enable/disable the specified scratch symbol location  
                  "danu": <true | false>, | Enable/disable the specified scratch symbol location  
                  "master": <true | false>, | Enable/disable the specified scratch symbol location  
                  "cellar": <true | false>, | Enable/disable the specified scratch symbol location  
                  "main": <true | false>, | Enable/disable the specified scratch symbol location  
                  "billiards": <true | false> | Enable/disable the specified scratch symbol location  
              },  
              "ghosts": {  
                  "danu": <true | false>, | Enable/disable the specified wicker ghost location  
                  "cellar": <true | false>, | Enable/disable the specified wicker ghost location  
                  "master": <true | false> | Enable/disable the specified wicker ghost location  
              },  
              "enemy_markers": <true | false> | Enable/disable waypoints that follow enemies required to die for lockdowns to progress  
          },  
          "boss_health_scaling": <0 | 1 | 2 | 3 | 4> | Override the boss health to scale with the specified player count. 0 means it acts as normal.  
      }  
  }

### box_settings.json
Weapon codenames are listen in the json. There are too many to neatly list here.  
- "enabled": <true | false>, | Used to enable/disable the box patch. Will not be enabled if the practice patch overall is disabled.  
- "settings": {  
      "weapon_order": [  
          "<weapon_name_1>", "<weapon_name_2>", "<...>", | List of weapons, in order, that the box will choose. No weapons repeat.  
      ],  
      "player_overrides": { | Player specific overrides for the box where the weapons listed below are given to that player instead of the weapons list above. If no weapons are listed, the weapons are still chosen from the list above.  
          "player_[1-4]": { | Player slots 1-4 as shown in the pregame lobby. 1 is the far left character and 4 is the far right character.  
              "player_name": "<player_name>", | You can enter a player name to identify the player by instead of relying on the character slot. This is just the players in game name, and caps do not matter. Conflicts may occur if multiple people have the same name.  
              "weapon_order": [  
                  "<weapon_name_1>", "<weapon_name_2>", "<...>" | List of weapons, in order, that the box will choose. No weapons repeat.  
              ]  
          }  
      }  
  }  
- "common_weapons": | Lists the names of the weapons on every map.
- "equipment": | Lists equipment for all maps. You are expected to know which equipment are on which map.
- "map_name_weapons": | Lists the name of all weapons specific to the specified map
