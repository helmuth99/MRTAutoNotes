Addon, private = ...

local selectedInstance = "";
local selectedEncounter = "";

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

local function GetSavedNote(instance, encounter)
    if MRTAutoNotesDB.Notes[instance][encounter] == nil then
        MRTAutoNotesDB.Notes[instance][encounter] = ""
    end
    return MRTAutoNotesDB.Notes[instance][encounter]
end

local function SetSavedNotes(instance, encounter, text)
    if MRTAutoNotesDB.Notes[instance][encounter] == nil then
        MRTAutoNotesDB.Notes[instance][encounter] = ""
    end
     MRTAutoNotesDB.Notes[instance][encounter] = text;
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
        local note = GetSavedNote(selectedInstance, key)
        selectedEncounter = key
        editbox:SetText(note)
    end)

    editbox:SetCallback("OnEnterPressed", function (widget, event, text)
        SetSavedNotes(selectedInstance, selectedEncounter, text)
        MRTAutoNotes:Print("Saved Note")
    end)
end


