ESX.RegisterServerCallback('item_creator:callback:CheckGroup', function(src, cb)
  local xPlayer = ESX.GetPlayerFromId(src)
  local PlayerGroup = xPlayer.getGroup()

  for k, v in pairs(Config.Groups) do
    if v == PlayerGroup then
      cb(true)
    end
  end

  cb(false)
end)

ESX.RegisterServerCallback('item_creator:callback:GetItems', function(src, cb)
  local xPlayer = ESX.GetPlayerFromId(src)
  local PlayerGroup = xPlayer.getGroup()

  for k, v in pairs(Config.Groups) do
    if v == PlayerGroup then
      MySQL.query('SELECT * FROM items', {}, function(response)
        if response then
          cb(response)
        end
      end)
    end
  end
end)

RegisterServerEvent('item_creator:addItem')
AddEventHandler('item_creator:addItem', function(itemName, itemLabel, itemWeight, isRemovable, targetPlayerId)
    if not itemName or not itemLabel or not itemWeight or not targetPlayerId then 
        print("Missing parameters")
        return
    end

    local targetPlayer = ESX.GetPlayerFromId(targetPlayerId)
    local xPlayer = ESX.GetPlayerFromId(targetPlayerId)

    if isRemovable == nil then
        isRemovable = 1
    end

    if xPlayer.getGroup() == Config.Groups then
        MySQL.Async.execute('INSERT INTO items (name, label, weight, can_remove) VALUES (@name, @label, @weight, @canRemove)', {
            ['@name'] = itemName,
            ['@label'] = itemLabel,
            ['@weight'] = itemWeight,
            ['@canRemove'] = isRemovable
        }, function(rowsAffected)
            if rowsAffected > 0 then
                ESX.Items[v.name] = {
                    name = v.name,
                    label = v.label,
                    weight = v.weight,
                    can_remove = v.can_remove
                }
                -- Notify
            end
        end)
    else
        -- Notify
    end
end)