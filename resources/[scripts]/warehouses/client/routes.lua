local function RegisterRoutes()
  local routes = {
    ['GET_AVAILABLE_PROPERTIES'] = function()
      local Callback = {}
      local Propertys = vSERVER.avaliablePropertys()
      for k,v in pairs(Propertys) do 
        if Warehouses[v] then 
          table.insert(Callback,{
            id = Warehouses[v].Id,
            icon = { 'fas', 'house' },
            name = v,
            price = Warehouses[v].Price,
            image_url = Warehouses[v].Image  
          })
        end
      end

      return Callback
    end,
    ['GET_PROPERTIES'] = function()
      local Callback = {}
      local Propertys = vSERVER.playerPropertys()
      
      for k,v in pairs(Propertys) do 
        if not Warehouses[v.name] then 
            goto continue 
        end

          table.insert(Callback,{
            default_name = v.name,
            id = Warehouses[v.name].Id,
            icon = 'fa-light fa-house',
            name = "<b>"..v.name.."</b>",
            image_url = Warehouses[v.name].Image
          })
        ::continue::
      end
      
      return Callback
    end,
    ['BUY_PROPERTY'] = function (data)
      local Response = vSERVER.buyPropertys(data)
      if type(Response) == "boolean" then 
        return Response 
      end
    end,
    ['GET_DETAILS_PROPERTY'] = function(data)
      local propertysInfos,propertyName = vSERVER.propertysInfos(data)
      if propertysInfos then 
        return {
          id = propertyName,
          name = propertysInfos.renamed or propertyName,
          icon = 'fa-light fa-house',
          image_url = Warehouses[propertyName].Image,
          rent_expires_in = propertysInfos.rentTime,

          rent_price = Warehouses[propertyName].Price * TaxPrice, -- OPCIONAL
          chest_weight = propertysInfos.chest,
          increased_quantity_weight = Warehouses[propertyName].Weight["Default"],
          buy_weight_price = Warehouses[propertyName].Weight["Buy"],
          buy_garage_price = GaragePrice,
          members = propertysInfos.members
        }
      end
    end,
    ['RENAME_PROPERTY'] = function (data)
      local Callback = vSERVER.editPropertys({property_id = data},"rename")
      if type(Callback) == "boolean" then 
        return Callback
      end
    end,
    ['REMOVE_MEMBER_PROPERTY'] = function(data)
      local Callback = vSERVER.editPropertys(data,"remove-members")
      if type(Callback) == "boolean" then 
        return Callback
      end
    end,
    ['INVITE_MEMBER_PROPERTY'] = function(data)
      local Callback = vSERVER.editPropertys({property_id = data},"add-members")
      if type(Callback) == "boolean" then 
        return Callback
      end
    end,
    ['INCREASE_WEIGHT_PROPERTY'] = function(data)
      local Callback = vSERVER.propertyFunctions(data,"increase-weight")
      if type(Callback) == "boolean" then 
        return Callback
      end
    end,
    ['BUY_GARAGE'] = function(data)
      local Callback = vSERVER.propertyFunctions(data,"garages")
      if type(Callback) == "boolean" then 
        return Callback
      end
    end,
    ['PAY_RENT_PROPERTY'] = function(data)
      local Callback = vSERVER.propertyFunctions(data,"pay-tax")
      if type(Callback) == "boolean" then 
        return Callback
      end      
    end,
    ['CLOSE'] = function()
      closeInterface()
      return true
    end
  }

  for k, v in pairs(routes) do
    RegisterNUICallback(k, function(data, cb)
      cb(v(data))
    end)
  end
end
Citizen.CreateThread(RegisterRoutes)