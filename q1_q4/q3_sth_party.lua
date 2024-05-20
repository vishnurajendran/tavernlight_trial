function do_sth_with_PlayerParty(playerId, membername)
    player = Player(playerId)
    -- validate the player table
    if not player then
        print("Error: player Id"..playerId.."is invalid")
        return
    end

    local party = player:getParty()

    if not party then
        print("Error: Player is not in party")
        return
    end

    local member = Player(membername)
    -- validate the memeber table
    if not member then
        print("Error: membername "..member.."is invalid")
        return
    end

    for _, partymember in pairs(party:getMembers()) do
        if partymember == member then
            party:removeMember(member)
            return
        end
    end
    print("member "..membername.." not in player's party")
end