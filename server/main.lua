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
