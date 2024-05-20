local STORAGE_VAL_KEY = 1000

local function releaseStorage(player)
    if player then
        player:setStorageValue(1000, -1)
    end
end
    
function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        releaseStorage(player)
    end
    return true
end