if DrawStrBoxYesNo(-1, -1, "Ҫ�����˲���ô��", C_WHITE, 30) == true then
    for i = 1, CC.TeamNum do                 
        local id = JY.Base["����" .. i];
		if id >= 0 then
			JY.Person[id]["��������"] = 30000
			War_PersonTrainBook(id)
			JY.Person[id]["����"] = 52000
			War_AddPersonLVUP(id);		
		end
    end
end