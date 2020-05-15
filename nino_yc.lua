function Cls(x1, y1, x2, y2, flag)
  if x1 == nil then
    x1 = 0
    y1 = 0
    x2 = 0
    y2 = 0
  end
  lib.SetClip(x1, y1, x2, y2)
  if JY.Status == GAME_START then
    lib.FillColor(0, 0, 0, 0, 0)
    lib.LoadPicture(CC.FirstFile, -1, -1)
  elseif JY.Status == GAME_START2 then
      lib.FillColor(0, 0, 0, 0, 0)
  elseif JY.Status == GAME_MMAP then
      lib.DrawMMap(JY.Base["��X"], JY.Base["��Y"], GetMyPic())
  elseif JY.Status == GAME_SMAP then
      DrawSMap()
  elseif JY.Status == GAME_WMAP then
      WarDrawMap(0)
  elseif JY.Status == GAME_DEAD then
      lib.FillColor(0, 0, 0, 0, 0)
      lib.LoadPicture(CC.DeadFile, -1, -1)
  elseif JY.Status == GAME_YC then
      lib.FillColor(0, 0, 0, 0, 0)
      lib.LoadPicture(CONFIG.PicturePath .. YC.BG ..".png", -1, -1)
	  --[[if flag == nil then
		YC_Display()
	  end]]
  elseif JY.Status == GAME_PET then
      lib.FillColor(0, 0, 0, 0, 0)
      lib.LoadPicture(CONFIG.PicturePath.."p"..JY.Base["����"]..".png", -1, -1)  
  elseif JY.Status == GAME_MATCH then
      lib.FillColor(0, 0, 0, 0, 0)
      lib.LoadPicture(CONFIG.PicturePath.."scroll.png", -1, -1)  
	  drawmatch(CC.Match)
  end
  lib.SetClip(0, 0, 0, 0)
end--�����ͼ����

function YC_Menu(a, b, lv)
	Cls()
	local main = {}
	local num = 0
	local current = 1
	for i = a, b do
		main[num + 1] = {i, CC.ScreenH / 8 - 10 + num * 90, CC.ScreenW / 5 * 3 + 50, 1}
		num = num + 1
	end
	if lv > 1 then
		main[num + 1] = {0, CC.ScreenH / 8 - 10 + num * 90, CC.ScreenW / 5 * 3 + 50, 1}
		num = num + 1		
	end
	--main[2][4]=0 --����
	while true do
		Cls()
		YC_Display()
		
		for i = 1, num do
			if main[i][4] == 1 then
				lib.PicLoadCache(11, main[i][1] * 2, main[i][2], main[i][3])
			else
				lib.PicLoadCache(11, 9 * 2, main[i][2], main[i][3])
			end
		end
		DrawBox3(main[current][2] - 35, main[current][3] - 35, main[current][2] + 35, main[current][3] + 37, C_RED)
		DrawBox3(main[current][2] - 36, main[current][3] - 36, main[current][2] + 36, main[current][3] + 38, C_RED)
		ShowScreen()
		local p = WaitKey()	
		
		if p == VK_ESCAPE then
			if lv > 1 then
				return 0
			end			
		elseif p == VK_SPACE or p == VK_RETURN then
			if main[current][4] == 1 then
				return main[current][1]
			end
		elseif p == VK_LEFT then
			current = current - 1
			if current < 1 then
				current = current + num
			end				
		elseif p == VK_RIGHT then
			current = current + 1	
			if current > num then
				current = current - num
			end							
		end		
	end
end

function YC_MC()
	if JY.GOLD < 500 then
		QZXS("���ϵ�����������")
		do return end
	end	
  Cls(nil, nil, nil, nil, 1) 
  local md = JYMsgBox("��վ", CC.s60, {"ʹ����", "��������"}, 2, 119)
  if md == 1 then		
	local r = SelectSceneMenu(24, 24)	
	if r > 0 and JY.Scene[r - 1]["��������"] == 0 and JY.SubScene ~= 25 and r ~= 84 and r ~= 83 and r ~= 81 and r ~= 82 then		
		instruct_2(174, -500)
		JY.Status = GAME_SMAP
		YC_Status(1)
		Auto_SaveRecord()
		JY.SubScene = r - 1
		local ss = JY.SubScene
		while JY.Scene[ss]["�⾰���X1"] == 0 and JY.Scene[ss]["�⾰���Y1"] == 0 do
			ss = JY.Scene[ss]["��ת����"]
		end
		JY.Base["��X"] = JY.Scene[ss]["�⾰���X1"]
		JY.Base["��Y"] = JY.Scene[ss]["�⾰���Y1"]
		if JY.Scene[JY.SubScene]["�⾰���X1"] == 0 and JY.Scene[JY.SubScene]["�⾰���Y1"] == 0 then
			JY.Base["��X1"] = JY.Scene[JY.SubScene]["��ת��X2"]
			JY.Base["��Y1"] = JY.Scene[JY.SubScene]["��ת��Y2"]
		else
			JY.Base["��X1"] = JY.Scene[JY.SubScene]["���X"]
			JY.Base["��Y1"] = JY.Scene[JY.SubScene]["���Y"]
		end
		Init_SMap(1)
		JY.Base["����"] = 70
		addtime2(1)	
		return 1
	elseif r <= 0 then
		return 0
	else
		say(CC.s63, 119, 5, CC.s64)
	end
  elseif md == 2 then
	return 0
  else
	return 0
  end
end

function YC_Status(a)
	if a == nil then		
		local t = GetS(0, 10, 0, 0)
		if t < 0 then t = 0 end
		--return t
		return 1
	else
		SetS(0, 10, 0, 0, a)
	end
end

function YC_Exit()
	JY.Status = GAME_YC
	dark()
	JY.SubScene = 70
	JY.Base["��X1"] = 8
	JY.Base["��Y1"] = 28
	JY.Base["��X"] = 358
	JY.Base["��Y"] = 235
	JY.MyPic = GetMyPic()	
	lib.PicInit()
	CleanMemory()
	Init_SMap(0)
	addtime2(1)
	JY.MmapMusic = -1
	YC_Status(0)	
	light()
	--tb("���ڻص�����")
	--YC_Main()
end

function vtb(s, x, y, color, size)
	if color == nil then color = C_GOLD end
	if size == nil then size = 30 end
	local ll = #s
	if x == nil or x == -1 then
		x = (CC.ScreenW-size-2*CC.MenuBorderPixel)/2
	end
	if y == nil or y == -1 then
        y=(CC.ScreenH-size/2*#s-2*CC.MenuBorderPixel)/2
	end	
	local len = string.len(s)
	if len <= 2 then
		tb2(s, x, y, color, size)
		return
	end
	local count = 0
	for i = 1, len - 1, 2 do
		DrawString(x, y + (count * (size)), string.sub(s, i, i + 1), color, size)
		count = count + 1
	end
end

function YC_Display()
	local str = "��"..JY.MONTH.."��"..JY.DAY.."�������޴��·���"
	if CC.SuiName ~= "" then
		str = "��"..JY.MONTH.."��"..JY.DAY.."��".. CC.SuiName.." "..CC.SuiThing.." "..CC.SuiResult 
	end
	lib.Background(0, CC.ScreenH - 20, CC.ScreenW, CC.ScreenH, 128)

	if CC.SuiType == 0 then
		DrawString(10, CC.ScreenH - 20, str, C_WHITE, 20)
	elseif CC.SuiType == 1 then
		DrawString(10, CC.ScreenH - 20, str, C_GOLD, 20)
	end
	DrawString(20,20,"��"..JY.YEAR.."�� "..JY.MONTH.."��"..JY.DAY.."��",C_GOLD,25)	
	DrawString(20,60,JY.Person[0]["����"],C_ORANGE,25)
	DrawString(20,90,"����СϺ��",C_ORANGE,25)
	lib.PicLoadCache(1, gethead(0) * 2, 20 + 178, 2, 1)	
	vtb("���飺���˷ܦ�", 90, 170, C_ORANGE, 30)
	if JY.SubScene >= 0 then
		vtb("�ص㣺��"..JY.Scene[JY.SubScene]["����"].."��", 40, 220, C_GOLD, 30)
	else
		vtb("�ص㣺����ͼ��", 40, 200, C_GOLD, 30)
	end
	local numlist = {"��", "��", "��", "��", "��", "��", "��", "��", "��", [0] = "��"}
	local list = {"�ȼ�", "������", "������", "�Ṧ", "ȭ�ƹ���", "��������", "ˣ������", "�������", "����", "��ѧ��ʶ", "ʵս"}
	local list2 = {"�ȼ�", "����", "����", "�Ṧ", "ȭ��", "����", "ˣ��", "����", "����", "�䳣", "ʵս"}
	for i = 1, #list do 
		local ts = list2[i].."��"..JY.Person[0][list[i]]
		for j = 0, 10 do
			ts = string.gsub(ts, ""..j, numlist[j])
		end
		vtb(ts, 320 + i * 40, 10, C_GOLD, 20)
	end	
end

function YC_Main()	
	local ycstatus = JY.Status
	JY.Status = GAME_YC
	lib.PicLoadFile(CC.YCPicFile[1], CC.YCPicFile[2], 11)
	local function bg(n)
		lib.LoadPicture(CONFIG.PicturePath .. n..".png", -1, -1)
	end
	Cls()
	bg(YC.BG) 
	lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)

	ShowScreen()
	local r = 0
	
	while true do
		lib.PicLoadFile(CC.YCPicFile[1], CC.YCPicFile[2], 11)
		r = YC_Menu(1, 8, 1)

		if r == 1 then
			local r2 = YC_Menu(21, 27, 2)
		elseif r == 2 then
			
		elseif r == 3 then
		
		elseif r == 4 then
			local r2 = YC_Menu(31, 34, 2)
		elseif r == 5 then
			local r2 = YC_Menu(41, 43, 2)
		elseif r == 6 then
			local r2 = YC_Menu(11, 15, 2)
			
			if r2 == 13 then
				YC.BG = "store"
				OEVENTLUA[2003]()
				YC.BG = "home"
			elseif r2 == 14 then
				YC.BG = "scroll"
				local mc = YC_MC()
				YC.BG = "home"
				if mc == 1 then
					break
				end
			elseif r2 == 15 then
				petMenu()			
			end
		elseif r == 7 then		
			JY.Person[zj()]["���˳̶�"] = 0
			JY.Person[zj()]["�ж��̶�"] = 0
			AddPersonAttrib(zj(), "����", math.huge)
			AddPersonAttrib(zj(), "����", math.huge)
			AddPersonAttrib(zj(), "����", math.huge)			
			JY.TL = 100
			addtime2(1)
		elseif r == 8 then
			--MMenu()
			if ycstatus == GAME_YC then
				JY.Status = GAME_SMAP
			else
				JY.Status = ycstatus
			end
			return
		end
	end
	
end	

function checktime(a, b, c)
	if JY.YEAR >= a and JY.MONTH >= b and JY.DAY >= c then
		return true
	end
	return false
end

function timeevent()
	if JY.MONTH == 6 and JY.DAY == 6 and JY.Status ~= GAME_SMAP then
		biwu()
	end
	YC.PET = {3, 2, 1, 1}
	CC.SuiType = 0
	CC.SuiName = ""
	CC.SuiThing = ""
	CC.SuiResult = ""		
	
	for i = 1, #YC.PLOT do

		if YC.PLOT[i][8] == 1 and YC.PLOT[i][1] ~= 0 and JY.YEAR >= YC.PLOT[i][4] and 
			JY.MONTH >= YC.PLOT[i][5] and JY.DAY >= YC.PLOT[i][6] then
			tb(""..i)
			CC.SuiName = YC.PLOT[i][10]
			CC.SuiType = 1
			YC.PLOT[i][8] = 3
			if YCEVENT[YC.PLOT[i][7]] ~= nil then
				YCEVENT[YC.PLOT[i][7]](i)
			end
		elseif YC.PLOT[i][8] == 0 and YC.PLOT[i][1] ~= 0 and JY.YEAR >= YC.PLOT[i][1] and 
			JY.MONTH >= YC.PLOT[i][2] and JY.DAY >= YC.PLOT[i][3] then
			YC.PLOT[i][8] = 1
			if YCEVENT[YC.PLOT[i][7]] ~= nil then
				YCEVENT[YC.PLOT[i][7]](i)
			end			
		end

	end	
	if CC.SuiType == 0 and math.random(100) <= 90 then
		local thing_list = {Talk40010,Talk40011,Talk40012,Talk40013}  
		local sui = math.random(#thing_list)  
		if sui == 3 and math.random(100) <= 50 then
			sui = 0
		end
		if sui == 4 and math.random(100) <= 80 then
			sui = 0
		end		
		if sui ~= 0 then
			thing_list[sui]()		
		end
	end
end

function timeevent() --mark, suited for non-yc
	if JY.MONTH == 6 and JY.DAY == 6 and JY.Status ~= GAME_SMAP then
		biwu()
	end
	--YC.PET = {3, 2, 1, 1}
	
	CC.SuiType = 0
	CC.SuiName = ""
	CC.SuiThing = ""
	CC.SuiResult = ""		
	
	if JY.RANDOM == 0 and JY.Status == GAME_MMAP then
		if CC.SuiType == 0 and math.random(100) <= 90 then
			local thing_list = {Talk40010,Talk40011,Talk40012,Talk40013}  
			local sui = math.random(#thing_list)  
			if sui == 3 and math.random(100) <= 50 then
				sui = 0
			end
			if sui == 4 and math.random(100) <= 80 then
				sui = 0
			end		
			if sui ~= 0 then
				thing_list[sui]()		
			end
		end
	end
end


function YC_Ani(a)
	for i = 1, 8 do
	Cls()
	lib.LoadPicture(CONFIG.PicturePath .. a..i..".png", -1, -1)
	ShowScreen()
	lib.Delay(60)
	if i == 8 and a == "w" then
		for j = 7, 8 do
			Cls()
			lib.LoadPicture(CONFIG.PicturePath .. a..j..".png", -1, -1)
			ShowScreen()	
			lib.Delay(150) 
		end
	end
	end
end

function YC_Rest(a)
	if a == nil then a = 1 end
	dark()
	for i = 1, CC.TeamNum do
		local id = JY.Base["����" .. i]
		if id >= 0 then
			JY.Person[id]["���˳̶�"] = 0
			JY.Person[id]["�ж��̶�"] = 0
			AddPersonAttrib(id, "����", math.huge)
			AddPersonAttrib(id, "����", math.huge)
			AddPersonAttrib(id, "����", math.huge)
		end
	end			
	JY.TL = limitX(JY.TL + math.random(20, 50) * a, 0, 100)
	addtime2(a)
	light()
	tb("�µ�һ�쿪ʼ��")
end

function GetThingPerson() --�������¼�����
    local pid = math.random(1, JY.PersonNum - 1)
    while true do
		if not xiaobin(pid) and JY.Person[pid]["����"] > 1 and not inteam(pid) and not duiyou(pid) then --�������ǣ����Ѳ������������
			break 
		end
		pid = math.random(1, JY.PersonNum - 1)
	end	
    return pid
end

function Talk40010() --NPC�����������������ֵ  
  local tid = GetThingPerson()  
  local tid_name = JY.Person[tid]["����"]
  
  local word = {"ͻ����ѧ��","�����߻���ħ"}  
  local change_word = {"����","����"}
  local number_word = {"��������","��������"}
  local sui = math.random(2)  
  local sui_target = math.random(2)
  local number = 0
  if number_word[sui_target] == "��������" then
     number = math.random(math.ceil(JY.Person[tid]["�������ֵ"] / 10) + 20)
	 if change_word[sui] == "����" then number = -number end
	 AddPersonAttrib(tid, "�������ֵ", number)
	 JY.Person[tid]["����"] = JY.Person[tid]["�������ֵ"]
  elseif number_word[sui_target] == "��������" then
     number = math.random(math.ceil(JY.Person[tid]["�������ֵ"] / 8) + 40)
	 if change_word[sui] == "����" then number = -number end
	 AddPersonAttrib(tid, "�������ֵ", number)
	 JY.Person[tid]["����"] = JY.Person[tid]["�������ֵ"]  
  end 
  if number < 0 then number = -number end  
  CC.SuiName = JY.Person[tid]["����"]
  CC.SuiThing = string.format("%s",word[sui])
  CC.SuiResult = string.format("%s".."%s%d",number_word[sui_target],change_word[sui],number)
  return true
end

function Talk40011() --NPC���������������������Ṧ  
  local tid = GetThingPerson() 
  local tid_name = JY.Person[tid]["����"]
  
  local word = {"�������","���ݶ���"}  
  local change_word = {"����","����"}
  local number_word = {"������","������","�Ṧ"}  
  local sui_fu = math.random(2)
  local sui_target = math.random(3)
  
  local number
  if number_word[sui_target] == "������" then
     number = math.random(math.ceil(JY.Person[tid]["������"] / 8) + 5)
	 if change_word[sui_fu] == "����" then number = -number end
     AddPersonAttrib(tid, "������", number)	 	 
  elseif number_word[sui_target] == "������" then
     number = math.random(math.ceil(JY.Person[tid]["������"] / 8) + 5)
	 if change_word[sui_fu] == "����" then number = -number end
	 AddPersonAttrib(tid, "������", number)	 
  elseif number_word[sui_target] == "�Ṧ" then
     number = math.random(math.ceil(JY.Person[tid]["�Ṧ"] / 8) + 5)
	 if change_word[sui_fu] == "����" then number = -number end
	 AddPersonAttrib(tid, "�Ṧ", number) 	 
  end  
  if number < 0 then number = -number end  
    
  CC.SuiName = JY.Person[tid]["����"]
  CC.SuiThing = string.format("%s",word[sui_fu])
  CC.SuiResult = string.format("%s".."%s%d��",number_word[sui_target],change_word[sui_fu],number)
  return true
end

function Talk40012() --NPC����书  
  local tid = GetThingPerson()   
  local tid_name = JY.Person[tid]["����"] 

  local word = {"�չسɹ�","��Դ���"}   
  local sui = math.random(#word) 
  local wugong = math.random(JY.WugongNum - 1)
  while true do
	  if PersonKF(tid, wugong) or wugong == 91 or (wugong >= 109 and wugong <= 113) or wugong == 122 then
		wugong = math.random(JY.WugongNum - 1)
	  else
		break
	  end
  end
  local function GetBlankWugong(enid)
     for i = 1,10 do
	    if JY.Person[enid]["�书" .. i] <= 0 then			
		   return i
		end
	 end
	 return false
  end
  
  local place = GetBlankWugong(tid)
  if not place then 
    return false
  else 
    JY.Person[tid]["�书"..place] = wugong
    JY.Person[tid]["�书�ȼ�"..place] = 999
  end
  
  CC.SuiName = JY.Person[tid]["����"]
  CC.SuiThing = string.format("%s",word[sui])
  CC.SuiResult = string.format("�����%s",JY.Wugong[wugong]["����"])  
  return true
end

function Talk40013() --NPC��������ֵ  
  local tid = GetThingPerson()   
  local tid_name = JY.Person[tid]["����"]
  
  local word = {"�̿��ù� �����ջ�","�������� �����½�"}  
  local change_word = {"����","����"}
  local number_word = {"ȭ�ƹ���","��������","ˣ������","�������", "��������"}  
  local sui = math.random(2)
  local sui_target = math.random(5)
  
  local number
  if number_word[sui_target] == "ȭ�ƹ���" then
     number = math.random(math.ceil(JY.Person[tid]["ȭ�ƹ���"] / 3) + 1)
	 if change_word[sui] == "����" then number = -number end
     AddPersonAttrib(tid, "ȭ�ƹ���", number)	 	 
  elseif number_word[sui_target] == "��������" then
     number = math.random(math.ceil(JY.Person[tid]["��������"] / 3) + 1)
	 if change_word[sui] == "����" then number = -number end
	 AddPersonAttrib(tid, "��������", number)	 
  elseif number_word[sui_target] == "ˣ������" then
     number = math.random(math.ceil(JY.Person[tid]["ˣ������"] / 3) + 1)
	 if change_word[sui] == "����" then number = -number end
	 AddPersonAttrib(tid, "ˣ������", number) 	 
  elseif number_word[sui_target] == "�������" then
     number = math.random(math.ceil(JY.Person[tid]["�������"] / 3) + 1)
	 if change_word[sui] == "����" then number = -number end
	 AddPersonAttrib(tid, "�������", number)		 
  elseif number_word[sui_target] == "��������" then
     number = math.random(math.ceil(JY.Person[tid]["��������"] / 3) + 1)
	 if change_word[sui] == "����" then number = -number end
	 AddPersonAttrib(tid, "��������", number)		 
  end  
  if number < 0 then number = -number end  
    
  CC.SuiName = JY.Person[tid]["����"]
  CC.SuiThing = string.format("%s",word[sui])
  CC.SuiResult = string.format("%s".."%s%d��",number_word[sui_target],change_word[sui],number)
  return true
end

function haogan(pid, a)
	if a ~= nil then
		if JY.Person[pid]["�Ѻö�"] == -1 then
			JY.Person[pid]["�Ѻö�"] = limitX(a, 0, 100)
		elseif a == 100 then
			JY.Person[pid]["�Ѻö�"] = 100
		else
			if JY.Person[pid]["�Ѻö�"] < 100 then
				JY.Person[pid]["�Ѻö�"] = limitX(JY.Person[pid]["�Ѻö�"] + a, 0, 90)
			end
		end
	else
		return limitX(JY.Person[pid]["�Ѻö�"], 0, 100)
	end
end

function haogan2(pid)
	local str = {"����", "����", "����", "��ʶ", "��֪", "�˽�", "����", "����", "֪��", "����", "�ж�"}
	local h = haogan(pid)
	if h < 0 then
		return "İ��"
	else
		h = math.modf(h / 10)
		return str[h]
	end
end

function YC_Plot()

end

YCEVENT = {}

YCEVENT[1] = function()

end

YCEVENT[2] = function()

end

YCEVENT[3] = function()

end

YCEVENT[4] = function()

end