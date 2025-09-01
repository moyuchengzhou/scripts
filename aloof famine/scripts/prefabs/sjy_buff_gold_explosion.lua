
-- -- local function OnAttached(inst, target)
-- -- 	inst.entity:SetParent(target.entity)  --父对象和位置
-- -- 	inst.Transform:SetPosition(0, 0, 0) --in case of loading   --相对位置
-- --    inst:ListenForEvent("death", function() --监听死亡事件‌：停止buff的效果
-- --       inst.components.debuff:Stop()
-- --    end, target)

-- -- end




-- local function OnAttached(inst, target, followsymbol, followoffset, data)
--     local suiji = math.random(50, 74)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
-- 	inst.ShockTask = target:DoPeriodicTask(1,function()
-- 		   if target ~= nil and target.components.health and not target.components.health:IsDead() then
-- 			    target.components.health:DoDelta(-suiji,nil,nil,true,nil,true)
--                 for i = 1, suiji, 1 do
--                     if target then
         
--                         local goldnugget = SpawnPrefab("goldnugget")

--                         goldnugget.Transform:SetPosition(target.Transform:GetWorldPosition())
        
--                         local periodicspawner = target.components.periodicspawner
--                         if periodicspawner ~= nil and periodicspawner.onspawn ~= nil then
--                             periodicspawner.onspawn(target, goldnugget)
--                         end
--                         target:PushEvent("ipecacgoldnugget")
--                     end
--                 end    
-- 		    end
-- 	end)
-- 	inst.components.timer:StartTimer("sjy_baojinbi_timer", 480)
-- 	inst:ListenForEvent("death",function()
-- 		inst.components.timer:StopTimer("sjy_baojinbi_timer")
-- 		inst.components.debuff:Stop()
-- 	end,target)
-- end

-- local function OnTimerDone(inst, data)     --倒计时结束后停止buff,原理是调用下面那个移除buff函数
--     if data.name == "sjy_baojinbi_timer" then
--         inst.components.debuff:Stop()
--     end
-- end

-- local function OnExtended(inst, target)  --重复给予药剂，检查并重置计时器
--     inst.components.timer:StopTimer("sjy_baojinbi_timer")
--     inst.components.timer:StartTimer("sjy_baojinbi_timer", 480)
-- end

-- local function OnDetached(inst, target)  --移除buff
--     if inst.ShockTask then
-- 		inst.ShockTask:Cancel()
-- 		inst.ShockTask = nil
-- 	end
--      inst:Remove()
-- end

-- local function fn()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         --Not meant for client!
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()

--     inst.entity:Hide()
--     inst.persists = false

--     inst:AddTag("CLASSIFIED")

--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true

--     inst:AddComponent("timer")
--     inst.components.timer:SetTimeLeft("sjy_baojinbi_timer", 480)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab("sjy_baojinbi", fn)
















-- -- 爆金币Buff配置（可根据需求调整）
-- local CONFIG = {
--     PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
--     DAMAGE_INTERVAL = 1,        -- 玩家掉血的间隔时间（秒）
--     DAMAGE_MIN = 50,            -- 每次掉血的最小数值
--     DAMAGE_MAX = 74,            -- 每次掉血的最大数值
--     PLAYER_PREFAB_NAME = "sjy_baojinbi",  -- 玩家携带的Buff预制体名称
--     GOLD_PREFAB_NAME = "goldnugget"  -- 金币预制体名称
-- }

-- -- 爆金币Buff附加时触发：开始掉血和爆金币循环
-- local function OnPlayerAttached(inst, player)
--     -- 绑定到玩家实体
--     inst.entity:SetParent(player.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性造成掉血并生成金币
--     inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
--         if player.components.health and not player.components.health:IsDead() then
--             -- 随机生成掉血数值
--             local damage = math.random(CONFIG.DAMAGE_MIN, CONFIG.DAMAGE_MAX)
--             -- 扣除玩家生命值
--             player.components.health:DoDelta(-damage, false, "gold_buff_damage")

--             -- 生成对应数量的金币
--             for i = 1, damage do
--                 local goldnugget = SpawnPrefab(CONFIG.GOLD_PREFAB_NAME)
--                 if goldnugget then
--                     local x, y, z = player.Transform:GetWorldPosition()
--                     -- 随机角度
--                     local angle = math.random() * 2 * math.pi
--                     -- 随机距离
--                     local distance = math.random(1, 3)
--                     local spawn_x = x + distance * math.cos(angle)
--                     local spawn_z = z + distance * math.sin(angle)
--                     goldnugget.Transform:SetPosition(spawn_x, y, spawn_z)

--                     local periodicspawner = player.components.periodicspawner
--                     if periodicspawner and periodicspawner.onspawn then
--                         periodicspawner.onspawn(player, goldnugget)
--                     end
--                     player:PushEvent("ipecacgoldnugget")
--                 else
--                     print("Warning: Failed to spawn goldnugget.")
--                 end
--             end
--         end
--     end)

--     -- 监听玩家死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, player)
-- end

-- -- 爆金币Buff计时器结束时触发：移除Buff并停止掉血循环
-- local function OnPlayerTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--         if inst._damage_task then
--             inst._damage_task:Cancel()
--             inst._damage_task = nil
--         end
--     end
-- end

-- -- 爆金币Buff重复施加时触发：刷新持续时间
-- local function OnPlayerExtended(inst, player)
--     if inst.components.timer:TimerExists("duration") then
--         inst.components.timer:StopTimer("duration")
--     end
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
-- end

-- -- 爆金币Buff移除时触发：停止掉血循环
-- local function OnPlayerDetached(inst, player)
--     if inst._damage_task then
--         inst._damage_task:Cancel()
--         inst._damage_task = nil
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












-- -- 爆金币Buff配置（可根据需求调整）
-- local CONFIG = {
--     PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
--     DAMAGE_INTERVAL = 1,        -- 玩家掉血的间隔时间（秒）
--     DAMAGE_MIN = 50,            -- 每次掉血的最小数值
--     DAMAGE_MAX = 74,            -- 每次掉血的最大数值
--     GOLD_SPAWN_HEIGHT = 2,      -- 金币生成的初始高度
--     GOLD_SPAWN_RADIUS = 3,      -- 金币生成的随机半径范围
--     PLAYER_PREFAB_NAME = "sjy_baojinbi",  -- 玩家携带的Buff预制体名称
--     GOLD_PREFAB_NAME = "goldnugget"  -- 金币预制体名称
-- }

-- -- 玩家Buff附加时触发：开始掉血和爆金币循环
-- local function OnPlayerAttached(inst, player)
--     -- 绑定到玩家实体
--     inst.entity:SetParent(player.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性造成掉血并生成金币
--     inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
--         if player.components.health and not player.components.health:IsDead() then
--             -- 随机生成掉血数值
--             local damage = math.random(CONFIG.DAMAGE_MIN, CONFIG.DAMAGE_MAX)
--             -- 扣除玩家生命值
--             player.components.health:DoDelta(-damage, false, "gold_buff_damage")

--             -- 生成对应数量的金币
--             for i = 1, damage do
--                 local goldnugget = SpawnPrefab(CONFIG.GOLD_PREFAB_NAME)
--                 if goldnugget then
--                     local x, y, z = player.Transform:GetWorldPosition()
--                     -- 随机角度
--                     local angle = math.random() * 2 * math.pi
--                     -- 随机距离
--                     local distance = math.random(1, CONFIG.GOLD_SPAWN_RADIUS)
--                     local spawn_x = x + distance * math.cos(angle)
--                     local spawn_z = z + distance * math.sin(angle)
--                     -- 设置金币初始高度
--                     goldnugget.Transform:SetPosition(spawn_x, CONFIG.GOLD_SPAWN_HEIGHT, spawn_z)

--                     local periodicspawner = player.components.periodicspawner
--                     if periodicspawner and periodicspawner.onspawn then
--                         periodicspawner.onspawn(player, goldnugget)
--                     end
--                     player:PushEvent("ipecacgoldnugget")
--                 else
--                     print("Warning: Failed to spawn goldnugget.")
--                 end
--             end
--         end
--     end)

--     -- 监听玩家死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, player)
-- end

-- -- 玩家Buff计时器结束时触发：移除Buff并停止掉血循环
-- local function OnPlayerTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--         if inst._damage_task then
--             inst._damage_task:Cancel()
--             inst._damage_task = nil
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

-- -- 玩家Buff移除时触发：停止掉血循环
-- local function OnPlayerDetached(inst, player)
--     if inst._damage_task then
--         inst._damage_task:Cancel()
--         inst._damage_task = nil
--     end
--     if player.components.debuffable then
--         player.components.debuffable:RemoveDebuff(inst.prefab)
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
--     if not inst.components.debuff then
--         print("Warning: Failed to add debuff component to " .. CONFIG.PLAYER_PREFAB_NAME)
--     else
--         inst.components.debuff:SetAttachedFn(OnPlayerAttached)
--         inst.components.debuff:SetDetachedFn(OnPlayerDetached)
--         inst.components.debuff:SetExtendedFn(OnPlayerExtended)
--         inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff
--     end

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
--     inst:ListenForEvent("timerdone", OnPlayerTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn)










-- -- 爆金币Buff配置（可根据需求调整）
-- local CONFIG = {
--     PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
--     DAMAGE_INTERVAL = 1,        -- 玩家掉血的间隔时间（秒）
--     DAMAGE_MIN = 50,            -- 每次掉血的最小数值
--     DAMAGE_MAX = 74,            -- 每次掉血的最大数值
--     GOLD_SPAWN_HEIGHT = 2,      -- 金币生成的初始高度
--     GOLD_SPAWN_RADIUS = 3,      -- 金币生成的随机半径范围
--     GOLD_SLIDE_FORCE = 2,       -- 金币掉落后滑动的力量
--     PLAYER_PREFAB_NAME = "sjy_baojinbi",  -- 玩家携带的Buff预制体名称
--     GOLD_PREFAB_NAME = "goldnugget"  -- 金币预制体名称
-- }

-- -- 玩家Buff附加时触发：开始掉血和爆金币循环
-- local function OnPlayerAttached(inst, player)
--     -- 绑定到玩家实体
--     inst.entity:SetParent(player.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性造成掉血并生成金币
--     inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
--         if player.components.health and not player.components.health:IsDead() then
--             -- 随机生成掉血数值
--             local damage = math.random(CONFIG.DAMAGE_MIN, CONFIG.DAMAGE_MAX)
--             -- 扣除玩家生命值
--             player.components.health:DoDelta(-damage, false, "gold_buff_damage")

--             -- 生成对应数量的金币
--             for i = 1, damage do
--                 local goldnugget = SpawnPrefab(CONFIG.GOLD_PREFAB_NAME)
--                 if goldnugget then
--                     local x, y, z = player.Transform:GetWorldPosition()
--                     -- 随机角度
--                     local angle = math.random() * 2 * math.pi
--                     -- 随机距离
--                     local distance = math.random(1, CONFIG.GOLD_SPAWN_RADIUS)
--                     local spawn_x = x + distance * math.cos(angle)
--                     local spawn_z = z + distance * math.sin(angle)
--                     -- 设置金币初始高度
--                     goldnugget.Transform:SetPosition(spawn_x, CONFIG.GOLD_SPAWN_HEIGHT, spawn_z)

--                     -- 给金币添加滑动效果
--                     if goldnugget.components and goldnugget.components.physics then
--                         local slide_angle = math.random() * 2 * math.pi
--                         local slide_force_x = math.cos(slide_angle) * CONFIG.GOLD_SLIDE_FORCE
--                         local slide_force_z = math.sin(slide_angle) * CONFIG.GOLD_SLIDE_FORCE
--                         goldnugget.components.physics:ApplyForce(slide_force_x, 0, slide_force_z)
--                     end

--                     local periodicspawner = player.components.periodicspawner
--                     if periodicspawner and periodicspawner.onspawn then
--                         periodicspawner.onspawn(player, goldnugget)
--                     end
--                     player:PushEvent("ipecacgoldnugget")
--                 else
--                     print("Warning: Failed to spawn goldnugget.")
--                 end
--             end
--         end
--     end)

--     -- 监听玩家死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, player)
-- end

-- -- 玩家Buff计时器结束时触发：移除Buff并停止掉血循环
-- local function OnPlayerTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--         if inst._damage_task then
--             inst._damage_task:Cancel()
--             inst._damage_task = nil
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

-- -- 玩家Buff移除时触发：停止掉血循环
-- local function OnPlayerDetached(inst, player)
--     if inst._damage_task then
--         inst._damage_task:Cancel()
--         inst._damage_task = nil
--     end
--     if player.components.debuffable then
--         player.components.debuffable:RemoveDebuff(inst.prefab)
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
--     if not inst.components.debuff then
--         print("Warning: Failed to add debuff component to " .. CONFIG.PLAYER_PREFAB_NAME)
--     else
--         inst.components.debuff:SetAttachedFn(OnPlayerAttached)
--         inst.components.debuff:SetDetachedFn(OnPlayerDetached)
--         inst.components.debuff:SetExtendedFn(OnPlayerExtended)
--         inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff
--     end

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
--     inst:ListenForEvent("timerdone", OnPlayerTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn)













-- -- 爆金币Buff配置（可根据需求调整）
-- local CONFIG = {
--     PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
--     DAMAGE_INTERVAL = 1,        -- 玩家掉血的间隔时间（秒）
--     DAMAGE_MIN = 50,            -- 每次掉血的最小数值
--     DAMAGE_MAX = 74,            -- 每次掉血的最大数值
--     GOLD_SPAWN_HEIGHT = 2,      -- 金币生成的初始高度
--     GOLD_SPAWN_RADIUS = 5,      -- 金币生成的随机半径范围
--     GOLD_SLIDE_FORCE = 6,       -- 金币掉落后滑动的力量
--     PLAYER_PREFAB_NAME = "sjy_baojinbi",  -- 玩家携带的Buff预制体名称
--     GOLD_PREFAB_NAME = "goldnugget"  -- 金币预制体名称
-- }

-- -- 玩家Buff附加时触发：开始掉血和爆金币循环
-- local function OnPlayerAttached(inst, player)
--     -- 绑定到玩家实体
--     inst.entity:SetParent(player.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性造成掉血并生成金币
--     inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
--         if player.components.health and not player.components.health:IsDead() then
--             -- 随机生成掉血数值
--             local damage = math.random(CONFIG.DAMAGE_MIN, CONFIG.DAMAGE_MAX)
--             -- 扣除玩家生命值
--             player.components.health:DoDelta(-damage, false, "gold_buff_damage")

--             -- 生成对应数量的金币
--             for i = 1, damage do
--                 local goldnugget = SpawnPrefab(CONFIG.GOLD_PREFAB_NAME)
--                 if goldnugget then
--                     local x, y, z = player.Transform:GetWorldPosition()
--                     -- 随机角度
--                     local angle = math.random() * 2 * math.pi
--                     -- 随机距离
--                     local distance = math.random(1, CONFIG.GOLD_SPAWN_RADIUS)
--                     local spawn_x = x + distance * math.cos(angle)
--                     local spawn_z = z + distance * math.sin(angle)
--                     -- 设置金币初始高度
--                     goldnugget.Transform:SetPosition(spawn_x, CONFIG.GOLD_SPAWN_HEIGHT, spawn_z)

--                     -- 给金币添加滑动效果
--                     if goldnugget.components and goldnugget.components.physics then
--                         local slide_angle = math.random() * 2 * math.pi
--                         local slide_force_x = math.cos(slide_angle) * CONFIG.GOLD_SLIDE_FORCE
--                         local slide_force_z = math.sin(slide_angle) * CONFIG.GOLD_SLIDE_FORCE
--                         goldnugget.components.physics:ApplyForce(slide_force_x, 0, slide_force_z)
--                     end

--                     local periodicspawner = player.components.periodicspawner
--                     if periodicspawner and periodicspawner.onspawn then
--                         periodicspawner.onspawn(player, goldnugget)
--                     end
--                     player:PushEvent("ipecacgoldnugget")
--                 else
--                     print("Warning: Failed to spawn goldnugget.")
--                 end
--             end
--         end
--     end)

--     -- 监听玩家死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, player)
-- end

-- -- 玩家Buff计时器结束时触发：移除Buff并停止掉血循环
-- local function OnPlayerTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--         if inst._damage_task then
--             inst._damage_task:Cancel()
--             inst._damage_task = nil
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

-- -- 玩家Buff移除时触发：停止掉血循环
-- local function OnPlayerDetached(inst, player)
--     if inst._damage_task then
--         inst._damage_task:Cancel()
--         inst._damage_task = nil
--     end
--     if player.components.debuffable then
--         player.components.debuffable:RemoveDebuff(inst.prefab)
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
--     if not inst.components.debuff then
--         print("Warning: Failed to add debuff component to " .. CONFIG.PLAYER_PREFAB_NAME)
--     else
--         inst.components.debuff:SetAttachedFn(OnPlayerAttached)
--         inst.components.debuff:SetDetachedFn(OnPlayerDetached)
--         inst.components.debuff:SetExtendedFn(OnPlayerExtended)
--         inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff
--     end

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
--     inst:ListenForEvent("timerdone", OnPlayerTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn)














-- -- 爆金币Buff配置（可根据需求调整）
-- local CONFIG = {
--     PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
--     DAMAGE_INTERVAL = 1,        -- 玩家掉血的间隔时间（秒）
--     DAMAGE_MIN = 50,            -- 每次掉血的最小数值
--     DAMAGE_MAX = 74,            -- 每次掉血的最大数值
--     GOLD_SPAWN_HEIGHT = 16,      -- 金币生成的初始高度
--     GOLD_THROW_RADIUS = 8,      -- 金币投掷的随机半径范围
--     GOLD_THROW_FORCE_MIN = 3,   -- 金币投掷力量最小值
--     GOLD_THROW_FORCE_MAX = 6,   -- 金币投掷力量最大值
--     PLAYER_PREFAB_NAME = "sjy_buff_gold_explosion",  -- 玩家携带的Buff预制体名称
--     GOLD_PREFAB_NAME = "goldnugget"  -- 金币预制体名称
-- }

-- -- 玩家Buff附加时触发：开始掉血和爆金币循环
-- local function OnPlayerAttached(inst, player)
--     -- 绑定到玩家实体
--     inst.entity:SetParent(player.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性造成掉血并生成金币
--     inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
--         if player.components.health and not player.components.health:IsDead() then
--             -- 随机生成掉血数值
--             local damage = math.random(CONFIG.DAMAGE_MIN, CONFIG.DAMAGE_MAX)
--             -- 扣除玩家生命值
--             player.components.health:DoDelta(-damage, false, "gold_buff_damage")

--             -- 生成对应数量的金币
--             for i = 1, damage do
--                 local goldnugget = SpawnPrefab(CONFIG.GOLD_PREFAB_NAME)
--                 if goldnugget then
--                     local x, y, z = player.Transform:GetWorldPosition()
--                     -- 随机角度
--                     local angle = math.random() * 2 * math.pi
--                     -- 随机距离
--                     local distance = math.random(1, CONFIG.GOLD_THROW_RADIUS)
--                     local spawn_x = x + distance * math.cos(angle)
--                     local spawn_z = z + distance * math.sin(angle)
--                     -- 设置金币初始高度
--                     goldnugget.Transform:SetPosition(spawn_x, CONFIG.GOLD_SPAWN_HEIGHT, spawn_z)

--                     -- 给金币添加投掷效果，带有一定弧度
--                     if goldnugget.components and goldnugget.components.physics then
--                         local throw_force = math.random(CONFIG.GOLD_THROW_FORCE_MIN, CONFIG.GOLD_THROW_FORCE_MAX)
--                         local throw_angle = math.random() * 2 * math.pi
--                         local throw_force_x = math.cos(throw_angle) * throw_force
--                         local throw_force_y = 3  -- 垂直向上的力量，形成弧度
--                         local throw_force_z = math.sin(throw_angle) * throw_force
--                         goldnugget.components.physics:ApplyForce(throw_force_x, throw_force_y, throw_force_z)
--                     end

--                     local periodicspawner = player.components.periodicspawner
--                     if periodicspawner and periodicspawner.onspawn then
--                         periodicspawner.onspawn(player, goldnugget)
--                     end
--                     player:PushEvent("ipecacgoldnugget")
--                 else
--                     print("Warning: Failed to spawn goldnugget.")
--                 end
--             end
--         end
--     end)

--     -- 监听玩家死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, player)
-- end

-- -- 玩家Buff计时器结束时触发：移除Buff并停止掉血循环
-- local function OnPlayerTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--         if inst._damage_task then
--             inst._damage_task:Cancel()
--             inst._damage_task = nil
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

-- -- 玩家Buff移除时触发：停止掉血循环
-- local function OnPlayerDetached(inst, player)
--     if inst._damage_task then
--         inst._damage_task:Cancel()
--         inst._damage_task = nil
--     end
--     if player.components.debuffable then
--         player.components.debuffable:RemoveDebuff(inst.prefab)
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
--     if not inst.components.debuff then
--         print("Warning: Failed to add debuff component to " .. CONFIG.PLAYER_PREFAB_NAME)
--     else
--         inst.components.debuff:SetAttachedFn(OnPlayerAttached)
--         inst.components.debuff:SetDetachedFn(OnPlayerDetached)
--         inst.components.debuff:SetExtendedFn(OnPlayerExtended)
--         inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff
--     end

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
--     inst:ListenForEvent("timerdone", OnPlayerTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn)


















-- -- 爆金币Buff配置（可根据需求调整）
-- local CONFIG = {
--     PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
--     DAMAGE_INTERVAL = 1,        -- 玩家掉血的间隔时间（秒）
--     DAMAGE_MIN = 50,            -- 每次掉血的最小数值
--     DAMAGE_MAX = 74,            -- 每次掉血的最大数值
--     GOLD_SPAWN_HEIGHT = 18,      -- 金币生成的初始高度
--     GOLD_THROW_RADIUS = 20,      -- 金币投掷的随机半径范围
--     GOLD_THROW_FORCE_MIN = 8,   -- 金币投掷力量最小值
--     GOLD_THROW_FORCE_MAX = 12,   -- 金币投掷力量最大值
--     GOLD_SLIDE_FORCE = 5,       -- 金币落地滑行力量
--     PLAYER_PREFAB_NAME = "sjy_buff_gold_explosion",  -- 玩家携带的Buff预制体名称
--     GOLD_PREFAB_NAME = "goldnugget"  -- 金币预制体名称
-- }

-- -- 金币落地滑行效果函数
-- local function ApplyGoldSlide(goldnugget)
--     if goldnugget.components and goldnugget.components.physics then
--         local angle = math.random() * 2 * math.pi
--         local slide_force_x = math.cos(angle) * CONFIG.GOLD_SLIDE_FORCE
--         local slide_force_z = math.sin(angle) * CONFIG.GOLD_SLIDE_FORCE
--         goldnugget.components.physics:ApplyForce(slide_force_x, 0, slide_force_z)
--     end
-- end

-- -- 玩家Buff附加时触发：开始掉血和爆金币循环
-- local function OnPlayerAttached(inst, player)
--     -- 绑定到玩家实体
--     inst.entity:SetParent(player.entity)
--     inst.Transform:SetPosition(0, 0, 0)

--     -- 开始周期性造成掉血并生成金币
--     inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
--         if player.components.health and not player.components.health:IsDead() then
--             -- 随机生成掉血数值
--             local damage = math.random(CONFIG.DAMAGE_MIN, CONFIG.DAMAGE_MAX)
--             -- 扣除玩家生命值
--             player.components.health:DoDelta(-damage, false, "gold_buff_damage")

--             -- 生成对应数量的金币
--             for i = 1, damage do
--                 local goldnugget = SpawnPrefab(CONFIG.GOLD_PREFAB_NAME)
--                 if goldnugget then
--                     local x, y, z = player.Transform:GetWorldPosition()
--                     -- 随机角度
--                     local angle = math.random() * 2 * math.pi
--                     -- 随机距离
--                     local distance = math.random(1, CONFIG.GOLD_THROW_RADIUS)
--                     local spawn_x = x + distance * math.cos(angle)
--                     local spawn_z = z + distance * math.sin(angle)
--                     -- 设置金币初始高度
--                     goldnugget.Transform:SetPosition(spawn_x, CONFIG.GOLD_SPAWN_HEIGHT, spawn_z)

--                     -- 给金币添加投掷效果，带有一定弧度
--                     if goldnugget.components and goldnugget.components.physics then
--                         local throw_force = math.random(CONFIG.GOLD_THROW_FORCE_MIN, CONFIG.GOLD_THROW_FORCE_MAX)
--                         local throw_angle = math.random() * 2 * math.pi
--                         local throw_force_x = math.cos(throw_angle) * throw_force
--                         local throw_force_y = 3  -- 垂直向上的力量，形成弧度
--                         local throw_force_z = math.sin(throw_angle) * throw_force
--                         goldnugget.components.physics:ApplyForce(throw_force_x, throw_force_y, throw_force_z)
--                     end

--                     -- 监听金币落地事件，触发滑行效果
--                     goldnugget:ListenForEvent("onhitground", function()
--                         ApplyGoldSlide(goldnugget)
--                     end)

--                     local periodicspawner = player.components.periodicspawner
--                     if periodicspawner and periodicspawner.onspawn then
--                         periodicspawner.onspawn(player, goldnugget)
--                     end
--                     player:PushEvent("ipecacgoldnugget")
--                 else
--                     print("Warning: Failed to spawn goldnugget.")
--                 end
--             end
--         end
--     end)

--     -- 监听玩家死亡事件：死亡后移除Buff
--     inst:ListenForEvent("death", function()
--         inst.components.debuff:Stop()
--     end, player)
-- end

-- -- 玩家Buff计时器结束时触发：移除Buff并停止掉血循环
-- local function OnPlayerTimerDone(inst, data)
--     if data.name == "duration" then
--         inst.components.debuff:Stop()
--         if inst._damage_task then
--             inst._damage_task:Cancel()
--             inst._damage_task = nil
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

-- -- 玩家Buff移除时触发：停止掉血循环
-- local function OnPlayerDetached(inst, player)
--     if inst._damage_task then
--         inst._damage_task:Cancel()
--         inst._damage_task = nil
--     end
--     if player.components.debuffable then
--         player.components.debuffable:RemoveDebuff(inst.prefab)
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
--     if not inst.components.debuff then
--         print("Warning: Failed to add debuff component to " .. CONFIG.PLAYER_PREFAB_NAME)
--     else
--         inst.components.debuff:SetAttachedFn(OnPlayerAttached)
--         inst.components.debuff:SetDetachedFn(OnPlayerDetached)
--         inst.components.debuff:SetExtendedFn(OnPlayerExtended)
--         inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff
--     end

--     -- 添加计时器组件（控制持续时间）
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
--     inst:ListenForEvent("timerdone", OnPlayerTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn)














-- 爆金币Buff配置（可根据需求调整）
local CONFIG = {
    PLAYER_DURATION = 480,      -- 玩家触发Buff的持续时间（游戏秒）
    DAMAGE_INTERVAL = 1,        -- 玩家掉血的间隔时间（秒）
    DAMAGE_MIN = 50,            -- 每次掉血的最小数值
    DAMAGE_MAX = 74,            -- 每次掉血的最大数值
    GOLD_SPAWN_HEIGHT = 18,      -- 金币生成的初始高度
    GOLD_THROW_RADIUS = 20,      -- 金币投掷的随机半径范围
    GOLD_THROW_FORCE_MIN = 8,   -- 金币投掷力量最小值
    GOLD_THROW_FORCE_MAX = 12,   -- 金币投掷力量最大值
    GOLD_SLIDE_FORCE = 5,       -- 金币落地滑行力量
    PLAYER_PREFAB_NAME = "sjy_buff_gold_explosion",  -- 玩家携带的Buff预制体名称
    GOLD_PREFAB_NAME = "goldnugget"  -- 金币预制体名称
}

-- 播放特效
local function SpawnBuffEffect(x, y, z)
    -- 按照要求的方式触发特效
    SpawnPrefab("cavein_debris").Transform:SetPosition(x, y, z)
end

-- 金币落地滑行效果函数
local function ApplyGoldSlide(goldnugget)
    if goldnugget.components and goldnugget.components.physics then
        local angle = math.random() * 2 * math.pi
        local slide_force_x = math.cos(angle) * CONFIG.GOLD_SLIDE_FORCE
        local slide_force_z = math.sin(angle) * CONFIG.GOLD_SLIDE_FORCE
        goldnugget.components.physics:ApplyForce(slide_force_x, 0, slide_force_z)
    end
end

-- 玩家Buff附加时触发：开始掉血和爆金币循环
local function OnPlayerAttached(inst, player)
    -- 绑定到玩家实体
    inst.entity:SetParent(player.entity)
    inst.Transform:SetPosition(0, 0, 0)

    -- 触发玩家获得Buff时的特效
    local x, y, z = player.Transform:GetWorldPosition()
    SpawnBuffEffect(x, y, z)

    -- 开始周期性造成掉血并生成金币
    inst._damage_task = inst:DoPeriodicTask(CONFIG.DAMAGE_INTERVAL, function()
        if player.components.health and not player.components.health:IsDead() then
            -- 随机生成掉血数值
            local damage = math.random(CONFIG.DAMAGE_MIN, CONFIG.DAMAGE_MAX)
            -- 扣除玩家生命值
            player.components.health:DoDelta(-damage, false, "gold_buff_damage")

            -- 触发玩家周期性特效
            local x, y, z = player.Transform:GetWorldPosition()
            SpawnBuffEffect(x, y, z)

            -- 生成对应数量的金币
            for i = 1, damage do
                local goldnugget = SpawnPrefab(CONFIG.GOLD_PREFAB_NAME)
                if goldnugget then
                    local x, y, z = player.Transform:GetWorldPosition()
                    -- 随机角度
                    local angle = math.random() * 2 * math.pi
                    -- 随机距离
                    local distance = math.random(1, CONFIG.GOLD_THROW_RADIUS)
                    local spawn_x = x + distance * math.cos(angle)
                    local spawn_z = z + distance * math.sin(angle)
                    -- 设置金币初始高度
                    goldnugget.Transform:SetPosition(spawn_x, CONFIG.GOLD_SPAWN_HEIGHT, spawn_z)

                    -- 给金币添加投掷效果，带有一定弧度
                    if goldnugget.components and goldnugget.components.physics then
                        local throw_force = math.random(CONFIG.GOLD_THROW_FORCE_MIN, CONFIG.GOLD_THROW_FORCE_MAX)
                        local throw_angle = math.random() * 2 * math.pi
                        local throw_force_x = math.cos(throw_angle) * throw_force
                        local throw_force_y = 3  -- 垂直向上的力量，形成弧度
                        local throw_force_z = math.sin(throw_angle) * throw_force
                        goldnugget.components.physics:ApplyForce(throw_force_x, throw_force_y, throw_force_z)
                    end

                    -- 监听金币落地事件，触发滑行效果
                    goldnugget:ListenForEvent("onhitground", function()
                        ApplyGoldSlide(goldnugget)
                    end)

                    local periodicspawner = player.components.periodicspawner
                    if periodicspawner and periodicspawner.onspawn then
                        periodicspawner.onspawn(player, goldnugget)
                    end
                    player:PushEvent("ipecacgoldnugget")
                else
                    print("Warning: Failed to spawn goldnugget.")
                end
            end
        end
    end)

    -- 监听玩家死亡事件：死亡后移除Buff
    inst:ListenForEvent("death", function()
        inst.components.debuff:Stop()
    end, player)
end

-- 玩家Buff计时器结束时触发：移除Buff并停止掉血循环
local function OnPlayerTimerDone(inst, data)
    if data.name == "duration" then
        inst.components.debuff:Stop()
        if inst._damage_task then
            inst._damage_task:Cancel()
            inst._damage_task = nil
        end
    end
end

-- 玩家Buff重复施加时触发：刷新持续时间
local function OnPlayerExtended(inst, player)
    if inst.components.timer:TimerExists("duration") then
        inst.components.timer:StopTimer("duration")
    end
    inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
    
    -- 刷新Buff时触发特效
    local x, y, z = player.Transform:GetWorldPosition()
    SpawnBuffEffect(x, y, z)
end

-- 玩家Buff移除时触发：停止掉血循环
local function OnPlayerDetached(inst, player)
    if inst._damage_task then
        inst._damage_task:Cancel()
        inst._damage_task = nil
    end
    if player.components.debuffable then
        player.components.debuffable:RemoveDebuff(inst.prefab)
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
    if not inst.components.debuff then
        print("Warning: Failed to add debuff component to " .. CONFIG.PLAYER_PREFAB_NAME)
    else
        inst.components.debuff:SetAttachedFn(OnPlayerAttached)
        inst.components.debuff:SetDetachedFn(OnPlayerDetached)
        inst.components.debuff:SetExtendedFn(OnPlayerExtended)
        inst.components.debuff.keepondespawn = true  -- 目标重生后仍保留Buff
    end

    -- 添加计时器组件（控制持续时间）
    inst:AddComponent("timer")
    inst.components.timer:StartTimer("duration", CONFIG.PLAYER_DURATION)
    inst:ListenForEvent("timerdone", OnPlayerTimerDone)

    return inst
end

return Prefab(CONFIG.PLAYER_PREFAB_NAME, PlayerBuffFn)