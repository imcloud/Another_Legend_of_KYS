--/////////////////////////////
--	playersetting ������ǵ��������ô�����غ���
--/////////////////////////////
HHH_GAME_SETTING = {}

local function initGameSetting()
	
	--����3���ֶ��Ǳ������������ֶ�������Ҫ�ģ���Ҫ���׸�
	HHH_GAME_SETTING["PADDED_NOUSE_2B_FIELD_COUNT"]	= 60		
	HHH_GAME_SETTING["PADDED_NOUSE_4B_FIELD_COUNT"]	= 20
	HHH_GAME_SETTING["WG_COUNT_MAX_LIMIT"]					= 50		-- ÿ���˵��书�������޵����ޣ�HHH_GAME_SETTING["WG_COUNT_MAX"]�ɱ仪�������ɳ�����ֵ�����Ҳ��Ҫ���׸Ķ�����Ϊ�漰�浵���ݣ�Ҫ�ľ͸������HHH_GAME_SETTING["WG_COUNT_MAX"]����ֵ��[10, 50]֮�伴��
	
	--�������Щ�ֶ�����Ϸ�пɵ������õ�,�����ѵȼ����޺��书�������ޡ��书�ĵȼ����޸�С�Ļ�����Ҫ���¿���

	HHH_GAME_SETTING["WG_COUNT_MAX"]								= 12		-- ÿ���˵��书��������
	
	HHH_GAME_SETTING["EnableMusic"]									= 1			-- �Ƿ������
	HHH_GAME_SETTING["EnableSound"]									= 1			-- �Ƿ����Ч
	HHH_GAME_SETTING["RepairMapErrorMove"]					= 0			-- �Ƿ��޸��ڵ�ͼ������ƶ�ʱ�����Ҷ�
	HHH_GAME_SETTING["RepairWarFeelDelay"]					= 0			-- �Ƿ��޸���ս����ż������ÿ�������
end

--HHH_SKILL_TREE_SET	= {}		-- װ���������ս������������Ϣ��table

local function transform_1DimensionTable_to_2DimensionTable(t, element_count_in_unit)
	local t2 		= nil
	local keyLoop	= nil
	local valueLoop	= nil
	if t ~= nil then
		t2 = {}
		for i = 1, math.modf((#t)/element_count_in_unit) do
			keyLoop		= t[element_count_in_unit*(i-1)+1]
			valueLoop	= t[element_count_in_unit*(i-1)+2]
			if keyLoop ~= nil and valueLoop ~= nil then
				t2[keyLoop] = valueLoop
			end
		end
	end
	return t2
end
local function compare2GameSetting(array1, array2)
	local hasError	= false
	local isSame		= true
	if array1 == nil or array2 == nil then
		help.util.debug("[compare2GameSetting] 1 ERROR array1="..tostring(array1)..", array2="..tostring(array2))
		hasError = true
	else
		for k,v in pairs(array1) do
			if k ~= nil and v ~= nil and array2[k] ~= nil then
				if v ~= array2[k] then
					help.util.debug("[compare2GameSetting] [Found Update] ["..tostring(k).."]\t"..tostring(v).."--->"..tostring(array2[k]))
					isSame = false
				end
			else
				help.util.debug("[compare2GameSetting] 2 ERROR k="..tostring(k))
				hasError = true
			end
		end
	end
	return hasError, isSame
end
local function compare2TreeSet(ts1, ts2)
	local hasError	= false
	local isSame		= true
	if ts1 == nil or ts2 == nil then
		help.util.debug("[compare2TreeSet] 1 ERROR ts1="..tostring(ts1)..", ts2="..tostring(ts2))
		hasError = true
	else
		for k,v in pairs(ts1) do
			if k ~= nil and v ~= nil and type(v) == "table" and ts2[k] ~= nil and type(ts2[k]) == "table" then
				for k1,v1 in pairs(ts1[k]) do
					if k1 ~= nil and v1 ~= nil and ts2[k][k1] ~= nil then
						if v1 ~= ts2[k][k1] then
							help.util.debug("[compare2TreeSet] [Found Update] ["..tostring(k).."]["..tostring(k1).."]\t"..tostring(v1).."--->"..tostring(ts2[k][k1]))
							isSame = false
						end
					else
						help.util.debug("[compare2TreeSet] 3 ERROR k="..tostring(k)..", k1="..tostring(k1)..", v1="..tostring(v1))
						hasError = true
					end
				end
			else
				help.util.debug("[compare2TreeSet] 2 ERROR k="..tostring(k))
				hasError = true
			end
		end
	end
	return hasError, isSame
end
local function load_GameSetting_from_file(id)
	local fileName	= CC.R_PersonSkillFilename[id]
	local fileExist	= help.file.is_file_exists(fileName)
	if fileExist then
		local content = help.file.readfile_allcontent(fileName)
		if content ~= nil then
			help.util.debug("[load_GameSetting_from_file] load_file_size="..string.len(content))
			
			local load_data				= json.decode(content)
			local tmpGameSetting	= load_data["HHH_GAME_SETTING"]
			--local tmpTreeSet			= load_data["HHH_SKILL_TREE_SET"]
			
			local hasError1, isSame1 = compare2GameSetting(HHH_GAME_SETTING, tmpGameSetting)
			if hasError1 then
				help.util.debug("[load_GameSetting_from_file] [Error] [not replace] [because new game_setting file["..fileName.."] has hasError]")
			else
				if isSame1 then
					help.util.debug("[load_GameSetting_from_file] [Not_Error] [not replace] [because new game_setting file["..fileName.."] is same as old]")
				else
					HHH_GAME_SETTING = tmpGameSetting
				end
			end
			
			local load_EnableMusic	= HHH_GAME_SETTING["EnableMusic"] or 0		-- �Ƿ������
			local load_EnableSound	= HHH_GAME_SETTING["EnableSound"]	or 0		-- �Ƿ����Ч
			if load_EnableMusic ~= JY.EnableMusic then
				JY.EnableMusic	= load_EnableMusic															-- �Ƿ������
				
				if JY.EnableMusic == 0 then
					lib.PlayMIDI("")
				else
					PlayMIDI(JY.CurrentMIDI)
				end
			end
			if load_EnableSound ~= JY.EnableSound then
				JY.EnableSound	= load_EnableSound															-- �Ƿ����Ч
			end
			
			--local hasError2, isSame2 = compare2TreeSet(HHH_SKILL_TREE_SET, tmpTreeSet)
			--if hasError2 then
			--	help.util.debug("[load_GameSetting_from_file] [Error] [not replace] [because new skill_tree file["..fileName.."] has hasError]")
			--else
			--	if isSame2 then
				--	help.util.debug("[load_GameSetting_from_file] [Not_Error] [not replace] [because new skill_tree file["..fileName.."] is same as old]")
				--else
				--	HHH_SKILL_TREE_SET = tmpTreeSet
			--	end
			--end
		end
	end
end
local function store_GameSetting_to_file(id)
	local fileName	= CC.R_PersonSkillFilename[id]
	
	local save_data = {}
	save_data["HHH_GAME_SETTING"]		= HHH_GAME_SETTING
	--save_data["HHH_SKILL_TREE_SET"]	= HHH_SKILL_TREE_SET
	
	local content = json.encode(save_data)
	if fileName ~= nil and content ~= nil then
		help.file.writefile(fileName, content)
		help.util.debug("[store_GameSetting_to_file] store_file_size="..string.len(content))
	end
end
--local function user_select_person_skill_tree()
	--local r = help.display.person_skill_tree_select(HHH_SKILL_TREE_SET, HHH_SKILL_TREE_TABLE)
	--if r ~= nil and r > 0 then
	--end
--end

local function populateMapAttribute(mapOutput, mapInput, key, useDefaultValueIfNull, defaultValue)
	if mapOutput~= nil and key ~= nil then
		local val	= nil
		
		if mapInput ~= nil and mapInput[key] ~= nil then
			val = mapInput[key]
		else
			if useDefaultValueIfNull and defaultValue ~= nil then
				local typeValue = type(defaultValue)
				if typeValue ~= "nil" and 
					(typeValue == "number" or typeValue == "string" or typeValue == "table" or typeValue == "boolean") then
					
					val = defaultValue
				elseif typeValue == "function" then
					val = defaultValue()	-- Ŀǰ, ����ĺ��� û�в���
				end
			end
		end
		
		if val ~= nil then
			if type(val) == "number" and type(mapOutput[key]) == "number" then
				--if mapOutput[key] < val then
					mapOutput[key] = val
				--end
			else
				mapOutput[key] = val
			end
		end
	end
end
local function initExp()
	--[[
	for i = 1, CC.Level do
		help.util.debug("[initExp] [CC.Exp["..i.."]="..CC.Exp[i].."]")
	end
	]]--
  if CC.Level < HHH_GAME_SETTING["PERSON_LEVEL_MAX"] then
  	for i = CC.Level + 1, HHH_GAME_SETTING["PERSON_LEVEL_MAX"] do
  		CC.Exp[i]	= math.modf(CC.Exp[i-1] * 1.12)
  		--help.util.debug("[initExp] [CC.Exp["..i.."]="..CC.Exp[i].."]")
  	end
  	CC.Level = HHH_GAME_SETTING["PERSON_LEVEL_MAX"]
  	CC.PersonAttribMax["����2"] = math.min(CC.Exp[HHH_GAME_SETTING["PERSON_LEVEL_MAX"]], 200000000)	-- ������ֵ�����ֵ
  	
  	--help.util.debug("[initExp] [CC.Level="..CC.Level.."] [CC.PersonAttribMax[����2]="..CC.PersonAttribMax["����2"].."]")
  end
  
end

local function myInit_1step()
	initGameSetting()															-- ��Ϸ������ص�
  --initPersonSkillTree() 												-- ���＼����������ص�
  help.data.Expand_Person_Padded_keys_init()		-- �ɷ����������� �������� ��Щ�ֶ�������ģ���Ҫ���·�����ȡ�ģ����ڿ��ܲ�����Ҫ�����Ǳ������ø�
end
local function myInit_2step()
  --initExp()																			-- ��Ϊ�õ��� const �����ݣ�Ų���ڶ����ȸ÷��������ú���ִ��
  --initWugongWeili()
  help.data.assert_store_file_exist()						-- ȷ��������Ĵ浵�ļ����ڣ���ΪC�İ�������ֻ��׷��д�����ܴ������ļ�
end

--local function is_self_update_role(pid, skill_key, setting_key)
--	local objRtn = nil
--	if is_self_update_role2(pid) then
--		if HHH_SKILL_TREE_SET ~= nil and HHH_SKILL_TREE_SET[skill_key] ~= nil then
--			objRtn = HHH_SKILL_TREE_SET[skill_key][setting_key]
--		end
		
--		if objRtn == nil then
----			help.util.debug("[ERROR] is_self_update_role["..pid.."]["..skill_key.."]["..setting_key.."]=nil")
--		end
		--help.util.debug("[TRACE] is_self_update_role["..pid.."]["..skill_key.."]["..setting_key.."]="..tostring(objRtn))
--	end
	
--	return objRtn
--end

help.playersetting = {
	myInit_1step													= myInit_1step,
	myInit_2step													= myInit_2step,
	is_self_update_role										= is_self_update_role,
	--is_self_update_role2									= is_self_update_role2,
	load_GameSetting_from_file 						= load_GameSetting_from_file,
	store_GameSetting_to_file							= store_GameSetting_to_file,
	--user_select_person_skill_tree					= user_select_person_skill_tree,
	--getPersonSkillDefinitionByTypeAndKey	= getPersonSkillDefinitionByTypeAndKey
}

return help.playersetting