local onDuty = false
local truck
local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent("sd-gopostal:jobCompleted")
AddEventHandler("sd-gopostal:jobCompleted", function()
    -- Handle job completion logic here
end)

RegisterServerEvent("sd-gopostal:playerEnteredVan")
AddEventHandler("sd-gopostal:playerEnteredVan", function()
    TriggerClientEvent("sd-gopostal:setupJobs", source)
end)

-- Add other server-side functions and events as needed

RegisterServerEvent("sd-gopostal:giveItem")
AddEventHandler("sd-gopostal:giveItem", function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        xPlayer.Functions.AddItem("stickynote", 1) -- Assuming "water" is the item name
        TriggerClientEvent("sd-gopostal:startJob", source)
    end
end)
RegisterServerEvent("sd-gopostal:removeItem")
AddEventHandler("sd-gopostal:removeItem", function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    print("hello test test", xPlayer)
    if xPlayer then
        xPlayer.Functions.RemoveItem("stickynote", 1) -- Assuming "water" is the item name
    end
end)
RegisterServerEvent("sd-gopostal:jobCompleted")
AddEventHandler("sd-gopostal:jobCompleted", function()
    -- Handle job completion logic here
    -- For example, you can give the player payment for completing the job
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        xPlayer.Functions.AddMoney("bank", Config.Database.SalaryPayOut) -- Pay the player $50 for completing a job
        -- You can adjust the amount or payment method as per your requirements
    end
end)