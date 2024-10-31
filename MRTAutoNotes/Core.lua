local addon, private = ...

MRTAutoNotes = LibStub("AceAddon-3.0"):NewAddon("MRTAutoNotes", "AceConsole-3.0", "AceEvent-3.0")

function MRTAutoNotes:TablePrint(myTable)
    for key, value in pairs(myTable) do
        print("Key: " .. key .. ", Value: " .. value)
    end
end

function MRTAutoNotes:SlashCommand(msg)
    private:CreateMainFrame()
end

local function Alert(text)
    StaticPopupDialogs["ProfileOverrideConfirm"] = {
		text = text,
		button1 = "I acknowledge",
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	-- tell our dialog box to show
	StaticPopup_Show("ProfileOverrideConfirm")
    
end

function MRTAutoNotes:ENCOUNTER_START(event, encounterID, encounterName, difficultyId, groupSize)
    MRTAutoNotes:Print(event.." "..encounterID.." "..encounterName.." "..difficultyId.." "..groupSize)
    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo()
    local instance = private.instanceID[tostring(instanceID)]
    if not instance then
        return
    end
    local note =  private:GetSavedNote(instance, encounterID, difficultyId)
    if note == nil or note == "" then
        --not overwritting notes that do not exist or are empty
        return
    end
    MRTAutoNotes:SetPersonalNote(note)
end

function MRTAutoNotes:ZONE_CHANGED_NEW_AREA(event)
    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo()
    MRTAutoNotes:Print("Dev: "..instanceID.." "..name)
end

function MRTAutoNotes:OnInitialize()
    --fix this befor release
    if MRTAutoNotesDB == nil then
        MRTAutoNotesDB = {}
        MRTAutoNotesDB.Notes = {

        }
    end 

    for key, value in pairs(private:GenerateInstanceList()) do
        if MRTAutoNotesDB.Notes[key] == nil then
            MRTAutoNotesDB.Notes[key] = {}
        end
    end
    	

    self:RegisterEvent("ENCOUNTER_START")
    --self:RegisterEvent("ZONE_CHANGED_NEW_AREA")

    self:RegisterChatCommand("mrtnotes", "SlashCommand")
    self:RegisterChatCommand("mrtautonotes", "SlashCommand")
    self:RegisterChatCommand("mrtn", "SlashCommand")
    
    --temp fix
    Alert("Due to technical reason you have to open MRT and open the Note tab for MRTAutoNotes to work.")
end