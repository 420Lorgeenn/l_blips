local Blipyx

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerLoaded = true

  Wait(1000)
  TriggerServerEvent('lorgen:GetBlips')
end)

RegisterNetEvent('lorgen:SendBlips')
AddEventHandler('lorgen:SendBlips', function(blips)
    CreateBlipsFromTable(blips)
    Blipyx = blips
end)

function CreateBlipsFromTable(blips)
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.typ)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, info.skala)
        SetBlipColour(info.blip, info.kolor)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.nazwa)
        EndTextCommandSetBlipName(info.blip)
        Citizen.Wait(1)
    end
end

function RemoveBlips(blips)
    for _, info in pairs(blips) do
        RemoveBlip(info.blip)
        Citizen.Wait(1)
    end
end

RegisterNetEvent('lorgen:RefreshBlips')
AddEventHandler('lorgen:RefreshBlips', function()

    RemoveBlips(Blipyx)
    TriggerServerEvent('lorgen:GetBlips')

end)

RegisterNetEvent('lorgen:menu')
AddEventHandler('lorgen:menu', function()

    local input = lib.inputDialog('Tworzenie Blipa - INFO: docs.fivem.net/docs/game-references/blips/', {
        {type = 'input', label = 'Nazwa', description = 'Ustaw nazwe blipa!', required = true, min = 1, max = 50},
        {type = 'input', label = 'Typ', description = 'Ustaw typ blipa!', required = true, min = 0, max = 1000},
        {type = 'input', label = 'Kolor', description = 'Ustaw Kolor blipa!', required = true, min = 0, max = 100},
        {type = 'input', label = 'Skala', description = 'Zalecana skala: 0.8 (Nie wpisywać 1/2 tylko 0.9/0.5)', required = true, min = 0, max = 100},
      })


    if input == nil then
        return 
    end


    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)

    local newBlip = {
        x = playerCoords.x,
        y = playerCoords.y,
        z = playerCoords.z,
        nazwa = input[1],
        typ = tonumber(input[2]),
        kolor = tonumber(input[3]),
        skala = tonumber(input[4])
    }

    TriggerServerEvent('lorgen:SaveBlip', newBlip)

    ESX.ShowNotification('Pomyślnie zapisano blipa o nazwie '..input[1])

end)

TriggerEvent('chat:addSuggestion', '/addblip', 'Stwórz blip', {
    { name="Stwórz blip" }
})

TriggerEvent('chat:addSuggestion', '/bliprefresh', 'Odśwież blipy', {
    { name="Odśwież blipy" }
})