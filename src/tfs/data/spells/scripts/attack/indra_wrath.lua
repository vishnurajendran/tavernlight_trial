-- Spell name: Indra's Wrath, Spell Id : 10001
-- This scripts contains the logic of Indira's Wrath spell
-- What we want: Have a swarm of tornados surround the player

-- Idea : Spawn a bunch of tornadoes around th player, and let them have the ability
-- to spawn more tornadoes recursivly,This appeared to give good results, not exactly like
-- what the demo needed tho :/.

-- delay between child spawns
local EACH_SPAWN_DELAY = 100
local MAGIC_EFFECT = CONST_ME_ICETORNADO

-- This function returns a point on a circle with centre and radius provided
-- taking into account the angle
-- @return position
function getPointInCircle(center, radius, angleDegrees)
    local angleRadians = math.rad(angleDegrees)
    local x = center.x + (math.cos(angleRadians) * radius)
    local y = center.y + (math.sin(angleRadians) * radius)
    return Position(x, y, center.z)

end

-- Invoked when the item is used
function onCastSpell(cid, variant)
    local player = Player(cid)
    if not player then
        return false
    end

	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Indira's Wrath is unleashed")
    -- spawn 10 initially, this looked like a good number
    local intialSpawns = 10
    local maxRecursions = 10
    for i = 0, intialSpawns - 1 do
        doRandomTornadoSpawn(cid, maxRecursions, (i*360)/intialSpawns, 2.5)
    end
    return true
end

-- This functions spawns 1 tornado and if recursion is allowed will spawn successive
-- child tornados on random spawn points.
function doRandomTornadoSpawn(playerId, maxRecursionDepth, angle, radius)
    local player = Player(playerId)
    local position = getPointInCircle(player:getPosition(),radius,angle)
    maxRecursionDepth = maxRecursionDepth - 1
    position:sendMagicEffect(MAGIC_EFFECT)
    
    --recursivly call the function, if we are past the max dept, exit
    if maxRecursionDepth <= 0 then
        return
    end
    -- random radius for new position for children
    newRad = clamp(radius-1, 1.5,3)
    --recursivly call the function with delay
    -- we randomly pick a number between 0 and 359 as our next angle
    -- the radius is clamped so we spawn farther to closer.
    local newAngle = math.random(0, 360)
    local newRad = math.random(1.5, newRad)
    addEvent(doRandomTornadoSpawn, EACH_SPAWN_DELAY,player:getId(),maxRecursionDepth,newAngle,newRad)
end

-- simple function to clamp a number
function clamp(num, min, max)
    if num < min then
        return min
    elseif num > max then
        return max
    end
    return num
end