Config = {}

-- Lägg till alla vapen det ska fungera på
Config.WeaponList = {
	453432689,
	-1716189206,
}

Config.UnarmedHash = -1569615261

Citizen.CreateThread(function()
	local animDict = 'reaction@intimidation@1h'
	local animIntroName = 'intro'
	local animOutroName = 'outro'

	RequestAnimDict(animDict)
	  
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(100)
	end

	local lastWeapon = nil

	while true do
		Citizen.Wait(0)

		for i=1, #Config.WeaponList do
			if lastWeapon ~= nil and lastWeapon ~= Config.WeaponList[i] and GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.WeaponList[i] then
				TaskPlayAnim(GetPlayerPed(-1), animDict, animIntroName, 8.0, -8.0, 2700, 0, 0, false, false, false)
				Citizen.Wait(1000)
				SetCurrentPedWeapon(GetPlayerPed(-1), Config.WeaponList[i], true)
			end
		end
		
		if lastWeapon ~= nil and lastWeapon ~= Config.UnarmedHash and GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.UnarmedHash then
			TaskPlayAnim(GetPlayerPed(-1), animDict, animOutroName, 8.0, -8.0, 2700, 0, 0, false, false, false)
			Citizen.Wait(1000)
			SetCurrentPedWeapon(GetPlayerPed(-1), Config.UnarmedHash, true)
		end

		lastWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
	end
end)