# Personal Menu Script

This script provides a personal menu for players in a FiveM server, supporting both ESX and QBCore frameworks. The menu displays personal information, financial data, and job details, allowing bosses to access society accounts.

## Features

- Framework support for ESX and QBCore.
- Displays player's personal information, bank balance, cash, and job details.
- Bosses can access society accounts.
- Configurable notifications and menu options.

## Client-Side Overview

1. **Framework Detection**: The script detects whether to use ESX or QBCore.
2. **Job Update Handling**: Listens for job updates and sets player job data accordingly.
3. **Menu Registration**: Uses `lib.addRadialItem` to create a personal menu option, which retrieves and displays player data.

### Functions

- `isBoss()`: Checks if the player is a boss.
- `formatNumber(amount)`: Formats numbers with thousands separators.
- `formatCurrency(amount)`: Formats currency based on locale settings.

### Usage

- The personal menu can be accessed via the radial menu and displays:
  - Personal Info (Name, Date of Birth, Phone Number)
  - Economy Overview (Bank, Cash, Black Money)
  - Job Details (Position, Grade)
  - Society Account (if the player is a boss)

## Server-Side Overview

1. **Framework Detection**: Similar to the client-side, it detects the framework in use.
2. **Data Retrieval**: The server listens for callbacks to provide player data, including cash, bank balance, job details, and phone number.
3. **Database Queries**: Retrieves relevant data from the database, such as user information and society account balances.

### Callbacks

- `ejj_personmenu:getMoneyData`: Returns player data to the client when requested.

## Configuration

The configuration file allows customization of the script's behavior.

```lua
Config = {}

Config.Framework = 'ESX' -- Choose between 'ESX' & 'QBCore'

Config.BossActionMenu = 'ESX' -- Choose between 'ESX', 'QBCore', or 'Custom'

Config.MenuOptions = {
    personal_info = { 
        icon = 'user',  
        readOnly = true,
    },
    economy = {
        icon = 'briefcase',  
        readOnly = true,
    },
    societyAccount = {
        icon = 'briefcase', 
    },
    job = {
        icon = 'user-tie', 
        readOnly = true,
    }
}

Config.BossActions = {
    onSelect = function(data)
        if Config.BossActionMenu == 'ESX' then
            TriggerEvent('esx_society:openBossMenu', data.job)
        elseif Config.BossActionMenu == 'QBCore' then
            TriggerEvent('qb-bossmenu:client:openMenu')
        elseif Config.BossActionMenu == 'Custom' then
            exports['lunar_multijob']:openBossMenu()
        end
    end
}

Config.NotifySettings = {
    position = 'top' -- Notification position: 'top', 'top-right', 'top-left', 'bottom', 'bottom-right', 'bottom-left', 'center-right', 'center-left'
}
```

## Installation
Download the script and place it in your server's resources folder.
Ensure your server is set up for either ESX or QBCore.
Add the necessary dependency references in your server.cfg.

## License
This script is open-source and can be modified as per your server's requirements.


This `README.md` provides a comprehensive overview of your script, covering its features, client and server logic, configuration, and installation steps. Let me know if you need any changes or additional sections!
