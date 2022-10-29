local blips = {}

RegisterNetEvent('eki_crashlogger:displayCrashes', function(results)
    for _, blip in pairs(blips) do
        RemoveBlip(blip)
    end
    blips = {}

    for i, crash in pairs(results) do
        crash.position = json.decode(crash.position)
        crash.position = vector3(crash.position.x, crash.position.y, crash.position.z)
    end

    for i, crash in pairs(results) do
        local blip = AddBlipForCoord(crash.position)
        SetBlipSprite(blip, 431)
        SetBlipColour(blip, 1)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Crash')
        EndTextCommandSetBlipName(blip)

        blips[i] = crash
    end
end)

RegisterNetEvent('eki_crashlogger:hideCrashes', function()
    for _, blip in pairs(blips) do
        RemoveBlip(blip)
    end
    blips = {}
end)
