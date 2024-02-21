local QBCore = exports['qb-core']:GetCoreObject()

-- LOCALS
local onDuty = false
local startJob
local isDeliverySignedIn = false
local PackageObject = nil
local truck

CreateThread(function()
    local sleep = 0
    local lastToggleTime = 0
    while true do
        local playerPed = PlayerPedId()
        local dist = #(Config.PostalLocations.start.coords - GetEntityCoords(playerPed))
        if dist < 30.0 then
            sleep = 0
            if not onDuty then  
            end
            if dist < 2.0 then
                if GetGameTimer() - lastToggleTime > 10000 then 
                    onDuty = not onDuty
                    lastToggleTime = GetGameTimer()
                    if onDuty then
                        SpawnTruck()
                    else
                        if truck then
                            DeleteEntity(truck)
                        end
                    end
                end
            end
        else    
            sleep = 1000
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    local pedModel = GetHashKey(Config.PostalLocations.start.pedModel)
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(1)
    end
    local ped = CreatePed(4, pedModel, Config.PostalLocations.start.pedCoords.x, Config.PostalLocations.start.pedCoords.y,Config.PostalLocations.start.pedCoords.z, Config.PostalLocations.start.pedCoords.w, false, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetEntityHeading(ped, Config.PostalLocations.start.pedCoords.w)
    SetPedCanPlayAmbientAnims(ped, true)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)

    if Config.Variables.Framework == 'ox' then
        exports.ox_target:addModel('s_m_m_postal_01', {
            {
                label = "Sign In",
                distance = 1.5,
                event = "sd-gopostal:startjob",
                icon = "fas fa-sign-in-alt",
                canInteract = function(entity, data)
                    return not isDeliverySignedIn
                end,
            },
            {
                label = "Receive Payment & End Work",
                distance = 1.5,
                event = "sd-gopostal:finishwork",
                icon = "fas fa-money-check-alt",
                canInteract = function(entity, data)
                    return isDeliverySignedIn
                end,
            },
        })
        exports.ox_target:addGlobalVehicle({
            {
                label = "Take Package",
                event = "sd-gopostal:takepackage",
                icon = "fas fa-box",
                distance = 2.5,
                canInteract = function(entity, data)
                    return onDuty and (GetEntityModel(entity) == Config.PostalLocations.start.vehicleModel)
                end,
            }
        })
    elseif Config.Variables.Framework == 'qb' then
        exports['qb-target']:AddTargetModel('s_m_m_postal_01', {
            options = {
                {
                    type = "client",
                    event = "sd-gopostal:startJob",
                    icon = "fas fa-sign-in-alt",
                    label = "Sign In",
                    canInteract = function(entity, data)
                        return not isDeliverySignedIn
                    end,
                },
                {
                    type = "client",
                    event = "sd-gopostal:finishwork",
                    icon = "fas fa-money-check-alt",
                    label = "Receive Payment & End Work",
                    canInteract = function(entity, data)
                        return isDeliverySignedIn
                    end,
                },
            },
            distance = 1.5
        })
        exports['qb-target']:AddGlobalVehicle({
            options = {
                {
                    type = "client",
                    event = "sd-gopostal:takepackage",
                    icon = "fas fa-box",
                    label = "Take Package",
                    canInteract = function(entity, data)
                        return onDuty and (GetEntityModel(entity) == Config.PostalLocations.start.vehicleModel)
                    end,
                }
            },
            distance = 2.5,
        })
    end
end)


function RequestAnim(anim)
    RequestAnimDict(anim)
    while not HasAnimDictLoaded(anim) do
        print(anim)
        Wait(0)
    end
end

function PlayAnim(ped, dict, anim, flag, dur)
    RequestAnim(dict)
    TaskPlayAnim(ped, dict, anim, 1.0,-1.0, dur, flag, 1, false, false, false)
end

function LoadAnim(anim)
    RequestAnimDict(anim)
    while not HasAnimDictLoaded(anim) do
        Wait(0)
    end
end

function LoadModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(10)
	end
end

function SpawnTruck()
    RequestModel(`boxville2`)
    while not HasModelLoaded(`boxville2`) do
        Wait(0)
    end
    truck = CreateVehicle(`boxville2`, Config.PostalLocations.start.truckSpawn, 1, 0)
    SetEntityAsMissionEntity(truck)
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(truck))
    QBCore.Functions.Notify('Get inside van to start job!')
    WaitForPedToEnterVan()
end

function WaitForPedToEnterVan()
    CreateThread(function()
        while not IsPedInVehicle(PlayerPedId(), truck, 0) do
            Wait(0)
            if not onDuty then
                break
            end
            DrawMarker(3, GetEntityCoords(truck)+vec3(0,0,2.5), 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 255, 0, 255, 1, 1, 0, 0, 0, 0, 0)
        end
        SetupJobs()
    end)
end
local isFirst = true
local lastNumber = 0
function SetupJobs()
    if onDuty then
        jobNumber = math.random(1, #Config.PostalBoxes)
        if jobNumber == lastNumber then
            if jobNumber == #Config.PostalBoxes then
                jobNumber = jobNumber -1
            else
                jobNumber = jobNumber +1
            end
        end
        lastNumber = jobNumber
        currentJobPositions = Config.PostalBoxes[jobNumber]
        print(currentJobPositions)
        if isFirst then
            QBCore.Functions.Notify('Head to your first delivery')
        end
        isFirst = false
        local chopBlip = AddBlipForCoord(currentJobPositions[1])
        SetBlipColour(chopBlip, 3)
        SetBlipHiddenOnLegend(chopBlip, true)
        SetBlipRoute(chopBlip, true)
        SetBlipDisplay(chopBlip, 8)
        SetBlipRouteColour(chopBlip, 3)
        for k,v in pairs(currentJobPositions) do
            hasCompleted = false
            SetNewWaypoint(chopBlip)
            while not hasCompleted do
                local jobStatus = JobStatus(v)
                if jobStatus then
                    TriggerServerEvent("sd-gopostal:removeItem")
                    hasCompleted = true
                end
                Wait(0)
            end
        end
        RemoveBlip(chopBlip)
        TriggerServerEvent("sd-gopostal:jobCompleted")
        QBCore.Functions.Notify('Head to your next job location!', 'success')
        SetupJobs()
    end
end

function JobStatus(coords)
    local playerPed = PlayerPedId()
    local dist = #(coords - GetEntityCoords(playerPed))
    if dist < 50.0 then
        DrawMarker(3, coords+vec3(0,0,1.99), 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 255, 255, 255, 255, 0, 1, 0, 0, 0, 0, 0)
        if dist < 2.0 then
            if IsControlJustPressed(0, 38) then
                PlayAnim(playerPed, "mini@repair", "fixing_a_ped", 22, 2000)
                Wait(2000)
                return true
            end
        end
    end
end

function createStaticBlip()
    local blipCoords = vector3(65.01, 115.24, 79.09)  -- Update these coordinates with your desired location
    local blip = AddBlipForCoord(blipCoords.x, blipCoords.y, blipCoords.z)
    SetBlipSprite(blip, 480) -- radar_property sprite
    SetBlipDisplay(blip, 2) -- Only show on map
    SetBlipColour(blip, 5) -- Purple color
    SetBlipScale(blip, 1.0) -- Normal scale
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gopostal Job") -- Blip label
    EndTextCommandSetBlipName(blip)
end

-- JOB WORK

RegisterNetEvent("sd-gopostal:startJob")
AddEventHandler("sd-gopostal:startJob", function()
    if HasJob() then
        onDuty = not onDuty
        if onDuty then
            TriggerEvent("sd-gopostal:SpawnTruck", -1)
        else
            if not onDuty then 
                --DeleteEntity(truck)
            end
        end
    else
        QBCore.Functions.Notify("You need to have the 'sd-gopostal' job to start working.")
    end
end)


function HasJob(jobName)
    PlayerData = QBCore.Functions.GetPlayerData()
    return PlayerData.job.name == Config.Database.Job
end

RegisterNetEvent("sd-gopostal:SpawnTruck")
AddEventHandler("sd-gopostal:SpawnTruck", function()
    SpawnTruck()
end)

Citizen.CreateThread(function()
    createStaticBlip()
end)

RegisterNetEvent('inventory:client:ItemBox', function(itemData, type, amount)
    SendNUIMessage({
        action = "itemBox",
        item = itemData,
        type = type,
        amount = amount
    }) 
end)

RegisterNetEvent('sd-gopostal:takepackage', function()
	if onDuty and not IsPedInAnyVehicle(PlayerPedId()) then
		LoadModel("hei_prop_heist_box")
		local pos = GetEntityCoords(PlayerPedId(), false)
		PackageObject = CreateObjectNoOffset(GetHashKey("hei_prop_heist_box"), pos.x, pos.y, pos.z, true, false, false)
		AttachEntityToEntity(PackageObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, true, true, false, true, 0, true)
		LoadAnim("anim@heists@box_carry@")
		TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
        TriggerServerEvent("sd-gopostal:giveItem")
        onDuty = true
    end
end)