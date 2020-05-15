--[[
30010 - quest
30015 - gambling
30050 - random stuff

63, 0 - # of random stuff
63, 1 - battle protagonist
63, 2 - battle antagonist

63, 3 - quest type
63, 4 - quest completion status
63, 5 - duel enemy
63, 6 - guard quest destination
63, 7 - #of quests

63, 20 - rumor battle #
63, 21 - rumor battle type
]]

local function randomPD(tt)
	local max = 0
	for i = 1, #tt do
		max = max + tt[i]
	end
	local event = math.random(max)
	local count = 0
	local result = 1
	for i = 1, #tt do
		if event > count and event <= tt[i] + count then
			result = i
			break
		end
		count = tt[i] + count
	end
	return result
end


local function changeattrib(id, str, flag) -- flag 0 - random, 1 - +, 2 - -
	local change = 0
	local word = "����"
	if math.random(50) <= 5 or flag == 2 then
		change = 1
		word = "����"
	end
	if flag == 1 then
		change = 0
		word = "����"
	end
	local number = math.random(0, 10)
	if str == "������" or str == "�Ṧ" or str == "������" then
		number = number + 5
	end
	if change == 1 then
		number = math.modf(number * -1)
	end	
	AddPersonAttrib(id, str, number)
	if id == 0 then
		id = zj()
	end
	return JY.Person[id]["����"].."��"..str..word..math.abs(number).."��"
end

local function conversion (pp)
	if pp == 1 then
		pp = "������"
	elseif pp == 2 then
		pp = "�Ṧ"
	elseif pp == 3 then
		pp = "������"
	elseif pp == 4 then
		pp = "ȭ�ƹ���"
	elseif pp == 5 then
		pp = "��������"
	elseif pp == 6 then
		pp = "ˣ������"
	else
		pp = "�������"
	end
	return pp
end


--[[
63, 3 - quest type 
1 ���� 
2 �ַ�
3 �ỹ 
4 ���� 
5 ����
63, 4 - quest completion status
63, 5 - duel enemy
63, 6 - guard quest destination
63, 7 - #of quests
]]
OEVENTLUA[30010] = function() --������
	if GetS(106, 63, 3, 0) ~= 0 and GetS(106, 63, 4, 0) == 1 then --���
		say("���úã�������ĳ��", 96, 0, "�н���")
		Cls()
		if GetS(106, 63, 3, 0) == 2 then --�ַ�
			local times = math.random(2, 5)
			for i = 1, times do
				if math.random(100) <= 30 then
					addthing(174, math.random(500, 3000))		
				else
					local thing = randomthing()
					addthing(thing, math.random(1, 5))		
				end
			end			
		elseif GetS(106, 63, 3, 0) == 3 then --�ỹ
			local times = math.random(5)
			for i = 1, times do
				if math.random(50) == 1 then
					local thing = randomwugong()
					addthing(thing, 1)						
				elseif math.random(100) <= 20 then
					addthing(174, math.random(200, 1000))		
				else
					local thing = randomthing()
					addthing(thing, math.random(2, 5))		
				end
			end					
		elseif GetS(106, 63, 3, 0) == 5 then --����
			local times = math.random(5)
			for i = 1, times do
				if math.random(100) <= 40 then
					addthing(174, math.random(500, 2000))		
				else
					addthing(210, math.random(20))	
					addthing(209, math.random(20))	
				end
				if math.random(100) <= 30 then
					addthing(math.random(14, 17), math.random(2))
				end
			end			
		end
		SetS(106, 63, 3, 0, 0)
		SetS(106, 63, 4, 0, 0)
		SetS(106, 63, 5, 0, 0)
		SetS(106, 63, 6, 0, 0)	
		do return end
	end
	if GetS(106, 63, 3, 0) == 1 and JY.SubScene == GetS(106, 63, 6, 0) then --��ɱ���
		say("��һ·�����ˣ���������ĳ��", 96, 0, "�н���")
		addthing(174, math.random(500, 5000))	
		for i=1, CC.TeamNum do
			if JY.Base["����"..i] >= 0 then
				AddPersonAttrib(JY.Base["����"..i], "ʵս", 20)
			end
		end	
		QZXS("ȫ�����ʵս����20��");		
		SetS(106, 63, 3, 0, 0)
		SetS(106, 63, 4, 0, 0)
		SetS(106, 63, 5, 0, 0)
		SetS(106, 63, 6, 0, 0)
		do return end
	end
	if GetS(106, 63, 3, 0) ~= 0 then
		say("��ô��������æ�������ģ��Ȱ������ϵ�������ɵ��ɡ�", 96, 0, "�н���")
		do return end
	end
	if GetS(106, 63, 7, 0) > 20 and hasHZ(21) == false then
		say("���ʱ���������Ĵ����ߣ���������ѣ������Ŭ����", 96, 0, "�н���")
		addHZ(21)
		do return end
	end
	if GetS(106, 63, 7, 0) >= math.modf(3 + 3 * tianshu()) then
		say("��ʱû��������㣬�����������ɡ�", 96, 0, "�н���")
		do return end
	end
	Cls()
	local quest = math.random(5)		
	if quest == 1 then
		say("ί������һ���ڼ���������������������������", 96, 0, "�н���")	
		Cls()
		if DrawStrBoxYesNo(-1, -1, "Ҫ������", C_WHITE, 30) == false then		
			do return end
		end
		OEVENTLUA[30013]()				
	elseif quest == 2 then
		say("������ɽ�����񣬹ٸ��������˽����ַ�������������������", 96, 0, "�н���")	
		Cls()
		if DrawStrBoxYesNo(-1, -1, "Ҫ������", C_WHITE, 30) == false then		
			do return end
		end	
		SetS(106, 63, 3, 0, 2)
		Cls()
		say("���Ǿ��ڸ�����ɽ������С�ġ�", 96, 0, "�н���")	
	elseif quest == 3 then
		say("ί���˵Ĵ���֮������֮ǰ���������䣬��������س�������", 96, 0, "�н���")	
		Cls()
		say("ί����ϣ���������ĵذ��������������������������", 96, 0, "�н���")
		Cls()
		if DrawStrBoxYesNo(-1, -1, "Ҫ������", C_WHITE, 30) == false then		
			do return end
		end			
		SetS(106, 63, 3, 0, 3)
		Cls()
		say("�õ��˱����Ǹ���������ڸ������֣����С�ġ�", 96, 0, "�н���")	
	elseif quest == 4 then		
		say("ί��������Լ����������Ծ�������ͻȻ�������ˡ�", 96, 0, "�н���")	
		Cls()
		say("Ϊ���������룬��Ҫһ��������Ӧս������������������", 96, 0, "�н���")	
		if DrawStrBoxYesNo(-1, -1, "Ҫ������", C_WHITE, 30) == false then		
			do return end
		end
		OEVENTLUA[30012]()		
	elseif quest == 5 then
		say("���������Ұ�޺������ˣ��ٸ��������ͳ���������������������", 96, 0, "�н���")	
		Cls()
		if DrawStrBoxYesNo(-1, -1, "Ҫ������", C_WHITE, 30) == false then		
			do return end
		end	
		SetS(106, 63, 3, 0, 5)
		Cls()
		say("Ұ��Ⱥ���ڸ�����ɽ������С�ġ�", 96, 0, "�н���")	
	end
	SetS(106, 63, 7, 0, GetS(106, 63, 7, 0) + 1)
end
--[[
OEVENTLUA[30011] = function() --���ͼ����
	local yes = 0
	if math.random(100) == 100 then
		yes = 1
	end
	if yes == 0 then
		do return end
	end
	if yes == 1 then
		if GetS(106, 63, 3, 0) == 1 then
			Cls()	
			say("��·���ҿ������������ԣ�Ҫ��Ӵ˹���������·�ƣ�", math.random(100, 200), 0, "ɽ��")		
			if WarMain(287) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end			
			light()
			do return end
		elseif GetS(106, 63, 3, 0) == 2 and GetS(106, 63, 4, 0) ~= 1 then
			Cls()	
			say("˭�Ҵ�ɽ��", math.random(100, 200), 0, "ɽ����")	
			Cls()	
			say("��ɽ�������ٷ�������Ͷ����")				
			Cls()	
			say("�����������ǹٸ����������ġ�", math.random(100, 200), 0, "ɽ����")	
			Cls()	
			say("�ֵ����ϣ�", math.random(100, 200), 0, "ɽ����")				
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			SetS(106, 63, 4, 0, 1)	
			light()
			say("���ڽ�����ˡ���ȥ����ɡ�")	
			do return end	
		elseif GetS(106, 63, 3, 0) == 3 and GetS(106, 63, 4, 0) ~= 1 then
			Cls()	
			say("�����ˣ�Ӧ�þ����Ǹ��ˡ���Ȼ�е�Բ�����....����û�취��....")				
			if WarMain(290) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			SetS(106, 63, 4, 0, 1)	
			light()
			say("�����������ˣ���ȥ����ɡ�")	
			do return end				
		elseif GetS(106, 63, 3, 0) == 5 and GetS(106, 63, 4, 0) ~= 1 then
			Cls()	
			say("�������ˣ���Ȼ�ܶ�Ұ�޺��У�")							
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			SetS(106, 63, 4, 0, 1)	
			light()
			say("���ڽ�����ˡ���ȥ����ɡ�")	
			do return end			
		end	
			
	end		
end
]]
OEVENTLUA[30012] = function() --��������	
	Cls()
	local enemy = -1
	while true do
		enemy = math.random(1, 130)
		if not xiaobin(enemy) and not duiyou(enemy) then
			break
		end
	end
	SetS(106, 63, 5, 0, enemy)
	if WarMain(289) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end	
	light()
	Cls()
	say("���úã�������ĳ��", 96, 0, "�н���")
	local times = math.random(5)
	for i = 1, times do
		if math.random(40) == 1 then
			local thing = randomwugong()
			addthing(thing, 1)						
		elseif math.random(100) <= 20 then
			addthing(174, math.random(200, 1000))		
		else
			local thing = randomthing()
			addthing(thing, math.random(2, 5))		
		end
	end			
	AddPersonAttrib(zj(), "ʵս", 15)
	QZXS(JY.Person[zj()]["����"].."ʵս����15�㣡")		
end

OEVENTLUA[30013] = function() --��������
	local list = {1, 3, 40, 60, 61}
	local word = {"�����ջ", "�м��ջ", "������", "���ſ�ջ", "������ջ"}
	local place
	while true do
		place = math.random(#list)
		if list[place] ~= JY.SubScene then
			break
		end
	end
	SetS(106, 63, 6, 0, list[place])
	SetS(106, 63, 3, 0, 1)
	say("����ڰ�ȫ���͵�"..word[place].."�������ˡ�", 96, 0, "�н���")	
end

OEVENTLUA[30014] = function() --��̨
	local pid, eid = -1
	local number = math.random(3)
	say("�����ǽ�������Сվ��һ�н��п��ܣ�����ջ�Ų������Ρ�",220,0,"����վ") 	
	Cls()
	if GetS(106, 63, 20, 0) >= math.modf(5 + 5 * tianshu()) then
		say("�����ʱû��ʲô���ţ�����ʱ�������ɡ�",220,0,"����վ") 	
		do return end
	end	
	local event = math.random(#CC.battle)
	say(CC.battle[event][4],220,0,"����վ") 
	Cls()
	if not inteam(CC.battle[event][2]) then
		do return end
	end
	say("�ף��ѵ�����Ǵ����е��ˣ�",220,0,"����վ") 	
	Cls()
	if DrawStrBoxYesNo(-1, -1, "Ҫ������", C_WHITE, 30) == false then		
		say("�Բ���ԭ���ҿ����ˡ�",220,0,"����վ") 	
		do return end
	end		
	SetS(106, 63, 21, 0, CC.battle[event][1])
	SetS(106, 63, 20, 0, GetS(106, 63, 20, 0) + 1)
	
	pid = CC.battle[event][2]
	eid = CC.battle[event][3]
	local tmp1 = JY.Person[eid]["������"] 	
	local tmp2 = JY.Person[eid]["�Ṧ"]
	local tmp3 = JY.Person[eid]["������"]	
	
	JY.Person[eid]["������"] = math.modf(JY.Person[pid]["������"] * 0.7) + math.random(100)
	JY.Person[eid]["�Ṧ"] = math.modf(JY.Person[pid]["�Ṧ"] * 0.6) + 50
	JY.Person[eid]["������"] = math.modf(JY.Person[pid]["������"] * 0.7) + math.random(100)
	
	if WarMain(291) == false then
		Cls()
		JY.Person[eid]["������"] = tmp1
		JY.Person[eid]["�Ṧ"] = tmp2
		JY.Person[eid]["������"] = tmp3
		light()
		say("���������л�������....",220,0,"����վ") 	
		for i = 1, number do
			local str = math.random(7)
			str = conversion(str)
			QZXS(changeattrib(pid, str, 2))
		end
		do return end
	end
	Cls()
	JY.Person[eid]["������"] = tmp1
	JY.Person[eid]["�Ṧ"] = tmp2
	JY.Person[eid]["������"] = tmp3	
	light()
	for i = 1, number + 1 do
		local str = math.random(7)
		str = conversion(str)
		QZXS(changeattrib(pid, str, 1))
	end	
	Cls()
	say("��ϲ��˳������˴��š�",220,0,"����վ") 		
end

OEVENTLUA[30050] = function() --�����ܻ�
	local pd = math.modf((101 - JY.Person[zj()]["����"]) * 0.1)
	if putong() == 11 then
		pd = pd + 3
	end
	if GetS(106, 63, 0, 0) >= math.modf(pd + 5 + 5 * tianshu()) then
		do return end
	end
	local yes = 0
	if math.random(20) == 5 then
		yes = 1
	end
	if yes == 0 then
		do return end
	end
	if yes == 1 then
		local bonus = tianshu()
		local bonus2 = math.modf((101 - JY.Person[zj()]["����"]) * 0.1)
		local lv = randomPD({10, 9, 8, 7, 6, 5, 4, 3, 2, 1})
		if hasHZ(94) then --getHZ(zj(), 21) or hasTF(zj(), 94) �������ǣ�����BUG
			lv = randomPD({0, 0, 0, 7, 6, 5, 4, 3, 2, 1})
		end
		if putong() == 11 and lv < 5 then
			lv = randomPD({0, 0, 0, 7, 6, 5, 4, 3, 2, 1})
		end
		local prob = {
			{0, 10, 15, 25, 25, 15, 10}, --1
			{0, 15, 10, 25, 25, 10, 15}, --2
			{0, 15, 10, 25, 25, 10, 15}, --3
			{0, 15, 10, 25, 25, 10, 15}, --4
			{0, 20, 10, 20, 20, 10, 20}, --5
			{0, 20, 10, 20, 20, 10, 20}, --6
			{0, 20, 10, 20, 20, 10, 20}, --7
			{0, 25, 10, 15, 15, 10, 25}, --8
			{0, 25, 10, 15, 15, 10, 25}, --9
			{0, 30, 10, 10, 10, 10, 30}, --10
		}
		local qy = randomPD(prob[lv])                                     --math.random(2, 7)                  --randomPD(prob[lv])
		--while qy == 3 do
		--	qy = randomPD(prob[lv]) -- ����
		--end
		if (JY.Thing[203][WZ6] or 0) >= 20 then
			if qy <= 5 then
				qy = 5
			else
				qy = 7
			end
		end
		if qy == 1 then
			OEVENTLUA[30051](lv)
		elseif qy == 2 then
			local tmp = lv - 2
			if tmp <= 0 then
				tmp = 1
			end
			if lv > 11 then
				lv = 15
				tmp = 9
			end
			if lv == tmp then
				lv = lv + 1
			end
			OEVENTLUA[30052](tmp, lv)
		elseif qy == 3 then
			OEVENTLUA[30053]()
		elseif qy == 4 then
			OEVENTLUA[30054]()
		elseif qy == 5 then
			OEVENTLUA[30055]()
		elseif qy == 6 then
			OEVENTLUA[30056]()
		elseif qy == 7 then
			local tmp = lv
			if lv == 10 then
				lv = 15
			end
			OEVENTLUA[30057](tmp, lv)		
		end	
		SetS(106, 63, 0, 0, GetS(106, 63, 0, 0) + 1)
	end	
end

OEVENTLUA[30051] = function(aa) --����Ʒ
	say("�ף����Ϻ�����ʲô����....")
	local times = math.random(aa) + 1
	for i = 1, times do
		if math.random(100) <= 30 then
			addthing(174, math.random(100, 1000))		
		else
			local thing = randomthing()
			addthing(thing, math.random(1, 3))		
		end
	end
	say("������׬����׬���ˣ�")
end

OEVENTLUA[30052] = function(aa, bb) --���书
	say("�ף����Ϻ����б���....")
	local thing = randomwugong2(aa, bb)
	local count = 0
	while true do
		if hasthing(thing) == false or count >= 25 then
			break
		end
		count = count + 1
		thing = randomwugong2(aa, bb)
	end
	addthing(thing, 1)		
	if count >=25 then
		say("ԭ�����Ѿ������ľ��顣")
	else
		say("������׬����׬���ˣ�")
	end
end

OEVENTLUA[30053] = function() --��ս
	local teamnum = 1
	local enemy = -1
	local prot = -1
	for i = 2, CC.TeamNum do
		if JY.Base["����" .. i] > 0 then
			teamnum = teamnum + 1
		end
	end
	prot = JY.Base["����" .. math.random(teamnum)]
	SetS(106, 63, 1, 0, prot)
	while true do
		enemy = math.random(1, 500)
		if xiaobin(enemy) then
			break
		end
	end
	SetS(106, 63, 2, 0, enemy)
	Cls()	
	say("վס������"..JY.Person[prot]["����"].."���������²��ţ��������һ����", math.random(100, 200), 0, "������")
	if DrawStrBoxYesNo(-1, -1, "Ҫ����ô��", C_WHITE, 30) == false then	
		say("����ʵ�����ã������׳�")	
		do return end
	end
	JY.Person[enemy]["������"] = JY.Person[enemy]["������"] + 150
	JY.Person[enemy]["�Ṧ"] = JY.Person[enemy]["�Ṧ"] + 150
	JY.Person[enemy]["������"] = JY.Person[enemy]["������"] + 150	
	JY.Person[enemy]["�������ֵ"] = JY.Person[enemy]["�������ֵ"] + 500	
	JY.Person[enemy]["����"] = JY.Person[enemy]["�������ֵ"]			
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end	
	JY.Person[enemy]["������"] = JY.Person[enemy]["������"] - 150
	JY.Person[enemy]["�Ṧ"] = JY.Person[enemy]["�Ṧ"] - 150
	JY.Person[enemy]["������"] = JY.Person[enemy]["������"] - 150	
	JY.Person[enemy]["�������ֵ"] = JY.Person[enemy]["�������ֵ"] - 500	
	JY.Person[enemy]["����"] = JY.Person[enemy]["�������ֵ"]		
	light()	
	AddPersonAttrib(prot, "ʵս", 25)
	AddPersonAttrib(prot, "������", 12)
	AddPersonAttrib(prot, "�Ṧ", 12)
	AddPersonAttrib(prot, "������", 12)
	QZXS(JY.Person[prot]["����"].."ʵս����25�㣡����������12�㣡")
end


OEVENTLUA[30054] = function() --��ҩ
	local money = math.random(3) * 1000
	local head = math.random(350, 575)
	Cls()
	say("��λ�����������������Ƶ��鵤����������������Ϊ������ֻҪ"..money.."�����ӡ���֪������û����Ȥ��", head, 0, "����")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "Ҫ��Ǯô��", C_WHITE, 30) == false then	
		say("�ҿ�����������ô��ƭ������һ��ȥ��")	
		do return end
	end
	Cls()
	if JY.GOLD < money then
		say("ԭ���Ǹ�����˷���ʱ�䣡", head, 0, "����")
		do return end
	end
	Cls()
	say("�����ˣ�")	
	instruct_2(174, -money)
	Cls()

        local x1 = CC.MainSubMenuX
        local y1 = CC.MainSubMenuY + CC.SingleLineHeight
        CC.DYRW = -1
        CC.DYRW2 = -1
	DrawStrBox(x1, y1, "����˭���������Ƶ�ҩ�أ�",C_WHITE, CC.DefaultFont);
	local menu = {}
	local menu2 = {}
	local id = -1
	for i = 1, CC.TeamNum do
		menu[i] = {"", nil, 0}
		id = JY.Base["����" .. i]	
		if id >= 0 and duiyou(id) then
			menu[i] = { JY.Person[id]["����"], nil, 1}
		end
	end
	local numItem = table.getn(menu);
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);	
               id = JY.Base["����" .. r]
	CC.DYRW = id
        local aa = math.random(7, 14)
        AddPersonAttrib(id, "������", aa)
        QZXS(JY.Person[id]["����"].."����������".. aa.."�㣡")        
        local bb = math.random(6, 15)
        AddPersonAttrib(id, "�Ṧ", bb)
        QZXS(JY.Person[id]["����"].."�Ṧ����".. bb.."�㣡")      
        local cc = math.random(7, 14)
        AddPersonAttrib(id, "������", cc)
        QZXS(JY.Person[id]["����"].."����������".. cc.."�㣡")      

end


OEVENTLUA[30055] = function() --������
	local money = math.random(3) * 1000
	if (JY.Thing[203][WZ6] or 0) >= 20 then money = 3000 end
	local head = math.random(350, 575)
	Cls()
	say("�������Ĳ�ϰ�ֻ࣬��Ҫ"..money.."�����ӣ�����Ȥ��", head, 0, "����")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "Ҫ��Ǯô��", C_WHITE, 30) == false then	
		say("�ҿ�����������ô��ƭ������һ��ȥ��")	
		do return end
	end
	Cls()
	if JY.GOLD < money then
		say("ԭ���Ǹ�����˷���ʱ�䣡", head, 0, "����")
		do return end
	end
	Cls()
	say("��Ҫ������")	
	instruct_2(174, -money)
	Cls()
    local x1 = CC.MainSubMenuX
    local y1 = CC.MainSubMenuY + CC.SingleLineHeight
    CC.DYRW = -1
    CC.DYRW2 = -1
	DrawStrBox(x1, y1, "����˭������ѧϰ���أ�",C_WHITE, CC.DefaultFont);
	local menu = {}
	local menu2 = {}
	local id = -1
	for i = 1, CC.TeamNum do
		menu[i] = {"", nil, 0}
		id = JY.Base["����" .. i]	
		if id >= 0 and duiyou(id) then
			menu[i] = { JY.Person[id]["����"], nil, 1}
		end
	end
	local numItem = table.getn(menu);
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);	
        id = JY.Base["����" .. r]
	CC.DYRW = id
        local aa = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then aa = 8 end
        AddPersonAttrib(id, "ȭ�ƹ���", aa)
	QZXS(JY.Person[id]["����"].."ȭ�ƹ�������".. aa.."�㣡")        
        local bb = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then bb = 8 end
        AddPersonAttrib(id, "��������", bb)
	QZXS(JY.Person[id]["����"].."������������".. bb.."�㣡")      
        local cc = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then cc = 8 end
        AddPersonAttrib(id, "ˣ������", cc)
	QZXS(JY.Person[id]["����"].."ˣ����������".. cc.."�㣡")      
        local dd = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then dd = 8 end
        AddPersonAttrib(id, "�������", dd)
	QZXS(JY.Person[id]["����"].."�����������".. dd.."�㣡")      
        local ee = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then ee = 8 end
        AddPersonAttrib(id, "��������", ee)
	QZXS(JY.Person[id]["����"].."������������".. ee.."�㣡")      
end

OEVENTLUA[30056] = function() --������
	local money = math.random(3) * 1000
	local head = math.random(350, 575)
	Cls()
	say("��λ�������ҿ��԰���������ϵ����������ֻ��Ҫ"..money.."�����ӣ�������Ȥ��", head, 0, "����")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "Ҫ��Ǯô��", C_WHITE, 30) == false then	
		say("�ҿ�����������ô��ƭ������һ��ȥ��")	
		do return end
	end
	Cls()
	if JY.GOLD < money then
		say("ԭ���Ǹ�����˷���ʱ�䣡", head, 0, "����")
		do return end
	end
	Cls()
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
		if JY.Thing[id]["����"] == 1 then
		  thing[num] = id
		  thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
		  num = num + 1
		end
      end 
    end
    local r = 0
	r = SelectThing(thing, thingnum)	
	if r < 1 then
		Cls()
		say("��Ҫ�����ˣ�", head, 0, "����")
		do return end
	end
	
	Cls()
	say("�ǾͰ����ˡ�")	
	instruct_2(174, -money)
	Cls()
	local aa, bb
	aa = math.random(2, 5) * 2
	bb = aa
	if JY.Thing[r]["ʹ����"] >= 0 then
		if JY.Thing[r]["װ������"] == 1 then
			if doublearmor(JY.Thing[r]["ʹ����"]) then
				aa = aa * 2
			end
		end
		if JY.Thing[r]["װ������"] == 0 then
			if doubleweapon(JY.Thing[r]["ʹ����"]) then
				aa = aa * 2
			end		
		end
	end	
	JY.Thing[r]["�ӹ�����"] = JY.Thing[r]["�ӹ�����"] + aa
	QZXS(JY.Thing[r]["����"].."���ӹ�����".. bb.."��")
	aa = math.random(2, 5) * 2
	bb = aa
	if JY.Thing[r]["ʹ����"] >= 0 then
		if JY.Thing[r]["װ������"] == 1 then
			if doublearmor(JY.Thing[r]["ʹ����"]) then
				aa = aa * 2
			end
		end
		if JY.Thing[r]["װ������"] == 0 then
			if doubleweapon(JY.Thing[r]["ʹ����"]) then
				aa = aa * 2
			end		
		end
	end	
	JY.Thing[r]["�ӷ�����"] = JY.Thing[r]["�ӷ�����"] + aa
	QZXS(JY.Thing[r]["����"].."���ӷ�����".. bb.."��")	
	aa = math.random(2, 5) * 2
	bb = aa
	if JY.Thing[r]["ʹ����"] >= 0 then
		if JY.Thing[r]["װ������"] == 1 then
			if doublearmor(JY.Thing[r]["ʹ����"]) then
				aa = aa * 2
			end
		end
		if JY.Thing[r]["װ������"] == 0 then
			if doubleweapon(JY.Thing[r]["ʹ����"]) then
				aa = aa * 2
			end		
		end
	end	
	JY.Thing[r]["���Ṧ"] = JY.Thing[r]["���Ṧ"] + aa
	QZXS(JY.Thing[r]["����"].."�����Ṧ".. bb.."��")
end

OEVENTLUA[30057] = function(aa, bb) --ϴ�书
    local teamnum = 1
	local enemy = -1
	local prot = -1
	for i = 2, CC.TeamNum do
		if JY.Base["����" .. i] > 0 then
			teamnum = teamnum + 1
		end
	end
	prot = JY.Base["����" .. math.random(teamnum)]
	SetS(106, 63, 1, 0, prot)	
    local head = math.random(350, 575)	
	Cls()
	say("���....������·�ˡ�������ô�����������ˣ���ô��....", prot)	
	Cls()
	say("ǰ������и�ɽ���������ˣ��Ƚ�ȥ��һ����˵��", prot)	
	Cls()
	say("��λ����...", head, 0, "������")
	Cls()
	say("��������һ��....��ǰ����������ץ���󰡣���", prot)	
	Cls()
	say("���ڴ����Ӷ��꣬������û�����ҵ������������Ե���Ҵ���һЩ�书��Σ�", head, 0, "������")	
	Cls()
	say("��ļٵ�....ɽ��������������ѵ���������ǣ�", prot)	
	if DrawStrBoxYesNo(-1, -1, "Ҫ����ô��", C_WHITE, 30) == false then	
		Cls()
		say("��лǰ����ֻ������Ϊ����ѧ֮���󾫲���࣬ǰ���ĺ����������ˡ�" , prot)	
		Cls()
		say("Ҳ�գ����Ȼ�д��۽磬��Ҳ����ǿ���ˡ�", head, 0, "������")	
		do return end
	end
	Cls()
	say("���ҿ�����Ļ�����Ρ�", head, 0, "������")
	local thing, wugong = -1
	local hasit = 1	
	local count = 0
	while hasit == 1 do
		thing = randomwugong2(aa, bb)
		wugong = JY.Thing[thing]["�����书"]
		hasit = 0
		for i = 1, 10 do
			if JY.Person[prot]["�书"..i] > 0 and JY.Person[prot]["�书"..i] == wugong then
				hasit = 1	
			end
		end
		count = count + 1
		if count >= 100 then
			break
		end
	end
	if count >= 100 then
		Cls()
		say("��СС��ͣ���Ȼ�Ѿ�������˾��硣���Ǻ�����η��", head, 0, "������")	
		Cls()
		say("��û�ж������Խ����ˣ��㻹��������·������ʹ���ɡ�", head, 0, "������")	
		do return end
	end
	Cls()
	say("���������ҾͰ������ѧ"..JY.Wugong[wugong]["����"].."���ڸ��㣬�����ˡ�", head, 0, "������")	
	JY.Person[prot]["�书1"] = wugong
	JY.Person[prot]["�书�ȼ�1"] = 90 --math.random(750, 900) �������ǣ�ȡ�����û�����������
	Cls()
	dark()
	light()
	QZXS(JY.Person[prot]["����"].."����"..JY.Wugong[wugong]["����"].."��")
	say("��Σ���������", head, 0, "������")	
	Cls()
	say("���ˡ�ллǰ��ָ�㡣", prot)	
	Cls()
	say("�ܺã�����Ը�������·�ˡ��Ժ���Զ��Ҫ����˵������ҡ�", head, 0, "������")	
	Cls()
	say("�õģ�ǰ�����أ�", prot)	
end

OEVENTLUA[30010] = function()
	if RW.fame >= 50 and hasHZ(94) == false then
		say("�����������ȵ���ڽ�����ʵ���Ǵ�����һ�����á����СС������Ц�ɡ�", 96, 0, "�н���")
		addHZ(94) --21 �������ǣ�����BUG
		do return end
	end
	local menu = {
		{"����״̬", nil, 1},
		{"ȡ������", nil, 1},
		{"��������", nil, 1},
	}	
	local r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
	if r == 1 then
		RWstatus()
	elseif r == 2 then
		Cls()
		if yesno("Ҫȡ������ô��") then			
			displayRW(3, RW.scene, RW.location)	
			displayRW(3, RW.targetscene, RW.target)			
			for i = 1, #RW.special do
				if RW.special[i][1] == RW.event then
					null(RW.special[i][2], 110)
				end
			end
			resetRW()
		end
	elseif r == 3 then
		local teshu = {
			{"����������", nil, not setRW(1) and 1 or 0},
			{"������", nil, not setRW(2) and 1 or 0},
			{"������", nil, not setRW(3) and 1 or 0},
			{"��ؤ�����", nil, not setRW(4) and 1 or 0},
			{"��������", nil, not setRW(5) and 1 or 0},
			{"��Թ����", nil, not setRW(6) and 1 or 0},
			{"��������", nil, not setRW(7) and 1 or 0},
			{"��Գ����Ů", nil, not setRW(8) and 1 or 0},
			{"��������", nil, not setRW(9) and 1 or 0},
		}
		if #teshu > 0 then
			local rt = ShowMenu3(teshu,#teshu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
			if rt > 0 then getRW(VK_SPACE, rt + 100) end
		end
	end
end

function autostats(a)
	local p1 = 0	
	if duiyou(a) then
		p1 = (limitX(JY.Person[a]["����"], 4, 5) + 1) * (limitX(JY.Person[a]["����"], 4, 5) + 1) * 25
	else
		p1 = JY.Person[a]["����"] * JY.Person[a]["����"] * 30
	end
	if CC.NLJS[JY.Person[a]["����"]] ~= nil then --�츳�ӳ�150
		p1 = p1 + 150
	end	
	p1 = p1 + math.modf((sixi(a, 1) + sixi(a, 2) + sixi(a, 3) + sixi(a, 4)) / 5) --��ϵ��0.2 max192
	p1 = p1 + math.modf((JY.Person[a]["������"] + JY.Person[a]["������"] + JY.Person[a]["�Ṧ"]) / 15) --��Χ��0.07 max120
	p1 = p1 + math.modf(JY.Person[a]["��ѧ��ʶ"]) --�䳣max50
	if JY.Person[a]["���һ���"] == 1 then p1 = p1 + 50 end --���Ҽ�50
	p1 = p1 + JY.Wugong[JY.Person[a]["����"]]["�ȼ�"] * 10 --�����10 max100
	p1 = p1 + math.modf(JY.Person[a]["ʵս"] / 10) --ʵս��0.1 max 50
	p1 = p1 + math.modf(JY.Person[a]["�������ֵ"] / 10) --������0.1
	for i = 1, HHH_GAME_SETTING["WG_COUNT_MAX"] do
		if JY.Person[a]["�书"..i] > 0 and JY.Person[a]["�书�ȼ�"..i] >= 900 then
			if duiyou(a) then
				p1 = p1 + JY.Wugong[JY.Person[a]["�书"..i]]["�ȼ�"] * 7
			else
				p1 = p1 + JY.Wugong[JY.Person[a]["�书"..i]]["�ȼ�"] * 5
			end
		end
	end	
	return p1
end
function lottery(a, b)
	local p1, p2 = 0, 0
	--[[if math.abs(JY.Person[a]["����"] - JY.Person[b]["����"]) >= 2 then --Խ��������
		if JY.Person[a]["����"] > JY.Person[b]["����"] then 
			return a
		else
			return b
		end
	end	]]	
	p1 = autostats(a)
	p2 = autostats(b)
	local x, y = 0, 0
	local total = math.modf(p1 + p2)
	for i = 1, 50 do
		if math.random(total) <= p1 then
			x = x + 1
		else
			y = y + 1
		end
	end
	if x > y then
		return a
	elseif y > x then
		return b
	else
		if p1 > p2 then
			return a
		else
			return b
		end
	end
	--return JY.Person[a]["����"]..p1.."  :  "..JY.Person[b]["����"]..p2
end

function drawline(x1, y1, x2, y2, color)
	if color == nil then
		color = C_RED
	end
	DrawBox3(x1, y1, x2, y1, color)
	DrawBox3(x2, y1, x2, y2, color)
end
	
function drawmatch(list)

	lib.LoadPicture(CONFIG.PicturePath.."scroll.png", -1, -1)  
	local color = M_Cyan

	for i = 1, 16 do
		color = M_Cyan
		if list[i][3] == -1 then
			color = M_Silver
		end
		DrawString(25, 36 * i - 10, list[i][2], color, 30)	
		color = M_Cyan
		if list[i + 16][3] == -1 then
			color = M_Silver
		end		
		DrawString(CC.ScreenW - 150, 36 * i - 10, list[i + 16][2], color, 30)	
	
	end
	local line = {
			{{155, 41, 205, 59}, {205, 59, 255, 95}, {255, 95, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}}, --2, 4, 8
			{{155, 77, 205, 59}, {205, 59, 255, 95}, {255, 95, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 113, 205, 131}, {205, 131, 255, 95}, {255, 95, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 149, 205, 131}, {205, 131, 255, 95}, {255, 95, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 185, 205, 203}, {205, 203, 255, 239},{255, 239, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 221, 205, 203}, {205, 203, 255, 239}, {255, 239, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 257, 205, 275}, {205, 275, 255, 239}, {255, 239, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 293, 205, 275}, {205, 275, 255, 239}, {255, 239, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},

			{{155, 329, 205, 347}, {205, 347, 255, 383}, {255, 383, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 365, 205, 347}, {205, 347, 255, 383}, {255, 383, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 401, 205, 419}, {205, 419, 255, 383}, {255, 383, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 437, 205, 419}, {205, 419, 255, 383}, {255, 383, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 473, 205, 491}, {205, 491, 255, 527}, {255, 527, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 509, 205, 491}, {205, 491, 255, 527}, {255, 527, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 545, 205, 563}, {205, 563, 255, 527}, {255, 527, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 581, 205, 563}, {205, 563, 255, 527}, {255, 527, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},

			{{640, 41, 590, 59}, {590, 59, 540, 95}, {540, 95, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}}, --2, 4, 8
			{{640, 77, 590, 59}, {590, 59, 540, 95}, {540, 95, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 113, 590, 131}, {590, 131, 540, 95}, {540, 95, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 149, 590, 131}, {590, 131, 540, 95}, {540, 95, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 185, 590, 203}, {590, 203, 540, 239},{540, 239, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 221, 590, 203}, {590, 203, 540, 239}, {540, 239, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 257, 590, 275}, {590, 275, 540, 239}, {540, 239, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 293, 590, 275}, {590, 275, 540, 239}, {540, 239, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},

			{{640, 329, 590, 347}, {590, 347, 540, 383}, {540, 383, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 365, 590, 347}, {590, 347, 540, 383}, {540, 383, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 401, 590, 419}, {590, 419, 540, 383}, {540, 383, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 437, 590, 419}, {590, 419, 540, 383}, {540, 383, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 473, 590, 491}, {590, 491, 540, 527}, {540, 527, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 509, 590, 491}, {590, 491, 540, 527}, {540, 527, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 545, 590, 563}, {590, 563, 540, 527}, {540, 527, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 581, 590, 563}, {590, 563, 540, 527}, {540, 527, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
		}
		for i = 1, #line do
			for j = 1, #line[i] do
				drawline(line[i][j][1], line[i][j][2], line[i][j][3], line[i][j][4], M_RoyalBlue)
			end
		end
		drawline(355, 311, 440, 311, M_RoyalBlue)
		
		for i = 1, #line do
			if list[i][3] < 1 or list[i][3] > 5 then
			
			else
				for j = 1, list[i][3] do
					drawline(line[i][j][1], line[i][j][2], line[i][j][3], line[i][j][4])
				end
			end
		end
			
end

function shuffle(t)
	local n = #t
	while n >= 2 do
		local k = math.random(n)
		t[n], t[k] = t[k], t[n]
		n = n - 1
	end
	return t	
end

function participant(flag)
	local total = 32
	local r4, r5, r6, r7, r8 = {}, {}, {}, {}, {}
	for i = 0, JY.PersonNum - 1 do
		local pp = JY.Person[i]["����"]
		if i >= 594 and i <= 596 then
			pp = 0
		elseif i >= 497 and i <= 577 then
			pp = 0
		elseif i >= 607 and i <= 613 then
			pp = 0	
		elseif i == 620 then
			pp = 0
		elseif duiyou(i) then
			if inteam(i) then
				pp = pp + 1
			else
				pp = 0
			end
			if pp > 6 then pp = 6 end
		end
		if pp == 4 then
			r4[#r4 + 1] = {i, 0} --30%
		elseif pp == 5 then
			r5[#r5 + 1] =  {i, 0} --50%
		elseif pp == 6 then
			r6[#r6 + 1] =  {i, 0} --65$
		elseif pp == 7 then
			r7[#r7 + 1] =  {i, 0}	--80%
		end
	end
	r4 = shuffle(r4)
	r5 = shuffle(r5)
	r6 = shuffle(r6)
	r7 = shuffle(r7)
	local list = {}
	for i = 1, total do
		list[i] = {nil, nil, 0}
	end
	list[1] = {zj(), JY.Person[zj()]["����"], 0}
	local n = 2
	while n <= total do
		for i = 1, #r7 do
			if math.random(100) <= 80 and r7[i][2] == 0 then
				list[n] = {r7[i][1], JY.Person[r7[i][1]]["����"], 0}
				n = n + 1
				r7[i][2] = 1
				if n > total then break end
			end
		end
		if n > total then break end
		for i = 1, #r6 do
			if math.random(100) <= 65 and r6[i][2] == 0 then
				list[n] = {r6[i][1], JY.Person[r6[i][1]]["����"], 0}
				n = n + 1
				r6[i][2] = 1
				if n > total then break end
			end
		end		
		if n > total then break end
		for i = 1, #r5 do
			if math.random(100) <= 50 and r5[i][2] == 0 then
				list[n] = {r5[i][1], JY.Person[r5[i][1]]["����"], 0}
				n = n + 1
				r5[i][2] = 1
				if n > total then break end
			end
		end		
		if n > total then break end
		for i = 1, #r4 do
			if math.random(100) <= 30 and r4[i][2] == 0 then
				list[n] = {r4[i][1], JY.Person[r4[i][1]]["����"], 0}
				n = n + 1
				r4[i][2] = 1
				if n > total then break end
			end
		end		
		if n > total then break end
	end
	list = shuffle(list)
	list = shuffle(list)
	CC.Match = list
	return list
end

function biwu()
	local gstatus = JY.Status
	lib.Delay(100)
	say("��˵һ��һ�ȵĻ�ɽ�۽������ٿ��ˣ��������ɶ�Ħȭ����׼�����һ֮���ء�", math.random(1, 189), 0, "����")
	say("��ɽ�۽�����Ҫ�μ���")
	if yesno("�μ���") == false then
		
	else
		say("ȥ����Ҳ�á�")
		My_Enter_SubScene(25,28,26,2)
		say("��ӭ��λ�������컪ɽ�۽���", 585)
		biwu_sub()
		say("��Ȼ������У�")
		JY.Status = gstatus
		lib.PicInit()
		CleanMemory()
		lib.ShowSlow(50, 1)
		if JY.MmapMusic < 0 then
		  JY.MmapMusic = 16
		end
		Init_MMap()
		JY.SubScene = -1
		JY.oldSMapX = -1
		JY.oldSMapY = -1
		lib.DrawMMap(JY.Base["��X"], JY.Base["��Y"], GetMyPic())
		lib.ShowSlow(50, 0)
		lib.GetKey()
		addtime(3)		
	end
end

function biwu_sub()
	local jiangli = 1
	local tmp = JY.Status
	local list = participant()
	local store = {}
	for i = 1, #list do
		store[list[i][1]] = {}
		store[list[i][1]][1] = JY.Person[list[i][1]][CC.EVB29] 
		store[list[i][1]][2] = JY.Person[list[i][1]][CC.EVB30]
		store[list[i][1]][3] = JY.Person[list[i][1]][CC.EVB31]
		store[list[i][1]][4] = JY.Person[list[i][1]][CC.EVB32]
		JY.Person[list[i][1]][CC.EVB29] = -1
		JY.Person[list[i][1]][CC.EVB30] = -1
		JY.Person[list[i][1]][CC.EVB31] = -1
		JY.Person[list[i][1]][CC.EVB32] = -1	
	end
	CC.MatchTurn = 1 --����������5������ѡ����������ǿ��������ܾ���
	CC.MatchMe = -1
	CC.MatchYou = -1	
	CC.MatchAuto = 0
	local one = -1
	local winner = -1
	JY.Status = GAME_MATCH
	Cls()
	local word = {"��ѡ����", "��������", "��ǿ����", "�������", "�ܾ�����"}
	local menu = {
		{"���岻��", nil, 1}, 
		{"�����侳", nil, 1},
		{"��������", nil, 1},
	}
	local menu2 = {}
	local r = -1
	say("����������ɽ�۽���ʽ��ʼ��", 585)
	for i = 1, #list, 2 do
		CC.MatchAuto = 0
		list[i][3] = CC.MatchTurn
		list[i + 1][3] = CC.MatchTurn
		say(word[CC.MatchTurn]..list[i][2].."��"..list[i + 1][2].."��", 585)
		if inteam(list[i][1]) or inteam(list[i + 1][1]) then
			if inteam(list[i][1]) then
				CC.MatchMe = list[i][1]
				CC.MatchYou = list[i + 1][1]			
			else
				CC.MatchMe = list[i + 1][1]
				CC.MatchYou = list[i][1]			
			end
			if WarMain(342) then
				winner = CC.MatchMe
			else
				winner = CC.MatchYou
			end			
		else
			--r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,"��ѡ��", nil,M_DimGray,C_RED)
			r = 3
			if r == 1 then
				jiangli = 0
				CC.MatchAuto = 1
				if math.random(2) == 1 then
					CC.MatchMe = list[i][1]
					CC.MatchYou = list[i + 1][1]
				else
					CC.MatchMe = list[i + 1][1]
					CC.MatchYou = list[i][1]
				end
				if WarMain(342) then
					winner = CC.MatchMe
				else
					winner = CC.MatchYou
				end
			elseif r == 2 then
				jiangli = 0
				local p1, p2 = list[i][1], list[i + 1][1]
				menu2 = {
					{JY.Person[p1]["����"], nil, 1, p1},
					{JY.Person[p2]["����"], nil, 1, p2},
				}
				Cls()
				local r2 = ShowMenu3(menu2,#menu2,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"�����˭��", nil,M_DimGray,C_RED)
				if r2 == 1 then
					CC.MatchMe = p1
					CC.MatchYou = p2
				else
					CC.MatchMe = p2
					CC.MatchYou = p1
				end
				if WarMain(342) then
					winner = CC.MatchMe
				else
					winner = CC.MatchYou
				end			
			else
				winner = lottery(list[i][1], list[i + 1][1])
			end
		end
		if list[i][1] == winner then
			list[i + 1][3] = -1
			list[i][3] = list[i][3] + 1
		else
			list[i][3] = -1
			list[i + 1][3] = list[i + 1][3] + 1
		end
		say("ʤ����"..JY.Person[winner]["����"].."��", 585)
	end
	CC.MatchTurn = CC.MatchTurn + 1
	
	for i = 2, 5 do
		CC.MatchAuto = 0
		local tlist = {}
		for i = 1, #list do
			if list[i][3] > 0 then
				tlist[#tlist + 1] = {list[i][1], list[i][2], list[i][3], i}
			end
		end
		for i = 1, #tlist, 2 do
			say(word[CC.MatchTurn]..tlist[i][2].."��"..tlist[i + 1][2].."��", 585)
			if inteam(tlist[i][1]) or inteam(tlist[i + 1][1]) then
				if inteam(tlist[i][1]) then
					CC.MatchMe = tlist[i][1]
					CC.MatchYou = tlist[i + 1][1]			
				else
					CC.MatchMe = tlist[i + 1][1]
					CC.MatchYou = tlist[i][1]			
				end
				if WarMain(342) then
					winner = CC.MatchMe
				else
					winner = CC.MatchYou
				end			
			else
				--r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,"��ѡ��", nil,M_DimGray,C_RED)
				r = 3
				if r == 1 then 
					jiangli = 0
					CC.MatchAuto = 1
					if math.random(2) == 1 then
						CC.MatchMe = tlist[i][1]
						CC.MatchYou = tlist[i + 1][1]
					else
						CC.MatchMe = tlist[i + 1][1]
						CC.MatchYou = tlist[i][1]
					end
					if WarMain(342) then
						winner = CC.MatchMe
					else
						winner = CC.MatchYou
					end
				elseif r == 2 then
					jiangli = 0
					local p1, p2 = tlist[i][1], tlist[i + 1][1]
					menu2 = {
						{JY.Person[p1]["����"], nil, 1, p1},
						{JY.Person[p2]["����"], nil, 1, p2},
					}
					Cls()
					local r2 = ShowMenu3(menu2,#menu2,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"�����˭��", nil,M_DimGray,C_RED)
					if r2 == 1 then
						CC.MatchMe = p1
						CC.MatchYou = p2
					else
						CC.MatchMe = p2
						CC.MatchYou = p1
					end
					if WarMain(342) then
						winner = CC.MatchMe
					else
						winner = CC.MatchYou
					end			
				else
					winner = lottery(tlist[i][1], tlist[i + 1][1])
				end
			end		
			if CC.MatchTurn < 5 then
				if tlist[i][1] == winner then
					list[tlist[i + 1][4]][3] = -1
					list[tlist[i][4]][3] = list[tlist[i][4]][3] + 1
				else
					list[tlist[i][4]][3] = -1
					list[tlist[i + 1][4]][3] = list[tlist[i + 1][4]][3] + 1
				end
			else
				one = winner
			end
			say("ʤ����"..JY.Person[winner]["����"].."��", 585)	
			--if CC.MatchTurn >= 3 then
			--	if winner == zj() or inteam(winner) then
			--		addHZ(math.random(#CC.HZ))
			--	end
			--end
		end
		CC.MatchTurn = CC.MatchTurn + 1
	end
	say("���컪ɽ�۽�����ʤ���ߣ��书���µ�һ��"..JY.Person[one]["����"].."��", 585)
	--if inteam(one) then AddPersonAttrib(one, "ʵս", 500) end
	if inteam(one) and jiangli == 1 and (not hasHZ(90)) then addHZ(90) end
	for i = 1, #list do
		JY.Person[list[i][1]][CC.EVB29] = store[list[i][1]][1]
		JY.Person[list[i][1]][CC.EVB30] = store[list[i][1]][2]
		JY.Person[list[i][1]][CC.EVB31] = store[list[i][1]][3] 
		JY.Person[list[i][1]][CC.EVB32] = store[list[i][1]][4]
	end	
	JY.Status = tmp
end
