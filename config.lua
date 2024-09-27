Config = {}

Config.Framework = 'ESX' -- Choose between ESX & QBCore

Config.BossActionMenu = 'ESX' -- Choose between 'ESX', 'QBCore' or 'Custom'

Config.MenuOptions = {
    cash = { 
        icon = 'fa-solid fa-money-bill',
        readOnly = true,
    },
    bank = {
        icon = 'fa-solid fa-building',
        readOnly = true,
    },
    black_money = {
        icon = 'fa-solid fa-sack-dollar',
        readOnly = true,
    },
    societyAccount = {
        icon = 'fa-solid fa-briefcase',
    },
    job = {
        icon = 'fa-solid fa-user-tie', 
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