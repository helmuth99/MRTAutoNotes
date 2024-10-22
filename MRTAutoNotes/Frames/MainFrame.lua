Addon, private = ...

function private:CreateMainFrame()
    local AceGUI = LibStub("AceGUI-3.0")
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("MRTAutoNotes")
    frame:SetStatusText("MRTAutoNotes powered by EU-Gravity-Blackhand")

    local dropdown = AceGUI:Create("Dropdown")
    dropdown:SetWidth(200)
    dropdown:SetList(MRTAutoNotesDB.Notes)
    dropdown:ClearAllPoints()
    dropdown:SetPoint("RIGHT")
    frame:AddChild(dropdown)

    local editbox = AceGUI:Create("MultiLineEditBox")
    editbox:SetLabel("")
    editbox:SetRelativeWidth(0.9)
    editbox:SetHeight(300)
    editbox:SetFullWidth(true)
    editbox:ClearAllPoints()
    editbox:SetPoint("BOTTOM")
    frame:AddChild(editbox)
    
end
