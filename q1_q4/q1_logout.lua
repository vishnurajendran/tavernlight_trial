local STORAGE_VAL_KEY = 1000

local function releaseStorage(player, key)
    if player then
        player:setStorageValue(key, -1)
    end
end
    
function onLogout(player)
    if player:getStorageValue(STORAGE_VAL_KEY) == 1 then
        releaseStorage(player, STORAGE_VAL_KEY)
    end
    return true
end
