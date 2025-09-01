-- -- 玩家周围生成生物Buff配置（可根据需求调整）
-- local CONFIG = {
--     PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
--     CREATURE_MIN_COUNT = 4,     -- 每次生成生物的最小数量
--     CREATURE_MAX_COUNT = 6,     -- 每次生成生物的最大数量
--     SPAWN_INTERVAL = 5,         -- 生物生成的间隔时间（秒）
--     PLAYER_PREFAB_NAME = "sjy_buff_spawn_creatures",  -- 玩家携带的Buff预制体名称
-- }

-- -- 玩家Buff附加时触发：开始生成生物循环
-- local function OnPlayerAttached(inst, player)
--     -- 绑定到玩家实体
--     inst.entity:SetParent(player.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性生成生物
--     inst._spawn_task = inst:DoPeriodicTask(CONFIG.SPAWN_INTERVAL, function()
--         local player_pos = player:GetPosition()
--         local num_creatures = math.random(CONFIG.CREATURE_MIN_COUNT, CONFIG.CREATURE_MAX_COUNT)

--         for _ = 1, num_creatures do
--             local creature_prefab
--             if math.random() < 0.5 then
--                 creature_prefab = "butterfly"
--             else
--                 creature_prefab = "killerbee"
--             end

--             local offset_x = math.random(-5, 5)
--             local offset_z = math.random(-5, 5)
--             local spawn_pos = Vector3(player_pos.x + offset_x, player_pos.y, player_pos.z + offset_z)

--             local creature = SpawnPrefab(creature_prefab)
--             if creature then
--                 creature.Transform:SetPosition(spawn_pos:Get())
--             end
--         end
--     end)
-- end

-- -- 玩家Buff计时器结束时触发：移除Buff并停止生成生物循环
-- local function OnPlayerTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--         local player = inst.components.debuff.target
--         if player and inst._spawn_task then
--             inst._spawn_task:Cancel()
--             inst._spawn_task = nil
--         end
--     end
-- end

-- -- 玩家Buff重复施加时触发：刷新持续时间
-- local function OnPlayerExtended(inst, player)
--     if inst.components.timer:TimerExists("duration") then
--         inst.components.timer:StopTimer("duration")
--     end
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
-- end

-- -- 玩家Buff移除时触发：停止生成生物循环
-- local function OnPlayerDetached(inst, player)
--     if inst._spawn_task then
--         inst._spawn_task:Cancel()
--         inst._spawn_task = nil
--     end
--     inst:Remove()  -- 移除Buff实体
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

-- return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn)
















-- 玩家周围生成生物Buff配置（可根据需求调整）
local CONFIG = {
    PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
    CREATURE_MIN_COUNT = 4,     -- 每次生成生物的最小数量
    CREATURE_MAX_COUNT = 6,     -- 每次生成生物的最大数量
    SPAWN_INTERVAL = 5,         -- 生物生成的间隔时间（秒）
    PLAYER_PREFAB_NAME = "sjy_buff_spawn_creatures",  -- 玩家携带的Buff预制体名称
}

-- 播放玩家携带Buff的特效
local function SpawnPlayerEffect(x, y, z)
    -- 按照要求的方式触发玩家特效
    SpawnPrefab("wormwood_lunar_transformation_finish").Transform:SetPosition(x, y, z)
end

-- 播放生物生成时的特效
local function SpawnCreatureEffect(x, y, z)
    -- 按照要求的方式触发生物出生特效
    SpawnPrefab("spawn_fx_tiny").Transform:SetPosition(x, y, z)
end

-- 玩家Buff附加时触发：开始生成生物循环
local function OnPlayerAttached(inst, player)
    -- 绑定到玩家实体
    inst.entity:SetParent(player.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 开始周期性生成生物
    inst._spawn_task = inst:DoPeriodicTask(CONFIG.SPAWN_INTERVAL, function()
        local player_pos = player:GetPosition()
        local num_creatures = math.random(CONFIG.CREATURE_MIN_COUNT, CONFIG.CREATURE_MAX_COUNT)

        -- 触发玩家特效（与生物生成同步，每5秒一次）
        SpawnPlayerEffect(player_pos.x, player_pos.y, player_pos.z)

        for _ = 1, num_creatures do
            local creature_prefab
            if math.random() < 0.5 then
                creature_prefab = "butterfly"
            else
                creature_prefab = "killerbee"
            end

            local offset_x = math.random(-5, 5)
            local offset_z = math.random(-5, 5)
            local spawn_pos = Vector3(player_pos.x + offset_x, player_pos.y, player_pos.z + offset_z)

            -- 触发生物生成特效
            SpawnCreatureEffect(spawn_pos.x, spawn_pos.y, spawn_pos.z)

            local creature = SpawnPrefab(creature_prefab)
            if creature then
                creature.Transform:SetPosition(spawn_pos:Get())
            end
        end
    end)
end

-- 玩家Buff计时器结束时触发：移除Buff并停止生成生物循环
local function OnPlayerTimerDone(inst, data)
    if data.name == "duration" then
        inst.components.debuff:Stop()
        local player = inst.components.debuff.target
        if player and inst._spawn_task then
            inst._spawn_task:Cancel()
            inst._spawn_task = nil
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

-- 玩家Buff移除时触发：停止生成生物循环
local function OnPlayerDetached(inst, player)
    if inst._spawn_task then
        inst._spawn_task:Cancel()
        inst._spawn_task = nil
    end
    inst:Remove()  -- 移除Buff实体
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

return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn)
    