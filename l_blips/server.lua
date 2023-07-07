RegisterServerEvent('lorgen:GetBlips')
AddEventHandler('lorgen:GetBlips', function()
    local _source = source
    local configFile = LoadResourceFile(GetCurrentResourceName(), 'config.json')
    local Blips = json.decode(configFile)
    local data = {}
    
    for _, blip in ipairs(Blips.Blips) do
        local newBlip = {
            x = blip.x,
            y = blip.y,
            z = blip.z,
            nazwa = blip.nazwa,
            typ = blip.typ,
            kolor = blip.kolor,
            skala = blip.skala
        }
        table.insert(data, newBlip)
    end
    
    TriggerClientEvent('lorgen:SendBlips', _source, data)
end)

RegisterCommand('bliprefresh', function(source, args, error)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'best' then
        TriggerClientEvent('lorgen:RefreshBlips', -1)
        xPlayer.showNotification('Odświeżono zmiany')
    else
        xPlayer.showNotification('Nie możesz użyć tej komendy')
    end
end)

RegisterCommand('addblip', function(source, args, error)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'best' then
        TriggerClientEvent('lorgen:menu', _source)
    else
        xPlayer.showNotification('Nie możesz użyć tej komendy')
    end
end)

RegisterServerEvent('lorgen:SaveBlip')
AddEventHandler('lorgen:SaveBlip', function(blip)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'best' then

    local Blips = {}

    local resourcePath = GetResourcePath(GetCurrentResourceName())
    local configFile = LoadResourceFile(GetCurrentResourceName(), 'config.json')

    if configFile then
        Blips = json.decode(configFile)
    end

    table.insert(Blips.Blips, blip)
    local jsonBlips = json.encode(Blips, { indent = true })

    local success = SaveResourceFile(GetCurrentResourceName(), 'config.json', jsonBlips, -1)

    if success then
        print('Zapisano Blipa: ' .. blip.nazwa)
    else
        print('Nie udało się zapisać Blipa: ' .. blip.nazwa)
    end


    else
        xPlayer.showNotification('Nie możesz użyć tej komendy')
        return 
    end

end)