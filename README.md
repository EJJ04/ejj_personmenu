# ejj_personmenu

**ejj_personmenu** is a FiveM resource that provides players with a personal menu to view their financial data, including cash, bank balance, black money, and society account details. This resource also supports various phone scripts to display the player's phone number.

## Features
- View cash, bank balance, black money, and society account information
- Support for multiple phone scripts, including:
  - `lb-phone`
  - `qs-smartphone-pro`
  - `qs-smartphone`
  - `gksphone`
- Customizable notification settings

## Installation

1. **Download the Resource**:
   Clone or download the repository to your `resources` directory.

   ```bash
   git clone https://github.com/EJJ04/ejj_personmenu
Add to server.cfg: Ensure the following resources are started by adding them to your server.cfg in this order:

```
start ox_lib
start ejj_personmenu
```

## Locale Files 

Update or add locale files for your desired languages in the locales directory (e.g., en.json, da.json).

## Configuration

You can customize the menu options and notification settings by editing the Config table in the resource. The default configuration is set as follows:

```
Config = {}

Config.MenuOptions = {
    cash = {
        title = 'Kontanter',
        icon = 'fa-solid fa-money-bill',
    },
    bank = {
        title = 'Bank',
        icon = 'fa-solid fa-building',
        readOnly = true,
    },
    black_money = {
        title = 'Sort Penge',
        icon = 'fa-solid fa-sack-dollar',
        readOnly = true,
    },
    societyAccount = {
        title = 'Firmakonto',
        icon = 'fa-solid fa-briefcase',
        bossOnly = true,
    }
}


Config.NotifySettings = {
    position = 'top' -- 'top', 'top-right', 'top-left', 'bottom', 'bottom-right', 'bottom-left', 'center-right', or 'center-left'
}
```

## Usage
Once installed and configured, players can access their personal menu through a designated input key or context menu option. The menu will display their financial information based on the data fetched from the database.

## Support

If you encounter any issues or have suggestions for improvements, feel free to open an issue on the GitHub repository or join my Discord server - https://discord.gg/N869PRHGfd

Feel free to copy this block directly! Let me know if you need anything else.
