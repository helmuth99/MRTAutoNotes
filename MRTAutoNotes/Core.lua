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

function MRTAutoNotes:OnInitialize()
    --fix this befor release
    --if MRTAutoNotesDB == nil then
    MRTAutoNotesDB = {}
    MRTAutoNotesDB.Notes = {

    }
    --end 

    for key, value in pairs(private:GenerateInstanceList()) do
        if MRTAutoNotesDB.Notes[key] == nil then
            MRTAutoNotesDB.Notes[key] = {}
        end
    end


    self:RegisterChatCommand("mrtnotes", "SlashCommand")
    self:RegisterChatCommand("mrtautonotes", "SlashCommand")
    self:RegisterChatCommand("mrtn", "SlashCommand")
    
end