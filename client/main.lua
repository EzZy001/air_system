local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
end

local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
end

lib.registerContext({
        id = 'letecka_skola',
        title = 'Letecká škola',
        options = {

            {
            title = 'Letecká teorie',
            description = 'Teoretická část výcviku',
            icon = 'fa-id-card',
            onSelect = function()
                print("test")
            end,
            },

        }
    })

local function spawnPeds()
    for _, pedInfo in pairs({ Config.NPC.TheoryNPC }) do
        loadModel(GetHashKey(pedInfo.pedmodel))

        local ped = CreatePed(4, GetHashKey(pedInfo.pedmodel), pedInfo.coords.x, pedInfo.coords.y, pedInfo.coords.z - 1.0, pedInfo.heading, false, true)

        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)

        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedCanRagdoll(ped, false)
        SetPedCanBeTargetted(ped, false)
        SetPedCanBeTargettedByPlayer(ped, false)
        SetPedCanBeDraggedOut(ped, false)
        SetEntityAsMissionEntity(ped, true, true)

        exports.ox_target:addLocalEntity(ped, {
            {
                label = 'Letecká škola',
                name = 'letecka_skola',
                icon = 'fas fa-plane',
                onSelect = function()
                    lib.showContext('letecka_skola')
                end,
                distance = 2.0
            }
        })
    end
end

Citizen.CreateThread(function()
    spawnPeds()
end)
