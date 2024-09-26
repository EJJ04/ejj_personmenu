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
    position = 'top' -- 'top' or 'top-right' or 'top-left' or 'bottom' or 'bottom-right' or 'bottom-left' or 'center-right' or 'center-left'
}