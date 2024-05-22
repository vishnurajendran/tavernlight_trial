-- This script provides the logic needed for Question 7
-- having a custom modal with an animated button
-- IMP: this module has to be loaded manually from the module manager in the client

-- delay between two consecutive frames
local ANIM_INTERVAL = 250
-- minimum x position before button updates x position
local ANIM_X_MIN = 10
-- maximum x position the button sets to after reaching X_MIN
local ANIM_X_MAX = 300
-- delta x-position between 2 positions
local ANIM_X_DELTA = 10

-- min Y value for y-position update
local Y_MIN = 50
-- max Y value for y-position update
local Y_MAX = 250

-- references
local customWindow;
local button;
local bttnPos = {x=0, y=0}

-- A simple function that sets the y-position to a random position
-- within Y_MIN and Y_MAX
function moveToRandomY()
    randY = math.random(Y_MIN, Y_MAX)
    bttnPos.y = randY
end

-- onclik function, invoked when button is clicked
function onButtonClick()
    moveToRandomY()
   setButtonPos(bttnPos)
end

-- animate function updates the x-position to move towards
-- each frame, position is updated by ANIM_X_DELTA pixels
-- if the end is reached, we jump to a diff y and set the
-- x-position to ANIM_X_MAX
function animate()
    newX = bttnPos.x - ANIM_X_DELTA
    if(newX < ANIM_X_MIN) then
        moveToRandomY();
        newX = ANIM_X_MAX
    end
    bttnPos.x  = newX
    setButtonPos(bttnPos)
end

-- This function simply sets the position of the button, using the provided
-- table
function setButtonPos(pos)
    button:setMarginTop(pos.y)
    button:setMarginLeft(pos.x)
end

-- referenced in custom_window.otmod (invoked onLoad), initialises the window and starts the animation
function init()
    customWindow = g_ui.loadUI('custom_window.otui', modules.game_interface.getRootPanel())
    customWindow:show()
    button = customWindow:getChildById('jmpBttn')
    bttnPos = {x=200, y=150}
    setButtonPos(bttnPos)
    -- this function calls the "animate" function on regular intervals (ANIM_INTERVAL)
    -- this simulates our frame by frame animation
    cycleEvent(animate, ANIM_INTERVAL)
end

-- termination function, closes the window
-- referenced in custom_window.otmod (invoked onUnLoad, and OnGameEnd)
function terminate()
    customWindow:destroy()
end
