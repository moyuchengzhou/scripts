
GLOBAL.setmetatable(env,{__index = function(t, k)return GLOBAL.rawget(GLOBAL,k)end,})

local SJY_DADOUBEAN = GLOBAL.Action({priority = 99,mount_valid = true}) 
SJY_DADOUBEAN.id = "SJY_DADOUBEAN"                                 
SJY_DADOUBEAN.str = "用嘴剥开"                                              
SJY_DADOUBEAN.fn = function(act)                                        
   local inst = act.invobject
   local target = act.target
   local doer = act.doer
   local count = (inst and inst.components and inst.components.stackable) and inst.components.stackable:StackSize() or 1 
   inst.components.lootdropper:SpawnLootPrefab("sjy_lvdoubean")
   inst.components.stackable:Get(1):Remove()  --一次性道具
   return true
end
AddAction(SJY_DADOUBEAN)


AddComponentAction("INVENTORY", "inventoryitem", function(inst, doer, actions, right)
    if inst and inst:HasTag("sjy_dadoubean") and doer ~= nil and doer:HasTag("player") then
        table.insert(actions, ACTIONS.SJY_DADOUBEAN)
    end
 end)     

 AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(ACTIONS.SJY_DADOUBEAN, "quickeat"))
 AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(ACTIONS.SJY_DADOUBEAN, "quickeat"))


 --================ actions
local SJY_GAIBIAN = GLOBAL.Action({priority=10})
SJY_GAIBIAN.id = "SJY_GAIBIAN"
SJY_GAIBIAN.str = "改造"
SJY_GAIBIAN.fn = function(act)
	if act.invobject and act.invobject.components.sjy_gaibian and act.target  then
		return act.invobject.components.sjy_gaibian:GaiBian(act.target)
	end	
end

local SJY_WUXIANNAIJIU = GLOBAL.Action({priority=10})
SJY_WUXIANNAIJIU.id = "SJY_WUXIANNAIJIU"
SJY_WUXIANNAIJIU.str = "使用"
SJY_WUXIANNAIJIU.fn = function(act)
	if act.invobject and act.target and act.target.components.sjy_wuxiannaijiu then
		return act.target.components.sjy_wuxiannaijiu:SetWNJ(act.invobject)
	end	
end
AddAction(SJY_GAIBIAN)
AddAction(SJY_WUXIANNAIJIU)


AddComponentAction("USEITEM", "sjy_wuxiannaijiuyonghu" , function(inst, doer, target, actions) 
	if  target and target:HasTag("can_sjy_wuxiannaijiu") then
		table.insert(actions, ACTIONS.SJY_WUXIANNAIJIU)
	end
end)

AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(ACTIONS.SJY_WUXIANNAIJIU, "dolongaction"))
AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(ACTIONS.SJY_WUXIANNAIJIU, "dolongaction"))

AddComponentPostInit("fueled", function(self) 
    if self.inst then 
        self.inst:AddComponent('sjy_wuxiannaijiu') 
    end 
end)

AddComponentPostInit("finiteuses", function(self) 
    if self.inst then 
        self.inst:AddComponent('sjy_wuxiannaijiu') 
    end 
end)

AddComponentPostInit("armor", function(self) 
    if self.inst then 
        self.inst:AddComponent('sjy_wuxiannaijiu') 
    end 
end)


-- 注册土豆召唤者的使用动作
local Action = GLOBAL.Action
local ActionHandler = GLOBAL.ActionHandler
local STRINGS = GLOBAL.STRINGS

-- 定义"使用土豆召唤者"动作
local ACTION_USE_POTATO_SUMMONER = Action({mount_valid = true})
ACTION_USE_POTATO_SUMMONER.id = "USE_POTATO_SUMMONER"
ACTION_USE_POTATO_SUMMONER.str = "召唤土豆"  -- 动作显示文本
ACTION_USE_POTATO_SUMMONER.fn = function(act)
    -- 校验使用者和目标物品
    if act.invobject and act.invobject:IsValid() and act.doer and act.doer:IsValid() then
        -- 调用主文件中的召唤逻辑
        if act.invobject.components and act.invobject.components.spellbook then
            -- 触发法术书中的召唤函数
            local spells = act.invobject.components.spellbook:GetItems()
            if spells and spells[1] and spells[1].fn then
                spells[1].fn()
                return true
            end
        end
    end
    return false
end

-- 注册动作到全局
AddAction(ACTION_USE_POTATO_SUMMONER)

-- 绑定动作到物品：当玩家右键点击"potato_summoner"时触发该动作
AddComponentAction("INVENTORY", "inventoryitem", function(inst, doer, actions, right)
    if inst.prefab == "sjy_potato_summoner" and right then
        table.insert(actions, GLOBAL.ACTIONS.USE_POTATO_SUMMONER)
    end
end)

-- 设置动作的操作提示文本
STRINGS.ACTIONS.USE_POTATO_SUMMONER = "召唤土豆"