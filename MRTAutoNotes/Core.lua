local addon, private = ...

MRTAutoNotes = LibStub("AceAddon-3.0"):NewAddon("MRTAutoNotes", "AceConsole-3.0", "AceEvent-3.0")

function MRTAutoNotes:TablePrint(myTable)
    for key, value in pairs(myTable) do
        print("Key: " .. key .. ", Value: " .. value)
    end
end

function MRTAutoNotes:OnInitialize()
   

    --fix this befor release
    --if MRTAutoNotesDB == nil then
        MRTAutoNotesDB = {}
        MRTAutoNotesDB.Notes = {
            test = "hello",
            test2 = "hello2"
        }
    --end 

 
    MRTAutoNotes:TablePrint(MRTAutoNotesDB.Notes)
    private:CreateMainFrame()
    
end