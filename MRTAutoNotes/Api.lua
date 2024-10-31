Addon, private = ...

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