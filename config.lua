Config = {}

Config.Variables = {
    Framework = 'qb', -- QB/ESX/None -- set to none to use k_diseases:forceStart trigger instead
    Notify = 'qb', -- QB/ESX/Custom -- custom function below
    target = 'qb', -- 'qb' or 'ox',
    item = '' -- this is the item that you can put for players to get when putting away papers/posts
}

Config.Database = {
    Job = 'police', -- this is the job players need to use the gopostal
    SalaryPayOut = '50'  -- this is the salary payout
}

Config.PostalLocations = {
    start = {
        coords = vector3(78.9, 111.71, 81.16),
        truckSpawn = vector4(69.94, 122.4, 79.07, 160.39),
        pedModel = 's_m_m_postal_01',
        pedCoords = vector3(70.87, 108.39, 78.2),
        vehicleModel = `boxville2`
    }
}

Config.PostalBoxes = {
    [1] = {
        vector3(261.45, -216.67, 52.98),
        vector3(259.81, -216.21, 52.97),
        vector3(259.01, -215.92, 52.97),
        vector3(258.37, -215.71, 52.97),
        vector3(257.78, -215.41, 52.96)
    },
    [2] = {
        vector3(-52.84, -99.07, 56.81),
        vector3(-53.84, -98.68, 56.83),
        vector3(-54.68, -98.46, 56.81),
        vector3(-55.53, -98.16, 56.81),
        vector3(-56.21, -97.98, 56.81)
    },
    [3] = {
        vector3(-18.83, -113.39, 55.93),
        vector3(-22.03, -112.08, 55.99),
        vector3(-22.81, -111.76, 56.0)
    },
    [4] = {
        vector3(117.8, -164.12, 53.73),
        vector3(120.0, -164.93, 53.69),
        vector3(120.78, -165.18, 53.69),
        vector3(121.46, -165.37, 53.68),
        vector3(122.3, -165.68, 53.67)
    }
}


if not IsDuplicityVersion() then --Client Side
    function Notify(text, type)
        print(text)
        --custom code for a custom notify
    end
else
    function DropExploiter(src)
        DropPlayer(src, 'stinky cheetor')
    end
end