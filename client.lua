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

local function formatNumber(amount)
    local formatted = tostring(amount):reverse():gsub("(%d%d%d)", "%1."):reverse()
    if formatted:sub(1, 1) == '.' then
        formatted = formatted:sub(2)
    end
    return formatted
end

local function formatCurrency(amount)
    local localeSetting = GetConvar('ox:locale', 'en')
    
    if localeSetting == 'da' then
        return formatNumber(amount) .. ' ' .. locale('currency_symbol')
    else
        return locale('currency_symbol') .. formatNumber(amount)
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
                local phoneNumber = data.phoneNumber ~= '' and data.phoneNumber or locale('missing_phone_number')

                -- Extract birthday from data
                local birthday = ""
                if Config.Framework == 'ESX' then
                    birthday = data.dateofbirth -- Assuming birthday is retrieved from the database in server.lua
                elseif Config.Framework == 'QBCore' then
                    birthday = QBCore.Functions.GetPlayerData().charinfo.birthdate -- Assuming this is the correct way to access birthday
                end

                -- Format birthday by replacing / with -
                local formattedBirthday = ""
                if birthday and birthday ~= "" then
                    formattedBirthday = birthday:gsub('/', '-') -- Replace / with -
                end

                print(data.dateofbirth)

                local options = {
                    {
                        title = locale('personal_info_title'),
                        icon = Config.MenuOptions.personal_info.icon, 
                        description = data.name .. " (" .. formattedBirthday .. ")\n" .. locale('phone_number_label') .. phoneNumber,
                        readOnly = true,
                    },
                    {
                        title = locale('economy_title'),
                        icon = Config.MenuOptions.economy.icon, 
                        description = locale('bank_title') .. ': ' .. formatCurrency(data.bank) .. '\n' ..
                                      locale('cash_title') .. ': ' .. formatCurrency(data.cash) .. '\n' ..
                                      locale('black_money_title') .. ': ' .. formatCurrency(data.black_money),
                        readOnly = true,
                    },
                    {
                        title = locale('job_title'),
                        icon = Config.MenuOptions.job.icon, 
                        description = locale('work_at') .. ' ' .. (Config.Framework == 'ESX' and ESX.PlayerData.job.label or QBCore.Functions.GetPlayerData().job.label) .. '. \n' ..
                                      '(' .. (Config.Framework == 'ESX' and ESX.PlayerData.job.grade_label or QBCore.Functions.GetPlayerData().job.grade.name) .. ')',
                        readOnly = true,
                    }
                }                

                if isBoss() then
                    table.insert(options, {
                        title = locale('society_account_title') .. ': ' .. formatCurrency(data.societyAccountMoney),
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
                    title = locale('overview_title') .. ' ' .. data.name, 
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