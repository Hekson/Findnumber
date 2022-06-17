ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end)

RegisterCommand('findnumber', function(source, args, users)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" and xPlayer.job.grade > 0 then
        if args[1] then
            if string.len(args[1]) == 10 then
            local number = tonumber(args[1])
                if number then
                    MySQL.Async.fetchAll('SELECT playerName FROM users WHERE phone_number=@number', 
                    {
                        ['@number'] =  number
                    }, function(data)
                        if data[1] then
                            TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0 In Shomare be naame ^3" .. string.gsub(data[1].playerName, "_", " ") .. " ^0Ast!"} })
                        else
                            TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', "^0 In shomare vojoud nadarad"} })
                        end
                    end)
                else
                    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shoma dar ghesmat Shomare vaghat mitavanid adad vared konid!"} })
                end
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shomare bayad 11 raghami bashad!"} })
            end
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shoma dar ghesmat Shomare chizi vared nakardid!"} })
        end
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shoma police nistid!"} })
    end
end)