
-- local MakePlayerCharacter = require "prefabs/player_common"


-- local assets = {
--     Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
-- }
-- local prefabs = {}

-- -- 初始物品
-- local start_inv = {
-- 	"sjy_gudongpifeng",
-- 	"sjy_gudongwanguan",
-- 	--自带一个长矛
-- }
-- -- 当人物复活的时候
-- local function onbecamehuman(inst)
-- 	-- 设置人物的移速（1表示1倍于wilson）
-- 	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "esctemplate_speed_mod", 1)
-- end
-- --当人物死亡的时候
-- local function onbecameghost(inst)
-- 	-- 变成鬼魂的时候移除速度修正
--    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "esctemplate_speed_mod")
-- end

-- -- 重载游戏或者生成一个玩家的时候
-- local function onload(inst)
--     inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
--     inst:ListenForEvent("ms_becameghost", onbecameghost)

--     if inst:HasTag("playerghost") then
--         onbecameghost(inst)
--     else
--         onbecamehuman(inst)
--     end
-- end


-- local sjy_sans = 0

-- local function IsEatings(inst, data)
-- 	local food = data and data.food
-- 	if food:HasTag("preparedfood") then
-- 		if inst.components.health and inst.components.health.maxhealth < 200 then
-- 			local getcurrenthealth = inst.components.health.currenthealth
-- 			local maxhealth = inst.components.health.maxhealth
-- 			inst.components.health:SetMaxHealth(maxhealth +0.2)
-- 			if inst.components.health.maxhealth >= getcurrenthealth then
-- 				inst.components.health.currenthealth = getcurrenthealth
-- 				inst.components.health:DoDelta(0)
-- 			end
-- 			inst.xueliang = inst.components.health.maxhealth
-- 		end
-- 	end
-- end



-- local function IsSan(inst, data)
-- 		if inst.components.sanity  then
-- 			local getcurrentsanity = inst.components.sanity.current
-- 			local maxsanity = inst.components.sanity.max
-- 			inst.components.sanity:SetMax(maxsanity + 300)
-- 			inst.components.talker:Say("本国王又长知识嘞！")
-- 			if inst.components.sanity.max >= getcurrentsanity then
-- 				inst.components.sanity.currentsanity = getcurrentsanity
-- 				inst.components.sanity:DoDelta(0)
-- 			end
-- 			inst.sans = inst.components.sanity.max
-- 		end
-- end


-- ----加载
-- local function onpreload(inst, data)
-- 	if data then
-- 		if data.xueliang then
-- 			inst.xueliang = data.xueliang
-- 			if inst.components.health then
-- 				inst.components.health:SetMaxHealth(inst.xueliang)
-- 			end
-- 		end
-- 		if data.sans then
-- 			inst.sans = data.sans
-- 			if inst.components.sanity then
-- 				inst.components.sanity:SetMax(inst.sans)
-- 			end
-- 		end
-- 	end
	
-- end

-- ----保存
-- local function onsave(inst, data)
-- 	data.xueliang = inst.xueliang
-- 	data.sans = inst.sans
-- 	-- inst.components.health:SetMaxHealth(inst.xueliang)
-- end


-- -- 疑似夜晚也可以回san
-- local function GetEquippableDapperness(owner, equippable)
-- 	local dapperness = equippable:GetDapperness(owner, owner.components.sanity.no_moisture_penalty)
-- 	return equippable.inst:HasTag("shadow_item")
-- 		and dapperness * TUNING.WAXWELL_SHADOW_ITEM_RESISTANCE
-- 		or dapperness
-- end

-- --这个函数将在服务器和客户端都会执行
-- --一般用于添加小地图标签等动画文件或者需要主客机都执行的组件（少数）
-- local common_postinit = function(inst) 
-- 	-- Minimap icon
-- 	inst.MiniMapEntity:SetIcon( "esctemplate.tex" )
-- end

-- -- 这里的的函数只在主机执行  一般组件之类的都写在这里
-- local master_postinit = function(inst)

-- 	inst.xueliang = 30
-- 	inst.sans = 60
-- 	inst.OnSave = onsave		----保存
-- 	inst.OnPreLoad = onpreload	----加载
	
-- 	-- 人物音效
-- 	inst.soundsname = "willow"

-- 	--最喜欢的食物  名字 倍率（1.2）
-- 	inst.components.foodaffinity:AddPrefabAffinity("baconeggs", TUNING.AFFINITY_15_CALORIES_HUGE)

	

	
-- 	inst.components.health:SetMaxHealth(inst.xueliang)
-- 	inst.components.hunger:SetMax(75)
-- 	inst.components.sanity:SetMax(inst.sans)
-- 	print("前")
-- 	print(inst.components.sanity.max)
-- 	print("前")
-- 	if inst.components.sanity.max >300 then
-- 		print("后")
-- 		print(inst.components.sanity.max)
-- 		print("可以读书了")
-- 		inst:AddTag("bookbuilder")
-- 		inst:AddTag("reader")
-- 		local SHADOWCREATURE_MUST_TAGS = { "shadowcreature", "_combat", "locomotor" }
-- 		local SHADOWCREATURE_CANT_TAGS = { "INLIMBO", "notaunt" }

-- 		local function OnReadFn(inst, book)
-- 			if inst.components.sanity:IsInsane() then
				
-- 				local x,y,z = inst.Transform:GetWorldPosition()
-- 				local ents = TheSim:FindEntities(x, y, z, 16, SHADOWCREATURE_MUST_TAGS, SHADOWCREATURE_CANT_TAGS)
		
-- 				if #ents < TUNING.BOOK_MAX_SHADOWCREATURES then
-- 					TheWorld.components.shadowcreaturespawner:SpawnShadowCreature(inst)
-- 				end
-- 			end
-- 		end

-- 		inst:AddComponent("reader")
-- 		--调用可读书函数
-- 		inst.components.reader:SetOnReadFn(OnReadFn)

-- 		inst.components.talker:Say("本咕咚国王写了几本小说！")
-- 	end

-- 	-- 三维	
	
-- 	inst:ListenForEvent("oneat", IsEatings)
-- 	inst:WatchWorldState("startday",IsSan)
-- 	inst.components.health.absorb = 0.1	
-- 	-- 添加位面防御
-- 	inst:AddComponent("planardefense")
-- 	-- 减免10点位面防御 角色自带
--     inst.components.planardefense:SetBaseDefense(1000)
-- 	-- 夜晚不掉san与不受装备影响掉san
-- 	inst.components.sanity.dapperness = TUNING.DAPPERNESS_SUPERHUGE
-- 	inst.components.sanity.get_equippable_dappernessfn = GetEquippableDapperness
-- 		--------------------------------------------------------------------------------
-- 	-- 伤害系数
--     inst.components.combat.damagemultiplier = 0.9
	
-- 	-- 饥饿速度
-- 	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

-- 	inst.components.temperature.maxtemp = 20
-- 	--最低温度
-- 	inst.components.temperature.mintemp = 20

-- 	inst.OnLoad = onload
--     inst.OnNewSpawn = onload
	
-- end

-- return MakePlayerCharacter("esctemplate", prefabs, assets, common_postinit, master_postinit, start_inv)






















local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("SOUND", "sound/willow.fsb"), -- 复用willow音效
    
    Asset( "IMAGE", "images/saveslot_portraits/esctemplate.tex" ), --存档图片
    Asset( "ATLAS", "images/saveslot_portraits/esctemplate.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/esctemplate.tex" ), --单机选人界面
    Asset( "ATLAS", "images/selectscreen_portraits/esctemplate.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/esctemplate_silho.tex" ), --单机未解锁界面
    Asset( "ATLAS", "images/selectscreen_portraits/esctemplate_silho.xml" ),

    Asset( "IMAGE", "bigportraits/esctemplate.tex" ), --人物大图（方形的那个）
    Asset( "ATLAS", "bigportraits/esctemplate.xml" ),
	
	Asset( "IMAGE", "images/map_icons/esctemplate.tex" ), --小地图
	Asset( "ATLAS", "images/map_icons/esctemplate.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_esctemplate.tex" ), --tab键人物列表显示的头像
    Asset( "ATLAS", "images/avatars/avatar_esctemplate.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_esctemplate.tex" ),--tab键人物列表显示的头像（死亡）
    Asset( "ATLAS", "images/avatars/avatar_ghost_esctemplate.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_esctemplate.tex" ), --人物检查按钮的图片
    Asset( "ATLAS", "images/avatars/self_inspect_esctemplate.xml" ),
	
	Asset( "IMAGE", "images/names_esctemplate.tex" ),  --人物名字
    Asset( "ATLAS", "images/names_esctemplate.xml" ),
	
    Asset( "IMAGE", "bigportraits/esctemplate_none.tex" ),  --人物大图（椭圆的那个）
    Asset( "ATLAS", "bigportraits/esctemplate_none.xml" ),

}

local prefabs = {}

-- 初始物品
local start_inv = {
    "sjy_gudongpifeng",
    "sjy_gudongwanguan",
    "spear", -- 自带长矛
}

-- 当人物复活的时候
local function onbecamehuman(inst)
    -- 设置人物的移速（1表示1倍于wilson）
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "esctemplate_speed_mod", 1)
end

-- 当人物死亡的时候
local function onbecameghost(inst)
    -- 变成鬼魂的时候移除速度修正
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "esctemplate_speed_mod")
end

-- 重载游戏或者生成一个玩家的时候
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

-- 检查并更新san值相关能力（读书/造书）【提前定义，解决变量未声明问题】
local function CheckSanityAbilities(inst)
    local sanity_max = inst.components.sanity and inst.components.sanity.max or 0

    -- 解锁读书能力（san上限≥150）
    if sanity_max >= 150 then
        if not inst:HasTag("reader") then
            inst:AddTag("reader")
            -- 仅在没有reader组件时添加
            if not inst.components.reader then
                inst:AddComponent("reader")
                -- 设置读书时的行为（参考wickerbottom）
                local SHADOWCREATURE_MUST_TAGS = { "shadowcreature", "_combat", "locomotor" }
                local SHADOWCREATURE_CANT_TAGS = { "INLIMBO", "notaunt" }
                local function OnReadFn(inst, book)
                    if inst.components.sanity:IsInsane() then
                        local x, y, z = inst.Transform:GetWorldPosition()
                        local ents = TheSim:FindEntities(x, y, z, 16, SHADOWCREATURE_MUST_TAGS, SHADOWCREATURE_CANT_TAGS)
                        if #ents < TUNING.BOOK_MAX_SHADOWCREATURES then
                            TheWorld.components.shadowcreaturespawner:SpawnShadowCreature(inst)
                        end
                    end
                end
                inst.components.reader:SetOnReadFn(OnReadFn)
            end
            inst.components.talker:Say("我现在能读懂这些书了！")
        end
    else
        -- 低于150时移除读书能力
        if inst:HasTag("reader") then
            inst:RemoveTag("reader")
        end
    end

    -- 解锁造书能力（san上限≥200）
    if sanity_max >= 200 then
        if not inst:HasTag("bookbuilder") then
            inst:AddTag("bookbuilder")
            inst.components.talker:Say("我现在能创作书籍了！")
        end
    else
        -- 低于200时移除造书能力
        if inst:HasTag("bookbuilder") then
            inst:RemoveTag("bookbuilder")
        end
    end
end

-- 处理食用烹饪食物增加血量上限
local function OnEatPreparedFood(inst, data)
    local food = data and data.food
    if food and food:HasTag("preparedfood") then -- 只对烹饪锅料理生效
        local health = inst.components.health
        if health then
            local current_max = health.maxhealth
            local new_max = math.min(current_max + 0.2, 200) -- 上限不超过200
            if new_max > current_max then
                local current_health = health.currenthealth
                health:SetMaxHealth(new_max)
                -- 确保当前血量不变（若当前血量超过新上限则设为新上限，否则保持）
                health.currenthealth = math.min(current_health, new_max)
                inst.xueliang = new_max -- 更新保存用的变量
            end
        end
    end
end

-- 处理每天增加san值上限
local function OnDayStart(inst)
    local sanity = inst.components.sanity
    if sanity then
        local current_max = sanity.max
        local new_max = math.min(current_max + 2, 300) -- 每天+2，上限300
        if new_max > current_max then
            local current_sanity = sanity.current
            sanity:SetMax(new_max)
            -- 确保当前san值不变（若当前san超过新上限则设为新上限，否则保持）
            sanity.current = math.min(current_sanity, new_max)
            inst.sans = new_max -- 更新保存用的变量
            inst.components.talker:Say("本国王又长知识嘞！")
            
            -- 检查是否解锁读书/造书能力（已提前定义）
            CheckSanityAbilities(inst)
        end
    end
end

-- 加载时恢复数据
local function onpreload(inst, data)
    if data then
        -- 恢复血量上限
        if data.xueliang then
            inst.xueliang = math.min(data.xueliang, 200) -- 确保不超过上限
            if inst.components.health then
                local current_health = inst.components.health.currenthealth
                inst.components.health:SetMaxHealth(inst.xueliang)
                inst.components.health.currenthealth = math.min(current_health, inst.xueliang)
            end
        end
        -- 恢复san值上限
        if data.sans then
            inst.sans = math.min(data.sans, 300) -- 确保不超过上限
            if inst.components.sanity then
                local current_sanity = inst.components.sanity.current
                inst.components.sanity:SetMax(inst.sans)
                inst.components.sanity.current = math.min(current_sanity, inst.sans)
            end
            -- 加载后检查能力解锁状态
            CheckSanityAbilities(inst)
        end
    end
end

-- 保存数据
local function onsave(inst, data)
    data.xueliang = inst.xueliang -- 保存当前血量上限
    data.sans = inst.sans -- 保存当前san值上限
end

-- 夜晚san值处理（不掉san且不受装备影响）
local function GetEquippableDapperness(owner, equippable)
    local dapperness = equippable:GetDapperness(owner, owner.components.sanity.no_moisture_penalty)
    -- 影子物品额外处理（参考wickerbottom逻辑）
    return equippable.inst:HasTag("shadow_item")
        and dapperness * TUNING.WAXWELL_SHADOW_ITEM_RESISTANCE
        or dapperness
end

-- 客户端和服务器共同初始化
local common_postinit = function(inst)
    -- 小地图图标
    inst.MiniMapEntity:SetIcon("esctemplate.tex")
end

-- 服务器端初始化
local master_postinit = function(inst)
    -- 初始化属性上限变量
    inst.xueliang = 30 -- 基础血量上限30
    inst.sans = 60 -- 基础san值上限60

    -- 绑定保存和加载函数
    inst.OnSave = onsave
    inst.OnPreLoad = onpreload

    -- 人物音效
    inst.soundsname = "willow"

    -- 最喜欢的食物
    inst.components.foodaffinity:AddPrefabAffinity("baconeggs", TUNING.AFFINITY_15_CALORIES_HUGE)

    -- 初始化三维属性
    inst.components.health:SetMaxHealth(inst.xueliang)
    inst.components.hunger:SetMax(75)
    inst.components.sanity:SetMax(inst.sans)

    -- 血量吸收
    inst.components.health.absorb = 0.1

    -- 添加位面防御
    inst:AddComponent("planardefense")
    inst.components.planardefense:SetBaseDefense(1000) -- 自带1000点位面防御

    -- 夜晚不掉san设置
    inst.components.sanity.dapperness = TUNING.DAPPERNESS_SUPERHUGE
    inst.components.sanity.get_equippable_dappernessfn = GetEquippableDapperness

    -- 伤害系数
    inst.components.combat.damagemultiplier = 0.9

    -- 饥饿速度（1倍于Wilson）
    inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

    -- 温度设置（固定在20度）
    inst.components.temperature.maxtemp = 20
    inst.components.temperature.mintemp = 20

    -- 监听事件
    inst:ListenForEvent("oneat", OnEatPreparedFood) -- 监听进食事件
    inst:WatchWorldState("startday", OnDayStart) -- 监听每天开始事件

    -- 初始化加载和重生处理
    inst.OnLoad = onload
    inst.OnNewSpawn = onload

    -- 初始检查san能力（初始60，不满足解锁条件）
    CheckSanityAbilities(inst)
end

return MakePlayerCharacter("esctemplate", prefabs, assets, common_postinit, master_postinit, start_inv)