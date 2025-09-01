-- -- 降温Buff配置（可根据需求调整）
-- local CONFIG = {
--     COOLING_VALUE = 10,          -- 降温值（℃）
--     RADIUS = 5,                  -- 降温范围半径（单位：游戏单位）
--     DURATION = 480,              -- 持续时间（游戏秒，1440秒=3天）
--     PREFAB_NAME = "sjy_buff_cooling"  -- Buff预制体名称
-- }

-- -- Buff附加时触发：开始检测附近队友并降温
-- local function OnAttached(inst, target)
--     -- 绑定到目标实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性检查附近的队友
--     inst._check_task = inst:DoPeriodicTask(1, function()
--         local x, y, z = target.Transform:GetWorldPosition()
--         local players = TheSim:FindEntities(x, y, z, CONFIG.RADIUS, {"player"})
--         for _, player in ipairs(players) do
--             if player ~= target and player.components.temperature then
--                 local current_temp = player.components.temperature:GetCurrent()
--                 local new_temp = math.max(current_temp - CONFIG.COOLING_VALUE, player.components.temperature.mintemp)
--                 player.components.temperature:SetTemperature(new_temp)
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

















-- 降温Buff配置（可根据需求调整）
local CONFIG = {
    COOLING_VALUE = 10,          -- 降温值（℃）
    RADIUS = 5,                  -- 降温范围半径（单位：游戏单位）
    DURATION = 480,              -- 持续时间（游戏秒，1440秒=3天）
    PREFAB_NAME = "sjy_buff_cooling",  -- Buff预制体名称
    EFFECT_INTERVAL = 0.5        -- 特效触发间隔（秒）
}

-- 播放携带Buff玩家的特效
local function SpawnPlayerEffect(x, y, z)
    -- 按照要求的方式触发玩家特效
    SpawnPrefab("crab_king_icefx").Transform:SetPosition(x, y, z)
end

-- 播放范围内受影响目标的第一种特效
local function SpawnAffectedEffect1(x, y, z)
    -- 按照要求的方式触发受影响目标的第一种特效
    SpawnPrefab("crab_king_icefx").Transform:SetPosition(x, y, z)
end

-- 播放范围内受影响目标的第二种特效
local function SpawnAffectedEffect2(x, y, z)
    -- 按照要求的方式触发受影响目标的第二种特效
    SpawnPrefab("ghostlyelixir_player_shield_dripfx").Transform:SetPosition(x, y, z)
end

-- Buff附加时触发：开始检测附近队友并降温
local function OnAttached(inst, target)
    -- 绑定到目标实体
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 开始周期性检查附近的队友并触发特效
    inst._check_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
        local x, y, z = target.Transform:GetWorldPosition()
        -- 触发携带Buff玩家的特效（0.5秒一次）
        SpawnPlayerEffect(x, y, z)
        
        -- 检测范围内的玩家并降温
        local players = TheSim:FindEntities(x, y, z, CONFIG.RADIUS, {"player"})
        for _, player in ipairs(players) do
            if player ~= target and player.components.temperature then
                -- 应用降温效果
                local current_temp = player.components.temperature:GetCurrent()
                local new_temp = math.max(current_temp - CONFIG.COOLING_VALUE, player.components.temperature.mintemp)
                player.components.temperature:SetTemperature(new_temp)
                
                -- 获取受影响玩家的位置
                local px, py, pz = player.Transform:GetWorldPosition()
                -- 触发受影响玩家的两种特效（均为0.5秒一次）
                SpawnAffectedEffect1(px, py, pz)
                SpawnAffectedEffect2(px, py, pz)
            end
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
