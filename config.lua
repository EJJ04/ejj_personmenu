Config = {}

Config.Framework = 'ESX' -- Choose between ESX & QBCore

Config.BossActionMenu = 'ESX' -- Choose between 'ESX', 'QBCore' or 'Custom'

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
            TriggerEvent('esx_society:openBossMenu', data.job, function(menuData, menu)
            end)
        elseif Config.BossActionMenu == 'QBCore' then
            TriggerEvent('qb-bossmenu:client:openMenu')
        elseif Config.BossActionMenu == 'Custom' then
            exports['lunar_multijob']:openBossMenu()
        end
    end
}

Config.NotifySettings = {
    position = 'top' -- 'top' or 'top-right' or 'top-left' or 'bottom' or 'bottom-right' or 'bottom-left' or 'center-right' or 'center-left'
}