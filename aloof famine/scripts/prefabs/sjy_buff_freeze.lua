-- -- 冰冻Buff配置（可根据需求调整）
-- local CONFIG = {
--     FREEZE_DURATION = 5,      -- 冰冻持续时间
--     RADIUS = 3,               -- 冰冻范围半径（单位：游戏单位）
--     DURATION = 480,           -- 持续时间（游戏秒，1440秒=3天）
--     PREFAB_NAME = "sjy_buff_freeze"  -- Buff预制体名称
-- }

-- -- Buff附加时触发：开始检测附近生物并冰冻
-- local function OnAttached(inst, target)
--     -- 绑定到目标实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性检查附近的生物
--     inst._check_task = inst:DoPeriodicTask(1, function()
--         local x, y, z = target.Transform:GetWorldPosition()
--         local entities = TheSim:FindEntities(x, y, z, CONFIG.RADIUS)
--         for _, entity in ipairs(entities) do
--             if entity ~= target and entity.components.freezable then
--                 entity.components.freezable:Freeze(CONFIG.FREEZE_DURATION)
--             end
--         end
--     end)

--     -- 监听目标死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, target)
-- end

-- -- 计时器结束时触发：移除Buff
-- local function OnTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发：刷新持续时间
-- local function OnExtended(inst, target)
--     inst.components.timer:StopTimer("duration")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
-- end

-- -- Buff移除时触发：停止检查任务
-- local function OnDetached(inst, target)
--     if inst._check_task then
--         inst._check_task:Cancel()
--         inst._check_task = nil
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











-- -- 冰冻Buff配置（可根据需求调整）
-- local CONFIG = {
--     FREEZE_DURATION = 5,      -- 冰冻持续时间
--     RADIUS = 3,               -- 冰冻范围半径（单位：游戏单位）
--     DURATION = 480,           -- 持续时间（游戏秒，1440秒=3天）
--     PREFAB_NAME = "sjy_buff_freeze",  -- Buff预制体名称
--     EFFECT_INTERVAL = 2       -- 特效触发间隔（秒）
-- }

-- -- 播放冰冻特效
-- local function SpawnFreezeEffect(x, y, z)
--     -- 按照要求的方式触发官方内置特效
--     SpawnPrefab("crabking_ring_fx").Transform:SetPosition(x, y, z)
-- end

-- -- Buff附加时触发：开始检测附近生物并冰冻
-- local function OnAttached(inst, target)
--     -- 绑定到目标实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性检查附近的生物
--     inst._check_task = inst:DoPeriodicTask(1, function()
--         local x, y, z = target.Transform:GetWorldPosition()
--         local entities = TheSim:FindEntities(x, y, z, CONFIG.RADIUS)
--         for _, entity in ipairs(entities) do
--             if entity ~= target and entity.components.freezable then
--                 entity.components.freezable:Freeze(CONFIG.FREEZE_DURATION)
--             end
--         end
--     end)

--     -- 开始每隔2秒在玩家身上播放特效
--     inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
--         local x, y, z = target.Transform:GetWorldPosition()
--         if x and y and z then
--             SpawnFreezeEffect(x, y, z)
--         end
--     end)

--     -- 监听目标死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, target)
-- end

-- -- 计时器结束时触发：移除Buff
-- local function OnTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发：刷新持续时间
-- local function OnExtended(inst, target)
--     inst.components.timer:StopTimer("duration")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
-- end

-- -- Buff移除时触发：停止检查任务
-- local function OnDetached(inst, target)
--     if inst._check_task then
--         inst._check_task:Cancel()
--         inst._check_task = nil
--     end
--     -- 停止特效播放循环
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














-- 冰冻Buff配置（可根据需求调整）
local CONFIG = {
    FREEZE_DURATION = 5,      -- 冰冻持续时间
    RADIUS = 6,               -- 冰冻范围半径（单位：游戏单位）
    DURATION = 480,           -- 持续时间（游戏秒，1440秒=3天）
    PREFAB_NAME = "sjy_buff_freeze",  -- Buff预制体名称
    EFFECT_INTERVAL = 2       -- 特效触发间隔（秒）
}

-- 播放生物冰冻特效
local function SpawnCreatureFreezeEffect(x, y, z)
    -- 按照要求的方式触发生物冰冻特效
    SpawnPrefab("fx_ice_crackle").Transform:SetPosition(x, y, z)
end

-- 播放玩家身上的特效
local function SpawnPlayerFreezeEffect(x, y, z)
    -- 按照要求的方式触发玩家身上的特效
    SpawnPrefab("crabking_ring_fx").Transform:SetPosition(x, y, z)
end

-- Buff附加时触发：开始检测附近生物并冰冻
local function OnAttached(inst, target)
    -- 绑定到目标实体
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 开始周期性检查附近的生物
    inst._check_task = inst:DoPeriodicTask(1, function()
        local x, y, z = target.Transform:GetWorldPosition()
        local entities = TheSim:FindEntities(x, y, z, CONFIG.RADIUS)
        for _, entity in ipairs(entities) do
            if entity ~= target and entity.components.freezable then
                -- 冰冻目标生物
                entity.components.freezable:Freeze(CONFIG.FREEZE_DURATION)
                -- 在受影响的生物身上触发特效
                local ex, ey, ez = entity.Transform:GetWorldPosition()
                SpawnCreatureFreezeEffect(ex, ey, ez)
            end
        end
    end)

    -- 开始每隔2秒在玩家身上播放特效
    inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
        local x, y, z = target.Transform:GetWorldPosition()
        if x and y and z then
            SpawnPlayerFreezeEffect(x, y, z)
        end
    end)

    -- 监听目标死亡事件：死亡后移除Buff
    inst:ListenForEvent("death", function()
        inst.components.debuff:Stop()
    end, target)
end

-- 计时器结束时触发：移除Buff
local function OnTimerDone(inst, data)
    if data.name == "duration" then
        inst.components.debuff:Stop()
    end
end

-- 重复施加时触发：刷新持续时间
local function OnExtended(inst, target)
    inst.components.timer:StopTimer("duration")
    inst.components.timer:StartTimer("duration", CONFIG.DURATION)
end

-- Buff移除时触发：停止检查任务
local function OnDetached(inst, target)
    if inst._check_task then
        inst._check_task:Cancel()
        inst._check_task = nil
    end
    -- 停止特效播放循环
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