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

function MRTAutoNotes:SetPersonalNote(Note)
    if not VMRT then 
        MRTAutoNotes:print("Method Raid Tools is not loaded or has an error." )
        return
    end
    VMRT.Note.SelfText = Note
    if not GMRT.A.Note.allframes.UpdateText or not GMRT.A.Note.options.UpdatePageAfterGettingNote then
        MRTAutoNotes:Print("Please open MRT on the Note Tab once to have them set automaticaly.")
        return
    end
    GMRT.A.Note.allframes:UpdateText()
    GMRT.A.Note.options:UpdatePageAfterGettingNote()
    --_G.MRTNotePersonal.text:SetText(Note)
end

function MRTAutoNotes:ENCOUNTER_START(event, encounterID, encounterName, difficultyId, groupSize)
    MRTAutoNotes:Print(encounterID.." "..encounterName.." "..difficultyId.." "..groupSize)
    local note =  private:GetSavedNote(tostring(encounterID), tostring(difficultyId))
    if note == nil or note == "" then
        return
    end
    MRTAutoNotes:SetPersonalNote(note)
end

--this is for dev use only
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