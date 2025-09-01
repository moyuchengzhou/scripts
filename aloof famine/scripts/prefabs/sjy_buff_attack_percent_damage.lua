-- -- 攻击附加百分比掉血Buff配置（可根据需求调整）
-- local CONFIG = {
--     PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
--     TARGET_DURATION = 10,       -- 被攻击生物掉血Buff的持续时间（游戏秒）
--     DAMAGE_INTERVAL = 2,        -- 生物掉血的间隔时间（秒）
--     DAMAGE_PERCENT = 5,         -- 每次掉血的百分比（2%）
--     PLAYER_PREFAB_NAME = "sjy_buff_attack_percent_damage",  -- 玩家携带的Buff预制体名称
--     TARGET_PREFAB_NAME = "sjy_buff_target_percent_damage"  -- 生物掉血Buff预制体名称
-- }

-- -- 生物掉血Buff附加时触发：开始掉血循环
-- local function OnTargetAttached(inst, target)
--     -- 绑定到目标实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性造成百分比掉血
--     inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
--         if target.components.health and not target.components.health:IsDead() then
--             local current_health = target.components.health.currenthealth
--             -- 这里 DAMAGE_PERCENT 应该除以 100，因为是百分比
--             local damage = current_health * (CONFIG.DAMAGE_PERCENT / 100)
--             target.components.health:DoDelta(-damage, false, "percent_damage_buff")
--         end
--     end)

--     -- 监听目标死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, target)
-- end

-- -- 生物掉血Buff计时器结束时触发：移除Buff
-- local function OnTargetTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 生物掉血Buff重复施加时触发：刷新持续时间
-- local function OnTargetExtended(inst, target)
--     inst.components.timer:StopTimer("duration")
--     inst.components.timer:StartTimer("duration", CONFIG.TARGET_DURATION)
-- end

-- -- 生物掉血Buff移除时触发：停止掉血循环
-- local function OnTargetDetached(inst, target)
--     if inst._damage_task then
--         inst._damage_task:Cancel()
--         inst._damage_task = nil
--     end
--     inst:Remove()  -- 移除Buff实体
-- end

-- -- 玩家Buff附加时触发：监听玩家攻击事件
-- local function OnPlayerAttached(inst, player)
--     -- 绑定到玩家实体
--     inst.entity:SetParent(player.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 监听玩家攻击事件
--     inst._onattack_listener = player:ListenForEvent("onattackother", function(_, data)
--         if data and data.target and not data.target:HasTag("player") then
--             local target = data.target
--             if target.components.health and not target.components.health:IsDead() then
--                 local buff = SpawnPrefab(CONFIG.TARGET_PREFAB_NAME)
--                 if buff then
--                     if buff.components.debuff then
--                         -- 修改此处，使用 AttachTo 方法激活 debuff，传入正确的参数
--                         buff.components.debuff:AttachTo(CONFIG.TARGET_PREFAB_NAME, target, nil, nil, nil, nil)
--                     else
--                         print("Warning: buff ".. buff.prefab .. " does not have a debuff component.")
--                     end
--                 end
--             end
--         end
--     end)
-- end

-- -- 玩家Buff计时器结束时触发：移除Buff并停止监听攻击事件
-- local function OnPlayerTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--         local player = inst.components.debuff.target
--         if player and inst._onattack_listener then
--             player:RemoveEventCallback("onattackother", inst._onattack_listener)
--             inst._onattack_listener = nil
--         end
--     end
-- end

-- -- 玩家Buff重复施加时触发：刷新持续时间
-- local function OnPlayerExtended(inst, player)
--     inst.components.timer:StopTimer("duration")
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
-- end

-- -- 玩家Buff移除时触发：停止监听玩家攻击事件
-- local function OnPlayerDetached(inst, player)
--     if inst._onattack_listener then
--         player:RemoveEventCallback("onattackother", inst._onattack_listener)
--         inst._onattack_listener = nil
--     end
--     inst:Remove()  -- 移除Buff实体
-- end

-- -- 创建生物掉血Buff实体
-- local function TargetBuffFn()
--     local inst = CreateEntity()

--     -- 客户端不生成实体（仅服务器处理）
--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     -- 实体设置
--     inst.entity:AddTransform()
--     inst.entity:Hide()  -- 隐藏实体（无需显示）
--     inst.persists = false  -- 不持久化存储
--     inst:AddTag("CLASSIFIED")  -- 标记为机密实体（防止客户端同步错误）

--     -- 添加Buff组件并绑定回调
--     inst:AddComponent("debuff")
--     if not inst.components.debuff then
--         print("Warning: Failed to add debuff component to " .. CONFIG.TARGET_PREFAB_NAME)
--     else
--         inst.components.debuff:SetAttachedFn(OnTargetAttached)
--         inst.components.debuff:SetDetachedFn(OnTargetDetached)
--         inst.components.debuff:SetExtendedFn(OnTargetExtended)
--         inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff
--     end

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.TARGET_DURATION)
--     inst:ListenForEvent("timerdone", OnTargetTimerDone)

--     return inst
-- end

-- -- 创建玩家携带的Buff实体
-- local function PlayerBuffFn()
--     local inst = CreateEntity()

--     -- 客户端不生成实体（仅服务器处理）
--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     -- 实体设置
--     inst.entity:AddTransform()
--     inst.entity:Hide()  -- 隐藏实体（无需显示）
--     inst.persists = false  -- 不持久化存储
--     inst:AddTag("CLASSIFIED")  -- 标记为机密实体（防止客户端同步错误）

--     -- 添加Buff组件并绑定回调
--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnPlayerAttached)
--     inst.components.debuff:SetDetachedFn(OnPlayerDetached)
--     inst.components.debuff:SetExtendedFn(OnPlayerExtended)
--     inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
--     inst:ListenForEvent("timerdone", OnPlayerTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn),
--        Prefab(CONFIG.TARGET_PREFAB_NAME, TargetBuffFn)




-- 攻击附加百分比掉血Buff配置（可根据需求调整）
-- local CONFIG = {
--     PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
--     TARGET_DURATION = 10,       -- 被攻击生物掉血Buff的持续时间（游戏秒）
--     DAMAGE_INTERVAL = 2,        -- 生物掉血的间隔时间（秒）
--     DAMAGE_PERCENT = 5,         -- 每次掉血的百分比（2%）
--     PLAYER_PREFAB_NAME = "sjy_buff_attack_percent_damage",  -- 玩家携带的Buff预制体名称
--     TARGET_PREFAB_NAME = "sjy_buff_target_percent_damage"  -- 生物掉血Buff预制体名称
-- }

-- -- 生物掉血Buff附加时触发：开始掉血循环
-- local function OnTargetAttached(inst, target)
--     -- 绑定到目标实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性造成百分比掉血
--     inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
--         if target.components.health and not target.components.health:IsDead() then
--             local current_health = target.components.health.currenthealth
--             -- 这里 DAMAGE_PERCENT 应该除以 100，因为是百分比
--             local damage = current_health * (CONFIG.DAMAGE_PERCENT / 100)
--             target.components.health:DoDelta(-damage, false, "percent_damage_buff")
--         end
--     end)

--     -- 监听目标死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, target)
-- end

-- -- 生物掉血Buff计时器结束时触发：移除Buff
-- local function OnTargetTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 生物掉血Buff重复施加时触发：刷新持续时间
-- local function OnTargetExtended(inst, target)
--     inst.components.timer:StopTimer("duration")
--     inst.components.timer:StartTimer("duration", CONFIG.TARGET_DURATION)
-- end

-- -- 生物掉血Buff移除时触发：停止掉血循环
-- local function OnTargetDetached(inst, target)
--     if inst._damage_task then
--         inst._damage_task:Cancel()
--         inst._damage_task = nil
--     end
--     inst:Remove()  -- 移除Buff实体
-- end

-- -- 玩家Buff附加时触发：监听玩家攻击事件
-- local function OnPlayerAttached(inst, player)
--     -- 绑定到玩家实体
--     inst.entity:SetParent(player.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 监听玩家攻击事件
--     inst._onattack_listener = player:ListenForEvent("onattackother", function(_, data)
--         if data and data.target and not data.target:HasTag("player") then
--             local target = data.target
--             if target.components.health and not target.components.health:IsDead() then
--                 -- 检查目标身上是否已经存在该Buff
--                 local existing_buff = target.components.debuffable and target.components.debuffable:HasDebuff(CONFIG.TARGET_PREFAB_NAME)
--                 if existing_buff then
--                     -- 如果存在，延长其持续时间
--                     existing_buff.components.debuff:Extend()
--                 else
--                     -- 如果不存在，创建新的Buff
--                     local buff = SpawnPrefab(CONFIG.TARGET_PREFAB_NAME)
--                     if buff then
--                         if buff.components.debuff then
--                             -- 修改此处，使用 AttachTo 方法激活 debuff，传入正确的参数
--                             buff.components.debuff:AttachTo(CONFIG.TARGET_PREFAB_NAME, target, nil, nil, nil, nil)
--                         else
--                             print("Warning: buff ".. buff.prefab .. " does not have a debuff component.")
--                         end
--                     end
--                 end
--             end
--         end
--     end)
-- end

-- -- 玩家Buff计时器结束时触发：移除Buff并停止监听攻击事件
-- local function OnPlayerTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--         local player = inst.components.debuff.target
--         if player and inst._onattack_listener then
--             player:RemoveEventCallback("onattackother", inst._onattack_listener)
--             inst._onattack_listener = nil
--         end
--     end
-- end

-- -- 玩家Buff重复施加时触发：刷新持续时间
-- local function OnPlayerExtended(inst, player)
--     inst.components.timer:StopTimer("duration")
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
-- end

-- -- 玩家Buff移除时触发：停止监听玩家攻击事件
-- local function OnPlayerDetached(inst, player)
--     if inst._onattack_listener then
--         player:RemoveEventCallback("onattackother", inst._onattack_listener)
--         inst._onattack_listener = nil
--     end
--     inst:Remove()  -- 移除Buff实体
-- end

-- -- 创建生物掉血Buff实体
-- local function TargetBuffFn()
--     local inst = CreateEntity()

--     -- 客户端不生成实体（仅服务器处理）
--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     -- 实体设置
--     inst.entity:AddTransform()
--     inst.entity:Hide()  -- 隐藏实体（无需显示）
--     inst.persists = false  -- 不持久化存储
--     inst:AddTag("CLASSIFIED")  -- 标记为机密实体（防止客户端同步错误）

--     -- 添加Buff组件并绑定回调
--     inst:AddComponent("debuff")
--     if not inst.components.debuff then
--         print("Warning: Failed to add debuff component to " .. CONFIG.TARGET_PREFAB_NAME)
--     else
--         inst.components.debuff:SetAttachedFn(OnTargetAttached)
--         inst.components.debuff:SetDetachedFn(OnTargetDetached)
--         inst.components.debuff:SetExtendedFn(OnTargetExtended)
--         inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff
--     end

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.TARGET_DURATION)
--     inst:ListenForEvent("timerdone", OnTargetTimerDone)

--     return inst
-- end

-- -- 创建玩家携带的Buff实体
-- local function PlayerBuffFn()
--     local inst = CreateEntity()

--     -- 客户端不生成实体（仅服务器处理）
--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     -- 实体设置
--     inst.entity:AddTransform()
--     inst.entity:Hide()  -- 隐藏实体（无需显示）
--     inst.persists = false  -- 不持久化存储
--     inst:AddTag("CLASSIFIED")  -- 标记为机密实体（防止客户端同步错误）

--     -- 添加Buff组件并绑定回调
--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnPlayerAttached)
--     inst.components.debuff:SetDetachedFn(OnPlayerDetached)
--     inst.components.debuff:SetExtendedFn(OnPlayerExtended)
--     inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
--     inst:ListenForEvent("timerdone", OnPlayerTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn),
--        Prefab(CONFIG.TARGET_PREFAB_NAME, TargetBuffFn)













-- 攻击附加百分比掉血Buff配置（可根据需求调整）
local CONFIG = {
    PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
    TARGET_DURATION = 10,       -- 被攻击生物掉血Buff的持续时间（游戏秒）
    DAMAGE_INTERVAL = 2,        -- 生物掉血的间隔时间（秒）
    DAMAGE_PERCENT = 0.2,         -- 每次掉血的百分比（2%）
    PLAYER_PREFAB_NAME = "sjy_buff_attack_percent_damage",  -- 玩家携带的Buff预制体名称
    TARGET_PREFAB_NAME = "sjy_buff_target_percent_damage"  -- 生物掉血Buff预制体名称
}

-- 生物掉血Buff附加时触发：开始掉血循环
local function OnTargetAttached(inst, target)
    -- 绑定到目标实体
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 开始周期性造成百分比掉血
    inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
        if target.components.health and not target.components.health:IsDead() then
            local current_health = target.components.health.currenthealth
            -- 这里 DAMAGE_PERCENT 应该除以 100，因为是百分比
            local damage = current_health * (CONFIG.DAMAGE_PERCENT / 100)
            target.components.health:DoDelta(-damage, false, "percent_damage_buff")
        end
    end)

    -- 监听目标死亡事件：死亡后移除Buff
    inst:ListenForEvent("death", function()
        inst.components.debuff:Stop()
    end, target)
end

-- 生物掉血Buff计时器结束时触发：移除Buff
local function OnTargetTimerDone(inst, data)
    if data.name == "duration" then
        inst.components.debuff:Stop()
    end
end

-- 生物掉血Buff重复施加时触发：刷新持续时间
local function OnTargetExtended(inst, target)
    if inst.components.timer:TimerExists("duration") then
        inst.components.timer:StopTimer("duration")
    end
    inst.components.timer:StartTimer("duration", CONFIG.TARGET_DURATION)
end

-- 生物掉血Buff移除时触发：停止掉血循环
local function OnTargetDetached(inst, target)
    if inst._damage_task then
        inst._damage_task:Cancel()
        inst._damage_task = nil
    end
    if target.components.debuffable then
        target.components.debuffable:RemoveDebuff(inst.prefab)
    end
    inst:Remove()  -- 移除Buff实体
end

-- 玩家Buff附加时触发：监听玩家攻击事件
local function OnPlayerAttached(inst, player)
    -- 绑定到玩家实体
    inst.entity:SetParent(player.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 监听玩家攻击事件
    inst._onattack_listener = player:ListenForEvent("onattackother", function(_, data)
        if data and data.target and not data.target:HasTag("player") then
            local target = data.target
            if target.components.health and not target.components.health:IsDead() then
                -- 检查目标身上是否已经存在该Buff
                local existing_buff = target.components.debuffable and target.components.debuffable:HasDebuff(CONFIG.TARGET_PREFAB_NAME)
                if existing_buff then
                    -- 如果存在，延长其持续时间
                    existing_buff.components.debuff:Extend()
                else
                    -- 如果不存在，创建新的Buff
                    local buff = SpawnPrefab(CONFIG.TARGET_PREFAB_NAME)
                    if buff then
                        if buff.components.debuff then
                            -- 使用 AttachTo 方法激活 debuff
                            buff.components.debuff:AttachTo(CONFIG.TARGET_PREFAB_NAME, target)
                        else
                            print("Warning: buff ".. buff.prefab .. " does not have a debuff component.")
                        end
                    end
                end
            end
        end
    end)
end

-- 玩家Buff计时器结束时触发：移除Buff并停止监听攻击事件
local function OnPlayerTimerDone(inst, data)
    if data.name == "duration" then
        inst.components.debuff:Stop()
        local player = inst.components.debuff.target
        if player and inst._onattack_listener then
            player:RemoveEventCallback("onattackother", inst._onattack_listener)
            inst._onattack_listener = nil
        end
    end
end

-- 玩家Buff重复施加时触发：刷新持续时间
local function OnPlayerExtended(inst, player)
    if inst.components.timer:TimerExists("duration") then
        inst.components.timer:StopTimer("duration")
    end
    inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
end

-- 玩家Buff移除时触发：停止监听玩家攻击事件
local function OnPlayerDetached(inst, player)
    if inst._onattack_listener then
        player:RemoveEventCallback("onattackother", inst._onattack_listener)
        inst._onattack_listener = nil
    end
    if player.components.debuffable then
        player.components.debuffable:RemoveDebuff(inst.prefab)
    end
    inst:Remove()  -- 移除Buff实体
end

-- 创建生物掉血Buff实体
local function TargetBuffFn()
    local inst = CreateEntity()

    -- 客户端不生成实体（仅服务器处理）
    if not TheWorld.ismastersim then
        inst:DoTaskInTime(0, inst.Remove)
        return inst
    end

    -- 实体设置
    inst.entity:AddTransform()
    inst.entity:Hide()  -- 隐藏实体（无需显示）
    inst.persists = false  -- 不持久化存储
    inst:AddTag("CLASSIFIED")  -- 标记为机密实体（防止客户端同步错误）

    -- 添加Buff组件并绑定回调
    inst:AddComponent("debuff")
    if not inst.components.debuff then
        print("Warning: Failed to add debuff component to " .. CONFIG.TARGET_PREFAB_NAME)
    else
        inst.components.debuff:SetAttachedFn(OnTargetAttached)
        inst.components.debuff:SetDetachedFn(OnTargetDetached)
        inst.components.debuff:SetExtendedFn(OnTargetExtended)
        inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff
    end

    -- 添加计时器组件（控制持续时间）
    inst:AddComponent("timer")
    inst.components.timer:StartTimer("duration", CONFIG.TARGET_DURATION)
    inst:ListenForEvent("timerdone", OnTargetTimerDone)

    return inst
end

-- 创建玩家携带的Buff实体
local function PlayerBuffFn()
    local inst = CreateEntity()

    -- 客户端不生成实体（仅服务器处理）
    if not TheWorld.ismastersim then
        inst:DoTaskInTime(0, inst.Remove)
        return inst
    end

    -- 实体设置
    inst.entity:AddTransform()
    inst.entity:Hide()  -- 隐藏实体（无需显示）
    inst.persists = false  -- 不持久化存储
    inst:AddTag("CLASSIFIED")  -- 标记为机密实体（防止客户端同步错误）

    -- 添加Buff组件并绑定回调
    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnPlayerAttached)
    inst.components.debuff:SetDetachedFn(OnPlayerDetached)
    inst.components.debuff:SetExtendedFn(OnPlayerExtended)
    inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff

    -- 添加计时器组件（控制持续时间）
    inst:AddComponent("timer")
    inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
    inst:ListenForEvent("timerdone", OnPlayerTimerDone)

    return inst
end

return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn),
       Prefab(CONFIG.TARGET_PREFAB_NAME, TargetBuffFn)