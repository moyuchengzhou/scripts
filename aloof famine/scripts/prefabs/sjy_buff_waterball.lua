-- 水球发射Buff配置（可根据需求调整）
local CONFIG = {
    DURATION = 1440,          -- 持续时间（游戏秒，1440秒 = 3天）
    SHOOT_INTERVAL = 5,       -- 水球发射的时间间隔（秒）
    WATERBALL_COUNT = 50,      -- 每次发射的水球数量
    PREFAB_NAME = "sjy_buff_waterball"  -- Buff预制体名称
}

-- 定义水球预制体名称，需要确保游戏中有该预制体
local WATERBALL_PREFAB = "waterballoon"

-- Buff附加时触发：开始水球发射循环
local function OnAttached(inst, target)
    -- 绑定到目标实体
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 标记玩家不受水球影响（不增加雨露值）
    target:AddTag("immune_to_waterball")

    -- 开始周期性发射水球
    inst._shoot_task = inst:DoPeriodicTask(CONFIG.SHOOT_INTERVAL, function()
        local x, y, z = target.Transform:GetWorldPosition()
        -- 检查坐标是否有效
        if x and y and z then
            for i = 1, CONFIG.WATERBALL_COUNT do
                -- 随机生成一个角度
                local angle = math.random(0, 360)
                local radian = math.rad(angle)
                -- 简单的发射距离
                local distance = 5 
                local target_x = x + distance * math.cos(radian)
                local target_z = z + distance * math.sin(radian)

                -- 创建水球实体
                local waterball = SpawnPrefab(WATERBALL_PREFAB)
                if waterball then
                    waterball.Transform:SetPosition(x, y, z)
                    -- 这里简单假设水球有一个发射函数，需要根据实际水球预制体的脚本调整
                    if waterball.components.complexprojectile then
                        waterball.components.complexprojectile:Launch(Vector3(target_x, 0, target_z), target, target)
                    end
                end
            end
        else
            print("Invalid target position:", x, y, z)
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

-- Buff移除时触发：停止水球发射循环并移除免疫标记
local function OnDetached(inst, target)
    if inst._shoot_task then
        inst._shoot_task:Cancel()
        inst._shoot_task = nil
    end
    -- 移除免疫水球影响的标记
    target:RemoveTag("immune_to_waterball")
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