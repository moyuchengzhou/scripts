-- -- 恒温Buff配置（可根据需求调整）
-- local CONFIG = {
--     TEMP_VALUE = 20,          -- 恒温值（℃）
--     DURATION = 1440,          -- 持续时间（游戏秒，1440秒=3天）
--     PREFAB_NAME = "sjy_buff_hengwen"  -- Buff预制体名称
-- }

-- -- Buff附加时触发：设置恒温并记录原体温范围
-- local function OnAttached(inst, target)
--     -- 绑定到目标实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 记录目标原本的体温范围（用于移除时恢复）
--     inst._original_maxtemp = target.components.temperature.maxtemp
--     inst._original_mintemp = target.components.temperature.mintemp

--     -- 应用恒温效果
--     target.components.temperature.maxtemp = CONFIG.TEMP_VALUE
--     target.components.temperature.mintemp = CONFIG.TEMP_VALUE
--     target.components.temperature:SetTemperature(CONFIG.TEMP_VALUE)  -- 立即将当前体温设为恒温值

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
--     -- 刷新时再次同步体温（防止极端情况体温异常）
--     target.components.temperature:SetTemperature(CONFIG.TEMP_VALUE)
-- end

-- -- Buff移除时触发：恢复原体温范围
-- local function OnDetached(inst, target)
--     -- 安全恢复原本的体温范围（判断目标和组件是否存在，避免报错）
--     if target and target:IsValid() and target.components.temperature then
--         target.components.temperature.maxtemp = inst._original_maxtemp or 70  -- 默认为游戏默认最高温
--         target.components.temperature.mintemp = inst._original_mintemp or -20 -- 默认为游戏默认最低温
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











-- 恒温Buff配置（可根据需求调整）
local CONFIG = {
    TEMP_VALUE = 20,          -- 恒温值（℃）
    DURATION = 1440,          -- 持续时间（游戏秒，1440秒=3天）
    PREFAB_NAME = "sjy_buff_hengwen",  -- Buff预制体名称
    EFFECT_INTERVAL = 0.5     -- 特效触发间隔（秒）
}

-- 播放携带Buff玩家的特效
local function SpawnPlayerEffect(x, y, z)
    -- 按照要求的方式触发玩家特效
    SpawnPrefab("slow_steam_fx4").Transform:SetPosition(x, y, z)
end

-- Buff附加时触发：设置恒温并记录原体温范围
local function OnAttached(inst, target)
    -- 绑定到目标实体
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 记录目标原本的体温范围（用于移除时恢复）
    inst._original_maxtemp = target.components.temperature.maxtemp
    inst._original_mintemp = target.components.temperature.mintemp

    -- 应用恒温效果
    target.components.temperature.maxtemp = CONFIG.TEMP_VALUE
    target.components.temperature.mintemp = CONFIG.TEMP_VALUE
    target.components.temperature:SetTemperature(CONFIG.TEMP_VALUE)  -- 立即将当前体温设为恒温值

    -- 开始每隔0.5秒触发一次特效
    inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
        if target:IsValid() then  -- 确保目标仍然有效
            local x, y, z = target.Transform:GetWorldPosition()
            SpawnPlayerEffect(x, y, z)
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
    -- 刷新时再次同步体温（防止极端情况体温异常）
    target.components.temperature:SetTemperature(CONFIG.TEMP_VALUE)
    
    -- 停止现有特效计时器并重新开始
    if inst._effect_task then
        inst._effect_task:Cancel()
    end
    inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
        if target:IsValid() then
            local x, y, z = target.Transform:GetWorldPosition()
            SpawnPlayerEffect(x, y, z)
        end
    end)
end

-- Buff移除时触发：恢复原体温范围
local function OnDetached(inst, target)
    -- 停止特效计时器
    if inst._effect_task then
        inst._effect_task:Cancel()
        inst._effect_task = nil
    end
    
    -- 安全恢复原本的体温范围（判断目标和组件是否存在，避免报错）
    if target and target:IsValid() and target.components.temperature then
        target.components.temperature.maxtemp = inst._original_maxtemp or 70  -- 默认为游戏默认最高温
        target.components.temperature.mintemp = inst._original_mintemp or -20 -- 默认为游戏默认最低温
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
    