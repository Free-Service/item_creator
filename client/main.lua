RegisterCommand("item", function(source, args)
    ESX.TriggerServerCallback('item_creator:callback:CheckGroup', function(HasGroup)
        if HasGroup then
            ESX.TriggerServerCallback('item_creator:callback:GetItems', function(Items)
                -- print(ESX.DumpTable(Items))
                SetNuiFocus(true, true)
                SendNUIMessage({
                    state = 'show',
                    items = json.encode(Items)
                })
            end)
        else
            -- notify
        end
    end)
end, false)

RegisterNUICallback('exit', function(data, cb)
    SetNuiFocus(false, false)
end)
