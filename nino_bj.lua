local first = 598
local last = 604

 --����4�ֽڣ��ʽ�4�ֽڣ���ʦ����4�ֽڣ�����4�ֽڣ������������ɹ�����ʧ����
function savebj(r)
	local data = Byte.create(10 * 4)
	Byte.set32(data, 0, limitX(BJ.fame, 0, 500))	
	Byte.set32(data, 4, limitX(BJ.cash, 0, 100000))	
	Byte.set32(data, 8, limitX(BJ.bouncer, 0, 10))	
	Byte.set32(data, 12, BJ.team)	
	Byte.set32(data, 16, BJ.total)
	Byte.set32(data, 20, BJ.win)
	Byte.set32(data, 24, BJ.lose)
	Byte.savefile(data, '.\\data\\SAVE\\bjdata'..r, 0, 10 * 4)
end

function loadbj(r)
	local data = Byte.create(10 * 4)
	Byte.loadfile(data, '.\\data\\SAVE\\bjdata'..r, 0, 10 * 4)
	BJ.fame = limitX(Byte.get32(data, 0), 0, 500)
	BJ.cash = limitX(Byte.get32(data, 4), 0, 100000)
	BJ.bouncer = limitX(Byte.get32(data, 8), 0, 8)
	BJ.team = Byte.get32(data, 12)
	BJ.total = limitX(Byte.get32(data, 16), 0, 10000)
	BJ.win = limitX(Byte.get32(data, 20), 0, 10000)
	BJ.lose = limitX(Byte.get32(data, 24), 0, 10000)
end

function tb(s)
	DrawStrBoxWaitKey(s, C_GOLD, 30)
end

OEVENTLUA[3000] = function() --�ھֿ���
	if JY.GOLD <= 20000 then --����Ҫ��
		do return end
	end
	Cls()
	say("����������һʱ���ھ֣����ȴҲ��ȥ¥�ա�����������������֪��")
	Cls()
	say("��ټ��ĵط�������Ҳ���˷ѣ���������������ӪҲ�á�")
	addevent(-2, -2, 0, 0, 0)
	if yesno("Ҫ��Ӫ�ھ���") == false then						
		do return end
	end		
	Cls()
	say("�ȹͼ�����ƴ���һ���ھ�����ɡ�")
	dark()
	addevent(-2, 21, 1, 3001, 1, 6094)
	addevent(-2, 22, 1, 3002, 1, 6092)
	addevent(-2, 23, 1, 3003, 1, 6092)
	light()
	instruct_2(174, -20000)
	addtime(20)
	resetbj()
	BJ.cash = 10000
	local pid
	local name = {"�����", "�ֱ���", "����ɽ"}
	for i = 1, #name do
		pid = freespot()
		generate(pid)
		JY.Person[pid]["����"] = name[i]
		hire(pid)
	end
	Cls()
	say("æµ��������£����ڿ��Կ����ˡ�")		
end
	
OEVENTLUA[3001] = function()
	Cls()
	say("ͷ���������������£�",220,0,"��ͷ") 
	local r = JYMsgBox("�����ھ�", "�����������ʽ������ȼ�*���䣺�����ʽ������书*��ʦ���쿴��ʦ״̬", {"����", "����", "��ʦ", "ȡ��"}, 4, 220)	
	if r <= 0 then
		do return end
	end
	if r == 1 then
		if BJ.cash < 2000 then
			Cls()
			say("�ʽ𲻹��ˡ�",220,0,"��ͷ") 	
			do return end
		end
		local pid = selectteam()
		Cls()
		ShowPersonStatus_sub(pid, 1)
		ShowScreen()
		lib.Delay(500)
		WaitKey()
		Cls()
		if yesno("��ʼ��") == false then
			do return end
		end			
		BJ.cash = BJ.cash - 2000
		tb("�ھ��ʽ����2000��")
		dark()
		light()
		JY.Person[pid]["����"] = JY.Person[pid]["����"] + math.random(1000, JY.Person[pid]["����"] * 1000)
		War_AddPersonLVUP(pid)	
		addtime(1)			
	elseif r == 2 then
		if BJ.cash < 1000 then
			Cls()
			say("�ʽ𲻹��ˡ�",220,0,"��ͷ") 	
			do return end
		end	
		local pid = selectteam()
		Cls()
		ShowPersonStatus_sub(pid, 1)
		ShowScreen()
		lib.Delay(500)
		WaitKey()
		Cls()		
		local thing = DIY_Menu_Thing(4, pid)	
		if thing ~= 1 then
			do return end
		end	
		if yesno("��ʼ��") == false then
			do return end
		end
		BJ.cash = BJ.cash - 1000
		tb("�ھ��ʽ����1000��")
		dark()
		light()
		JY.Person[pid]["��������"] = JY.Person[pid]["��������"] + math.random(800, JY.Person[pid]["����"] * 800)
		War_PersonTrainBook(pid)
		addtime(1)		
	elseif r == 3 then
		if BJ.bouncer == 0 then
			Cls()
			say("�ھ��ﻹû��Ƹ����ʦ��",220,0,"�˷�") 	
			do return end
		end
		bsstatus()		
	end
	
end

function jiebiao()

end

OEVENTLUA[3002] = function()
	Cls()
	say("ͷ����ɶ�Ը���",220,0,"�˷�") 
	local r = JYMsgBox("�����ھ�", "���ڣ���������*״̬���鿴�ھ�״̬*��ʦ���쿴��ʦ״̬*ȡǮ���ӿⷿȡǮ", {"����", "״̬", "��ʦ", "ȡǮ", "ȡ��"}, 5, 220)	
	if r <= 0 then
		do return end
	end
	if r == 1 then
	
	elseif r == 2 then
		bjstatus()
		lib.Delay(500)
		WaitKey()
	elseif r == 3 then
		if BJ.bouncer == 0 then
			Cls()
			say("�ھ��ﻹû��Ƹ����ʦ��",220,0,"�˷�") 	
			do return end
		end
		bsstatus()		
	elseif r == 4 then
		if BJ.cash <= 10000 then
			Cls()
			say("�ⷿ���Ǯ�����ˣ�Ӫ���ʽ��ǲ�Ҫ���ĺá�",220,0,"�˷�") 	
			do return end			
		end
		local difference = limitX((BJ.cash - 10000), 0, math.min(32000 - JY.GOLD, BJ.cash - 10000))
		BJ.cash = BJ.cash - difference
		instruct_2(174, difference)		
	end
end

OEVENTLUA[3003] = function()
	local pid = freespot()
	say("ͷ��������ֵ���Խ��Խ�иɾ��ˡ�",220,0,"��ʦ") 	
	Cls()
	local r = JYMsgBox("�����ھ�", "Ƹ�룺Ƹ��������ʿ*���䣺����Ѽ��뱣��*��ͣ������ʦ", {"Ƹ��", "����", "���", "ȡ��"}, 4, 220)
	if r <= 0 then 
		do return end
	end
	if r == 1 then	
		if pid == -1 or BJ.bouncer >= (last - first + 1) then
			Cls()
			say("�����ھ��Ѿ����㹻�������ˡ�",220,0,"��ʦ") 	
			do return end
		end
		if BJ.cash < 5000 then
			Cls()
			say("����ھ���ͷ�е�������������ˡ�",220,0,"��ʦ") 	
			do return end		
		end		
		say("���ҿ���....",220,0,"��ʦ") 	
		Cls()
		say("�����һλ����ӦƸ���ˡ��������ɶ�������ţ�",220,0,"��ʦ") 	
		generate(pid)
		Cls()
		say("�ҽ�......",JY.Person[pid]["ͷ�����"],0,"������") 	
		JY.Person[pid]["����"] = "";
		while JY.Person[pid]["����"] == "" do
			JY.Person[pid]["����"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[pid]["����"] == "" then
				DrawStrBoxWaitKey("���ڽ���Ư������û���֡�", C_WHITE, 30)
			end
		end
		Cls()
		ShowPersonStatus_sub(pid, 1)
		ShowScreen()
		lib.Delay(500)	
		local keyPress = WaitKey()			
		Cls()
		say("ͷ���������ϲ����⣿",220,0,"��ʦ") 	
		if yesno("ҪƸ����") == false then
			Cls()
			say("�����𣿺ðɣ���λ��������ı�߾Ͱɡ�",220,0,"��ʦ") 		
			Cls()
			say("�����ң��������ʧ��",JY.Person[pid]["ͷ�����"],0,JY.Person[pid]["����"]) 	
			do return end
		end
		Cls()
		say("���֣�����ͽ��˰�æ��������ʹ�ɨ���䣬��ӭ�»�ƣ�",220,0,"��ʦ") 	
		Cls()
		say("лл���Ҳ�������ʧ���ģ�",JY.Person[pid]["ͷ�����"],0,JY.Person[pid]["����"]) 
		Cls()
		BJ.cash = BJ.cash - 5000
		tb("�ھ��ʽ����5000��")
		hire(pid)
		addtime(1)
	elseif r == 2 then
		--[[Cls()
		say("�ھ�����ʱ������Ҫ���䡣",220,0,"��ʦ") 			
		do return end]]
		if BJ.team ~= 0 then
			Cls()
			say("���ڵĿ�����"..JY.Person[BJ.team]["����"].."��ͷ�����뻻����",220,0,"��ʦ") 	
			Cls()
			if yesno("�����䣿") == false then
				do return end
			end
		end		
		Cls()
		local pid = selectdy()
		if pid == -1 then
			Cls()
			say("ͷ����û�д���������",220,0,"��ʦ") 			
			do return end			
		end

		instruct_21(pid)
		if BJ.team ~= 0 then
			instruct_10(BJ.team)
		end
		hire(pid)
		BJ.team = pid
		tb(JY.Person[pid]["����"].."��Ϊ�ھֿ���")
	elseif r == 3 then
		if BJ.bouncer < 1 then
			Cls()
			say("�ھ��ﻹû��Ƹ����ʦ��",220,0,"��ʦ") 	
			do return end
		end
		Cls()
		say("ͷ��������λ�ֵܲ����⣿",220,0,"��ʦ") 	
		local pid = selectteam()
		Cls()
		ShowPersonStatus_sub(pid, 1)
		ShowScreen()
		lib.Delay(500)
		WaitKey()
		Cls()
		say("ͷ��������˼����",220,0,"��ʦ") 
		if yesno("��ʹ��ˣ�") == false then
			Cls()
			say("û�¾ͺá��治ϣ�������ֵ��뿪����",220,0,"��ʦ") 	
			do return end
		else
			Cls()
			say("�ðɣ��һ����λ�ֵܽ��͵ġ�",220,0,"��ʦ") 
			layoff(pid)
			BJ.fame = limitX(BJ.fame - 10, 0, 500)
		end			
	end		
end

function resetbj()
	for i = first, last do		
		layoff(i)
	end
	BJ.fame = 0
	BJ.cash = 0
	BJ.bouncer = 0
	BJ.team = 0
	BJ.total = 0
	BJ.win = 0
	BJ.lose = 0  
	--savebj()
end

function freespot()
	local value = -1
	for i = first, last do		
		if JY.Person[i]["USE"] == 0 then			
			value = i
			break
		end
	end
	return value
end

function bonus(jl)
	jl = jl + math.modf(BJ.fame / 50)
	if math.random(100) <= jl then
		return true
	end
	return false
end

function bjfight(pid, p)
	if (pid >= first and pid <= last) and BJ.team == p and BJ.fame >= 200 then
		return true
	end
	return false
end

function generate(pid)
	local r = math.random(1, 496)
	while (r >= 311 and r <= 319) or (r >= 410 and r <= 440) do
		r = math.random(1, 496)
	end
	JY.Person[pid]["�ȼ�"] = math.random(5)
	JY.Person[pid]["����"] = 0
	JY.Person[pid]["��������"] = math.random(0, 2)
	JY.Person[pid]["�Ա�"] = JY.Person[r]["�Ա�"]
	JY.Person[pid]["ͷ�����"] = JY.Person[r]["ͷ�����"]
	JY.Person[pid]["��������"] = JY.Person[r]["��������"]	
	JY.Person[pid]["�������ֵ"] = math.random(100, 500)
	JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"]
	JY.Person[pid]["�������ֵ"] = math.random(100, 1000)
	JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"]
	JY.Person[pid]["������"] = math.random(20, 50) + math.modf(BJ.fame / 25)
	JY.Person[pid]["������"] = math.random(20, 50) + math.modf(BJ.fame / 25)
	JY.Person[pid]["�Ṧ"] = math.random(20, 50) + math.modf(BJ.fame / 25)
	if bonus(20) then
		JY.Person[pid]["��������"] = math.random(10, 50)
	end
	if bonus(15) then
		JY.Person[pid]["��ѧ��ʶ"] = math.random(10, 30)
	end
	if bonus(20) then
		JY.Person[pid]["ҽ������"] = math.random(25, 60)
		JY.Person[pid]["�ⶾ����"] = math.random(25, 60)
	end
	if bonus(20) then
		JY.Person[pid]["�ö�����"] = math.random(25, 60)
		JY.Person[pid]["�ⶾ����"] = math.random(25, 60)
	end
	if bonus(25) then
		JY.Person[pid]["��������"] = math.random(10, 50)
	end
	JY.Person[pid]["ȭ�ƹ���"] = math.random(20, 70) + math.modf(BJ.fame / 25)
	JY.Person[pid]["��������"] = math.random(20, 70) + math.modf(BJ.fame / 25)
	JY.Person[pid]["ˣ������"] = math.random(20, 70) + math.modf(BJ.fame / 25)
	JY.Person[pid]["�������"] = math.random(20, 70) + math.modf(BJ.fame / 25)
	JY.Person[pid]["��������"] = math.random(10, 100) + math.modf(BJ.fame / 25)
	for i = 1, 5 do
		JY.Person[pid]["���ж���֡��" .. i] = JY.Person[r]["���ж���֡��" .. i]
		JY.Person[pid]["���ж����ӳ�" .. i] = JY.Person[r]["���ж����ӳ�" .. i]
		JY.Person[pid]["�书��Ч�ӳ�" .. i] = JY.Person[r]["�书��Ч�ӳ�" .. i]
	end		
	JY.Person[pid]["����"] = math.random(1, 100)
	JY.Person[pid]["���һ���"] = 0
	if JY.Person[pid]["����"] <= 70 and bonus(20) then
		JY.Person[pid]["���һ���"] = 1
	end
	JY.Person[pid]["����"] = 0
	JoinMP(pid, 0, 0)
	if bonus(10) then
		local nglist = {6,89,90,92,93,94,95,96,97,98,99,121,124,150,151,152,153,178}
		local nglist2 = {100,101,102,103,104,105,106,107,108,180}
		if bonus(20) then
			JY.Person[pid]["����"] = nglist2[math.random(#nglist2)]
		else
			JY.Person[pid]["����"] = nglist[math.random(#nglist)]
		end
	end
	if bonus(10) then
		JoinMP(pid, math.random(#CC.MP), 1)
	end	
	local aa = 1 + math.modf(BJ.fame / 100) 
	local bb = 5 + math.modf(BJ.fame / 100) 
	local thing = randomwugong2(aa, bb)
	JY.Person[pid]["�书1"] = JY.Thing[thing]["�����书"]	
	JY.Person[pid]["�书�ȼ�1"] = 999
	if BJ.fame > 50 then
		JY.Person[pid]["ʵս"] = math.random(BJ.fame)
	end
end

function hire(pid)
	JY.Person[pid]["USE"] = 1 
	BJ.bouncer = BJ.bouncer + 1
end

function layoff(pid)
	JY.Person[pid]["USE"] = 0
	BJ.bouncer = BJ.bouncer - 1
end

function bjstatus()
	local size = CC.DefaultFont
	local width = 13 * size 
	local h = size + CC.PersonStateRowPixel
	local height = 8 * h 
	local dx = (CC.ScreenW - width) / 2
	local dy = (CC.ScreenH - height) / 2
	local i = 1  
	Cls()
	--lib.LoadPicture(CC.STA, -1, -1)
	DrawBox(dx, dy, CC.ScreenW - dx, CC.ScreenH - dy, C_WHITE)
	DrawString(math.modf((CC.ScreenW - dx)/2) + size, dy, "�ھ���״", C_GOLD, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "����", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, ""..BJ.fame, M_Wheat, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "����", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, ""..BJ.cash, M_Wheat, size)	
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "����", C_ORANGE, size)
	if BJ.team == 0 then
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size - 5, dy + h * i, "��", M_Wheat, size)		
	else
		DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size - 5, dy + h * i, JY.Person[BJ.team]["����"], M_Wheat, size)		
	end
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "��ʦ��", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, ""..BJ.bouncer, M_Wheat, size)	
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "���ڴ���", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, ""..BJ.total, M_Wheat, size)	
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "�ɹ���", C_ORANGE, size)
	local tmp = 0
	if BJ.total > 0 then
		tmp = math.modf(BJ.win/BJ.total)
	end
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, tmp.."��", M_Wheat, size)		
	i = i + 1
	local tmp = 0
	if BJ.total > 0 then
		tmp = math.modf(BJ.lose/BJ.total)
	end	
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "ʧ����", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, tmp.."��", M_Wheat, size)			
	ShowScreen()
end

function selectteam()
	local menu = {}
	for i = 1, (last - first + 1) do
		menu[i] = {"", nil, 0, nil}
		if JY.Person[first - 1 + i]["USE"] > 0 then
			menu[i][1] = JY.Person[first - 1 + i]["����"]
			menu[i][3] = 1
			menu[i][4] = first - 1 + i
		end
	end	
	local r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"��ʦ�б�","",M_DimGray,C_RED)
	if r <= 0 then
		return -1
	end
	return menu[r][4]
end

function selectdy()
	local menu = {}
	local num = 0
	for i = 2, CC.TeamNum do
		if JY.Base["����" .. i] > 0 then
			local pid = JY.Base["����" .. i]
			num = num + 1
			menu[num] = {JY.Person[pid]["����"], nil, 1, pid}
		end
	end
	if num == 0 then
		return -1
	end
	local r = ShowMenu3(menu,num,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"�����б�","",M_DimGray,C_RED)
	if r <= 0 then
		return -1
	end
	return menu[r][4]
end

function bsstatus()
	local menu = {};
	local list = {}
	local page = 1
	for i = 1, (last - first + 1) do
		if JY.Person[first - 1 + i]["USE"] > 0 then
			menu[#menu + 1] = {JY.Person[first - 1 + i]["����"], nil, 1}
			list[#list + 1] = first - 1 + i
		end
	end	
	if BJ.team ~= 0 then
		menu[#menu + 1] = {JY.Person[BJ.team]["����"], nil, 1, BJ.team}
		list[#list + 1] = BJ.team
	end
	local r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,"��ʦ�б�",nil,M_DimGray,C_RED)
	if r < 1 then
		return
	end
	local id = list[r] 
	while true do
		Cls()
		page = limitX(page, 1, 2)

		if page == 1 then
			ShowPersonStatus_sub(list[r], page)
		elseif page == 2 then
			page = NLJS(list[r], page)
			if page == -1 then
				break
			end
			Cls()
			ShowPersonStatus_sub(list[r], page)
			ShowScreen()
		else
			ShowPersonStatus_sub(list[r], page)
		end	
		ShowScreen();
		local keypress = WaitKey()
		if keypress == VK_LEFT then
	  		page = page - 1;
   		elseif keypress == VK_RIGHT then
	  		page = page + 1;
	  	elseif keypress == VK_UP then
	  		r = r - 1
	  	elseif keypress == VK_DOWN then
	  		r = r + 1
		elseif keypress == 27 then
	  		break
		end
		if r < 1 then
			r = 1
		end
		if r > #list then
			r = #list
		end
	end
end

function DIY_Menu_Thing(flag, pid)
  local menu = {
{"ȫ����Ʒ", nil, 1}, 
{"������Ʒ", nil, 1}, 
{"�������", nil, 1}, 
{"�书����", nil, 1}, 
{"�鵤��ҩ", nil, 1}, 
{"���˰���", nil, 1}}
	local r
	if flag ~= nil then
		r = flag
	else
		r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
	end
 if r > 0 then
    local thing = {}
    local thingnum = {}
    for i = 0, CC.MyThingNum - 1 do
      thing[i] = -1
      thingnum[i] = 0
    end
    local num = 0
    for i = 0, CC.MyThingNum - 1 do
      local id = JY.Base["��Ʒ" .. i + 1]
      if id >= 0 then
        if r == 1 then
          thing[i] = id
          thingnum[i] = JY.Base["��Ʒ����" .. i + 1]
        else
	        if JY.Thing[id]["����"] == r - 2 then
	          thing[num] = id
	          thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
	          num = num + 1
	        end
      	end
      end 
    end
    local r = SelectThing(thing, thingnum)
    --[[if r > 236 then
      OVERZB()
    end]]
    if r >= 0 then   	
    	return DIYUseThing(r, pid)
  	end
  end
  return 0
end

function DIYUseThing(id, pid)
	Cls()
	local r
	if pid == nil then
		r = selectteam()
	else
		r = pid
	end
  if r > 0 then
    local personid = r
    local yes, full = nil, nil
    if JY.Thing[id]["�����书"] >= 0 then
      yes = 0
      full = 1
      for i = 1, 10 do
        if JY.Person[personid]["�书" .. i] == JY.Thing[id]["�����书"] then
          yes = 1
        else
          if JY.Person[personid]["�书" .. i] == 0 then
            full = 0
          end
        end
      end
    end
    
    --��������
    if CC.Shemale[id] == 1 then
		if JY.Person[personid]["�Ա�"] == 0 and CanUseThing(id, personid) then
			Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
			if DrawStrBoxYesNo(-1, -1, CC.EVB147, C_WHITE, CC.DefaultFont) == false then
			  return 0
			else
				lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
				ShowScreen()
				lib.Delay(80)
				lib.ShowSlow(15, 1)
				Cls()
				lib.ShowSlow(100, 0)
				JY.Person[personid]["�Ա�"] = 2
				local add, str = AddPersonAttrib(personid, "������", -25)
				DrawStrBoxWaitKey(JY.Person[personid]["����"] .. str, C_ORANGE, CC.DefaultFont)
				add, str = AddPersonAttrib(personid, "������", -35)
				DrawStrBoxWaitKey(JY.Person[personid]["����"] .. str, C_ORANGE, CC.DefaultFont)
			  end
		elseif JY.Person[personid]["�Ա�"] == 1 then
			DrawStrBoxWaitKey(CC.EVB148, C_WHITE, CC.DefaultFont)
			return 0
		end
    end
    
    if yes == 1 or CanUseThing(id, personid) or yes == 2 then
		if yes == 0 and full == 1 then
			if GetS(4, 7, 7, 5) == 0 then
				DrawStrBoxWaitKey(CC.EVB142, C_WHITE, CC.DefaultFont)
			else
				DrawStrBoxWaitKey(CC.EVB142, C_WHITE, CC.DefaultFont)
			end
			Cls();
			return 0
		end	 
		JY.Person[personid]["������Ʒ"] = id
		JY.Person[personid]["��Ʒ��������"] = 0
    else
    	DrawStrBoxWaitKey("���˲��ʺ���������Ʒ", C_WHITE, CC.DefaultFont)
    	return 0
    end
  end
  return 1
end