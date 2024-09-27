lib.locale()

if Config.Framework == 'ESX' then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
else
    print(locale('framework_not_detected'))
    return
end

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

local function isBoss()
    if Config.Framework == 'ESX' then
        return ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss'
    elseif Config.Framework == 'QBCore' then
        local job = QBCore.Functions.GetPlayerData().job
        return job and job.isboss
    end
end

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
                        readOnly = Config.MenuOptions.cash.readOnly,
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
                    },
                    {
                        title = locale('job_title') .. ': ' .. (Config.Framework == 'ESX' and ESX.PlayerData.job.label or QBCore.Functions.GetPlayerData().job.label),
                        description = locale('job_position') .. ': ' .. (Config.Framework == 'ESX' and ESX.PlayerData.job.grade_label or QBCore.Functions.GetPlayerData().job.grade.name),
                        icon = Config.MenuOptions.job.icon,
                        readOnly = Config.MenuOptions.job.readOnly,
                    }
                }

                if isBoss() then
                    table.insert(options, {
                        title = locale('society_account_title') .. ': ' .. locale('currency_symbol') .. data.societyAccountMoney,
                        description = locale('society_account_description'), 
                        icon = Config.MenuOptions.societyAccount.icon,
                        onSelect = function()
                            if Config.BossActions.onSelect then
                                Config.BossActions.onSelect(data)
                            end
                        end
                    })
                end

                lib.registerContext({
                    id = 'ejj_personmenu:context1',
                    title = data.phoneNumber .. ' | ' .. data.name,
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