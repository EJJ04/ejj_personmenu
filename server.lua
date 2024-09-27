lib.locale()

if Config.Framework == 'ESX' then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
else
    print(locale('framework_not_detected'))
    return
end

lib.callback.register('ejj_personmenu:getMoneyData', function(source)
    local xPlayer = nil
    local data = {}

    local phoneNumber = locale('missing_phone_number') 
    if GetResourceState('lb-phone') == 'started' then
        phoneNumber = exports["lb-phone"]:GetEquippedPhoneNumber(source) or phoneNumber
    elseif GetResourceState('qs-smartphone-pro') == 'started' then
        local identifier = xPlayer.getIdentifier()
        phoneNumber = exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier, false) or phoneNumber
    elseif GetResourceState('qs-smartphone') == 'started' then
        phoneNumber = exports['qs-base']:GetPlayerPhone(source) or phoneNumber
    elseif GetResourceState('gksphone') == 'started' then
        phoneNumber = exports["gksphone"]:GetPhoneBySource(source) or phoneNumber
    elseif GetResourceState('qb-phone') == 'started' then
        local player = QBCore.Functions.GetPlayer(source)
        if player then
            phoneNumber = player.PlayerData.charinfo.phone or phoneNumber
        end
    end

    local formattedPhoneNumber
    if GetResourceState('qb-phone') ~= 'started' then
        formattedPhoneNumber = (phoneNumber ~= locale('missing_phone_number')) and 
            phoneNumber:sub(1, 2) .. ' ' .. phoneNumber:sub(3, 4) .. ' ' .. phoneNumber:sub(5, 6) .. ' ' .. phoneNumber:sub(7, 8) or phoneNumber
    end

    if Config.Framework == 'ESX' then
        xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            data.cash = exports.ox_inventory:GetItem(source, 'cash', nil, true) or 0
            data.black_money = exports.ox_inventory:GetItem(source, 'black_money', nil, true) or 0
            
            data.bank = xPlayer.getAccount('bank').money
            
            local societyData = MySQL.query.await('SELECT money FROM addon_account_data WHERE account_name = @account_name', {
                ['@account_name'] = 'society_' .. xPlayer.getJob().name
            })

            if societyData and #societyData > 0 then
                data.societyAccountMoney = societyData[1].money or 0 
            end

            local userData = MySQL.query.await('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.identifier
            })

            if userData and #userData > 0 then
                data.name = userData[1].firstname .. ' ' .. userData[1].lastname 
            else
                data.name = locale('name_not_recieved')
            end

            data.job = xPlayer.getJob().name
        else
            print('xPlayer is nil for ESX framework')
        end

    elseif Config.Framework == 'QBCore' then
        xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer then
            data.cash = exports.ox_inventory:GetItem(source, 'cash', nil, true) or 0
            data.black_money = exports.ox_inventory:GetItem(source, 'black_money', nil, true) or 0
            
            data.bank = xPlayer.Functions.GetMoney('bank')

            data.name = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname 
            data.societyAccountMoney = exports['qb-banking']:GetAccountBalance(xPlayer.PlayerData.job.name) or 0
            
            data.job = xPlayer.PlayerData.job
        else
            print('xPlayer is nil for QBCore framework')
        end
    end

    data.phoneNumber = (GetResourceState('qb-phone') == 'started') and phoneNumber or formattedPhoneNumber 
    return data
end)