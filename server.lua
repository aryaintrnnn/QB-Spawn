local QBCore = exports['qb-core']:GetCoreObject()
local Players = {}

QBCore.Functions.CreateCallback('qb-spawn:server:getOwnedHouses', function(source, cb, cid)
    local enableLast = false
    if cid ~= nil then
        if Players[cid] ~= nil then enableLast = true end
        
        local houses = exports.oxmysql:executeSync('SELECT * FROM player_houses WHERE citizenid = ?', {cid})
        if houses[1] ~= nil then
            cb(houses, enableLast)
        else
            cb(nil, enableLast)
        end
    else
        cb(nil, enableLast)
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        Players[Player.PlayerData.citizenid] = true
    end
end)
