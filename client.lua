lib.locale()

local Framework = nil
if GetResourceState('es_extended') == 'started' then
    Framework = exports['es_extended']:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    Framework = exports['qb-core']:GetCoreObject()
end

if not Framework then
    print(locale('framework_not_detected'))
    return
end

local PlayerData = Framework.PlayerData

lib.addRadialItem({
    {
        id = 'ejj_personmenu1',
        label = locale('personmenu_label'), 
        icon = 'circle-info',
        onSelect = function()

            local data = lib.callback.await('ejj_personmenu:getMoneyData', false)
            
            if data then
                local options = {
                    {
                        title = locale('cash_title') .. ': ' .. locale('currency_symbol') .. data.cash, 
                        icon = Config.MenuOptions.cash.icon,
                    },
                    {
                        title = locale('bank_title') .. ': ' .. locale('currency_symbol') .. data.bank, 
                        icon = Config.MenuOptions.bank.icon,
                        readOnly = Config.MenuOptions.bank.readOnly,
                    },
                    {
                        title = locale('black_money_title') .. ': ' .. locale('currency_symbol') .. data.black_money, 
                        icon = Config.MenuOptions.black_money.icon,
                        readOnly = Config.MenuOptions.black_money.readOnly,
                    }
                }

                if (GetResourceState('es_extended') == 'started' and PlayerData.job.grade_name == 'boss') or 
                   (GetResourceState('qb-core') == 'started' and PlayerData.job.isboss) then
                    table.insert(options, {
                        title = locale('society_account_title') .. ': ' .. locale('currency_symbol') .. data.societyAccountMoney,
                        icon = Config.MenuOptions.societyAccount.icon,
                        onSelect = function()
                            lib.notify({
                                title = locale('society_account_title'),
                                description = locale('society_access', data.societyAccountMoney),
                                type = 'info',
                                position = Config.NotifySettings.position
                            })
                        end
                    })
                end

                lib.registerContext({
                    id = 'ejj_personmenu:context1',
                    title = data.name, 
                    options = options
                })

                lib.showContext('ejj_personmenu:context1')
            else
                lib.notify({
                    title = locale('error_title'), 
                    description = locale('error_description'), 
                    type = 'error',
                    position = Config.NotifySettings.position
                })
            end
        end
    },
})