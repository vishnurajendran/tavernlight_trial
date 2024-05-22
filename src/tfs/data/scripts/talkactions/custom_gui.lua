window = nil
currentXPos = 0;

Game.createTimer(100, onUpdateGUI)

function onUpdateGUI()
    if not window then
        return
    end

    -- we update the window gui here


end

function onSay(player, words, param)
    window = ModalWindow(1000, "Custom Modal", "Nothing here bruv")
    window:addButton(100, "Jump!")
    window:sendToPlayer(player)
end