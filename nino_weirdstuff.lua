instruct_3(1,1,-2,-2,10019,10020,-2,-2,-2,-2,-2,-2,-2)
OEVENTLUA[10020] = function()
	local r = 0
	if instruct_4(153) == true then
		OEVENTLUA[40000]()
		do return end
	end
end

OEVENTLUA[40000] = function()
	instruct_0()
	say("������£�����Ǳ����鰡��",220,0,"����С��") 	
	instruct_0()
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY,"��ѡ������", C_WHITE, CC.DefaultFont)	
	local test = false
	local menu = {
	{"����ĵ���֮��", nil, 0},
	{"С��Ů�ĵ���֮��", nil, 0},
	{"������µĽ���", nil, 0},
	{"��������Ϯ", nil, 0},
	}
	if instruct_16(58) and GetS(1, 1, 0, 1) ~= 9 then
		menu[1][3] = 1
		test = true
	end
	if instruct_16(59) then
		menu[2][3] = 1
		test = true
	end
	if instruct_16(58) and instruct_16(59) then
		menu[3][3] = 1
		test = true
	end
	if instruct_16(84) and GetS(1, 4, 0, 1) ~= 9 then
		menu[4][3] = 1
		test = true
	end	
	if test == false then
		instruct_0()
		say("���ѹؼ����������������ô������������أ�",220,0,"����С��") 	
		do return end
	end
	local r = ShowMenu(menu,#menu,0,CC.MainSubMenuX,CC.MainSubMenuY+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
	if r == 1 then
		instruct_0()
		say("��ʵ����һ����С�ӳ�Ϊ�߸�˧����־����....�������Թ�ǧ�֣�",220,0,"����С��") 			
		instruct_0()
		say("���糾���٣�ЪϢ��½��ׯ��ƫƫ������Ӣ�۴�ᡣһ��Ϊ������һ��Ϊ�����ӣ���ս�ʹ�չ����Ļ��",220,0,"����С��") 				
		SetS(1, 1, 0, 1, 1)
		if instruct_6(272,4,0,0) == false then --vs����
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end		
		instruct_0()
		instruct_13()
		SetS(1, 1, 0, 1, 2)
		if instruct_6(272,4,0,0) == false then --vs�����
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		instruct_0()
		instruct_13()	
		SetS(1, 1, 0, 1, 3)
		if instruct_6(272,4,0,0) == false then --vs����
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		instruct_0()
		instruct_13()	
		instruct_0()
		say("���ٺ������������˹�������ⲻ�ң������ж�������Զ�ߣ���ֻ��һ��һ���˼��������ȴ��ط����һ��....�������Թ�ǧ�֣�",220,0,"����С��") 			
		instruct_0()
		say("�޳ܺ��ߵ����ӵ���ƪ������",220,0,"����С��") 			
		SetS(1, 1, 0, 1, 9)
		elseif r == 2 then
	
	elseif r == 3 then
	
	elseif r == 4 then
		instruct_0()
		say("����һ����ĳ��ƽ�����淢��������....",220,0,"����С��") 		
		instruct_0()
		say("С��ͯ��Ȼ����սӢ�µ�С���ӣ�С���Ӿ�������һ��СС�Ľ�ѵ��",220,0,"����С��") 			
		SetS(1, 4, 0, 1, 1)
		local tmpatk = JY.Person[58]["������"]
		local tmpdef = JY.Person[58]["������"]
		local tmpspd = JY.Person[58]["�Ṧ"]	
		JY.Person[58]["������"] = 400
		JY.Person[58]["������"] = 400
		JY.Person[58]["�Ṧ"] = 300				
		if instruct_6(275,4,0,0) == false then --vs���
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		JY.Person[58]["������"] = tmpatk
		JY.Person[58]["������"] = tmpdef
		JY.Person[58]["�Ṧ"] = tmpspd			
		instruct_0()
		instruct_13()
		instruct_0()
		say("սʤ��С��ͯ��С���������緢��ֱ����Ҫ������˵�е���֮���ߡ�",220,0,"����С��") 	
		SetS(1, 4, 0, 1, 2)
		local tmpatk = JY.Person[55]["������"]
		local tmpdef = JY.Person[55]["������"]
		local tmpspd = JY.Person[55]["�Ṧ"]	
		JY.Person[55]["������"] = 300
		JY.Person[55]["������"] = 350
		JY.Person[55]["�Ṧ"] = 250				
		if instruct_6(275,4,0,0) == false then --vs����
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		JY.Person[55]["������"] = tmpatk
		JY.Person[55]["������"] = tmpdef
		JY.Person[55]["�Ṧ"] = tmpspd	
		instruct_0()
		instruct_13()
		instruct_0()
		say("Ī�������Ϊʦ������������������λ��֮��С����ͻ�����룺Ϊʲô�Ҳ��ܳ�Ϊ���������أ�",220,0,"����С��") 			
		SetS(1, 4, 0, 1, 3)
		if instruct_6(275,4,0,0) == false then --vs����
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		instruct_0()
		instruct_13()	
		instruct_0()
		say("��ϧ�þ�����������ԭ������ǿ�߸���̨����С�����ʵ����������Ķ�ɽ�������������ؤ�",220,0,"����С��") 			
		instruct_0()
		say("��ѧ������������躻ޣ�������ؤ�����ϴ������֣���������ʮ���ڡ�",220,0,"����С��") 			
		instruct_0()
		say("����ֻʣ��֮���ߵ�̫̫�������̫��վ��̨���ˡ�",220,0,"����С��") 	
		SetS(1, 4, 0, 1, 4)
		local tmpatk = JY.Person[56]["������"]
		local tmpdef = JY.Person[56]["������"]
		local tmpspd = JY.Person[56]["�Ṧ"]	
		JY.Person[56]["������"] = 350
		JY.Person[56]["������"] = 350
		JY.Person[56]["�Ṧ"] = 350				
		if instruct_6(275,4,0,0) == false then --vs����
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		JY.Person[56]["������"] = tmpatk
		JY.Person[56]["������"] = tmpdef
		JY.Person[56]["�Ṧ"] = tmpspd	
		instruct_0()
		instruct_13()		
		instruct_0()
		say("С���������г�ͷ���ˡ��Ӵ������Ұ��ӣ�������ؤ������ĸ￪�ŵ������졣",220,0,"����С��") 
		instruct_0()
		say("�г���С���Ӹ����ƪ������",220,0,"����С��") 		
		SetS(1, 4, 0, 1, 9)		
	end
end