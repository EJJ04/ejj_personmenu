lib.locale()

local Framework = nil
if GetResourceState('es_extended') == 'started' then
    Framework = exports['es_extended']:getSharedObject()
elseif GetResourceState('qb-core') == 'started' then
    Framework = exports['qb-core']:GetCoreObject()
end

if not Framework then
    print('No framework detected (es_extended or qb-core). Please make sure one is running.')
    return
end

lib.callback.register('ejj_personmenu:getMoneyData', function(source)
    local xPlayer = nil
    local cash, bank, black_money, societyAccountMoney = 0, 0, 0, 0
    local playerName = ""

    if GetResourceState('es_extended') == 'started' then
        xPlayer = Framework.GetPlayerFromId(source)
        if xPlayer then
            cash = xPlayer.getAccount('money').money
            bank = xPlayer.getAccount('bank').money
            black_money = xPlayer.getAccount('black_money').money
            local identifier = xPlayer.getIdentifier()

            local userData = MySQL.query.await('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
                ['@identifier'] = identifier
            })

            if userData and #userData > 0 then
                playerName = userData[1].firstname .. ' ' .. userData[1].lastname
            end
        else
            print('xPlayer is nil for es_extended framework')
        end
    elseif GetResourceState('qb-core') == 'started' then
        xPlayer = Framework.Functions.GetPlayer(source)
        if xPlayer then
            cash = xPlayer.Functions.GetMoney('cash')
            bank = xPlayer.Functions.GetMoney('bank')
            black_money = xPlayer.Functions.GetMoney('black_money') or 0
            
            societyAccountMoney = exports['qb-banking']:GetAccountBalance(xPlayer.PlayerData.job.name) or 0
            
            playerName = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
        else
            print('xPlayer is nil for qb-core framework')
        end
    end

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
    end
    
    local formattedPhoneNumber = (phoneNumber ~= locale('missing_phone_number')) and 
        phoneNumber:sub(1, 2) .. ' ' .. phoneNumber:sub(3, 4) .. ' ' .. phoneNumber:sub(5, 6) .. ' ' .. phoneNumber:sub(7, 8) or phoneNumber
    
    local data = {
        cash = cash,
        bank = bank,
        black_money = black_money,
        societyAccountMoney = societyAccountMoney,
        name = formattedPhoneNumber .. ' | ' .. playerName
    }
    
    return data 
end)