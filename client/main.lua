local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
end


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
                label = _Locale("flight_school_target_title"),
                name = 'letecka_skola',
                icon = 'fas fa-plane',
                onSelect = function()
                    lib.registerContext({
                        id = 'letecka_skola',
                        title = _Locale("flight_school_title"),
                        options = {

                            {
                            title = _Locale("flight_school_teory_option_title"),
                            description = _Locale("flight_school_teory_option_desc"),
                            icon = Config.menu.icon_theory,
                            onSelect = function()
                                print("test")
                            end,
                            },

                            
                            {
                            title = _Locale("flight_school_heli_option_title"),
                            description = _Locale("flight_school_heli_option_desc"),
                            icon = Config.menu.icon_heli,
                            onSelect = function()
                                print("test")
                            end,
                            },


                            {
                            title = _Locale("flight_school_plane_option_title"),
                            description = _Locale("flight_school_plane_option_desc"),
                            icon = Config.menu.icon_plane,
                            onSelect = function()
                                print("test")
                            end,
                            },                            

                        }
                    })

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
