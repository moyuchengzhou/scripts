-- local assets = {Asset("ANIM", "anim/zshd.zip"), Asset("IMAGE", "images/zshd.tex"), Asset("ATLAS", "images/zshd.xml")}

-- local prefabs =
-- {
--     "ipecacsyrup_buff",
--     "poop",
-- }

-- local function syrup_OnEaten(inst, eater)
--     if eater.sg ~= nil and eater.sg:HasState("ipecacpoop") then
--         eater:AddDebuff("ipecacsyrup_buff", "ipecacsyrup_buff")
--     end
-- end

-- local function fn_syrup()
--     local assetname = "zshd"
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)
--     MakeInventoryFloatable(inst)

--     inst.AnimState:SetBank(assetname)
--     inst.AnimState:SetBuild(assetname)
--     inst.AnimState:PlayAnimation("idle")

--     inst.entity:SetPristine()
--     if not TheWorld.ismastersim then
--         return inst
--     end
--     local edible = inst:AddComponent("edible")
--     edible.foodtype = FOODTYPE.ROUGHAGE
--     edible.healthvalue = 300
--     edible.hungervalue = 1000
--     --edible.sanityvalue = 0 -- this is the default
--     edible:SetOnEatenFn(syrup_OnEaten)
--     -- inst.components.edible.foodtype = FOODTYPE.ROUGHAGE
--     --
--     local stackable = inst:AddComponent("stackable")
--     stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

--     --
--     inst:AddComponent("tradable")
--     inst:AddComponent("inspectable")
--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/zshd.xml" -- 在背包里的贴图
--     --
--     MakeSmallBurnable(inst)
--     MakeSmallPropagator(inst)

--     --
--     MakeHauntableLaunch(inst)

--     return inst
-- end

-- ----
-- local IPECAC_TICK_TIMERNAME = "pooptick"

-- local function buff_OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0,0,0)
--     inst.components.timer:StartTimer(IPECAC_TICK_TIMERNAME, TUNING.IPECAC_TICK_TIME)

--     local stop_fn = function() inst.components.debuff:Stop() end
--     inst:ListenForEvent("death", stop_fn, target)
--     inst:ListenForEvent("onremove", stop_fn, target)
-- end

-- local function buff_OnExtended(inst, target)
--     -- Just reset our count. We don't want subsequent uses to stack up.
--     inst._tick_count = TUNING.IPECAC_POOP_COUNT
-- end

-- local function buff_DoTick(inst)
--     if inst._tick_count <= 0 then
--         inst.components.debuff:Stop()
--     else
--         inst._tick_count = inst._tick_count - 1
--         inst.components.timer:StartTimer(IPECAC_TICK_TIMERNAME, TUNING.IPECAC_TICK_TIME)
--     end

--     local target = inst.components.debuff.target
--     if target then
--         local poop = SpawnPrefab("poop")

--         poop.Transform:SetPosition(target.Transform:GetWorldPosition())
        
--         local periodicspawner = target.components.periodicspawner
--         if periodicspawner ~= nil and periodicspawner.onspawn ~= nil then
--             periodicspawner.onspawn(target, poop)
--         end

--         target:PushEvent("ipecacpoop")

--         local target_health = target.components.health

--         if target_health then
--             target_health:DoDelta(-TUNING.IPECAC_DAMAGE_PER_TICK, nil, inst.prefab, nil, inst)
--         end
--     end
-- end

-- local function buff_OnTimerDone(inst, data)
--     if data.name == IPECAC_TICK_TIMERNAME then
--         buff_DoTick(inst)
--     end
-- end

-- local function buff_OnSave(inst, data)
--     data.tick_count = inst._tick_count
-- end

-- local function buff_OnLoad(inst, data)
--     if data and data.tick_count then
--         inst._tick_count = data.tick_count
--     end
-- end

-- local function fn_buff()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         -- Meant for non-clients
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()

--     inst._tick_count = TUNING.IPECAC_POOP_COUNT

--     --[[Non-networked entity]]
--     inst.entity:Hide()
--     inst.persists = false

--     inst:AddTag("CLASSIFIED")

--     --
--     local debuff = inst:AddComponent("debuff")
--     debuff:SetAttachedFn(buff_OnAttached)
--     debuff:SetDetachedFn(inst.Remove)
--     debuff:SetExtendedFn(buff_OnExtended)

--     --
--     inst:AddComponent("timer")
--     inst:ListenForEvent("timerdone", buff_OnTimerDone)

--     --
--     inst.OnSave = buff_OnSave
--     inst.OnLoad = buff_OnLoad

--     return inst
-- end

-- return
--         Prefab("zshd",      fn_syrup, assets, prefabs),
--         Prefab("ipecacsyrup_buff", fn_buff,  assets         )




















-- local assets = {Asset("ANIM", "anim/zshd.zip"), Asset("IMAGE", "images/zshd.tex"), Asset("ATLAS", "images/zshd.xml")}

-- local prefabs =
-- {
--     "cow_health_buff", -- 牛血量上限buff
-- }

-- -- 食物被食用时的函数
-- local function syrup_OnEaten(inst, eater)
--     -- 只对牛生效（检查牛的标签）
--     if eater:HasTag("beefalo") then
--         -- 添加血量上限buff，重复添加会叠加效果
--         eater:AddDebuff("cow_health_buff", "cow_health_buff")
--     end
-- end

-- -- 食物实体创建函数
-- local function fn_syrup()
--     local assetname = "zshd"
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)
--     MakeInventoryFloatable(inst)

--     inst.AnimState:SetBank(assetname)
--     inst.AnimState:SetBuild(assetname)
--     inst.AnimState:PlayAnimation("idle")

--     inst.entity:SetPristine()
--     if not TheWorld.ismastersim then
--         return inst
--     end

--     -- 食物组件设置
--     local edible = inst:AddComponent("edible")
--     edible.foodtype = FOODTYPE.ROUGHAGE
--     edible.healthvalue = 300 -- 即时恢复的血量
--     edible.hungervalue = 1000 -- 恢复的饥饿值
--     edible:SetOnEatenFn(syrup_OnEaten)

--     -- 堆叠组件
--     local stackable = inst:AddComponent("stackable")
--     stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

--     -- 其他组件
--     inst:AddComponent("tradable")
--     inst:AddComponent("inspectable")
--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/zshd.xml"

--     MakeSmallBurnable(inst)
--     MakeSmallPropagator(inst)
--     MakeHauntableLaunch(inst)

--     return inst
-- end

-- -- 血量上限buff相关函数
-- local function buff_OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 记录当前叠加次数（首次添加为1，后续叠加递增）
--     inst.stack_count = (inst.stack_count or 0) + 1

--     -- 计算总增加的血量上限
--     local total_health_bonus = inst.stack_count * 100

--     -- 修改牛的血量上限
--     if target.components.health then
--         -- 保存原始血量上限（仅首次设置）
--         if target._original_maxhealth == nil then
--             target._original_maxhealth = target.components.health.maxhealth
--         end
--         -- 设置新的血量上限
--         target.components.health:SetMaxHealth(target._original_maxhealth + total_health_bonus)
--         -- 同步当前血量（保持百分比不变）
--         local current_percent = target.components.health:GetPercent()
--         target.components.health:SetMaxHealth(target._original_maxhealth + total_health_bonus)
--         target.components.health:SetPercent(current_percent)
--     end

--     -- 监听牛的死亡和移除事件
--     local stop_fn = function() inst:Remove() end
--     inst:ListenForEvent("death", stop_fn, target)
--     inst:ListenForEvent("onremove", stop_fn, target)
-- end

-- -- 重复添加buff时的叠加处理
-- local function buff_OnExtended(inst, target)
--     buff_OnAttached(inst, target) -- 直接复用附加函数实现叠加
-- end

-- -- buff实体创建函数
-- local function fn_buff()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()
--     inst.entity:Hide()
--     inst.persists = true -- 确保buff会被保存

--     inst:AddTag("CLASSIFIED")

--     --  debuff组件（用于持续附着和叠加）
--     local debuff = inst:AddComponent("debuff")
--     debuff:SetAttachedFn(buff_OnAttached)
--     debuff:SetDetachedFn(inst.Remove)
--     debuff:SetExtendedFn(buff_OnExtended)
--     debuff.keepondespawn = true -- 确保牛离开再回来buff依然有效

--     -- 保存和加载函数（确保叠加次数不会丢失）
--     inst.OnSave = function(inst, data)
--         data.stack_count = inst.stack_count
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stack_count then
--             inst.stack_count = data.stack_count
--         end
--     end

--     return inst
-- end

-- return
--     Prefab("zshd", fn_syrup, assets, prefabs),
--     Prefab("cow_health_buff", fn_buff, {})










-- local easing = require("easing")

-- local assets = {
--     Asset("ANIM", "anim/zshd.zip"),
--     Asset("IMAGE", "images/zshd.tex"),
--     Asset("ATLAS", "images/zshd.xml")
-- }

-- local prefabs = {
--     "cow_health_buff",
-- }

-- -- 检查实体是否有效
-- local function IsValidEntity(inst)
--     return inst ~= nil and type(inst) == "table" and inst.entity ~= nil and inst.entity:IsValid()
-- end

-- -- 平滑修改属性的辅助函数
-- local function LerpAttribute(component, target_value, duration)
--     if not component or not component.inst or not IsValidEntity(component.inst) then
--         return
--     end
    
--     if component.current == nil then
--         return
--     end
    
--     local start_value = component.current
--     local time = 0
--     local inst = component.inst

--     -- 停止之前的更新任务
--     if inst.attribute_lerp_task then
--         inst.attribute_lerp_task:Cancel()
--         inst.attribute_lerp_task = nil
--     end

--     local update_task = inst:DoPeriodicTask(0.1, function()
--         if not IsValidEntity(inst) then
--             if inst.attribute_lerp_task then
--                 inst.attribute_lerp_task:Cancel()
--                 inst.attribute_lerp_task = nil
--             end
--             return
--         end
        
--         time = time + 0.1
--         local progress = math.min(time / duration, 1)
--         local new_value = easing.outQuad(progress, start_value, target_value - start_value, 1)
        
--         if component.SetPercent and component.max then
--             local percent = new_value / component.max
--             component:SetPercent(percent)
--         else
--             component.current = new_value
--         end
        
--         if progress >= 1 then
--             if inst.attribute_lerp_task then
--                 inst.attribute_lerp_task:Cancel()
--                 inst.attribute_lerp_task = nil
--             end
--         end
--     end)
    
--     inst.attribute_lerp_task = update_task
-- end

-- -- 从铃铛获取牛的buff数据
-- local function GetBuffDataFromBell(beefalo)
--     if not IsValidEntity(beefalo) then return nil end
--     if not beefalo.components or not beefalo.components.follower then return nil end
    
--     local bell_owner = beefalo.components.follower:GetLeader()
--     if bell_owner and IsValidEntity(bell_owner) and bell_owner:HasTag("bell") and bell_owner.beefalo_buff_data then
--         return bell_owner.beefalo_buff_data[beefalo.GUID]
--     end
--     return nil
-- end

-- -- 保存buff数据到铃铛（修复崩溃点）
-- local function SaveBuffDataToBell(beefalo, data)
--     if not IsValidEntity(beefalo) then return end
--     if not beefalo.components or not beefalo.components.follower then return end
    
--     local bell_owner = beefalo.components.follower:GetLeader()
--     -- 检查铃铛是否有效且不在LIMBO状态
--     if bell_owner and IsValidEntity(bell_owner) and not bell_owner:HasTag("INLIMBO") and bell_owner:HasTag("bell") then
--         if not bell_owner.beefalo_buff_data then
--             bell_owner.beefalo_buff_data = {}
--         end
--         bell_owner.beefalo_buff_data[beefalo.GUID] = data
        
--         -- 正确的保存机制：使用实体的Save方法而非inventoryitem的
--         if bell_owner.Save then
--             bell_owner:Save()
--         end
--     end
-- end

-- -- 牛实体的数据保存函数
-- local function OnBeefaloSave(inst, data)
--     data = data or {}
--     if inst._beefalo_buff_data then
--         data.beefalo_buff = inst._beefalo_buff_data
--     end
-- end

-- -- 牛实体的数据加载函数
-- local function OnBeefaloLoad(inst, data)
--     if data and data.beefalo_buff then
--         inst._beefalo_buff_data = data.beefalo_buff
--         -- 延迟更新属性，确保实体初始化完成
--         inst:DoTaskInTime(0.5, function()
--             UpdateBeefaloStats(inst)
--         end)
--     end
-- end

-- -- 食物被食用时的函数
-- local function syrup_OnEaten(inst, eater)
--     if eater and IsValidEntity(eater) and eater:HasTag("beefalo") then
--         if TheWorld.ismastersim then
--             eater:DoTaskInTime(0.1, function()
--                 if IsValidEntity(eater) then
--                     -- 确保牛有保存/加载机制
--                     if not eater._has_buff_saveload then
--                         eater:ListenForEvent("save", OnBeefaloSave)
--                         eater:ListenForEvent("load", OnBeefaloLoad)
--                         eater._has_buff_saveload = true
--                     end
--                     eater:AddDebuff("cow_health_buff", "cow_health_buff")
--                 end
--             end)
--         end
--     end
-- end

-- -- 食物实体创建函数
-- local function fn_syrup()
--     local assetname = "zshd"
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)
--     MakeInventoryFloatable(inst)

--     inst.AnimState:SetBank(assetname)
--     inst.AnimState:SetBuild(assetname)
--     inst.AnimState:PlayAnimation("idle")

--     inst.entity:SetPristine()
--     if not TheWorld.ismastersim then
--         return inst
--     end

--     local edible = inst:AddComponent("edible")
--     edible.foodtype = FOODTYPE.ROUGHAGE
--     edible.healthvalue = 300
--     edible.hungervalue = 1000
--     edible:SetOnEatenFn(syrup_OnEaten)

--     local stackable = inst:AddComponent("stackable")
--     stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

--     inst:AddComponent("tradable")
--     inst:AddComponent("inspectable")
--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/zshd.xml"

--     MakeSmallBurnable(inst)
--     MakeSmallPropagator(inst)
--     MakeHauntableLaunch(inst)

--     return inst
-- end

-- -- 更新牛属性的函数
-- local function UpdateBeefaloStats(target)
--     if not IsValidEntity(target) then return end
    
--     local bell_data = GetBuffDataFromBell(target)
--     local data = bell_data or target._beefalo_buff_data or {
--         stack_count = 0,
--         original_maxhealth = target.components.health and target.components.health.maxhealth or 100,
--         original_attack = target.components.combat and target.components.combat.defaultdamage or 10,
--         original_maxhunger = target.components.hunger and target.components.hunger.max or 100
--     }
    
--     -- 双向同步数据
--     if bell_data then
--         target._beefalo_buff_data = data
--     else
--         SaveBuffDataToBell(target, data)
--     end
    
--     local stack_count = math.max(0, data.stack_count or 0)
    
--     local health_bonus = stack_count * 100
--     local attack_bonus = stack_count * 2
--     local hunger_bonus = stack_count * 50
    
--     -- 组件有效性检查
--     if target.components and target.components.health then
--         local new_max_health = data.original_maxhealth + health_bonus
--         target.components.health:SetMaxHealth(new_max_health)
--         if target.components.health.current ~= nil then
--             LerpAttribute(target.components.health, target.components.health.current, 1.0)
--         end
--     end
    
--     if target.components and target.components.combat then
--         target.components.combat:SetDefaultDamage(data.original_attack + attack_bonus)
--     end
    
--     if target.components and target.components.hunger then
--         local new_max_hunger = data.original_maxhunger + hunger_bonus
--         target.components.hunger:SetMax(new_max_hunger)
--         if target.components.hunger.current ~= nil then
--             LerpAttribute(target.components.hunger, target.components.hunger.current, 1.0)
--         end
--     end
-- end

-- -- 属性加成buff相关函数
-- local function buff_OnAttached(inst, target)
--     if not IsValidEntity(target) or not target:HasTag("beefalo") then
--         inst:Remove()
--         return
--     end

--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 确保牛有保存/加载机制
--     if not target._has_buff_saveload then
--         target:ListenForEvent("save", OnBeefaloSave)
--         target:ListenForEvent("load", OnBeefaloLoad)
--         target._has_buff_saveload = true
--     end

--     local data = GetBuffDataFromBell(target) or target._beefalo_buff_data
    
--     if not data then
--         data = {
--             stack_count = 0,
--             original_maxhealth = target.components.health and target.components.health.maxhealth or 100,
--             original_attack = target.components.combat and target.components.combat.defaultdamage or 10,
--             original_maxhunger = target.components.hunger and target.components.hunger.max or 100
--         }
--     end
    
--     data.stack_count = (data.stack_count or 0) + 1
--     inst.stack_count = data.stack_count
    
--     -- 双向保存数据
--     target._beefalo_buff_data = data
--     SaveBuffDataToBell(target, data)
    
--     target:DoTaskInTime(0.2, function()
--         if IsValidEntity(target) then
--             UpdateBeefaloStats(target)
--         end
--     end)

--     -- 清理旧的事件监听
--     if inst._event_listeners then
--         for event, fn in pairs(inst._event_listeners) do
--             inst:RemoveEventCallback(event, fn, target)
--         end
--     end

--     local function OnTargetRemoved()
--         inst:Remove()
--     end
    
--     inst._event_listeners = {
--         death = OnTargetRemoved,
--         onremove = OnTargetRemoved
--     }
    
--     inst:ListenForEvent("death", OnTargetRemoved, target)
--     inst:ListenForEvent("onremove", OnTargetRemoved, target)
    
--     inst:ListenForEvent("despawn", function()
--         if target._beefalo_buff_data and IsValidEntity(target) and not target:HasTag("INLIMBO") then
--             SaveBuffDataToBell(target, target._beefalo_buff_data)
--         end
--     end, target)
    
--     inst:ListenForEvent("spawnedfrominventory", function()
--         if IsValidEntity(target) then
--             UpdateBeefaloStats(target)
--         end
--     end, target)
-- end

-- -- 重复添加buff时的叠加处理
-- local function buff_OnExtended(inst, target)
--     buff_OnAttached(inst, target)
-- end

-- -- buff移除时恢复属性
-- local function buff_OnDetached(inst, target)
--     if not IsValidEntity(target) then
--         return
--     end
    
--     local data = target._beefalo_buff_data or GetBuffDataFromBell(target)
--     if not data then return end
    
--     data.stack_count = math.max(0, (data.stack_count or 0) - 1)
    
--     target._beefalo_buff_data = data
--     SaveBuffDataToBell(target, data)
    
--     target:DoTaskInTime(0.2, function()
--         if IsValidEntity(target) then
--             UpdateBeefaloStats(target)
--         end
--     end)
-- end

-- -- buff实体创建函数
-- local function fn_buff()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()
--     inst.entity:Hide()
--     inst.persists = true

--     inst:AddTag("CLASSIFIED")

--     local debuff = inst:AddComponent("debuff")
--     debuff:SetAttachedFn(buff_OnAttached)
--     debuff:SetDetachedFn(buff_OnDetached)
--     debuff:SetExtendedFn(buff_OnExtended)
--     debuff.keepondespawn = true

--     -- 保存和加载函数优化
--     inst.OnSave = function(inst, data)
--         data = data or {}
--         data.stack_count = inst.stack_count
--         local target = inst.entity:GetParent()
--         if target and IsValidEntity(target) then
--             data.target_guid = target.GUID
--             if target._beefalo_buff_data then
--                 data.buff_data = target._beefalo_buff_data
--             end
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data then
--             inst.stack_count = data.stack_count or 0
--             inst:DoTaskInTime(1.0, function()
--                 local target = inst.entity:GetParent()
--                 if target and IsValidEntity(target) then
--                     if data.buff_data then
--                         target._beefalo_buff_data = data.buff_data
--                         SaveBuffDataToBell(target, data.buff_data)
--                     end
--                     UpdateBeefaloStats(target)
--                 end
--             end)
--         end
--     end

--     return inst
-- end

-- return Prefab("zshd", fn_syrup, assets, prefabs),
--        Prefab("cow_health_buff", fn_buff, {})
































-- -- 引入缓动函数库，用于实现属性的平滑变化效果
-- local easing = require("easing")

-- -- 定义资源列表，包含动画、图像和图集
-- local assets = {
--     Asset("ANIM", "anim/zshd.zip"), -- 动画资源
--     Asset("IMAGE", "images/zshd.tex"), -- 图像资源
--     Asset("ATLAS", "images/zshd.xml") -- 图集资源，用于物品栏显示
-- }

-- -- 定义预制体列表，该物品使用到的其他预制体
-- local prefabs = {
--     "cow_health_buff", -- 牛的健康增益buff预制体
-- }

-- -- 检查实体是否有效（存在且未被销毁）
-- -- 防止对无效实体进行操作导致游戏崩溃
-- local function IsValidEntity(inst)
--     return inst ~= nil and type(inst) == "table" and inst.entity ~= nil and inst.entity:IsValid()
-- end

-- -- 平滑修改属性的辅助函数
-- -- 功能：在指定时间内将组件的当前值从起始值过渡到目标值，使用缓动函数使变化更自然
-- -- 参数：component（要修改的组件）、target_value（目标值）、duration（过渡时间）
-- local function LerpAttribute(component, target_value, duration)
--     -- 检查组件及其所属实体是否有效，无效则直接返回
--     if not component or not component.inst or not IsValidEntity(component.inst) then
--         return
--     end
    
--     -- 如果组件没有current属性（无法修改），则返回
--     if component.current == nil then
--         return
--     end
    
--     -- 记录起始值、当前时间和所属实体
--     local start_value = component.current
--     local time = 0
--     local inst = component.inst

--     -- 停止之前的更新任务，避免多个任务同时修改属性
--     if inst.attribute_lerp_task then
--         inst.attribute_lerp_task:Cancel()
--         inst.attribute_lerp_task = nil
--     end

--     -- 创建周期性任务，每0.1秒更新一次属性值
--     local update_task = inst:DoPeriodicTask(0.1, function()
--         -- 检查实体是否仍然有效，无效则清理任务并返回
--         if not IsValidEntity(inst) then
--             if inst.attribute_lerp_task then
--                 inst.attribute_lerp_task:Cancel()
--                 inst.attribute_lerp_task = nil
--             end
--             return
--         end
        
--         -- 累计时间并计算进度（0到1之间）
--         time = time + 0.1
--         local progress = math.min(time / duration, 1)
--         -- 使用缓动函数计算当前应有的值（outQuad类型：先快后慢）
--         local new_value = easing.outQuad(progress, start_value, target_value - start_value, 1)
        
--         -- 根据组件类型设置值：如果有SetPercent方法和max属性（如生命、饥饿），则按百分比设置
--         -- 否则直接修改current属性
--         if component.SetPercent and component.max then
--             local percent = new_value / component.max
--             component:SetPercent(percent)
--         else
--             component.current = new_value
--         end
        
--         -- 当进度达到1（完成过渡），清理任务
--         if progress >= 1 then
--             if inst.attribute_lerp_task then
--                 inst.attribute_lerp_task:Cancel()
--                 inst.attribute_lerp_task = nil
--             end
--         end
--     end)
    
--     -- 保存任务引用，以便后续可以取消
--     inst.attribute_lerp_task = update_task
-- end

-- -- 从铃铛获取牛的buff数据
-- -- 功能：当牛被铃铛控制时，从铃铛实体中读取该牛的buff数据
-- -- 参数：beefalo（牛实体）
-- local function GetBuffDataFromBell(beefalo)
--     -- 检查牛实体是否有效
--     if not IsValidEntity(beefalo) then return nil end
--     -- 检查牛是否有跟随者组件（用于获取铃铛主人）
--     if not beefalo.components or not beefalo.components.follower then return nil end
    
--     -- 获取铃铛主人（即牛跟随的对象，应该是铃铛实体）
--     local bell_owner = beefalo.components.follower:GetLeader()
--     -- 检查铃铛是否有效、是否有"bell"标签，且包含牛的buff数据，满足则返回对应数据
--     if bell_owner and IsValidEntity(bell_owner) and bell_owner:HasTag("bell") and bell_owner.beefalo_buff_data then
--         return bell_owner.beefalo_buff_data[beefalo.GUID]
--     end
--     return nil
-- end

-- -- 保存buff数据到铃铛（修复崩溃点）
-- -- 功能：当牛被铃铛控制时，将该牛的buff数据保存到铃铛实体中，确保数据不会丢失
-- -- 参数：beefalo（牛实体）、data（要保存的buff数据）
-- local function SaveBuffDataToBell(beefalo, data)
--     -- 检查牛实体是否有效
--     if not IsValidEntity(beefalo) then return end
--     -- 检查牛是否有跟随者组件
--     if not beefalo.components or not beefalo.components.follower then return end
    
--     -- 获取铃铛主人
--     local bell_owner = beefalo.components.follower:GetLeader()
--     -- 检查铃铛是否有效、不在LIMBO状态（临时状态，如物品在传送中）、且有"bell"标签
--     if bell_owner and IsValidEntity(bell_owner) and not bell_owner:HasTag("INLIMBO") and bell_owner:HasTag("bell") then
--         -- 如果铃铛没有buff数据存储表，则初始化一个
--         if not bell_owner.beefalo_buff_data then
--             bell_owner.beefalo_buff_data = {}
--         end
--         -- 用牛的GUID作为键，存储该牛的buff数据（确保每个牛的数据独立）
--         bell_owner.beefalo_buff_data[beefalo.GUID] = data
        
--         -- 正确的保存机制：使用实体的Save方法保存数据，而非inventoryitem的方法（避免错误）
--         if bell_owner.Save then
--             bell_owner:Save()
--         end
--     end
-- end

-- -- 牛实体的数据保存函数
-- -- 功能：当牛被保存时（如存档），将其buff数据存入保存数据中
-- -- 参数：inst（牛实体）、data（保存数据表格）
-- local function OnBeefaloSave(inst, data)
--     data = data or {} -- 确保data是一个表格
--     -- 如果牛有buff数据，则存入data中
--     if inst._beefalo_buff_data then
--         data.beefalo_buff = inst._beefalo_buff_data
--     end
-- end

-- -- 牛实体的数据加载函数
-- -- 功能：当牛被加载时（如读档），从保存数据中恢复其buff数据，并更新属性
-- -- 参数：inst（牛实体）、data（加载数据表格）
-- local function OnBeefaloLoad(inst, data)
--     -- 如果加载数据中有buff数据，则恢复到牛实体中
--     if data and data.beefalo_buff then
--         inst._beefalo_buff_data = data.beefalo_buff
--         -- 延迟更新属性，确保实体初始化完成（避免刚加载时组件未就绪）
--         inst:DoTaskInTime(0.5, function()
--             UpdateBeefaloStats(inst)
--         end)
--     end
-- end

-- -- 食物被食用时的函数
-- -- 功能：当食物被牛食用后，为牛添加健康增益buff
-- -- 参数：inst（食物实体）、eater（食用者实体）
-- local function syrup_OnEaten(inst, eater)
--     -- 检查食用者是否有效且是牛（有"beefalo"标签）
--     if eater and IsValidEntity(eater) and eater:HasTag("beefalo") then
--         -- 只在服务器端执行（避免客户端重复处理）
--         if TheWorld.ismastersim then
--             -- 延迟0.1秒执行，确保食用动作完成
--             eater:DoTaskInTime(0.1, function()
--                 -- 再次检查牛是否仍然有效
--                 if IsValidEntity(eater) then
--                     -- 确保牛有保存/加载机制（只添加一次）
--                     if not eater._has_buff_saveload then
--                         eater:ListenForEvent("save", OnBeefaloSave) -- 注册保存事件
--                         eater:ListenForEvent("load", OnBeefaloLoad) -- 注册加载事件
--                         eater._has_buff_saveload = true -- 标记已添加，避免重复
--                     end
--                     -- 为牛添加健康增益buff
--                     eater:AddDebuff("cow_health_buff", "cow_health_buff")
--                 end
--             end)
--         end
--     end
-- end

-- -- 食物实体创建函数
-- -- 功能：定义食物"zshd"的属性和行为
-- local function fn_syrup()
--     local assetname = "zshd" -- 资源名称，与anim、image等对应
--     local inst = CreateEntity() -- 创建实体

--     -- 添加必要的组件：变换、动画状态、网络同步
--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     -- 使物品具有物理特性（如掉落、堆叠）
--     MakeInventoryPhysics(inst)
--     -- 使物品在水中漂浮
--     MakeInventoryFloatable(inst)

--     -- 设置动画相关属性：银行（动画集）、构建（纹理集）、播放动画
--     inst.AnimState:SetBank(assetname)
--     inst.AnimState:SetBuild(assetname)
--     inst.AnimState:PlayAnimation("idle") -- 播放 idle 动画

--     -- 标记实体为纯净状态（客户端与服务器数据同步点）
--     inst.entity:SetPristine()
--     -- 如果是客户端，直接返回实体（客户端不需要处理服务器逻辑）
--     if not TheWorld.ismastersim then
--         return inst
--     end

--     -- 添加可食用组件，定义食物属性
--     local edible = inst:AddComponent("edible")
--     edible.foodtype = FOODTYPE.ROUGHAGE -- 食物类型为粗粮（适合牛食用）
--     edible.healthvalue = 300 -- 提供的健康值
--     edible.hungervalue = 1000 -- 提供的饥饿值
--     edible:SetOnEatenFn(syrup_OnEaten) -- 设置被食用时的回调函数

--     -- 添加可堆叠组件，设置最大堆叠数量
--     local stackable = inst:AddComponent("stackable")
--     stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM -- 使用游戏默认的大型物品堆叠数量

--     -- 添加可交易组件（可与NPC交易）
--     inst:AddComponent("tradable")
--     -- 添加可检查组件（鼠标悬停时显示检查信息）
--     inst:AddComponent("inspectable")
--     -- 添加物品栏组件（使物品可以被放入背包）
--     inst:AddComponent("inventoryitem")
--     -- 设置物品栏图标所在的图集
--     inst.components.inventoryitem.atlasname = "images/zshd.xml"

--     -- 使物品可被点燃（小型物品燃烧特性）
--     MakeSmallBurnable(inst)
--     -- 使物品可传播火焰（小型物品传播特性）
--     MakeSmallPropagator(inst)
--     -- 使物品可被幽灵 haunt（游戏中的幽灵互动特性）
--     MakeHauntableLaunch(inst)

--     return inst -- 返回创建的实体
-- end

-- -- 更新牛属性的函数
-- -- 功能：根据buff数据更新牛的最大生命、攻击力和最大饥饿值
-- -- 参数：target（牛实体）
-- local function UpdateBeefaloStats(target)
--     -- 检查牛实体是否有效
--     if not IsValidEntity(target) then return end
    
--     -- 获取buff数据：优先从铃铛获取，其次从牛自身获取，都没有则初始化默认数据
--     local bell_data = GetBuffDataFromBell(target)
--     local data = bell_data or target._beefalo_buff_data or {
--         stack_count = 0, -- buff堆叠数量
--         original_maxhealth = target.components.health and target.components.health.maxhealth or 100, -- 初始最大生命
--         original_attack = target.components.combat and target.components.combat.defaultdamage or 10, -- 初始攻击力
--         original_maxhunger = target.components.hunger and target.components.hunger.max or 100 -- 初始最大饥饿
--     }
    
--     -- 双向同步数据：如果有铃铛数据，则同步到牛自身；否则保存到铃铛
--     if bell_data then
--         target._beefalo_buff_data = data
--     else
--         SaveBuffDataToBell(target, data)
--     end
    
--     -- 获取buff堆叠数量，确保不为负数
--     local stack_count = math.max(0, data.stack_count or 0)
    
--     -- 根据堆叠数量计算属性加成
--     local health_bonus = stack_count * 100 -- 每堆叠1层，生命+100
--     local attack_bonus = stack_count * 2 -- 每堆叠1层，攻击+2
--     local hunger_bonus = stack_count * 50 -- 每堆叠1层，饥饿+50
    
--     -- 更新最大生命
--     if target.components and target.components.health then
--         local new_max_health = data.original_maxhealth + health_bonus
--         target.components.health:SetMaxHealth(new_max_health)
--         -- 如果当前生命存在，平滑过渡到当前值（避免突变）
--         if target.components.health.current ~= nil then
--             LerpAttribute(target.components.health, target.components.health.current, 1.0)
--         end
--     end
    
--     -- 更新攻击力
--     if target.components and target.components.combat then
--         target.components.combat:SetDefaultDamage(data.original_attack + attack_bonus)
--     end
    
--     -- 更新最大饥饿
--     if target.components and target.components.hunger then
--         local new_max_hunger = data.original_maxhunger + hunger_bonus
--         target.components.hunger:SetMax(new_max_hunger)
--         -- 如果当前饥饿存在，平滑过渡到当前值
--         if target.components.hunger.current ~= nil then
--             LerpAttribute(target.components.hunger, target.components.hunger.current, 1.0)
--         end
--     end
-- end

-- -- 属性加成buff相关函数：buff附加到目标时调用
-- -- 功能：当buff被添加到牛身上时，初始化数据并更新属性
-- -- 参数：inst（buff实体）、target（目标实体，即牛）
-- local function buff_OnAttached(inst, target)
--     -- 检查目标是否有效且是牛，否则移除buff
--     if not IsValidEntity(target) or not target:HasTag("beefalo") then
--         inst:Remove()
--         return
--     end

--     -- 将buff实体附加到牛身上（位置同步）
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 确保牛有保存/加载机制（只添加一次）
--     if not target._has_buff_saveload then
--         target:ListenForEvent("save", OnBeefaloSave)
--         target:ListenForEvent("load", OnBeefaloLoad)
--         target._has_buff_saveload = true
--     end

--     -- 获取或初始化buff数据
--     local data = GetBuffDataFromBell(target) or target._beefalo_buff_data
    
--     if not data then
--         data = {
--             stack_count = 0,
--             original_maxhealth = target.components.health and target.components.health.maxhealth or 100,
--             original_attack = target.components.combat and target.components.combat.defaultdamage or 10,
--             original_maxhunger = target.components.hunger and target.components.hunger.max or 100
--         }
--     end
    
--     -- 增加buff堆叠数量，并记录到buff实体中
--     data.stack_count = (data.stack_count or 0) + 1
--     inst.stack_count = data.stack_count
    
--     -- 双向保存数据
--     target._beefalo_buff_data = data
--     SaveBuffDataToBell(target, data)
    
--     -- 延迟0.2秒更新属性，确保数据保存完成
--     target:DoTaskInTime(0.2, function()
--         if IsValidEntity(target) then
--             UpdateBeefaloStats(target)
--         end
--     end)

--     -- 清理旧的事件监听，避免重复监听
--     if inst._event_listeners then
--         for event, fn in pairs(inst._event_listeners) do
--             inst:RemoveEventCallback(event, fn, target)
--         end
--     end

--     -- 定义目标被移除时的处理函数（移除buff）
--     local function OnTargetRemoved()
--         inst:Remove()
--     end
    
--     -- 记录事件监听，便于后续清理
--     inst._event_listeners = {
--         death = OnTargetRemoved, -- 目标死亡时
--         onremove = OnTargetRemoved -- 目标被移除时
--     }
    
--     -- 注册事件监听
--     inst:ListenForEvent("death", OnTargetRemoved, target)
--     inst:ListenForEvent("onremove", OnTargetRemoved, target)
    
--     -- 监听目标的despawn事件（消失时），保存buff数据
--     inst:ListenForEvent("despawn", function()
--         if target._beefalo_buff_data and IsValidEntity(target) and not target:HasTag("INLIMBO") then
--             SaveBuffDataToBell(target, target._beefalo_buff_data)
--         end
--     end, target)
    
--     -- 监听目标从物品栏中生成的事件，更新属性
--     inst:ListenForEvent("spawnedfrominventory", function()
--         if IsValidEntity(target) then
--             UpdateBeefaloStats(target)
--         end
--     end, target)
-- end

-- -- 重复添加buff时的叠加处理
-- -- 功能：当buff已存在且再次被添加时，执行与附加时相同的逻辑（实现堆叠效果）
-- -- 参数：inst（buff实体）、target（目标实体）
-- local function buff_OnExtended(inst, target)
--     buff_OnAttached(inst, target)
-- end

-- -- buff移除时恢复属性
-- -- 功能：当buff从牛身上移除时，减少堆叠数量并重新计算属性
-- -- 参数：inst（buff实体）、target（目标实体）
-- local function buff_OnDetached(inst, target)
--     -- 检查目标是否有效
--     if not IsValidEntity(target) then
--         return
--     end
    
--     -- 获取buff数据
--     local data = target._beefalo_buff_data or GetBuffDataFromBell(target)
--     if not data then return end
    
--     -- 减少堆叠数量（确保不为负数）
--     data.stack_count = math.max(0, (data.stack_count or 0) - 1)
    
--     -- 保存更新后的数据
--     target._beefalo_buff_data = data
--     SaveBuffDataToBell(target, data)
    
--     -- 延迟0.2秒更新属性
--     target:DoTaskInTime(0.2, function()
--         if IsValidEntity(target) then
--             UpdateBeefaloStats(target)
--         end
--     end)
-- end

-- -- buff实体创建函数
-- -- 功能：定义"cow_health_buff"的属性和行为
-- local function fn_buff()
--     local inst = CreateEntity() -- 创建实体

--     -- 客户端不处理buff逻辑，直接移除（buff逻辑在服务器端执行）
--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     -- 添加变换组件（用于设置位置）
--     inst.entity:AddTransform()
--     -- 隐藏buff实体（buff通常不可见）
--     inst.entity:Hide()
--     -- 设置buff实体可持久化（存档时保留）
--     inst.persists = true

--     -- 添加CLASSIFIED标签（标记为机密实体，不同步到客户端详细信息）
--     inst:AddTag("CLASSIFIED")

--     -- 添加debuff组件（用于管理buff的附加、移除和叠加）
--     local debuff = inst:AddComponent("debuff")
--     debuff:SetAttachedFn(buff_OnAttached) -- 设置附加时的回调
--     debuff:SetDetachedFn(buff_OnDetached) -- 设置移除时的回调
--     debuff:SetExtendedFn(buff_OnExtended) -- 设置叠加时的回调
--     debuff.keepondespawn = true -- 目标消失时保留buff（便于重新生成时恢复）

--     -- 保存和加载函数优化
--     inst.OnSave = function(inst, data)
--         data = data or {}
--         -- 保存buff堆叠数量
--         data.stack_count = inst.stack_count
--         -- 获取buff所属的目标实体
--         local target = inst.entity:GetParent()
--         if target and IsValidEntity(target) then
--             -- 保存目标的GUID（用于加载时匹配）
--             data.target_guid = target.GUID
--             -- 保存目标的buff数据
--             if target._beefalo_buff_data then
--                 data.buff_data = target._beefalo_buff_data
--             end
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data then
--             -- 加载堆叠数量
--             inst.stack_count = data.stack_count or 0
--             -- 延迟1秒执行，确保目标实体已加载完成
--             inst:DoTaskInTime(1.0, function()
--                 local target = inst.entity:GetParent()
--                 -- 检查目标是否有效
--                 if target and IsValidEntity(target) then
--                     -- 恢复目标的buff数据并更新属性
--                     if data.buff_data then
--                         target._beefalo_buff_data = data.buff_data
--                         SaveBuffDataToBell(target, data.buff_data)
--                     end
--                     UpdateBeefaloStats(target)
--                 end
--             end)
--         end
--     end

--     return inst -- 返回创建的实体
-- end

-- -- 返回预制体定义：食物"zshd"和buff"cow_health_buff"
-- return Prefab("zshd", fn_syrup, assets, prefabs),
--        Prefab("cow_health_buff", fn_buff, {})
    
    
    
-- 引入缓动函数库，用于实现属性的平滑变化效果
local easing = require("easing")

-- 定义资源列表，包含动画、图像和图集
local assets = {
    Asset("ANIM", "anim/zshd.zip"), -- 动画资源
    Asset("IMAGE", "images/zshd.tex"), -- 图像资源
    Asset("ATLAS", "images/zshd.xml") -- 图集资源，用于物品栏显示
}

-- 定义预制体列表，该物品使用到的其他预制体
local prefabs = {
    "cow_health_buff", -- 牛的健康增益buff预制体
}

-- 检查实体是否有效（存在且未被销毁）
-- 防止对无效实体进行操作导致游戏崩溃
local function IsValidEntity(inst)
    return inst ~= nil and type(inst) == "table" and inst.entity ~= nil and inst.entity:IsValid()
end

-- 平滑修改属性的辅助函数
-- 功能：在指定时间内将组件的当前值从起始值过渡到目标值，使用缓动函数使变化更自然
local function LerpAttribute(component, target_value, duration)
    if not component or not component.inst or not IsValidEntity(component.inst) then
        return
    end
    
    if component.current == nil then
        return
    end
    
    local start_value = component.current
    local time = 0
    local inst = component.inst

    -- 取消已有的插值任务，避免冲突
    if inst.attribute_lerp_task then
        inst.attribute_lerp_task:Cancel()
        inst.attribute_lerp_task = nil
    end

    local update_task = inst:DoPeriodicTask(0.1, function()
        if not IsValidEntity(inst) then
            if inst.attribute_lerp_task then
                inst.attribute_lerp_task:Cancel()
                inst.attribute_lerp_task = nil
            end
            return
        end
        
        time = time + 0.1
        local progress = math.min(time / duration, 1)
        local new_value = easing.outQuad(progress, start_value, target_value - start_value, 1)
        
        if component.SetPercent and component.max then
            local percent = new_value / component.max
            component:SetPercent(percent)
        else
            component.current = new_value
        end
        
        -- 完成插值后取消任务
        if progress >= 1 then
            if inst.attribute_lerp_task then
                inst.attribute_lerp_task:Cancel()
                inst.attribute_lerp_task = nil
            end
        end
    end)
    
    inst.attribute_lerp_task = update_task
end

-- 从铃铛获取牛的buff数据
local function GetBuffDataFromBell(beefalo)
    if not IsValidEntity(beefalo) then return nil end
    if not beefalo.components or not beefalo.components.follower then return nil end
    
    local bell_owner = beefalo.components.follower:GetLeader()
    if bell_owner and IsValidEntity(bell_owner) and bell_owner:HasTag("bell") and bell_owner.beefalo_buff_data then
        return bell_owner.beefalo_buff_data[beefalo.GUID]
    end
    return nil
end

-- 保存buff数据到铃铛（修复崩溃点）
local function SaveBuffDataToBell(beefalo, data)
    if not IsValidEntity(beefalo) then return end
    if not beefalo.components or not beefalo.components.follower then return end
    
    local bell_owner = beefalo.components.follower:GetLeader()
    if bell_owner and IsValidEntity(bell_owner) and not bell_owner:HasTag("INLIMBO") and bell_owner:HasTag("bell") then
        if not bell_owner.beefalo_buff_data then
            bell_owner.beefalo_buff_data = {}
        end
        bell_owner.beefalo_buff_data[beefalo.GUID] = data
        
        -- 安全的保存机制 - 修复崩溃点
        -- 只对有inventoryitem组件的实体调用Save方法
        if bell_owner.components and bell_owner.components.inventoryitem then
            -- 检查Save方法是否存在
            if type(bell_owner.components.inventoryitem.Save) == "function" then
                bell_owner.components.inventoryitem:Save()
            end
        end
    end
end

-- 牛实体的数据保存函数
local function OnBeefaloSave(inst, data)
    data = data or {}
    if inst._beefalo_buff_data then
        data.beefalo_buff = inst._beefalo_buff_data
    end
end

-- 牛实体的数据加载函数
local function OnBeefaloLoad(inst, data)
    if data and data.beefalo_buff then
        inst._beefalo_buff_data = data.beefalo_buff
        -- 延迟更新以确保所有组件都已初始化
        inst:DoTaskInTime(0.5, function()
            UpdateBeefaloStats(inst)
        end)
    end
end

-- 食物被食用时的函数
local function syrup_OnEaten(inst, eater)
    if eater and IsValidEntity(eater) and eater:HasTag("beefalo") then
        if TheWorld.ismastersim then
            eater:DoTaskInTime(0.1, function()
                if IsValidEntity(eater) then
                    if not eater._has_buff_saveload then
                        eater:ListenForEvent("save", OnBeefaloSave)
                        eater:ListenForEvent("load", OnBeefaloLoad)
                        eater._has_buff_saveload = true
                    end
                    eater:AddDebuff("cow_health_buff", "cow_health_buff")
                end
            end)
        end
    end
end

-- 食物实体创建函数
local function fn_syrup()
    local assetname = "zshd"
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank(assetname)
    inst.AnimState:SetBuild(assetname)
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    local edible = inst:AddComponent("edible")
    edible.foodtype = FOODTYPE.ROUGHAGE
    edible.healthvalue = 300
    edible.hungervalue = 1000
    edible:SetOnEatenFn(syrup_OnEaten)

    local stackable = inst:AddComponent("stackable")
    stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/zshd.xml"

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
    MakeHauntableLaunch(inst)

    return inst
end

-- 更新牛属性的函数
function UpdateBeefaloStats(target)
    if not IsValidEntity(target) then return end
    
    local bell_data = GetBuffDataFromBell(target)
    local data = bell_data or target._beefalo_buff_data or {
        stack_count = 0,
        original_maxhealth = target.components.health and target.components.health.maxhealth or 100,
        original_attack = target.components.combat and target.components.combat.defaultdamage or 10,
        original_maxhunger = target.components.hunger and target.components.hunger.max or 100
    }
    
    if bell_data then
        target._beefalo_buff_data = data
    else
        SaveBuffDataToBell(target, data)
    end
    
    local stack_count = math.max(0, data.stack_count or 0)
    
    local health_bonus = stack_count * 100
    local attack_bonus = stack_count * 2
    local hunger_bonus = stack_count * 50
    
    if target.components and target.components.health then
        local new_max_health = data.original_maxhealth + health_bonus
        target.components.health:SetMaxHealth(new_max_health)
        if target.components.health.current ~= nil then
            LerpAttribute(target.components.health, target.components.health.current, 1.0)
        end
    end
    
    if target.components and target.components.combat then
        target.components.combat:SetDefaultDamage(data.original_attack + attack_bonus)
    end
    
    if target.components and target.components.hunger then
        local new_max_hunger = data.original_maxhunger + hunger_bonus
        target.components.hunger:SetMax(new_max_hunger)
        if target.components.hunger.current ~= nil then
            LerpAttribute(target.components.hunger, target.components.hunger.current, 1.0)
        end
    end
end

-- buff附加时调用
local function buff_OnAttached(inst, target)
    if not IsValidEntity(target) or not target:HasTag("beefalo") then
        inst:Remove()
        return
    end

    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    if not target._has_buff_saveload then
        target:ListenForEvent("save", OnBeefaloSave)
        target:ListenForEvent("load", OnBeefaloLoad)
        target._has_buff_saveload = true
    end

    local data = GetBuffDataFromBell(target) or target._beefalo_buff_data
    
    if not data then
        data = {
            stack_count = 0,
            original_maxhealth = target.components.health and target.components.health.maxhealth or 100,
            original_attack = target.components.combat and target.components.combat.defaultdamage or 10,
            original_maxhunger = target.components.hunger and target.components.hunger.max or 100
        }
    end
    
    data.stack_count = (data.stack_count or 0) + 1
    inst.stack_count = data.stack_count
    
    target._beefalo_buff_data = data
    SaveBuffDataToBell(target, data)
    
    target:DoTaskInTime(0.2, function()
        if IsValidEntity(target) then
            UpdateBeefaloStats(target)
        end
    end)

    -- 清理已有的事件监听器
    if inst._event_listeners then
        for event, fn in pairs(inst._event_listeners) do
            inst:RemoveEventCallback(event, fn, target)
        end
    end

    local function OnTargetRemoved()
        inst:Remove()
    end
    
    inst._event_listeners = {
        death = OnTargetRemoved,
        onremove = OnTargetRemoved
    }
    
    inst:ListenForEvent("death", OnTargetRemoved, target)
    inst:ListenForEvent("onremove", OnTargetRemoved, target)
    
    inst:ListenForEvent("despawn", function()
        if target._beefalo_buff_data and IsValidEntity(target) and not target:HasTag("INLIMBO") then
            SaveBuffDataToBell(target, target._beefalo_buff_data)
        end
    end, target)
    
    inst:ListenForEvent("spawnedfrominventory", function()
        if IsValidEntity(target) then
            UpdateBeefaloStats(target)
        end
    end, target)
end

-- buff叠加处理
local function buff_OnExtended(inst, target)
    buff_OnAttached(inst, target)
end

-- buff移除时处理
local function buff_OnDetached(inst, target)
    if not IsValidEntity(target) then
        return
    end
    
    local data = target._beefalo_buff_data or GetBuffDataFromBell(target)
    if not data then return end
    
    data.stack_count = math.max(0, (data.stack_count or 0) - 1)
    
    target._beefalo_buff_data = data
    SaveBuffDataToBell(target, data)
    
    target:DoTaskInTime(0.2, function()
        if IsValidEntity(target) then
            UpdateBeefaloStats(target)
        end
    end)
end

-- buff实体创建函数
local function fn_buff()
    local inst = CreateEntity()

    if not TheWorld.ismastersim then
        inst:DoTaskInTime(0, inst.Remove)
        return inst
    end

    inst.entity:AddTransform()
    inst.entity:Hide()
    inst.persists = true

    inst:AddTag("CLASSIFIED")

    local debuff = inst:AddComponent("debuff")
    debuff:SetAttachedFn(buff_OnAttached)
    debuff:SetDetachedFn(buff_OnDetached)
    debuff:SetExtendedFn(buff_OnExtended)
    debuff.keepondespawn = true

    inst.OnSave = function(inst, data)
        data = data or {}
        data.stack_count = inst.stack_count
        local target = inst.entity:GetParent()
        if target and IsValidEntity(target) then
            data.target_guid = target.GUID
            if target._beefalo_buff_data then
                data.buff_data = target._beefalo_buff_data
            end
        end
    end

    inst.OnLoad = function(inst, data)
        if data then
            inst.stack_count = data.stack_count or 0
            inst:DoTaskInTime(1.0, function()
                local target = inst.entity:GetParent()
                if target and IsValidEntity(target) then
                    if data.buff_data then
                        target._beefalo_buff_data = data.buff_data
                        SaveBuffDataToBell(target, data.buff_data)
                    end
                    UpdateBeefaloStats(target)
                end
            end)
        end
    end

    return inst
end

return Prefab("zshd", fn_syrup, assets, prefabs),
       Prefab("cow_health_buff", fn_buff, {})