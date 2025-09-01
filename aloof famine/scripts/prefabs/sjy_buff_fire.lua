-- -- 火焰环绕Buff配置（可根据需求调整）
-- local CONFIG = {
--     DURATION = 1440,          -- 持续时间（游戏秒，1440秒 = 3天）
--     FIRE_CHECK_INTERVAL = 2,  -- 检查周围生物并点燃的时间间隔（秒）
--     FIRE_RADIUS = 5,          -- 点燃生物的半径范围
--     PREFAB_NAME = "sjy_buff_fire"  -- Buff预制体名称
-- }

-- -- Buff附加时触发：开始火焰检查循环
-- local function OnAttached(inst, target)
--     -- 绑定到目标实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 标记玩家不受火焰伤害
--     target:AddTag("immune_to_fire")

--     -- 开始周期性检查周围生物并点燃
--     inst._fire_task = inst:DoPeriodicTask(CONFIG.FIRE_CHECK_INTERVAL, function()
--         local x, y, z = target.Transform:GetWorldPosition()
--         -- 检查坐标是否有效
--         if x and y and z then
--             local ents = TheSim:FindEntities(x, y, z, CONFIG.FIRE_RADIUS, nil, {"immune_to_fire"})
--             for _, ent in ipairs(ents) do
--                 if ent.components.burnable and not ent:HasTag("fire") then
--                     ent.components.burnable:Ignite()
--                     print("Ignited entity:", ent.prefab)
--                 end
--             end
--         else
--             print("Invalid target position:", x, y, z)
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

-- -- Buff移除时触发：停止火焰检查循环并移除免疫标记
-- local function OnDetached(inst, target)
--     if inst._fire_task then
--         inst._fire_task:Cancel()
--         inst._fire_task = nil
--     end
--     -- 移除免疫火焰伤害的标记
--     target:RemoveTag("immune_to_fire")
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













-- 火焰环绕Buff配置（可根据需求调整）
local CONFIG = {
    DURATION = 480,          -- 持续时间（游戏秒，1440秒 = 3天）
    FIRE_CHECK_INTERVAL = 2,  -- 检查周围生物并点燃的时间间隔（秒）
    FIRE_RADIUS = 5,          -- 点燃生物的半径范围
    PREFAB_NAME = "sjy_buff_fire",  -- Buff预制体名称
    EFFECT_INTERVAL = 1       -- 特效触发间隔（秒）
}

-- 播放火焰特效
local function SpawnFireEffect(target)
    -- 获取目标当前位置并播放特效，确保特效跟随玩家移动
    local x, y, z = target.Transform:GetWorldPosition()
    SpawnPrefab("firesplash_fx").Transform:SetPosition(x, y, z)
end

-- 检查实体是否为玩家背包内的物品
local function IsInventoryItem(ent)
    return ent.components.inventoryitem ~= nil 
        and ent.components.inventoryitem.owner ~= nil 
        and ent.components.inventoryitem.owner:HasTag("player")
end

-- Buff附加时触发：开始火焰检查循环和特效播放循环
local function OnAttached(inst, target)
    -- 绑定到目标实体，确保特效位置随玩家移动更新
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 标记玩家不受火焰伤害
    target:AddTag("immune_to_fire")

    -- 开始周期性检查周围生物并点燃
    inst._fire_task = inst:DoPeriodicTask(CONFIG.FIRE_CHECK_INTERVAL, function()
        local x, y, z = target.Transform:GetWorldPosition()
        -- 检查坐标是否有效
        if x and y and z then
            -- 查找范围内实体，排除玩家背包物品和免疫火焰实体
            local ents = TheSim:FindEntities(x, y, z, CONFIG.FIRE_RADIUS, nil, {"immune_to_fire"})
            for _, ent in ipairs(ents) do
                -- 不点燃玩家背包内的物品
                if not IsInventoryItem(ent) 
                    and ent.components.burnable 
                    and not ent:HasTag("fire") 
                    and not ent:HasTag("player") then  -- 额外保险：不点燃玩家自身
                    ent.components.burnable:Ignite()
                    print("Ignited entity:", ent.prefab)
                end
            end
        else
            print("Invalid target position:", x, y, z)
        end
    end)

    -- 开始每隔1秒在玩家身上播放特效，确保特效跟随玩家
    inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
        if target:IsValid() then  -- 确保目标仍然有效
            SpawnFireEffect(target)
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

-- Buff移除时触发：停止火焰检查循环并移除免疫标记
local function OnDetached(inst, target)
    if inst._fire_task then
        inst._fire_task:Cancel()
        inst._fire_task = nil
    end
    -- 停止特效播放循环
    if inst._effect_task then
        inst._effect_task:Cancel()
        inst._effect_task = nil
    end
    -- 移除免疫火焰伤害的标记
    if target and target:IsValid() then  -- 确保目标仍然有效
        target:RemoveTag("immune_to_fire")
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