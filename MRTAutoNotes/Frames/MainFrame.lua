Addon, private = ...

local selectedInstance = "";
local selectedEncounter = "";
local selectedDifficulty = "";

function private:GenerateInstanceList()
    list = {}
    for key, value in pairs(private.encounterList) do
        list[key] = key
    end
    return list
end 

function private:ReturnEncounters(key)
    return private.encounterList[key]
end

function private:GetSavedNote(instance, encounter, difficulty)
    if MRTAutoNotesDB.Notes[instance][encounter] == nil then
        MRTAutoNotesDB.Notes[instance][encounter] = {}
    end
    if MRTAutoNotesDB.Notes[instance][encounter][difficulty] == nil then
        MRTAutoNotesDB.Notes[instance][encounter][difficulty] = ""
    end
    return MRTAutoNotesDB.Notes[instance][encounter][difficulty]
end

local function SetSavedNotes(instance, encounter, difficulty, text)
    if MRTAutoNotesDB.Notes[instance][encounter] == nil then
        MRTAutoNotesDB.Notes[instance][encounter] = {}
    end
    if MRTAutoNotesDB.Notes[instance][encounter][difficulty] == nil then
        MRTAutoNotesDB.Notes[instance][encounter][difficulty] = ""
    end
     MRTAutoNotesDB.Notes[instance][encounter][difficulty] = text;
end

function private:CreateMainFrame()
    local AceGUI = LibStub("AceGUI-3.0")
    local frame = AceGUI:Create("Frame")
    frame:SetLayout("Flow")
    frame:SetTitle("MRTAutoNotes")
    frame:SetStatusText("MRTAutoNotes powered by EU-Gravity-Blackhand")

    local description1 = AceGUI:Create("Label")
    description1:SetText("Welcome to the MRTAutoNotes.\nJust Select the Encounter below and set your note. The note should be set as a personal note on the start of the encounter.\nEmpty notes will not overwrite personal notes.")
    description1:SetFullWidth(true)
    frame:AddChild(description1)

    local heading1 = AceGUI:Create("Heading")
    heading1:SetText("Note")
    heading1:SetFullWidth(true)
    frame:AddChild(heading1)

    local dropdownInstance = AceGUI:Create("Dropdown")
    dropdownInstance:SetLabel("Instance")
    dropdownInstance:SetWidth(200)
    dropdownInstance:SetList(private:GenerateInstanceList())
    dropdownInstance:ClearAllPoints()
    dropdownInstance:SetPoint("RIGHT")
    frame:AddChild(dropdownInstance)

    local dropdownEncounter = AceGUI:Create("Dropdown")
    dropdownEncounter:SetLabel("Encounter")
    dropdownEncounter:SetWidth(200)
    dropdownEncounter:SetList({})
    dropdownEncounter:ClearAllPoints()
    dropdownEncounter:SetPoint("RIGHT")
    frame:AddChild(dropdownEncounter)

    local dropdownDifficulty = AceGUI:Create("Dropdown")
    dropdownDifficulty:SetLabel("Difficulty")
    dropdownDifficulty:SetWidth(120)
    dropdownDifficulty:SetList(private.difficulty)
    selectedDifficulty = "14"
    dropdownDifficulty:SetValue("14")
    frame:AddChild(dropdownDifficulty)

    local editbox = AceGUI:Create("MultiLineEditBox")
    editbox:SetLabel("")
    editbox:SetRelativeWidth(0.9)
    editbox:SetHeight(300)
    editbox:SetFullWidth(true)
    editbox:ClearAllPoints()
    editbox:SetPoint("BOTTOM")
    frame:AddChild(editbox)

    dropdownInstance:SetCallback("OnValueChanged", function (widget, event, key, checked)
        dropdownEncounter:SetList(private:ReturnEncounters(key))
        selectedInstance = key
    end )

    dropdownEncounter:SetCallback("OnValueChanged", function (widget, event, key, checked)
        editbox:SetText( private:GetSavedNote(selectedInstance, key, selectedDifficulty))
        selectedEncounter = key
    end)

    dropdownDifficulty:SetCallback("OnValueChanged", function (widget, event, key, checked)
        editbox:SetText( private:GetSavedNote(selectedInstance, selectedEncounter, key))
        selectedDifficulty = key
    end)

    editbox:SetCallback("OnEnterPressed", function (widget, event, text)
        SetSavedNotes(selectedInstance, selectedEncounter, selectedDifficulty, text)
        MRTAutoNotes:Print("Saved Note")
    end)

end