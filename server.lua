local CachedCoords = {}

local GetLicense = function(playerId)
	if playerId == nil then error('playerId is nil') end
	local license

	for _,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v:gsub("license:", "")
        end
	end

    return license
end

CreateThread(function()
    while true do
        for _, player in pairs(GetPlayers()) do
            CachedCoords[player] = GetEntityCoords(GetPlayerPed(player))
        end
        Wait(100)
    end
end)

AddEventHandler('playerDropped', function(source, reason)
    if not reason:find('Game crashed') and not reason:find('a cessé de fonctionner') and not reason:find('has stopped working') and not reason:find('ha dejado de funcionar') then
        return
    end

    if GetConvar('crashlogger_log', 'false') ~= 'false' then
        print('[CRASHLOGGER] ' .. GetPlayerName(source) .. ' (' .. GetLicense(source) .. ') crashed: ' .. reason)
    end

    if GetResourceState('mysql-async') == 'started' then
        MySQL.Async.execute('INSERT INTO crashes (`license`, `name`, `message`, `position`) VALUES (@license, @name, @message, @position);', {
            ['@license'] = GetLicense(source),
            ['@name'] = GetPlayerName(source),
            ['@message'] = reason,
            ['@position'] = json.encode(CachedCoords[source] or {}),
        }, function() end)
    elseif GetResourceState('oxmysql') == 'started' then
        MySQL.insert('INSERT INTO crashes (`license`, `name`, `message`, `position`) VALUES (?, ?, ?, ?);', {GetLicense(source), GetPlayerName(source), reason, json.encode(CachedCoords[source] or {})}, function() end)
    else
        print('[CRASHLOGGER] MySQL resource not found, skipping crash logging.')
    end

    CachedCoords[source] = nil
end)

RegisterCommand('displaycrashes', function(source, args, rawCommand)
    if GetResourceState('mysql-async') == 'started' then
        MySQL.Async.fetchAll('SELECT * FROM crashes', {}, function(results)
            TriggerClientEvent('eki_crashlogger:displayCrashes', source, results)
        end)
    elseif GetResourceState('oxmysql') == 'started' then
        MySQL.query('SELECT * from crashes', {}, function(results)
            TriggerClientEvent('eki_crashlogger:displayCrashes', source, results)
        end)
    else
        print('[CRASHLOGGER] MySQL resource not found, skipping crash display.')
    end
end, true)

RegisterCommand('hidecrashes', function(source, args, rawCommand)
    TriggerClientEvent('eki_crashlogger:hideCrashes', source)
end, true)
