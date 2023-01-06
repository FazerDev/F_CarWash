ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        print("Created_By_FaZer")
		Wait(100)
	end
end)

local MenuWash = false

------------------------------------ 
------------- [ MENU ] -------------
------------------------------------

local nettoyage = RageUI.CreateMenu("Nettoyage Voiture", "Service", 10 , 80)
nettoyage.Closed = function() MenuWash = false end

function OpenMenuCarWash()
    if MenuWash then
        MenuWash = false
    else
        MenuWash = true
    RageUI.Visible(nettoyage, true)
        CreateThread(function()
            while MenuWash do
                Wait(1)
                RageUI.IsVisible(nettoyage, function()
                    
                    RageUI.Button("Nettoyer le véhicule", nil, {RightLabel = "~b~ 25 €"}, true , {
                        onSelected = function()
                            TriggerServerEvent('CarWash')	
                            Wait(1)
                        end
                    })

                end)
            end
        end)
    end 
end

----------------------------------------
----------- [ Fonction Wash ] ----------
----------------------------------------

RegisterNetEvent('carwash:ok')
AddEventHandler('carwash:ok', function (price)
    WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
    SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
    ESX.ShowAdvancedNotification('BZH Corporation®', 'Nettoyage', 'Votre Véhicule est tout propre !', 'CHAR_PEGASUS_DELIVERY', 0)
end)

RegisterNetEvent('es_carwash:notenoughmoney')
AddEventHandler('es_carwash:notenoughmoney', function (moneyleft)
ESX.ShowAdvancedNotification('BZH Corporation®', 'Nettoyage', 'Paiment Refusé !', 'CHAR_PEGASUS_DELIVERY', 0)
end)

----------------------------------------
------------ [ DRAWMARKERS ] -----------
----------------------------------------


Citizen.CreateThread(function()
    while true do
        local pCoords2 = GetEntityCoords(PlayerPedId())
        local activerfps = false
        local dst = GetDistanceBetweenCoords(pCoords2, true)
        for _,v in pairs(Config.positionwash) do
            if #(pCoords2 - v.position) < 1.5 then
                activerfps = true
                Visual.Subtitle("Appuyer sur ~g~[E]~s~ pour accéder au Lavoir !")
            if MenuWash == false then
                if IsControlJustReleased(0, 38) then
                    OpenMenuCarWash()
                end
            end
            elseif #(pCoords2 - v.position) < 7.0 then
                activerfps = true
                DrawMarker(29, v.position, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 170, 1, 1, 2, 0, nil, nil, 0)
            end
        end
        if activerfps then
            Wait(1)
        else
            Wait(1500)
        end
    end
end)

---------------------------------
----------- [ BLIPS ] -----------
---------------------------------

Citizen.CreateThread(function()

for _, info in pairs(Config.blipswash) do
  info.blip = AddBlipForCoord(info.x, info.y, info.z)
  SetBlipSprite(info.blip, info.id)
  SetBlipDisplay(info.blip, 4)
  SetBlipScale(info.blip, 0.7)
  SetBlipColour(info.blip, info.colour)
  SetBlipAsShortRange(info.blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(info.title)
  EndTextCommandSetBlipName(info.blip)
    end
end)

----------------------------------------------------------------------------------
------------------------------ [ CREATED BY FAZER ] ------------------------------
----------------------------------------------------------------------------------
