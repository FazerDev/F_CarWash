ESX = nil

enableprice = true -- true = carwash is paid, false = carwash is free

price = 25

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('CarWash')
AddEventHandler('CarWash', function ()
	if enableprice == true then
		TriggerEvent('es:getPlayerFromId', source, function (user)
			userMoney = user.getMoney()
			if userMoney >= price then
				user.removeMoney(price)
				TriggerClientEvent('carwash:ok', source, price)
			else
				moneyleft = price - userMoney
				TriggerClientEvent('es_carwash:notenoughmoney', source, moneyleft)
			end
		end)
	else
		TriggerClientEvent('es_carwash:free', source)
	end
end)
