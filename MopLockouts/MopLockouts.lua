--OnLoad stuff
local f = CreateFrame("Frame") -- this is the frame for message sending thing
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_REGEN_ENABLED")

local Galleon = 32098 --index 2
local Sha = 32099  --index 3
local Nalak = 32518 --index 4
local Oondasta = 32519 --index 5

--Stuff for the /commands

SLASH_PHRASE1 = "/lockout";
SLASH_PHRASE2 = "/lockouts";

SlashCmdList["PHRASE"] = function(msg)
	if msg == "" then
        for i=1,#MopLockouts do
		    print("---- "..MopLockouts[i][1].." ----")
            print("Galleon: "..MopLockouts[i][2])
            print("Sha: "..MopLockouts[i][3])
            print("Nalak: "..MopLockouts[i][4])
            print("Oondasta: "..MopLockouts[i][5])
            print("")
        end
    elseif msg.sub(msg,1,5) == "reset" then
        for x = 1,#MopLockouts do
            for i=2,5 do
                MopLockouts[x][i] = "Available"
            end
        end
        print("Lockouts for All Characters Reset")
    end
	
end

-- Event handler for the initialization
f:SetScript("OnEvent", function(self,event,...)

	if event == "PLAYER_LOGIN" or "PLAYER_REGEN_ENABLED" then
        print "player lockouts loaded"
        local ToonName,realm = UnitName("player")
        if MopLockouts == nil then
            MopLockouts = {}
        end
        local PlayerRecorded = 0
        for i=1,#MopLockouts do
            if ToonName == MopLockouts[i][1] then
                PlayerRecorded = 1
                -- Galleon
                if IsQuestFlaggedCompleted(32098) == nil then
                    MopLockouts[i][2] = "Available"
                else
                    MopLockouts[i][2] = "Locked"
                end
                -- Sha
                if IsQuestFlaggedCompleted(32099) == nil then
                    MopLockouts[i][3] = "Available"
                else
                    MopLockouts[i][3] = "Locked"
                end
                -- Nalak
                if IsQuestFlaggedCompleted(32518) == nil then
                    MopLockouts[i][4] = "Available"
                else
                    MopLockouts[i][4] = "Locked"
                end
                -- Oondasta
                if IsQuestFlaggedCompleted(32519) == nil then
                    MopLockouts[i][5] = "Available"
                else
                    MopLockouts[i][5] = "Locked"
                end
            end
        end
        if PlayerRecorded == 0 then
            MopLockouts[#MopLockouts+1] = {ToonName,"no info","no info","no info","no info"}
        end
    end            
end)