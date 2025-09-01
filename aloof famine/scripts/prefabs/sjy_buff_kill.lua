-- -- -- 特殊死亡复仇Buff配置（可根据需求调整）
-- -- local CONFIG = {
-- --     DURATION = 1440,          -- 持续时间（游戏秒，1440秒 = 3天）
-- --     PREFAB_NAME = "sjy_buff_kill"  -- Buff预制体名称
-- -- }

-- -- -- Buff附加时触发：监听玩家死亡事件
-- -- local function OnAttached(inst, target)
-- --     -- 绑定到目标实体
-- --     inst.entity:SetParent(target.entity)
-- --     inst.Transform:SetPosition(0, 0, 0)

-- --     -- 监听目标死亡事件
-- --     inst._on_death = function(target, data)
-- --         if data and data.afflicter and data.afflicter.components.health then
-- --             -- 杀死导致玩家死亡的生物
-- --             data.afflicter.components.health:Kill()
-- --         end
-- --         inst.components.debuff:Stop()
-- --     end
-- --     inst:ListenForEvent("death", inst._on_death, target)

-- --     -- 监听目标重生事件：重生后移除Buff（可选，可根据需要调整）
-- --     inst:ListenForEvent("respawnfromghost", function()
-- --         inst.components.debuff:Stop()
-- --     end, target)
-- -- end

-- -- -- 计时器结束时触发：移除Buff
-- -- local function OnTimerDone(inst, data)
-- --     if data.name == "duration" then
-- --         inst.components.debuff:Stop()
-- --     end
-- -- end

-- -- -- 重复施加时触发：刷新持续时间
-- -- local function OnExtended(inst, target)
-- --     inst.components.timer:StopTimer("duration")
-- --     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
-- -- end

-- -- -- Buff移除时触发：停止监听死亡事件
-- -- local function OnDetached(inst, target)
-- --     if inst._on_death then
-- --         inst:RemoveEventCallback("death", inst._on_death, target)
-- --         inst._on_death = nil
-- --     end
-- --     inst:Remove()  -- 移除Buff实体
-- -- end

-- -- -- 创建Buff实体
-- -- local function fn()
-- --     local inst = CreateEntity()

-- --     -- 客户端不生成实体（仅服务器处理）
-- --     if not TheWorld.ismastersim then
-- --         inst:DoTaskInTime(0, inst.Remove)
-- --         return inst
-- --     end

-- --     -- 实体设置
-- --     inst.entity:AddTransform()
-- --     inst.entity:Hide()  -- 隐藏实体（无需显示）
-- --     inst.persists = false  -- 不持久化存储
-- --     inst:AddTag("CLASSIFIED")  -- 标记为机密实体（防止客户端同步错误）

-- --     -- 添加Buff组件并绑定回调
-- --     inst:AddComponent("debuff")
-- --     inst.components.debuff:SetAttachedFn(OnAttached)
-- --     inst.components.debuff:SetDetachedFn(OnDetached)
-- --     inst.components.debuff:SetExtendedFn(OnExtended)
-- --     inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff

-- --     -- 添加计时器组件（控制持续时间）
-- --     inst:AddComponent("timer")
-- --     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
-- --     inst:ListenForEvent("timerdone", OnTimerDone)

-- --     return inst
-- -- end

-- -- return Prefab(CONFIG.PREFAB_NAME, fn)












-- -- 特殊死亡复仇Buff配置（可根据需求调整）
-- local CONFIG = {
--     DURATION = 1440,          -- 持续时间（游戏秒，1440秒 = 3天）
--     PREFAB_NAME = "sjy_buff_kill"  -- Buff预制体名称
-- }

-- -- Buff附加时触发：监听玩家死亡事件
-- local function OnAttached(inst, target)
--     -- 绑定到目标实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 监听目标死亡事件
--     inst._on_death = function(target, data)
--         if data and data.afflicter and data.afflicter.components.health then
--             -- 杀死导致玩家死亡的生物
--             data.afflicter.components.health:Kill()
--         end
--         inst.components.debuff:Stop()
--     end
--     inst:ListenForEvent("death", inst._on_death, target)

--     -- 监听目标重生事件：重生后移除Buff
--     inst:ListenForEvent("respawnfromghost", function()
--         inst.components.debuff:Stop()
--     end, target)
-- end

-- -- 计时器结束时触发：移除Buff并强制杀死玩家（如果3天内未死亡）
-- local function OnTimerDone(inst, data)
--     if data.name == "duration" then
--         -- 获取Buff携带者
--         local target = inst.entity:GetParent()
--         -- 检查目标是否有效且仍然存活
--         if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
--             -- 强制杀死携带Buff的玩家
--             target.components.health:Kill()
--         end
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发：刷新持续时间
-- local function OnExtended(inst, target)
--     inst.components.timer:StopTimer("duration")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
-- end

-- -- Buff移除时触发：停止监听死亡事件
-- local function OnDetached(inst, target)
--     if inst._on_death then
--         inst:RemoveEventCallback("death", inst._on_death, target)
--         inst._on_death = nil
--     end
--     inst:Remove()  -- 移除Buff实体
-- end

-- -- 创建Buff实体
-- local function fn()
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
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)








-- -- 特殊死亡复仇Buff配置（可根据需求调整）
-- local CONFIG = {
--     DURATION = 1440,          -- 持续时间（游戏秒，1440秒 = 3天）
--     PREFAB_NAME = "sjy_buff_kill",  -- Buff预制体名称
--     EFFECT_INTERVAL = 1       -- 玩家特效触发间隔（秒）
-- }

-- -- 播放被强制杀死生物的特效
-- local function SpawnKilledCreatureEffect(x, y, z)
--     -- 按照要求的方式触发被强制杀死生物的特效
--     SpawnPrefab("charlie_snap").Transform:SetPosition(x, y, z)
-- end

-- -- 播放携带Buff玩家的特效
-- local function SpawnPlayerEffect(x, y, z)
--     -- 按照要求的方式触发携带Buff玩家的特效
--     SpawnPrefab("shadow_teleport_out").Transform:SetPosition(x, y, z)
-- end

-- -- 播放玩家被Buff强制杀死的特效
-- local function SpawnPlayerForcedDeathEffect(x, y, z)
--     -- 按照要求的方式触发玩家被Buff强制杀死的特效
--     SpawnPrefab("statue_transition").Transform:SetPosition(x, y, z)
-- end

-- -- Buff附加时触发：监听玩家死亡事件
-- local function OnAttached(inst, target)
--     -- 绑定到目标实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 触发玩家获得Buff时的特效
--     local x, y, z = target.Transform:GetWorldPosition()
--     SpawnPlayerEffect(x, y, z)

--     -- 开始每隔1秒在玩家身上播放特效
--     inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
--         if target:IsValid() then  -- 确保目标仍然有效
--             local x, y, z = target.Transform:GetWorldPosition()
--             SpawnPlayerEffect(x, y, z)
--         end
--     end)

--     -- 监听目标死亡事件
--     inst._on_death = function(target, data)
--         if data and data.afflicter and data.afflicter.components.health then
--             -- 杀死导致玩家死亡的生物
--             data.afflicter.components.health:Kill()
--             -- 在被杀死的生物位置触发特效
--             local ex, ey, ez = data.afflicter.Transform:GetWorldPosition()
--             SpawnKilledCreatureEffect(ex, ey, ez)
--         end
--         inst.components.debuff:Stop()
--     end
--     inst:ListenForEvent("death", inst._on_death, target)

--     -- 监听目标重生事件：重生后移除Buff
--     inst:ListenForEvent("respawnfromghost", function()
--         inst.components.debuff:Stop()
--     end, target)
-- end

-- -- 计时器结束时触发：移除Buff并强制杀死玩家（如果3天内未死亡）
-- local function OnTimerDone(inst, data)
--     if data.name == "duration" then
--         -- 获取Buff携带者
--         local target = inst.entity:GetParent()
--         -- 检查目标是否有效且仍然存活
--         if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
--             -- 强制杀死携带Buff的玩家
--             target.components.health:Kill()
--             -- 在玩家位置触发被强制杀死的特效
--             local x, y, z = target.Transform:GetWorldPosition()
--             SpawnPlayerForcedDeathEffect(x, y, z)
--         end
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发：刷新持续时间
-- local function OnExtended(inst, target)
--     inst.components.timer:StopTimer("duration")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
    
--     -- 停止现有特效计时器
--     if inst._effect_task then
--         inst._effect_task:Cancel()
--     end
    
--     -- 重新开始特效计时器
--     inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
--         if target:IsValid() then
--             local x, y, z = target.Transform:GetWorldPosition()
--             SpawnPlayerEffect(x, y, z)
--         end
--     end)
-- end

-- -- Buff移除时触发：停止监听死亡事件
-- local function OnDetached(inst, target)
--     if inst._on_death then
--         inst:RemoveEventCallback("death", inst._on_death, target)
--         inst._on_death = nil
--     end
    
--     -- 停止特效计时器
--     if inst._effect_task then
--         inst._effect_task:Cancel()
--         inst._effect_task = nil
--     end
    
--     inst:Remove()  -- 移除Buff实体
-- end

-- -- 创建Buff实体
-- local function fn()
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
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)










-- 特殊死亡复仇Buff配置（可根据需求调整）
local CONFIG = {
    DURATION = 1440,          -- 持续时间（游戏秒，1440秒 = 3天）
    PREFAB_NAME = "sjy_buff_kill",  -- Buff预制体名称
    EFFECT_INTERVAL = 1,       -- 玩家特效触发间隔（秒）
    CREATURE_EFFECT_SCALE = 1  -- 生物特效放大倍数
}

-- 播放被强制杀死生物的特效（在生物头顶且放大1倍）
local function SpawnKilledCreatureEffect(x, y, z)
    -- 按照要求的方式触发被强制杀死生物的特效
    local effect = SpawnPrefab("charlie_snap")
    -- 设置特效位置在生物头顶（y轴适当提高）
    effect.Transform:SetPosition(x, y + 7, z)
    -- 放大特效1倍
    effect.Transform:SetScale(
        CONFIG.CREATURE_EFFECT_SCALE,
        CONFIG.CREATURE_EFFECT_SCALE,
        CONFIG.CREATURE_EFFECT_SCALE
    )
end

-- 播放携带Buff玩家的特效
local function SpawnPlayerEffect(x, y, z)
    -- 按照要求的方式触发携带Buff玩家的特效
    SpawnPrefab("shadow_teleport_out").Transform:SetPosition(x, y, z)
end

-- 播放玩家被Buff强制杀死的特效
local function SpawnPlayerForcedDeathEffect(x, y, z)
    -- 按照要求的方式触发玩家被Buff强制杀死的特效
    SpawnPrefab("shadowthrall_parasite_attach_poof_fx").Transform:SetPosition(x, y, z)
end

-- Buff附加时触发：监听玩家死亡事件
local function OnAttached(inst, target)
    -- 绑定到目标实体
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 触发玩家获得Buff时的特效
    local x, y, z = target.Transform:GetWorldPosition()
    SpawnPlayerEffect(x, y, z)

    -- 开始每隔1秒在玩家身上播放特效
    inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
        if target:IsValid() then  -- 确保目标仍然有效
            local x, y, z = target.Transform:GetWorldPosition()
            SpawnPlayerEffect(x, y, z)
        end
    end)

    -- 监听目标死亡事件
    inst._on_death = function(target, data)
        if data and data.afflicter and data.afflicter.components.health then
            -- 杀死导致玩家死亡的生物
            data.afflicter.components.health:Kill()
            -- 在被杀死的生物位置触发特效
            local ex, ey, ez = data.afflicter.Transform:GetWorldPosition()
            SpawnKilledCreatureEffect(ex, ey, ez)
        end
        inst.components.debuff:Stop()
    end
    inst:ListenForEvent("death", inst._on_death, target)

    -- 监听目标重生事件：重生后移除Buff
    inst:ListenForEvent("respawnfromghost", function()
        inst.components.debuff:Stop()
    end, target)
end

-- 计时器结束时触发：移除Buff并强制杀死玩家（如果3天内未死亡）
local function OnTimerDone(inst, data)
    if data.name == "duration" then
        -- 获取Buff携带者
        local target = inst.entity:GetParent()
        -- 检查目标是否有效且仍然存活
        if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
            -- 强制杀死携带Buff的玩家
            target.components.health:Kill()
            -- 在玩家位置触发被强制杀死的特效
            local x, y, z = target.Transform:GetWorldPosition()
            SpawnPlayerForcedDeathEffect(x, y, z)
        end
        inst.components.debuff:Stop()
    end
end

-- 重复施加时触发：刷新持续时间
local function OnExtended(inst, target)
    inst.components.timer:StopTimer("duration")
    inst.components.timer:StartTimer("duration", CONFIG.DURATION)
    
    -- 停止现有特效计时器
    if inst._effect_task then
        inst._effect_task:Cancel()
    end
    
    -- 重新开始特效计时器
    inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
        if target:IsValid() then
            local x, y, z = target.Transform:GetWorldPosition()
            SpawnPlayerEffect(x, y, z)
        end
    end)
end

-- Buff移除时触发：停止监听死亡事件
local function OnDetached(inst, target)
    if inst._on_death then
        inst:RemoveEventCallback("death", inst._on_death, target)
        inst._on_death = nil
    end
    
    -- 停止特效计时器
    if inst._effect_task then
        inst._effect_task:Cancel()
        inst._effect_task = nil
    end
    
    inst:Remove()  -- 移除Buff实体
end

-- 创建Buff实体
local function fn()
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
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(OnDetached)
    inst.components.debuff:SetExtendedFn(OnExtended)
    inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff

    -- 添加计时器组件（控制持续时间）
    inst:AddComponent("timer")
    inst.components.timer:StartTimer("duration", CONFIG.DURATION)
    inst:ListenForEvent("timerdone", OnTimerDone)

    return inst
end

return Prefab(CONFIG.PREFAB_NAME, fn)