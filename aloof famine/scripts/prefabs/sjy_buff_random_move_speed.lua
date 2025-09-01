-- 玩家随机移动速度Buff配置（可根据需求调整）
local CONFIG = {
    PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
    SPEED_CHANGE_INTERVAL = 2,  -- 移动速度随机变化的间隔时间（秒）
    MIN_SPEED = 0.01,            -- 最小移动速度
    MAX_SPEED = 3,              -- 最大移动速度
    PLAYER_PREFAB_NAME = "sjy_buff_random_move_speed"  -- 玩家携带的Buff预制体名称
}

-- 玩家Buff附加时触发：开始随机改变移动速度的循环
local function OnPlayerAttached(inst, player)
    -- 绑定到玩家实体
    inst.entity:SetParent(player.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 开始周期性随机改变移动速度
    inst._speed_task = inst:DoPeriodicTask(CONFIG.SPEED_CHANGE_INTERVAL, function()
        if player.components.locomotor then
            local random_speed = math.random() * (CONFIG.MAX_SPEED - CONFIG.MIN_SPEED) + CONFIG.MIN_SPEED
            player.components.locomotor:SetExternalSpeedMultiplier(player, "random_speed_buff", random_speed)
        end
    end)
end

-- 玩家Buff计时器结束时触发：移除Buff并恢复正常移动速度
local function OnPlayerTimerDone(inst, data)
    if data.name == "duration" then
        inst.components.debuff:Stop()
        local player = inst.components.debuff.target
        if player and player.components.locomotor then
            player.components.locomotor:RemoveExternalSpeedMultiplier(player, "random_speed_buff")
        end
        if inst._speed_task then
            inst._speed_task:Cancel()
            inst._speed_task = nil
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

-- 玩家Buff移除时触发：停止随机改变移动速度的循环并恢复正常移动速度
local function OnPlayerDetached(inst, player)
    if inst._speed_task then
        inst._speed_task:Cancel()
        inst._speed_task = nil
    end
    if player and player.components.locomotor then
        player.components.locomotor:RemoveExternalSpeedMultiplier(player, "random_speed_buff")
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