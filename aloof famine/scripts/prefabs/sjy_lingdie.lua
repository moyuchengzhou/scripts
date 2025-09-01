-- require "prefabutil"

-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_lingdie.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_lingdie.tex"),
-- 	Asset("ATLAS", "images/inventoryimages/sjy_lingdie.xml"),
-- }

-- local prefabs =
-- {
--     "nightmarefuel",
--     "ghostflower",
--     "planted_flower",
--     "lightbulb",
-- }

-- local brain = require "brains/butterflybrain"

-- local function OnDropped(inst)
--     inst.sg:GoToState("idle")
--     if inst.sjy_lingdiespawner ~= nil then
--         inst.sjy_lingdiespawner:StartTracking(inst)
--     end
--     if inst.components.workable ~= nil then
--         inst.components.workable:SetWorkLeft(1)
--     end
--     if inst.components.stackable ~= nil then
--         while inst.components.stackable:StackSize() > 1 do
--             local item = inst.components.stackable:Get()
--             if item ~= nil then
--                 if item.components.inventoryitem ~= nil then
--                     item.components.inventoryitem:OnDropped()
--                 end
--                 item.Physics:Teleport(inst.Transform:GetWorldPosition())
--             end
--         end
--     end
-- end

-- local function OnPickedUp(inst)
--     if inst.sjy_lingdiespawner ~= nil then
--         inst.sjy_lingdiespawner:StopTracking(inst)
--     end
-- end

-- local function OnWorked(inst, worker)
--     if worker.components.inventory ~= nil then
--         if inst.sjy_lingdiespawner ~= nil then
--             inst.sjy_lingdiespawner:StopTracking(inst)
--         end
--         worker.components.inventory:GiveItem(inst, nil, inst:GetPosition())
--         worker.SoundEmitter:PlaySound("dontstarve/common/butterfly_trap")
--     end
-- end

-- local function CanDeploy(inst)
--     return true
-- end

-- local function OnDeploy(inst, pt, deployer)
--     local flower = SpawnPrefab("planted_flower")
--     if flower then
--         flower:PushEvent("growfrombutterfly")
--         flower.Transform:SetPosition(pt:Get())
--         inst.components.stackable:Get():Remove()
--         AwardPlayerAchievement("growfrombutterfly", deployer)
--         TheWorld:PushEvent("CHEVO_growfrombutterfly",{target=flower,doer=deployer})
--         if deployer and deployer.SoundEmitter then
--             deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
--         end
--     end
-- end

-- local function OnMutate(inst, transformed_inst)
-- 	if transformed_inst ~= nil then
-- 		transformed_inst.sg:GoToState("idle")
-- 	end
-- end

-- local function fn()
--     local inst = CreateEntity()

--     --Core components
--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddDynamicShadow()
--     inst.entity:AddSoundEmitter()
--     inst.entity:AddNetwork()

--     --Initialize physics
--     MakeTinyFlyingCharacterPhysics(inst, 1, .5)
--     inst:AddTag("sjy_lingdie")
--     inst:AddTag("butterfly")
--     inst:AddTag("flying")
--     inst:AddTag("ignorewalkableplatformdrowning")
--     inst:AddTag("insect")
--     inst:AddTag("smallcreature")
--     inst:AddTag("cattoyairborne")
--     inst:AddTag("wildfireprotected")
--     inst:AddTag("deployedplant")
--     inst:AddTag("lightbattery")
--     inst:AddComponent("homeseeker")
--     --pollinator (from pollinator component) added to pristine state for optimization
--     inst:AddTag("pollinator")

--     inst.Transform:SetTwoFaced()

--     inst.AnimState:SetBuild("sjy_lingdie")
--     inst.AnimState:SetBank("sjy_lingdie")
--     inst.AnimState:PlayAnimation("idle")
--     inst.AnimState:SetRayTestOnBB(true)

--     inst.DynamicShadow:SetSize(.8, .5)

--     MakeInventoryFloatable(inst)

--     MakeFeedableSmallLivestockPristine(inst)

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     ---------------------
--     inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
--     inst.components.locomotor:EnableGroundSpeedMultiplier(false)
--     inst.components.locomotor:SetTriggersCreep(false)
--     inst:SetStateGraph("SGbutterfly")

--     ---------------------
--     inst:AddComponent("stackable")
--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_lingdie.xml"
--     inst.components.inventoryitem.canbepickedup = false
--     inst.components.inventoryitem.canbepickedupalive = true
--     inst.components.inventoryitem.nobounce = true
--     inst.components.inventoryitem.pushlandedevents = false

--     ------------------
--     inst:AddComponent("pollinator")

--     ------------------
--     inst:AddComponent("health")
--     inst.components.health:SetMaxHealth(1)

--     ------------------
--     inst:AddComponent("combat")
--     inst.components.combat.hiteffectsymbol = "butterfly_body"

--     ------------------
--     inst:AddComponent("knownlocations")

--     MakeSmallBurnableCharacter(inst, "butterfly_body")
--     MakeTinyFreezableCharacter(inst, "butterfly_body")

--     ------------------
--     inst:AddComponent("inspectable")

--     ------------------
--     inst:AddComponent("lootdropper")
--     inst.components.lootdropper:AddRandomLoot("ghostflower", 0.5)
--     inst.components.lootdropper:AddRandomLoot("wortox_soul",0.5)
--     -- inst.components.lootdropper:AddRandomLoot("wortox_soul",0.3)
--     inst.components.lootdropper.numrandomloot = 1

--     ------------------
--     inst:AddComponent("workable")
--     inst.components.workable:SetWorkAction(ACTIONS.NET)
--     inst.components.workable:SetWorkLeft(1)
--     inst.components.workable:SetOnFinishCallback(OnWorked)

--     ------------------
--     inst:AddComponent("tradable")

--     ------------------
--     inst:AddComponent("deployable")
--     inst.components.deployable.ondeploy = OnDeploy
--     inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)

--     MakeHauntablePanicAndIgnite(inst)

--     inst:SetBrain(brain)

--     inst.sjy_lingdiespawner = TheWorld.components.sjy_lingdiespawner
--     if inst.sjy_lingdiespawner ~= nil then
--         inst.components.inventoryitem:SetOnPickupFn(inst.sjy_lingdiespawner.StopTrackingFn)
--         inst:ListenForEvent("onremove", inst.sjy_lingdiespawner.StopTrackingFn)
--         inst.sjy_lingdiespawner:StartTracking(inst)
--     end

--     MakeFeedableSmallLivestock(inst, TUNING.BUTTERFLY_PERISH_TIME, OnPickedUp, OnDropped)

-- 	inst:AddComponent("halloweenmoonmutable")
-- 	inst.components.halloweenmoonmutable:SetPrefabMutated("moonbutterfly")
-- 	inst.components.halloweenmoonmutable:SetOnMutateFn(OnMutate)
-- 	inst.components.halloweenmoonmutable.push_attacked_on_new_inst = false

--     return inst
-- end

-- return Prefab("sjy_lingdie", fn, assets, prefabs),
--     MakePlacer("sjy_lingdie_placer", "flower_evil", "flower_evil", "f1")









require "prefabutil"

local assets = {
    Asset("ANIM", "anim/sjy_lingdie.zip"),
    Asset("IMAGE", "images/inventoryimages/sjy_lingdie.tex"),
    Asset("ATLAS", "images/inventoryimages/sjy_lingdie.xml"),
}

local prefabs = {
    "nightmarefuel",
    "ghostflower",
    "planted_flower",
    "lightbulb",
    "moonbutterfly",
}

local brain = require "brains/lingdiebrain"

-- 范围伤害检查（每2秒一次）
local function DoAreaDamage(inst)
    if not inst or not inst:IsValid() then return end
    
    local x, y, z = inst.Transform:GetWorldPosition()
    local range = 6
    local players = FindPlayersInRange(x, y, z, range, true)
    
    if inst.components and inst.components.combat then
        local current_damage = inst.components.combat.defaultdamage or 200
        for _, player in ipairs(players) do
            if player and player:IsValid() and 
               player.components and player.components.health and 
               not player.components.health:IsDead() then
                player.components.health:DoDelta(-2)
                inst.components.combat.defaultdamage = current_damage + 2
            end
        end
    end
    
    -- 保持2秒间隔
    if inst and inst:IsValid() then
        inst.area_task = inst:DoTaskInTime(2, DoAreaDamage)
    end
end

-- 攻击目标检测与追踪（仅作为备用，主要依赖行为树）
local function CheckTarget(inst)
    if not inst or not inst:IsValid() then return end
    
    -- 忙碌状态跳过检测（如攻击动画中）
    if inst.sg and inst.sg:HasStateTag("busy") then
        inst.target_task = inst:DoTaskInTime(1, CheckTarget)
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    local target = nil

    -- 优先攻击玩家（15范围）
    if TheWorld and TheWorld.ismastersim then
        target = FindClosestPlayerInRange(x, y, z, 15, true)
    end
    
    -- 没有玩家则寻找其他目标
    if not target then
        local ents = TheSim:FindEntities(x, y, z, 10, 
            nil,  -- 必须包含的标签
            {"INLIMBO", "notarget", "sjy_lingdie", "playerghost"}  -- 排除的标签
        )
        for _, ent in ipairs(ents) do
            if ent and ent:IsValid() and 
               ent.components and ent.components.health and 
               not ent.components.health:IsDead() then
                target = ent
                break
            end
        end
    end

    -- 设置目标并主动靠近攻击
    if inst.components and inst.components.combat and inst.components.locomotor then
        if target then
            inst.components.combat:SetTarget(target)
            inst:PushEvent("start_attack", {target = target})
        else
            inst.components.combat:SetTarget(nil)
        end
    end

    -- 持续检测
    if inst and inst:IsValid() then
        inst.target_task = inst:DoTaskInTime(1, CheckTarget)
    end
end

-- 被攻击时的反击逻辑
local function OnAttacked(inst, data)
    if not inst or not inst:IsValid() then return end
    if data and data.attacker and data.attacker:IsValid() and data.attacker ~= inst then
        if inst.components and inst.components.combat then
            inst.components.combat:SetTarget(data.attacker)
            inst:PushEvent("start_attack", {target = data.attacker})
        end
    end
end

-- 攻击回调（处理血量上限提升）
local function OnAttack(inst, data)
    if not inst or not inst:IsValid() then return end
    if data and data.target and data.target:IsValid() and
       inst.components and inst.components.health then
        local current_max = inst.components.health.maxhealth or 100
        inst.components.health:SetMaxHealth(current_max + 100)
        inst.components.health:DoDelta(100, false, "attack_growth")
    end
end

-- 清理任务
local function CleanupTasks(inst)
    if inst and inst.target_task then
        inst.target_task:Cancel()
        inst.target_task = nil
    end
    if inst and inst.area_task then
        inst.area_task:Cancel()
        inst.area_task = nil
    end
end

local function OnDropped(inst)
    if not inst or not inst:IsValid() then return end
    
    if inst.sg then
        inst.sg:GoToState("idle")
    end
    
    if inst.sjy_lingdiespawner and inst.sjy_lingdiespawner:IsValid() then
        inst.sjy_lingdiespawner:StartTracking(inst)
    end
    
    if inst.components and inst.components.workable then
        inst.components.workable:SetWorkLeft(1)
    end
    
    if inst.components and inst.components.stackable then
        while inst.components.stackable:StackSize() > 1 do
            local item = inst.components.stackable:Get()
            if item and item:IsValid() then
                if item.components and item.components.inventoryitem then
                    item.components.inventoryitem:OnDropped()
                end
                if item.Transform then
                    item.Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
            end
        end
    end
    
    -- 掉落时立即开始攻击检测
    if inst.components and inst.components.combat then
        CheckTarget(inst)
        DoAreaDamage(inst)
    end
end

local function OnPickedUp(inst)
    if not inst or not inst:IsValid() then return end
    
    if inst.sjy_lingdiespawner and inst.sjy_lingdiespawner:IsValid() then
        inst.sjy_lingdiespawner:StopTracking(inst)
    end
    CleanupTasks(inst)
end

local function OnWorked(inst, worker)
    if not inst or not inst:IsValid() then return end
    if worker and worker:IsValid() and worker.components and worker.components.inventory then
        if inst.sjy_lingdiespawner and inst.sjy_lingdiespawner:IsValid() then
            inst.sjy_lingdiespawner:StopTracking(inst)
        end
        worker.components.inventory:GiveItem(inst, nil, inst:GetPosition())
        if worker.SoundEmitter then
            worker.SoundEmitter:PlaySound("dontstarve/common/butterfly_trap")
        end
    end
    CleanupTasks(inst)
end

local function OnDeploy(inst, pt, deployer)
    if not inst or not inst:IsValid() then return end
    
    local flower = SpawnPrefab("planted_flower")
    if flower and flower:IsValid() then
        flower:PushEvent("growfrombutterfly")
        if flower.Transform then
            flower.Transform:SetPosition(pt:Get())
        end
        local item = inst.components and inst.components.stackable and inst.components.stackable:Get()
        if item and item:IsValid() then
            item:Remove()
        end
        
        if deployer and deployer:IsValid() then
            AwardPlayerAchievement("growfrombutterfly", deployer)
            if TheWorld then
                TheWorld:PushEvent("CHEVO_growfrombutterfly", {target = flower, doer = deployer})
            end
            if deployer.SoundEmitter then
                deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
            end
        end
    end
end

-- 变异处理
local function OnMutate(inst, transformed_inst)
    if transformed_inst and transformed_inst:IsValid() then
        if transformed_inst.sg then
            transformed_inst.sg:GoToState("idle")
        end
        
        -- 复制生命值
        if transformed_inst.components and transformed_inst.components.health and
           inst.components and inst.components.health then
            transformed_inst.components.health:SetMaxHealth(inst.components.health.maxhealth)
            transformed_inst.components.health:SetCurrentHealth(inst.components.health.currenthealth)
        end
        
        -- 复制战斗属性
        if transformed_inst.components and transformed_inst.components.combat and
           inst.components and inst.components.combat then
            transformed_inst.components.combat.defaultdamage = inst.components.combat.defaultdamage or 200
            transformed_inst.components.combat.attackperiod = 2  -- 确保变异后仍保持2秒攻击间隔
            transformed_inst.components.combat:SetRange(inst.components.combat.attackrange or 3)
        end
        
        -- 启动战斗逻辑
        if transformed_inst.components and transformed_inst.components.combat then
            CheckTarget(transformed_inst)
            DoAreaDamage(transformed_inst)
        end
    end
end

local function OnRemove(inst)
    CleanupTasks(inst)
end

-- 实体创建
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddDynamicShadow()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeTinyFlyingCharacterPhysics(inst, 1, .5)
    -- 核心标签
    inst:AddTag("sjy_lingdie")
    inst:AddTag("butterfly")
    inst:AddTag("flying")
    inst:AddTag("ignorewalkableplatformdrowning")
    inst:AddTag("insect")
    inst:AddTag("smallcreature")
    inst:AddTag("cattoyairborne")
    inst:AddTag("wildfireprotected")
    inst:AddTag("deployedplant")
    inst:AddTag("lightbattery")
    inst:AddTag("aggressive")
    inst:AddTag("pollinator")
    inst:AddTag("hostile")
    inst:AddTag("no_flee")

    inst.Transform:SetTwoFaced()

    inst.AnimState:SetBuild("sjy_lingdie")
    inst.AnimState:SetBank("sjy_lingdie")
    inst.AnimState:PlayAnimation("idle_flight_loop", true)  -- 初始化正确的 idle 动画
    inst.AnimState:SetRayTestOnBB(true)

    inst.DynamicShadow:SetSize(.8, .5)

    MakeInventoryFloatable(inst)
    MakeFeedableSmallLivestockPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- 战斗组件配置
    inst:AddComponent("combat")
    if inst.components.combat then
        inst.components.combat.hiteffectsymbol = "butterfly_body"
        inst.components.combat.defaultdamage = 200
        inst.components.combat.attackperiod = 2  -- 攻击间隔2秒，确保能连续攻击
        inst.components.combat:SetRange(3)
        inst.components.combat:SetPlayerStunlock(PLAYERSTUNLOCK.NEVER)
        inst.components.combat:SetHurtSound("dontstarve/bee/bee_hurt")
        
        -- 攻击函数实现
        inst.components.combat.Attack = function(self, target)
            if target and target:IsValid() and not target:HasTag("playerghost") then
                self:DoAttack(target)  -- 使用标准战斗组件的DoAttack方法
                inst:PushEvent("onattackother", {target = target})
                -- 攻击后重置攻击冷却
                self:SetAttackPeriod(2)
            end
        end
        
        -- 保持目标逻辑：扩大范围并优化条件
        inst.components.combat.keepTargetFn = function(inst, target)
            return target ~= nil 
                and target:IsValid() 
                and not target:HasTag("sjy_lingdie")
                and (not target.components.health or not target.components.health:IsDead())
                and inst:IsNear(target, 25)  -- 扩大追踪范围
        end
        
        inst:ListenForEvent("onattackother", OnAttack)
        inst:ListenForEvent("attacked", OnAttacked)
    end

    -- 运动组件
    inst:AddComponent("locomotor")
    if inst.components.locomotor then
        inst.components.locomotor:EnableGroundSpeedMultiplier(false)
        inst.components.locomotor:SetTriggersCreep(false)
        inst.components.locomotor.walkspeed = 6
        inst.components.locomotor.runspeed = 8
        inst.components.locomotor.pathcaps = { ignorecreep = true }  -- 忽略地面 creep 影响
    end
    inst:SetStateGraph("SGlingdie")

    -- 库存组件
    inst:AddComponent("stackable")
    inst:AddComponent("inventoryitem")
    if inst.components.inventoryitem then
        inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_lingdie.xml"
        inst.components.inventoryitem.canbepickedup = false
        inst.components.inventoryitem.canbepickedupalive = true
        inst.components.inventoryitem.nobounce = true
        inst.components.inventoryitem.pushlandedevents = false
    end

    -- 授粉组件
    inst:AddComponent("pollinator")

    -- 健康组件
    inst:AddComponent("health")
    if inst.components.health then
        inst.components.health:SetMaxHealth(100)
    end

    -- 其他组件
    inst:AddComponent("knownlocations")
    MakeSmallBurnableCharacter(inst, "butterfly_body")
    MakeTinyFreezableCharacter(inst, "butterfly_body")
    inst:AddComponent("inspectable")

    -- 战利品组件
    inst:AddComponent("lootdropper")
    if inst.components.lootdropper then
        inst.components.lootdropper:AddRandomLoot("ghostflower", 0.5)
        inst.components.lootdropper:AddRandomLoot("wortox_soul", 0.5)
        inst.components.lootdropper.numrandomloot = 1
    end

    -- 可采集组件
    inst:AddComponent("workable")
    if inst.components.workable then
        inst.components.workable:SetWorkAction(ACTIONS.NET)
        inst.components.workable:SetWorkLeft(1)
        inst.components.workable:SetOnFinishCallback(OnWorked)
    end

    -- 其他功能组件
    inst:AddComponent("tradable")
    inst:AddComponent("deployable")
    if inst.components.deployable then
        inst.components.deployable.ondeploy = OnDeploy
        inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
    end

    MakeHauntablePanicAndIgnite(inst)
    inst:SetBrain(brain)

    -- 生成器跟踪
    if TheWorld and TheWorld.components and TheWorld.components.sjy_lingdiespawner then
        inst.sjy_lingdiespawner = TheWorld.components.sjy_lingdiespawner
        if inst.components and inst.components.inventoryitem then
            inst.components.inventoryitem:SetOnPickupFn(inst.sjy_lingdiespawner.StopTrackingFn)
        end
        inst:ListenForEvent("onremove", inst.sjy_lingdiespawner.StopTrackingFn)
        inst.sjy_lingdiespawner:StartTracking(inst)
    end

    MakeFeedableSmallLivestock(inst, TUNING.BUTTERFLY_PERISH_TIME, OnPickedUp, OnDropped)

    -- 变异组件
    inst:AddComponent("halloweenmoonmutable")
    if inst.components.halloweenmoonmutable then
        inst.components.halloweenmoonmutable:SetPrefabMutated("moonbutterfly")
        inst.components.halloweenmoonmutable:SetOnMutateFn(OnMutate)
        inst.components.halloweenmoonmutable.push_attacked_on_new_inst = false
    end

    -- 移除时清理任务
    inst:ListenForEvent("onremove", OnRemove)

    -- 启动AI逻辑
    CheckTarget(inst)
    DoAreaDamage(inst)

    return inst
end

return Prefab("sjy_lingdie", fn, assets, prefabs),
    MakePlacer("sjy_lingdie_placer", "flower_evil", "flower_evil", "f1")