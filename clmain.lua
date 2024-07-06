ESX = exports["es_extended"]:getSharedObject()
local isDead = false
IsPlayerPlaying = false

RegisterNetEvent('radiantm:joinOnlyP')
AddEventHandler('radiantm:joinOnlyP', function()
    local playerPed = PlayerPedId()
    isPlayerPlaying = true

    local teleportLocation = Config.Teleports[math.random(#Config.Teleports)]
    TriggerServerEvent('radiant:setBucket', 11)
    SetEntityCoords(playerPed, teleportLocation.x, teleportLocation.y, teleportLocation.z, 0, 0, 0, true)
    exports.ox_inventory:weaponWheel(true)
    RemoveAllPedWeapons(playerPed)
    for _, weaponHash in ipairs(Config.Weapons) do
        GiveWeaponToPed(playerPed, weaponHash, 1000, false, true)
    end
end)

RegisterNetEvent('radiantm:leaveOnlyP')
AddEventHandler('radiantm:leaveOnlyP', function()
    local playerPed = PlayerPedId()
    IsPlayerPlaying = false

    exports.ox_inventory:weaponWheel(false)
    Citizen.Wait(400)
    exports['esx_ambulancejob']:respawn(Config.Spawnpoint, 0.0)
    TriggerEvent('esx_ambulancejob:revive')
    Citizen.Wait(500)
    SetEntityCoords(playerPed, Config.Spawnpoint.x, Config.Spawnpoint.y, Config.Spawnpoint.z, 0, 0, 0, true)  
    TriggerServerEvent('radiant:setBucket', 0)
end)

if Config.Commands then
    RegisterCommand(Config.CommandsN.join, function()
        local playerPed = PlayerPedId()
    
        if IsEntityDead(playerPed) then
            return
        end
    
        TriggerEvent('radiantm:joinOnlyP')
    end)
    
    RegisterCommand(Config.CommandsN.leave, function()
        local playerPed = PlayerPedId()
    
        if IsEntityDead(playerPed) or not IsPlayerPlaying then
            return
        end
    
        TriggerEvent('radiantm:leaveOnlyP')
    end)
end

AddEventHandler('esx:onPlayerDeath', function(data)
    IsDead = true
    local playerPed = PlayerPedId()

    if IsPlayerPlaying and IsDead then
        local teleportLocation = Config.Teleports[math.random(#Config.Teleports)]

        ClearPedBloodDamage(playerPed)
        exports['esx_ambulancejob']:respawn(teleportLocation, 0.0)
        
        SetEntityAlpha(playerPed, 55, false)
        Citizen.Wait(100)
        SetEntityAlpha(playerPed, 105, false)
        Citizen.Wait(400)
        SetEntityAlpha(playerPed, 255, false)

        for _, weaponHash in ipairs(Config.Weapons) do
            GiveWeaponToPed(playerPed, weaponHash, 1000, false, true)
        end

        IsDead = false
    end
end)

exports('isPlayerPlaying', function()
    return IsPlayerPlaying
end)