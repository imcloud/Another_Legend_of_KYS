--nino: С���Ĳ����������Ǹ����¼�
OEVENTLUA[30016] = function() --������
	zjini()
	SetS(103, 0, 0, 1, 0)
	All_team(1, 191) --���������������������10�ı�����Ȼ���ܷ�ҳʱ������
	All_team(581, 581)
	All_team(589, 596)
	say("����ʵ���ֻ��һ��С�����͹�������Ҫ����ɶ����",220,0,"����С��") 	
	instruct_0()
	say("�ţ����뻻���棿��ô��Խ�������㾹Ȼ����һ��С����������",220,0,"����С��") 
	instruct_0()
	say("�ðɺðɣ���������ô�г���һֱ���ո���ķ��ϣ��ҾͰ����ɡ�",220,0,"����С��") 
	instruct_0()
	say("������Ҫ�յ�С�ѵģ������ڼ��������Ѱɡ�",220,0,"����С��") 
	instruct_0()	
	say("��˵��Ŷ���ҿɲ���֤����Ϸ��������������ȥ......",220,0,"����С��")	
	if DrawStrBoxYesNo(-1, -1, "Ҫ��������", C_WHITE, 30) == true then	
		instruct_0()
		DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "Ҫ����˭��", C_WHITE, CC.DefaultFont)
		local nexty = CC.MainSubMenuY + CC.SingleLineHeight
		local r = My_Select(CC.menu, CC.i - 1, 10)
		local pid
		if r <= 0 then
			instruct_0()
			say("�������𣿺ðɣ���Ҳʡ�ĵ㡣���������ȥ�ɡ�",220,0,"����С��")				
			do return; end
		end
		pid = CC.menu[r][4]
		
		if pid == GetS(103, 0, 0, 1) then
			instruct_0()
			say("�㲻���Ѿ��������������������ѡ���ɡ�",220,0,"����С��")				
			do return; end		
		end				
		if duiyou(pid) then --����Ƕ���
			if inteam(pid) then --����ڶ���������λ
				local position = -1
				for i = 1, CC.TeamNum do
					if JY.Base["����"..i] == pid then
						position = i
						break
					end
				end
				local current = 1
				for i = 1, CC.TeamNum do
					if JY.Base["����"..i] > 0 then
						current = current + 1
					end
				end
				for i = position + 1, CC.TeamNum do
					if JY.Base["����"..i] > 0 then
						JY.Base["����"..i - 1] = JY.Base["����"..i]
					end
				end
				JY.Base["����"..current] = -1
				JY.Base["����1"] = pid			
			else --���ڶ�������ֱ���޸�
				JY.Base["����1"] = pid	
			end
		else --������Ƕ���		
			for i = 1, #PSX do
				SetS(103, i, 0, 0, JY.Person[pid][PSX[i]]) --��¼ԭʼ����
			end	
			instruct_0()
			say("��Ϊ��ѡ����ǳ�ʼ�ȼ��ߵķǶ���������Ը����ѡ��Ļ���ɡ�",220,0,"����С��")	
			local initialize = 0
			if DrawStrBoxYesNo(-1, -1, "Ҫ��ʼ������������", C_WHITE, 30) then
				initialize = 1
			end
			JY.Person[pid]["�ȼ�"] = 30 --���õȼ���������
			JY.Person[pid]["����"] = 1500
			JY.Person[pid]["�������ֵ"] = 1500
			JY.Person[pid]["�������ֵ"] = 5000
			JY.Person[pid]["����"] = 5000
			if initialize == 1 then --���ݳ�ʼ��
				SetS(103, 0, 0, 3, 1)
				JY.Person[pid]["�ȼ�"] = 10
				JY.Person[pid]["������"] = 120
				JY.Person[pid]["�Ṧ"] = 120
				JY.Person[pid]["������"] = 120
				JY.Person[pid]["����"] = 1000
				JY.Person[pid]["�������ֵ"] = 1000
				JY.Person[pid]["�������ֵ"] = 3000
				JY.Person[pid]["����"] = 3000				
				if JY.Person[pid]["ȭ�ƹ���"] < 40 then
					JY.Person[pid]["ȭ�ƹ���"] = 40
				end
				if JY.Person[pid]["��������"] < 40 then
					JY.Person[pid]["��������"] = 40
				end		
				if JY.Person[pid]["ˣ������"] < 40 then
					JY.Person[pid]["ˣ������"] = 40
				end			
				if JY.Person[pid]["�������"] < 40 then
					JY.Person[pid]["�������"] = 40
				end			
				for i = 1, 10 do
					if JY.Person[pid]["�书"..i] > 0 then
						JY.Person[pid]["�书�ȼ�"..i] = 0
					end
				end
			end
			JY.Base["����1"] = pid	
			local T = {}
			for a = 1, 1000 do
			  local b = "" .. a
			  T[b] = a
			end
			DrawStrBoxWaitKey("��������Ҫ����������", C_WHITE, 30)
			JY.Person[pid]["����"] = -1
			while JY.Person[pid]["����"] == -1 do
				local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				if T[r] ~= nil and T[r] > -1 and T[r] < 101 then
				  JY.Person[pid]["����"] = T[r]
				else
					DrawStrBoxWaitKey(CC.EVB125, C_WHITE, 30)
				end
			end			
		end
		SetS(103, 0, 0, 0, 1)
		SetS(103, 0, 0, 1, pid)			
		instruct_0()
		say("���ǻ���"..JY.Person[pid]["����"].."�ˣ���Ҫ�������ľ��������Ұɡ�",220,0,"����С��")	
		instruct_3(61,3,-2,-2,30017,-2,-2,-2,-2,-2,-2,-2,-2)	
	else
		instruct_0()
		say("�������𣿺ðɣ���Ҳʡ�ĵ㡣���������ȥ�ɡ�",220,0,"����С��")	
	end
end

OEVENTLUA[30017] = function() --������
	say("�����͹�����ô������˰����뻻������",220,0,"����С��") 	
	instruct_0()
	say("�ðɺðɣ���Ȼ�����������Ǿ�����Ѱ���һ�ΰɡ�",220,0,"����С��") 
	instruct_0()
	say("�����һ��ǲ���֤�᲻���к���֢Ŷ��",220,0,"����С��")	
	if DrawStrBoxYesNo(-1, -1, "Ҫ��������", C_WHITE, 30) == true then	
		local pid = GetS(103, 0, 0, 1)
		if duiyou(pid) then
			instruct_0()
			say("��Ϊ�Һ������Ծ�ֱ�ӵ�������¼���Ŷ��Ҫ�Ļ��͵�С��ȥ�һ���λ������α���Ƕ��Ѱɡ�",220,0,"����С��")					
			JY.Base["����1"] = 0
			instruct_0()
			for i,v in pairs(CC.PersonExit) do
				if GetS(103, 0, 0, 1) == v[1] then
					if OEVENTLUA[v[2]] ~= nil then
						OEVENTLUA[v[2]]()
					else
						oldCallEvent(v[2])
					end
				end
			end	
		else
			for i = 1, #PSX do --����npc����
				JY.Person[pid][PSX[i]] = GetS(103, i, 0, 0)
			end
			JY.Base["����1"] = 0	
			instruct_0()
			say("α���ǵ������Ѿ������ˡ�",220,0,"����С��")							
		end

		SetS(103, 0, 0, 0, 0)
		SetS(103, 0, 0, 1, 0)
		SetS(103, 0, 0, 3, 0)
		instruct_0()
		say("���ˣ�����������ǹ⻷����ȥ�ɡ�",220,0,"����С��")	
		instruct_3(61,3,-2,-2,30016,-2,-2,-2,-2,-2,-2,-2,-2)	
	else
		instruct_0()
		say("�������𣿺ðɣ���Ҳʡ�ĵ㡣���������ȥ�ɡ�",220,0,"����С��")	
	end
end

OEVENTLUA[30016] = function() --������
	say("����ʵ���ֻ��һ��С�����͹�������Ҫ����ɶ����",220,0,"����С��") 	
end
