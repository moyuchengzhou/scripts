-- -- 斩杀Buff配置
-- local CONFIG = {
--     DURATION = 1440,          -- 持续时间（游戏秒，1440秒 = 3天）
--     PREFAB_NAME = "sjy_buff_execute",  -- Buff预制体名称
--     EFFECT_INTERVAL = 0.5,    -- 玩家持续特效间隔（秒）
--     HEAL_AMOUNT = 5,          -- 回血数值
--     HEAL_CHANCE = 0.02,       -- 回血触发概率（2%）
--     LOG_EFFECTS = false,      -- 是否打印特效日志
--     DEBUG_MODE = true,        -- 调试模式开关，优化期间建议开启
--     LOG_INTERVAL = 3,         -- 重复日志的最小输出间隔（秒）- 缩短便于调试
--     SLAY_THRESHOLD = 1.2      -- 斩杀阈值：玩家血量 > 目标血量的1.2倍
-- }

-- -- 用于限制日志输出频率
-- local function ThrottledLog(inst, message, key)
--     if not CONFIG.DEBUG_MODE then return end
    
--     local id = inst and inst.GUID or "未知"
--     local now = GetTime()
--     inst._logTimestamps = inst._logTimestamps or {}
    
--     -- 首次记录或超过间隔时间才输出日志
--     if not inst._logTimestamps[key] or now - inst._logTimestamps[key] > CONFIG.LOG_INTERVAL then
--         inst._logTimestamps[key] = now
--         print(string.format("[%s] [斩杀Buff#%s] %s", os.date("%H:%M:%S"), id, message))
--     end
-- end

-- -- 打印调试信息（带时间戳和实体ID）
-- local function Log(inst, message, key)
--     if key then
--         ThrottledLog(inst, message, key)
--     else
--         if not CONFIG.DEBUG_MODE then return end
        
--         local id = inst and inst.GUID or "未知"
--         print(string.format("[%s] [斩杀Buff#%s] %s", os.date("%H:%M:%S"), id, message))
--     end
-- end

-- -- 增强版玩家获取函数 - 优化获取逻辑和优先级
-- local function GetPlayer(inst)
--     Log(inst, "尝试获取玩家实体...", "get_player_attempt")
    
--     -- 途径1: 从debuff目标直接获取（最高优先级）
--     if inst.components and inst.components.debuff and inst.components.debuff.target then
--         local target = inst.components.debuff.target
--         if target and target:IsValid() and target:HasTag("player") then
--             inst._player = target
--             Log(inst, "从debuff目标获取到玩家，已缓存", "get_player_from_debuff_target")
--             return target
--         end
--     end
    
--     -- 途径2: 直接使用缓存的玩家引用
--     if inst._player and inst._player:IsValid() and inst._player:HasTag("player") then
--         Log(inst, "通过缓存获取到玩家实体", "get_player_cached")
--         return inst._player
--     end
    
--     -- 途径3: 从父实体获取
--     local parent = inst.entity:GetParent()
--     if parent and parent:IsValid() then
--         Log(inst, "找到父实体，验证是否为玩家...", "get_player_parent_check")
--         if parent:HasTag("player") then
--             inst._player = parent
--             Log(inst, "父实体是玩家，已缓存", "get_player_parent_success")
--             return parent
--         else
--             Log(inst, "父实体存在但不是玩家: " .. tostring(parent.prefab or "未知预制体"))
--         end
--     else
--         Log(inst, "未找到父实体", "get_player_no_parent")
--     end
    
--     -- 途径4: 从最近的攻击数据中获取
--     if inst._last_attack_data and inst._last_attack_data.attacker then
--         local attacker = inst._last_attack_data.attacker
--         if attacker and attacker:IsValid() and attacker:HasTag("player") then
--             inst._player = attacker
--             Log(inst, "从攻击事件中获取到玩家，已缓存", "get_player_from_attack")
--             return attacker
--         end
--     end
    
--     -- 途径5: 通过玩家标签遍历查找
--     Log(inst, "开始遍历所有玩家查找Buff持有者...", "get_player_iterate")
--     if AllPlayers and #AllPlayers > 0 then
--         for i, player in ipairs(AllPlayers) do
--             if player and player:IsValid() and player:HasTag("player") then
--                 Log(inst, "检查玩家 #" .. i .. ": " .. tostring(player.prefab), "get_player_check_"..i)
                
--                 if player.components and player.components.debuffable then
--                     local debuffs
--                     if type(player.components.debuffable.GetDebuffs) == "function" then
--                         debuffs = player.components.debuffable:GetDebuffs()
--                     else
--                         debuffs = player.components.debuffable.debuffs
--                         Log(inst, "玩家的debuffable组件缺少GetDebuffs方法，尝试直接访问debuffs字段")
--                     end
                    
--                     if debuffs and type(debuffs) == "table" then
--                         for _, debuff in pairs(debuffs) do
--                             if debuff and debuff.prefab == inst.prefab and debuff.GUID == inst.GUID then
--                                 inst._player = player
--                                 Log(inst, "通过Buff匹配找到玩家，已缓存", "get_player_match_found")
--                                 return player
--                             end
--                         end
--                     else
--                         Log(inst, "玩家没有任何debuff", "get_player_no_debuffs")
--                     end
--                 else
--                     Log(inst, "玩家缺少debuffable组件", "get_player_no_debuffable")
--                 end
--             else
--                 Log(inst, "玩家 #" .. i .. " 无效", "get_player_invalid_"..i)
--             end
--         end
--     else
--         Log(inst, "没有找到任何玩家实体", "get_player_no_players")
--     end
    
--     Log(inst, "无法通过任何方式获取玩家实体", "get_player_failed")
--     return nil
-- end

-- -- 播放玩家携带Buff的持续特效
-- local function SpawnPlayerContinuousEffect(x, y, z)
--     local fx = SpawnPrefab("winters_feast_food_depleted")
--     if fx then
--         fx.Transform:SetPosition(x, y, z)
--         if CONFIG.LOG_EFFECTS then
--             print(string.format("[%s] [斩杀Buff] 播放持续特效", os.date("%H:%M:%S")))
--         end
--     else
--         print(string.format("[%s] [斩杀Buff] 持续特效预制体不存在: winters_feast_food_depleted", os.date("%H:%M:%S")))
--     end
-- end

-- -- 播放玩家回血特效
-- local function SpawnPlayerHealEffect(x, y, z)
--     local fx = SpawnPrefab("ghostlyelixir_player_speed_fx")
--     if fx then
--         fx.Transform:SetPosition(x, y, z)
--         print(string.format("[%s] [斩杀Buff] 播放回血特效", os.date("%H:%M:%S")))
--     else
--         print(string.format("[%s] [斩杀Buff] 回血特效预制体不存在: ghostlyelixir_player_speed_fx", os.date("%H:%M:%S")))
--     end
-- end

-- -- 播放怪物被斩杀特效
-- local function SpawnSlaughterEffect(x, y, z)
--     local fx = SpawnPrefab("shadowstrike_slash_fx")
--     if fx then
--         fx.Transform:SetPosition(x, y, z)
--         print(string.format("[%s] [斩杀Buff] 播放斩杀特效", os.date("%H:%M:%S")))
--     else
--         print(string.format("[%s] [斩杀Buff] 斩杀特效预制体不存在: shadowstrike_slash_fx", os.date("%H:%M:%S")))
--     end
-- end

-- -- 攻击判定函数（修复版）
-- local function OnAttack(inst, data)
--     -- 验证攻击数据有效性
--     if not data or not data.target then
--         Log(inst, "攻击数据无效或缺少目标", "invalid_attack_data")
--         return
--     end
    
--     -- 缓存攻击数据
--     inst._last_attack_data = data
--     Log(inst, "检测到攻击事件", "attack_detected")
    
--     -- 获取玩家实体
--     local player = GetPlayer(inst)
--     if not player or not player:IsValid() or not player:HasTag("player") then
--         Log(inst, "无法获取有效玩家实体，尝试从攻击数据中获取", "player_invalid_try_attack")
        
--         -- 从攻击数据中获取攻击者
--         if data.attacker and data.attacker:IsValid() and data.attacker:HasTag("player") then
--             Log(inst, "使用攻击事件中的攻击者作为玩家", "use_attacker_as_player")
--             player = data.attacker
--             inst._player = player  -- 更新缓存
--         else
--             Log(inst, "攻击事件中也没有有效玩家，终止处理", "no_valid_player")
--             return
--         end
--     end
    
--     -- 验证玩家健康组件
--     if not player.components or not player.components.health then
--         Log(inst, "玩家缺少health组件", "player_missing_health")
--         return
--     end
    
--     -- 验证目标
--     local target = data.target
--     if not target or not target:IsValid() then
--         Log(inst, "攻击目标无效或不存在", "invalid_target")
--         return
--     end
    
--     -- 验证目标健康组件
--     if not target.components or not target.components.health then
--         Log(inst, "目标缺少health组件", "target_missing_health")
--         return
--     end
    
--     -- 确保目标还活着
--     if target.components.health:IsDead() then
--         Log(inst, "目标已死亡，无需处理", "target_already_dead")
--         return
--     end
    
--     Log(inst, string.format("攻击验证通过: 玩家=%s, 目标=%s", 
--         tostring(player.prefab), tostring(target.prefab)), "attack_validated")
    
--     -- 获取血量组件并验证
--     local player_health_comp = player.components.health
--     local target_health_comp = target.components.health
    
--     if not player_health_comp.currenthealth or not target_health_comp.currenthealth then
--         Log(inst, "无法获取玩家或目标的当前血量", "missing_health_values")
--         return
--     end
    
--     -- 转换为数值确保比较安全
--     local player_health = tonumber(player_health_comp.currenthealth)
--     local target_health = tonumber(target_health_comp.currenthealth)
    
--     Log(inst, string.format("玩家血量: %.1f, 目标血量: %.1f, 斩杀阈值: %.1f倍", 
--         player_health, target_health, CONFIG.SLAY_THRESHOLD), "health_values")
    
--     local slayed = false
--     -- 玩家血量高于目标血量的指定倍数时触发斩杀
--     if player_health > target_health * CONFIG.SLAY_THRESHOLD then
--         Log(inst, "满足斩杀条件，执行斩杀", "slay_condition_met")
        
--         -- 执行斩杀
--         target_health_comp:Kill()
        
--         -- 验证斩杀结果
--         if target_health_comp:IsDead() then
--             Log(inst, "斩杀成功", "slay_successful")
--             local x, y, z = target.Transform:GetWorldPosition()
--             SpawnSlaughterEffect(x, y, z)
--             slayed = true
--         else
--             Log(inst, "斩杀执行失败，目标未死亡", "slay_failed")
--         end
--     else
--         Log(inst, "不满足斩杀条件", "slay_condition_not_met")
--     end
    
--     -- 独立的回血概率判定（无论是否斩杀都可能触发）
--     if math.random() <= CONFIG.HEAL_CHANCE then
--         Log(inst, "触发回血概率", "heal_triggered")
--         if not player_health_comp:IsDead() then
--             -- 检查DoDelta方法是否存在
--             if type(player_health_comp.DoDelta) == "function" then
--                 Log(inst, string.format("执行回血: +%d", CONFIG.HEAL_AMOUNT), "heal_executed")
--                 -- 第三个参数用于标识回血来源
--                 player_health_comp:DoDelta(CONFIG.HEAL_AMOUNT, nil, "sjy_buff_execute")
--                 local x, y, z = player.Transform:GetWorldPosition()
--                 SpawnPlayerHealEffect(x, y, z)
--             else
--                 Log(inst, "玩家health组件缺少DoDelta方法，无法回血", "heal_method_missing")
--             end
--         else
--             Log(inst, "玩家已死亡，无法回血", "player_dead_no_heal")
--         end
--     else
--         Log(inst, "未触发回血概率", "heal_not_triggered")
--     end
-- end

-- -- 强化版玩家验证函数
-- local function ValidatePlayer(inst)
--     Log(inst, "执行玩家实体有效性验证", "validate_player")
--     local player = GetPlayer(inst)
    
--     -- 如果玩家无效，尝试修复
--     if not player or not player:IsValid() then
--         Log(inst, "玩家实体无效，尝试修复...", "validate_player_invalid")
        
--         -- 尝试重新绑定到玩家
--         if AllPlayers and #AllPlayers > 0 then
--             for _, p in ipairs(AllPlayers) do
--                 if p and p:IsValid() and p:HasTag("player") and 
--                    p.components and p.components.debuffable then
--                     -- 重新关联到有效玩家
--                     inst.entity:SetParent(p.entity)
--                     inst._player = p
--                     Log(inst, "已尝试将Buff重新关联到玩家: " .. tostring(p.prefab), "validate_player_rebind")
--                     return ValidatePlayer(inst)  -- 重新验证
--                 end
--             end
--         end
        
--         Log(inst, "玩家实体验证失败，无法修复，移除Buff", "validate_player_failed")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--         return false
--     end
    
--     Log(inst, "玩家实体有效", "validate_player_success")
--     return true
-- end

-- -- Buff附加时触发（优化版）
-- local function OnAttached(inst, target)
--     Log(inst, "Buff开始附加到目标", "buff_attaching")
    
--     -- 验证目标有效性
--     if not target or not target:IsValid() then
--         Log(inst, "目标无效，移除Buff", "invalid_target_remove_buff")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--         return
--     end
    
--     -- 验证目标是玩家
--     if not target:HasTag("player") then
--         Log(inst, "目标不是玩家，移除Buff", "target_not_player")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--         return
--     end
    
--     -- 强制绑定到玩家实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
--     Log(inst, "已强制绑定到玩家实体", "entity_parent_set")
    
--     -- 缓存玩家引用
--     inst._player = target
--     Log(inst, "已缓存Buff携带者玩家实体: " .. tostring(target.prefab), "player_cached")
    
--     -- 启动玩家实体验证任务（1秒一次，提高响应速度）
--     if inst._validation_task then
--         inst._validation_task:Cancel()
--     end
--     inst._validation_task = inst:DoPeriodicTask(1, function()
--         ValidatePlayer(inst)
--     end)
--     Log(inst, "已启动玩家实体验证任务", "validation_task_started")
    
--     -- 开始播放持续特效
--     if inst._effect_task then
--         inst._effect_task:Cancel()
--     end
--     inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
--         local player = GetPlayer(inst)
--         if player and player:IsValid() then
--             local x, y, z = player.Transform:GetWorldPosition()
--             SpawnPlayerContinuousEffect(x, y, z)
--         else
--             Log(inst, "目标已失效，停止持续特效", "effect_target_invalid")
--             if inst._effect_task then
--                 inst._effect_task:Cancel()
--                 inst._effect_task = nil
--             end
--         end
--     end)
--     Log(inst, string.format("持续特效计时器启动，间隔: %.1f秒", CONFIG.EFFECT_INTERVAL), "effect_task_started")
    
--     -- 优化事件监听，只监听玩家的攻击事件
--     inst:ListenForEvent("onattackother", function(_, data)
--         OnAttack(inst, data)
--     end, target)
--     Log(inst, "已设置攻击事件监听", "attack_listener_set")
    
--     -- 监听目标重生事件
--     inst:ListenForEvent("respawnfromghost", function()
--         Log(inst, "目标重生，更新玩家引用", "player_respawned")
--         inst._player = target  -- 重生后更新引用
--     end, target)
    
--     -- 监听玩家死亡事件
--     inst:ListenForEvent("death", function()
--         Log(inst, "玩家已死亡，移除Buff", "player_death_remove_buff")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end, target)
    
--     Log(inst, "Buff附加流程完成", "buff_attached")
-- end

-- -- 计时器结束时触发
-- local function OnTimerDone(inst, data)
--     if data and data.name == "duration" then
--         Log(inst, "Buff持续时间结束，停止Buff", "buff_duration_ended")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end
-- end

-- -- 重复施加时触发：刷新持续时间
-- local function OnExtended(inst, target)
--     Log(inst, "Buff被重复施加，刷新持续时间", "buff_extended")
    
--     -- 刷新计时器
--     if inst.components and inst.components.timer then
--         inst.components.timer:StopTimer("duration")
--         inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     end
    
--     -- 强制刷新玩家缓存和绑定
--     inst.entity:SetParent(target.entity)
--     inst._player = target
--     Log(inst, "已强制刷新玩家绑定和缓存", "player_cache_refreshed")
    
--     -- 重置特效计时器
--     if inst._effect_task then
--         inst._effect_task:Cancel()
--         Log(inst, "旧特效计时器已取消", "old_effect_cancelled")
--     end
--     inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
--         local player = GetPlayer(inst)
--         if player and player:IsValid() then
--             local x, y, z = player.Transform:GetWorldPosition()
--             SpawnPlayerContinuousEffect(x, y, z)
--         else
--             Log(inst, "目标已失效，停止持续特效", "effect_stopped")
--         end
--     end)
--     Log(inst, "新特效计时器启动", "new_effect_started")
-- end

-- -- Buff移除时触发
-- local function OnDetached(inst, target)
--     Log(inst, "Buff开始移除流程", "buff_detaching")
    
--     -- 移除所有事件监听
--     if target and target:IsValid() then
--         inst:RemoveEventCallback("onattackother", nil, target)
--         inst:RemoveEventCallback("respawnfromghost", nil, target)
--         inst:RemoveEventCallback("death", nil, target)
--     end
--     inst:RemoveEventCallback("onattackother", nil, TheWorld)
--     Log(inst, "已移除所有事件监听", "event_listeners_removed")
    
--     -- 停止所有任务
--     if inst._effect_task then
--         inst._effect_task:Cancel()
--         inst._effect_task = nil
--         Log(inst, "特效计时器已停止", "effect_task_stopped")
--     end
    
--     if inst._validation_task then
--         inst._validation_task:Cancel()
--         inst._validation_task = nil
--         Log(inst, "玩家验证任务已停止", "validation_task_stopped")
--     end
    
--     -- 清除缓存数据
--     inst._player = nil
--     inst._last_attack_data = nil
--     inst._logTimestamps = nil
    
--     Log(inst, "Buff移除流程完成", "buff_detached")
--     inst:Remove()
-- end

-- -- 创建Buff实体（优化版）
-- local function fn()
--     local inst = CreateEntity()
--     Log(inst, "开始创建Buff实体", "entity_creation_started")

--     -- 客户端不生成实体（仅服务器处理）
--     if not TheWorld.ismastersim then
--         Log(inst, "客户端：移除实体（仅服务器处理）", "client_entity_removed")
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     -- 实体设置
--     inst.entity:AddTransform()
--     inst.entity:AddNetwork()  -- 添加网络组件确保多端同步
--     inst.entity:Hide()
--     inst.persists = false
--     inst:AddTag("CLASSIFIED")
--     inst:AddTag("sjy_buff_execute_tag")  -- 添加独特标签便于识别
    
--     -- 初始化存储变量
--     inst._player = nil
--     inst._last_attack_data = nil
--     inst._effect_task = nil
--     inst._validation_task = nil
--     inst._logTimestamps = nil
    
--     -- 网络同步设置
--     inst.entity:SetPristine()
--     if not TheWorld.ismastersim then
--         return inst
--     end
    
--     Log(inst, "实体基础设置完成", "entity_base_setup_done")

--     -- 添加Buff组件
--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true
--     Log(inst, "已添加debuff组件", "debuff_component_added")

--     -- 添加计时器组件
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)
--     Log(inst, "已添加timer组件，持续时间: "..CONFIG.DURATION.."秒", "timer_component_added")

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)




-- -- 斩杀Buff配置
-- local CONFIG = {
--     DURATION = 1440,          -- 持续时间（游戏秒，1440秒 = 3天）
--     PREFAB_NAME = "sjy_buff_execute",  -- Buff预制体名称
--     EFFECT_INTERVAL = 0.5,    -- 玩家持续特效间隔（秒）
--     HEAL_AMOUNT = 10,          -- 回血数值
--     HEAL_CHANCE = 0.1,       -- 回血触发概率（2%）
--     LOG_EFFECTS = false,      -- 是否打印特效日志
--     DEBUG_MODE = false,        -- 调试模式开关，优化期间建议开启
--     LOG_INTERVAL = 3,         -- 重复日志的最小输出间隔（秒）- 缩短便于调试
--     SLAY_THRESHOLD = 1      -- 斩杀阈值：玩家血量 > 目标血量的1.2倍
-- }

-- -- 用于限制日志输出频率
-- local function ThrottledLog(inst, message, key)
--     if not CONFIG.DEBUG_MODE then return end
    
--     local id = inst and inst.GUID or "未知"
--     local now = GetTime()
--     inst._logTimestamps = inst._logTimestamps or {}
    
--     -- 首次记录或超过间隔时间才输出日志
--     if not inst._logTimestamps[key] or now - inst._logTimestamps[key] > CONFIG.LOG_INTERVAL then
--         inst._logTimestamps[key] = now
--         print(string.format("[%s] [斩杀Buff#%s] %s", os.date("%H:%M:%S"), id, message))
--     end
-- end

-- -- 打印调试信息（带时间戳和实体ID）
-- local function Log(inst, message, key)
--     if key then
--         ThrottledLog(inst, message, key)
--     else
--         if not CONFIG.DEBUG_MODE then return end
        
--         local id = inst and inst.GUID or "未知"
--         print(string.format("[%s] [斩杀Buff#%s] %s", os.date("%H:%M:%S"), id, message))
--     end
-- end

-- -- 增强版玩家获取函数 - 优化获取逻辑和优先级
-- local function GetPlayer(inst)
--     Log(inst, "尝试获取玩家实体...", "get_player_attempt")
    
--     -- 途径1: 从debuff目标直接获取（最高优先级）
--     if inst.components and inst.components.debuff and inst.components.debuff.target then
--         local target = inst.components.debuff.target
--         if target and target:IsValid() and target:HasTag("player") then
--             inst._player = target
--             Log(inst, "从debuff目标获取到玩家，已缓存", "get_player_from_debuff_target")
--             return target
--         end
--     end
    
--     -- 途径2: 直接使用缓存的玩家引用
--     if inst._player and inst._player:IsValid() and inst._player:HasTag("player") then
--         Log(inst, "通过缓存获取到玩家实体", "get_player_cached")
--         return inst._player
--     end
    
--     -- 途径3: 从父实体获取
--     local parent = inst.entity:GetParent()
--     if parent and parent:IsValid() then
--         Log(inst, "找到父实体，验证是否为玩家...", "get_player_parent_check")
--         if parent:HasTag("player") then
--             inst._player = parent
--             Log(inst, "父实体是玩家，已缓存", "get_player_parent_success")
--             return parent
--         else
--             Log(inst, "父实体存在但不是玩家: " .. tostring(parent.prefab or "未知预制体"))
--         end
--     else
--         Log(inst, "未找到父实体", "get_player_no_parent")
--     end
    
--     -- 途径4: 从最近的攻击数据中获取
--     if inst._last_attack_data and inst._last_attack_data.attacker then
--         local attacker = inst._last_attack_data.attacker
--         if attacker and attacker:IsValid() and attacker:HasTag("player") then
--             inst._player = attacker
--             Log(inst, "从攻击事件中获取到玩家，已缓存", "get_player_from_attack")
--             return attacker
--         end
--     end
    
--     -- 途径5: 通过玩家标签遍历查找
--     Log(inst, "开始遍历所有玩家查找Buff持有者...", "get_player_iterate")
--     if AllPlayers and #AllPlayers > 0 then
--         for i, player in ipairs(AllPlayers) do
--             if player and player:IsValid() and player:HasTag("player") then
--                 Log(inst, "检查玩家 #" .. i .. ": " .. tostring(player.prefab), "get_player_check_"..i)
                
--                 if player.components and player.components.debuffable then
--                     local debuffs
--                     if type(player.components.debuffable.GetDebuffs) == "function" then
--                         debuffs = player.components.debuffable:GetDebuffs()
--                     else
--                         debuffs = player.components.debuffable.debuffs
--                         Log(inst, "玩家的debuffable组件缺少GetDebuffs方法，尝试直接访问debuffs字段")
--                     end
                    
--                     if debuffs and type(debuffs) == "table" then
--                         for _, debuff in pairs(debuffs) do
--                             if debuff and debuff.prefab == inst.prefab and debuff.GUID == inst.GUID then
--                                 inst._player = player
--                                 Log(inst, "通过Buff匹配找到玩家，已缓存", "get_player_match_found")
--                                 return player
--                             end
--                         end
--                     else
--                         Log(inst, "玩家没有任何debuff", "get_player_no_debuffs")
--                     end
--                 else
--                     Log(inst, "玩家缺少debuffable组件", "get_player_no_debuffable")
--                 end
--             else
--                 Log(inst, "玩家 #" .. i .. " 无效", "get_player_invalid_"..i)
--             end
--         end
--     else
--         Log(inst, "没有找到任何玩家实体", "get_player_no_players")
--     end
    
--     Log(inst, "无法通过任何方式获取玩家实体", "get_player_failed")
--     return nil
-- end

-- -- 播放玩家携带Buff的持续特效
-- local function SpawnPlayerContinuousEffect(x, y, z)
--     local fx = SpawnPrefab("winters_feast_food_depleted")
--     if fx then
--         fx.Transform:SetPosition(x, y - 1, z)
--         if CONFIG.LOG_EFFECTS then
--             print(string.format("[%s] [斩杀Buff] 播放持续特效", os.date("%H:%M:%S")))
--         end
--     else
--         print(string.format("[%s] [斩杀Buff] 持续特效预制体不存在: winters_feast_food_depleted", os.date("%H:%M:%S")))
--     end
-- end

-- -- 播放玩家回血特效
-- local function SpawnPlayerHealEffect(x, y, z)
--     local fx = SpawnPrefab("ghostlyelixir_player_speed_fx")
--     if fx then
--         fx.Transform:SetPosition(x, y, z)
--         print(string.format("[%s] [斩杀Buff] 播放回血特效", os.date("%H:%M:%S")))
--     else
--         print(string.format("[%s] [斩杀Buff] 回血特效预制体不存在: ghostlyelixir_player_speed_fx", os.date("%H:%M:%S")))
--     end
-- end

-- -- 播放怪物被斩杀特效
-- local function SpawnSlaughterEffect(x, y, z)
--     local fx = SpawnPrefab("shadowstrike_slash_fx")
--     if fx then
--         fx.Transform:SetPosition(x, y, z)
--         print(string.format("[%s] [斩杀Buff] 播放斩杀特效", os.date("%H:%M:%S")))
--     else
--         print(string.format("[%s] [斩杀Buff] 斩杀特效预制体不存在: shadowstrike_slash_fx", os.date("%H:%M:%S")))
--     end
-- end

-- -- 攻击判定函数（修复版）
-- local function OnAttack(inst, data)
--     -- 验证攻击数据有效性
--     if not data or not data.target then
--         Log(inst, "攻击数据无效或缺少目标", "invalid_attack_data")
--         return
--     end
    
--     -- 缓存攻击数据
--     inst._last_attack_data = data
--     Log(inst, "检测到攻击事件", "attack_detected")
    
--     -- 获取玩家实体
--     local player = GetPlayer(inst)
--     if not player or not player:IsValid() or not player:HasTag("player") then
--         Log(inst, "无法获取有效玩家实体，尝试从攻击数据中获取", "player_invalid_try_attack")
        
--         -- 从攻击数据中获取攻击者
--         if data.attacker and data.attacker:IsValid() and data.attacker:HasTag("player") then
--             Log(inst, "使用攻击事件中的攻击者作为玩家", "use_attacker_as_player")
--             player = data.attacker
--             inst._player = player  -- 更新缓存
--         else
--             Log(inst, "攻击事件中也没有有效玩家，终止处理", "no_valid_player")
--             return
--         end
--     end
    
--     -- 验证玩家健康组件
--     if not player.components or not player.components.health then
--         Log(inst, "玩家缺少health组件", "player_missing_health")
--         return
--     end
    
--     -- 验证目标
--     local target = data.target
--     if not target or not target:IsValid() then
--         Log(inst, "攻击目标无效或不存在", "invalid_target")
--         return
--     end
    
--     -- 验证目标健康组件
--     if not target.components or not target.components.health then
--         Log(inst, "目标缺少health组件", "target_missing_health")
--         return
--     end
    
--     -- 确保目标还活着
--     if target.components.health:IsDead() then
--         Log(inst, "目标已死亡，无需处理", "target_already_dead")
--         return
--     end
    
--     Log(inst, string.format("攻击验证通过: 玩家=%s, 目标=%s", 
--         tostring(player.prefab), tostring(target.prefab)), "attack_validated")
    
--     -- 获取血量组件并验证
--     local player_health_comp = player.components.health
--     local target_health_comp = target.components.health
    
--     if not player_health_comp.currenthealth or not target_health_comp.currenthealth then
--         Log(inst, "无法获取玩家或目标的当前血量", "missing_health_values")
--         return
--     end
    
--     -- 转换为数值确保比较安全
--     local player_health = tonumber(player_health_comp.currenthealth)
--     local target_health = tonumber(target_health_comp.currenthealth)
    
--     Log(inst, string.format("玩家血量: %.1f, 目标血量: %.1f, 斩杀阈值: %.1f倍", 
--         player_health, target_health, CONFIG.SLAY_THRESHOLD), "health_values")
    
--     local slayed = false
--     -- 玩家血量高于目标血量的指定倍数时触发斩杀
--     if player_health > target_health * CONFIG.SLAY_THRESHOLD then
--         Log(inst, "满足斩杀条件，执行斩杀", "slay_condition_met")
        
--         -- 执行斩杀
--         target_health_comp:Kill()
        
--         -- 验证斩杀结果
--         if target_health_comp:IsDead() then
--             Log(inst, "斩杀成功", "slay_successful")
--             local x, y, z = target.Transform:GetWorldPosition()
--             SpawnSlaughterEffect(x, y, z)
--             slayed = true
--         else
--             Log(inst, "斩杀执行失败，目标未死亡", "slay_failed")
--         end
--     else
--         Log(inst, "不满足斩杀条件", "slay_condition_not_met")
--     end
    
--     -- 独立的回血概率判定（无论是否斩杀都可能触发）
--     if math.random() <= CONFIG.HEAL_CHANCE then
--         Log(inst, "触发回血概率", "heal_triggered")
--         if not player_health_comp:IsDead() then
--             -- 检查DoDelta方法是否存在
--             if type(player_health_comp.DoDelta) == "function" then
--                 Log(inst, string.format("执行回血: +%d", CONFIG.HEAL_AMOUNT), "heal_executed")
--                 -- 第三个参数用于标识回血来源
--                 player_health_comp:DoDelta(CONFIG.HEAL_AMOUNT, nil, "sjy_buff_execute")
--                 local x, y, z = player.Transform:GetWorldPosition()
--                 SpawnPlayerHealEffect(x, y, z)
--             else
--                 Log(inst, "玩家health组件缺少DoDelta方法，无法回血", "heal_method_missing")
--             end
--         else
--             Log(inst, "玩家已死亡，无法回血", "player_dead_no_heal")
--         end
--     else
--         Log(inst, "未触发回血概率", "heal_not_triggered")
--     end
-- end

-- -- 强化版玩家验证函数
-- local function ValidatePlayer(inst)
--     Log(inst, "执行玩家实体有效性验证", "validate_player")
--     local player = GetPlayer(inst)
    
--     -- 如果玩家无效，尝试修复
--     if not player or not player:IsValid() then
--         Log(inst, "玩家实体无效，尝试修复...", "validate_player_invalid")
        
--         -- 尝试重新绑定到玩家
--         if AllPlayers and #AllPlayers > 0 then
--             for _, p in ipairs(AllPlayers) do
--                 if p and p:IsValid() and p:HasTag("player") and 
--                    p.components and p.components.debuffable then
--                     -- 重新关联到有效玩家
--                     inst.entity:SetParent(p.entity)
--                     inst._player = p
--                     Log(inst, "已尝试将Buff重新关联到玩家: " .. tostring(p.prefab), "validate_player_rebind")
--                     return ValidatePlayer(inst)  -- 重新验证
--                 end
--             end
--         end
        
--         Log(inst, "玩家实体验证失败，无法修复，移除Buff", "validate_player_failed")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--         return false
--     end
    
--     Log(inst, "玩家实体有效", "validate_player_success")
--     return true
-- end

-- -- Buff附加时触发（优化版）
-- local function OnAttached(inst, target)
--     Log(inst, "Buff开始附加到目标", "buff_attaching")
    
--     -- 验证目标有效性
--     if not target or not target:IsValid() then
--         Log(inst, "目标无效，移除Buff", "invalid_target_remove_buff")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--         return
--     end
    
--     -- 验证目标是玩家
--     if not target:HasTag("player") then
--         Log(inst, "目标不是玩家，移除Buff", "target_not_player")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--         return
--     end
    
--     -- 强制绑定到玩家实体
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
--     Log(inst, "已强制绑定到玩家实体", "entity_parent_set")
    
--     -- 缓存玩家引用
--     inst._player = target
--     Log(inst, "已缓存Buff携带者玩家实体: " .. tostring(target.prefab), "player_cached")
    
--     -- 启动玩家实体验证任务（1秒一次，提高响应速度）
--     if inst._validation_task then
--         inst._validation_task:Cancel()
--     end
--     inst._validation_task = inst:DoPeriodicTask(1, function()
--         ValidatePlayer(inst)
--     end)
--     Log(inst, "已启动玩家实体验证任务", "validation_task_started")
    
--     -- 开始播放持续特效
--     if inst._effect_task then
--         inst._effect_task:Cancel()
--     end
--     inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
--         local player = GetPlayer(inst)
--         if player and player:IsValid() then
--             local x, y, z = player.Transform:GetWorldPosition()
--             SpawnPlayerContinuousEffect(x, y, z)
--         else
--             Log(inst, "目标已失效，停止持续特效", "effect_target_invalid")
--             if inst._effect_task then
--                 inst._effect_task:Cancel()
--                 inst._effect_task = nil
--             end
--         end
--     end)
--     Log(inst, string.format("持续特效计时器启动，间隔: %.1f秒", CONFIG.EFFECT_INTERVAL), "effect_task_started")
    
--     -- 优化事件监听，只监听玩家的攻击事件
--     -- 存储事件回调引用以便后续准确移除
--     inst._onattackother_fn = function(_, data)
--         OnAttack(inst, data)
--     end
--     inst:ListenForEvent("onattackother", inst._onattackother_fn, target)
--     Log(inst, "已设置攻击事件监听", "attack_listener_set")
    
--     -- 监听目标重生事件
--     inst._onrespawn_fn = function()
--         Log(inst, "目标重生，更新玩家引用", "player_respawned")
--         inst._player = target  -- 重生后更新引用
--     end
--     inst:ListenForEvent("respawnfromghost", inst._onrespawn_fn, target)
    
--     -- 监听玩家死亡事件
--     inst._ondeath_fn = function()
--         Log(inst, "玩家已死亡，移除Buff", "player_death_remove_buff")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end
--     inst:ListenForEvent("death", inst._ondeath_fn, target)
    
--     Log(inst, "Buff附加流程完成", "buff_attached")
-- end

-- -- 计时器结束时触发
-- local function OnTimerDone(inst, data)
--     if data and data.name == "duration" then
--         Log(inst, "Buff持续时间结束，停止Buff", "buff_duration_ended")
--         if inst.components and inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end
-- end

-- -- 重复施加时触发：刷新持续时间
-- local function OnExtended(inst, target)
--     Log(inst, "Buff被重复施加，刷新持续时间", "buff_extended")
    
--     -- 刷新计时器
--     if inst.components and inst.components.timer then
--         inst.components.timer:StopTimer("duration")
--         inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     end
    
--     -- 强制刷新玩家缓存和绑定
--     inst.entity:SetParent(target.entity)
--     inst._player = target
--     Log(inst, "已强制刷新玩家绑定和缓存", "player_cache_refreshed")
    
--     -- 重置特效计时器
--     if inst._effect_task then
--         inst._effect_task:Cancel()
--         Log(inst, "旧特效计时器已取消", "old_effect_cancelled")
--     end
--     inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
--         local player = GetPlayer(inst)
--         if player and player:IsValid() then
--             local x, y, z = player.Transform:GetWorldPosition()
--             SpawnPlayerContinuousEffect(x, y, z)
--         else
--             Log(inst, "目标已失效，停止持续特效", "effect_stopped")
--         end
--     end)
--     Log(inst, "新特效计时器启动", "new_effect_started")
-- end

-- -- Buff移除时触发
-- local function OnDetached(inst, target)
--     Log(inst, "Buff开始移除流程", "buff_detaching")
    
--     -- 移除所有事件监听（使用存储的回调函数引用）
--     if target and target:IsValid() then
--         if inst._onattackother_fn then
--             inst:RemoveEventCallback("onattackother", inst._onattackother_fn, target)
--             inst._onattackother_fn = nil
--         end
--         if inst._onrespawn_fn then
--             inst:RemoveEventCallback("respawnfromghost", inst._onrespawn_fn, target)
--             inst._onrespawn_fn = nil
--         end
--         if inst._ondeath_fn then
--             inst:RemoveEventCallback("death", inst._ondeath_fn, target)
--             inst._ondeath_fn = nil
--         end
--     end
    
--     -- 停止所有任务
--     if inst._effect_task then
--         inst._effect_task:Cancel()
--         inst._effect_task = nil
--         Log(inst, "特效计时器已停止", "effect_task_stopped")
--     end
    
--     if inst._validation_task then
--         inst._validation_task:Cancel()
--         inst._validation_task = nil
--         Log(inst, "玩家验证任务已停止", "validation_task_stopped")
--     end
    
--     -- 清除缓存数据
--     inst._player = nil
--     inst._last_attack_data = nil
--     inst._logTimestamps = nil
    
--     Log(inst, "Buff移除流程完成", "buff_detached")
--     inst:Remove()
-- end

-- -- 创建Buff实体（优化版）
-- local function fn()
--     local inst = CreateEntity()
--     Log(inst, "开始创建Buff实体", "entity_creation_started")

--     -- 客户端不生成实体（仅服务器处理）
--     if not TheWorld.ismastersim then
--         Log(inst, "客户端：移除实体（仅服务器处理）", "client_entity_removed")
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     -- 实体设置
--     inst.entity:AddTransform()
--     inst.entity:AddNetwork()  -- 添加网络组件确保多端同步
--     inst.entity:Hide()
--     inst.persists = false
--     inst:AddTag("CLASSIFIED")
--     inst:AddTag("sjy_buff_execute_tag")  -- 添加独特标签便于识别
    
--     -- 初始化存储变量
--     inst._player = nil
--     inst._last_attack_data = nil
--     inst._effect_task = nil
--     inst._validation_task = nil
--     inst._logTimestamps = nil
--     -- 初始化事件回调存储变量
--     inst._onattackother_fn = nil
--     inst._onrespawn_fn = nil
--     inst._ondeath_fn = nil
    
--     -- 网络同步设置
--     inst.entity:SetPristine()
--     if not TheWorld.ismastersim then
--         return inst
--     end
    
--     Log(inst, "实体基础设置完成", "entity_base_setup_done")

--     -- 添加Buff组件
--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true
--     Log(inst, "已添加debuff组件", "debuff_component_added")

--     -- 添加计时器组件
--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)
--     Log(inst, "已添加timer组件，持续时间: "..CONFIG.DURATION.."秒", "timer_component_added")

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)




















-- 斩杀Buff配置
local CONFIG = {
    DURATION = 1440,          -- 持续时间（游戏秒，1440秒 = 3天）
    PREFAB_NAME = "sjy_buff_execute",  -- Buff预制体名称
    EFFECT_INTERVAL = 0.5,    -- 玩家持续特效间隔（秒）
    HEAL_AMOUNT = 10,         -- 回血数值
    HEAL_CHANCE = 0.1,        -- 回血触发概率（10%）
    LOG_EFFECTS = false,      -- 是否打印特效日志
    DEBUG_MODE = false,        -- 调试模式开关
    LOG_INTERVAL = 3,         -- 重复日志的最小输出间隔（秒）
    SLAY_THRESHOLD = 1        -- 斩杀阈值：玩家血量 > 目标血量的1.2倍
}

-- 用于限制日志输出频率
local function ThrottledLog(inst, message, key)
    if not CONFIG.DEBUG_MODE then return end
    
    local id = inst and inst.GUID or "未知"
    local now = GetTime()
    inst._logTimestamps = inst._logTimestamps or {}
    
    if not inst._logTimestamps[key] or now - inst._logTimestamps[key] > CONFIG.LOG_INTERVAL then
        inst._logTimestamps[key] = now
        print(string.format("[%s] [斩杀Buff#%s] %s", os.date("%H:%M:%S"), id, message))
    end
end

-- 打印调试信息
local function Log(inst, message, key)
    if key then
        ThrottledLog(inst, message, key)
    else
        if not CONFIG.DEBUG_MODE then return end
        
        local id = inst and inst.GUID or "未知"
        print(string.format("[%s] [斩杀Buff#%s] %s", os.date("%H:%M:%S"), id, message))
    end
end

-- 增强版玩家获取函数
local function GetPlayer(inst)
    Log(inst, "尝试获取玩家实体...", "get_player_attempt")
    
    -- 途径1: 从debuff目标直接获取（最高优先级）
    if inst.components and inst.components.debuff and inst.components.debuff.target then
        local target = inst.components.debuff.target
        if target and target:IsValid() and target:HasTag("player") then
            inst._player = target
            Log(inst, "从debuff目标获取到玩家，已缓存", "get_player_from_debuff_target")
            return target
        end
    end
    
    -- 途径2: 直接使用缓存的玩家引用
    if inst._player and inst._player:IsValid() and inst._player:HasTag("player") then
        Log(inst, "通过缓存获取到玩家实体", "get_player_cached")
        return inst._player
    end
    
    -- 途径3: 从父实体获取
    local parent = inst.entity:GetParent()
    if parent and parent:IsValid() then
        Log(inst, "找到父实体，验证是否为玩家...", "get_player_parent_check")
        if parent:HasTag("player") then
            inst._player = parent
            Log(inst, "父实体是玩家，已缓存", "get_player_parent_success")
            return parent
        else
            Log(inst, "父实体存在但不是玩家: " .. tostring(parent.prefab or "未知预制体"))
        end
    else
        Log(inst, "未找到父实体", "get_player_no_parent")
    end
    
    -- 途径4: 从最近的攻击数据中获取
    if inst._last_attack_data and inst._last_attack_data.attacker then
        local attacker = inst._last_attack_data.attacker
        if attacker and attacker:IsValid() and attacker:HasTag("player") then
            inst._player = attacker
            Log(inst, "从攻击事件中获取到玩家，已缓存", "get_player_from_attack")
            return attacker
        end
    end
    
    -- 途径5: 通过玩家标签遍历查找
    Log(inst, "开始遍历所有玩家查找Buff持有者...", "get_player_iterate")
    if AllPlayers and #AllPlayers > 0 then
        for i, player in ipairs(AllPlayers) do
            if player and player:IsValid() and player:HasTag("player") then
                Log(inst, "检查玩家 #" .. i .. ": " .. tostring(player.prefab), "get_player_check_"..i)
                
                if player.components and player.components.debuffable then
                    local debuffs
                    if type(player.components.debuffable.GetDebuffs) == "function" then
                        debuffs = player.components.debuffable:GetDebuffs()
                    else
                        debuffs = player.components.debuffable.debuffs
                        Log(inst, "玩家的debuffable组件缺少GetDebuffs方法，尝试直接访问debuffs字段")
                    end
                    
                    if debuffs and type(debuffs) == "table" then
                        for _, debuff in pairs(debuffs) do
                            if debuff and debuff.prefab == inst.prefab and debuff.GUID == inst.GUID then
                                inst._player = player
                                Log(inst, "通过Buff匹配找到玩家，已缓存", "get_player_match_found")
                                return player
                            end
                        end
                    else
                        Log(inst, "玩家没有任何debuff", "get_player_no_debuffs")
                    end
                else
                    Log(inst, "玩家缺少debuffable组件", "get_player_no_debuffable")
                end
            else
                Log(inst, "玩家 #" .. i .. " 无效", "get_player_invalid_"..i)
            end
        end
    else
        Log(inst, "没有找到任何玩家实体", "get_player_no_players")
    end
    
    Log(inst, "无法通过任何方式获取玩家实体", "get_player_failed")
    return nil
end

-- 播放玩家携带Buff的持续特效
local function SpawnPlayerContinuousEffect(x, y, z)
    local fx = SpawnPrefab("winters_feast_food_depleted")
    if fx then
        fx.Transform:SetPosition(x, y - 1, z)
        if CONFIG.LOG_EFFECTS then
            print(string.format("[%s] [斩杀Buff] 播放持续特效", os.date("%H:%M:%S")))
        end
    else
        print(string.format("[%s] [斩杀Buff] 持续特效预制体不存在: winters_feast_food_depleted", os.date("%H:%M:%S")))
    end
end

-- 播放玩家回血特效
local function SpawnPlayerHealEffect(x, y, z)
    local fx = SpawnPrefab("ghostlyelixir_player_speed_fx")
    if fx then
        fx.Transform:SetPosition(x, y, z)
        print(string.format("[%s] [斩杀Buff] 播放回血特效", os.date("%H:%M:%S")))
    else
        print(string.format("[%s] [斩杀Buff] 回血特效预制体不存在: ghostlyelixir_player_speed_fx", os.date("%H:%M:%S")))
    end
end

-- 播放怪物被斩杀特效
local function SpawnSlaughterEffect(x, y, z)
    local fx = SpawnPrefab("shadowstrike_slash_fx")
    if fx then
        fx.Transform:SetPosition(x, y, z)
        print(string.format("[%s] [斩杀Buff] 播放斩杀特效", os.date("%H:%M:%S")))
    else
        print(string.format("[%s] [斩杀Buff] 斩杀特效预制体不存在: shadowstrike_slash_fx", os.date("%H:%M:%S")))
    end
end

-- 攻击判定函数（修复版）
local function OnAttack(inst, data)
    -- 验证攻击数据有效性
    if not data or not data.target then
        Log(inst, "攻击数据无效或缺少目标", "invalid_attack_data")
        return
    end
    
    -- 缓存攻击数据
    inst._last_attack_data = data
    Log(inst, "检测到攻击事件", "attack_detected")
    
    -- 获取玩家实体
    local player = GetPlayer(inst)
    if not player or not player:IsValid() or not player:HasTag("player") then
        Log(inst, "无法获取有效玩家实体，尝试从攻击数据中获取", "player_invalid_try_attack")
        
        -- 从攻击数据中获取攻击者
        if data.attacker and data.attacker:IsValid() and data.attacker:HasTag("player") then
            Log(inst, "使用攻击事件中的攻击者作为玩家", "use_attacker_as_player")
            player = data.attacker
            inst._player = player  -- 更新缓存
        else
            Log(inst, "攻击事件中也没有有效玩家，终止处理", "no_valid_player")
            return
        end
    end
    
    -- 验证玩家健康组件
    if not player.components or not player.components.health then
        Log(inst, "玩家缺少health组件", "player_missing_health")
        return
    end
    
    -- 验证目标
    local target = data.target
    if not target or not target:IsValid() then
        Log(inst, "攻击目标无效或不存在", "invalid_target")
        return
    end
    
    -- 验证目标健康组件
    if not target.components or not target.components.health then
        Log(inst, "目标缺少health组件", "target_missing_health")
        return
    end
    
    -- 确保目标还活着
    if target.components.health:IsDead() then
        Log(inst, "目标已死亡，无需处理", "target_already_dead")
        return
    end
    
    Log(inst, string.format("攻击验证通过: 玩家=%s, 目标=%s", 
        tostring(player.prefab), tostring(target.prefab)), "attack_validated")
    
    -- 获取血量组件并验证
    local player_health_comp = player.components.health
    local target_health_comp = target.components.health
    
    if not player_health_comp.currenthealth or not target_health_comp.currenthealth then
        Log(inst, "无法获取玩家或目标的当前血量", "missing_health_values")
        return
    end
    
    -- 转换为数值确保比较安全
    local player_health = tonumber(player_health_comp.currenthealth)
    local target_health = tonumber(target_health_comp.currenthealth)
    
    Log(inst, string.format("玩家血量: %.1f, 目标血量: %.1f, 斩杀阈值: %.1f倍", 
        player_health, target_health, CONFIG.SLAY_THRESHOLD), "health_values")
    
    local slayed = false
    -- 玩家血量高于目标血量的指定倍数时触发斩杀
    if player_health > target_health * CONFIG.SLAY_THRESHOLD then
        Log(inst, "满足斩杀条件，执行斩杀", "slay_condition_met")
        
        -- 执行斩杀
        target_health_comp:Kill()
        
        -- 验证斩杀结果
        if target_health_comp:IsDead() then
            Log(inst, "斩杀成功", "slay_successful")
            local x, y, z = target.Transform:GetWorldPosition()
            SpawnSlaughterEffect(x, y, z)
            slayed = true
        else
            Log(inst, "斩杀执行失败，目标未死亡", "slay_failed")
        end
    else
        Log(inst, "不满足斩杀条件", "slay_condition_not_met")
    end
    
    -- 独立的回血概率判定（无论是否斩杀都可能触发）
    if math.random() <= CONFIG.HEAL_CHANCE then
        Log(inst, "触发回血概率", "heal_triggered")
        if not player_health_comp:IsDead() then
            -- 检查DoDelta方法是否存在
            if type(player_health_comp.DoDelta) == "function" then
                Log(inst, string.format("执行回血: +%d", CONFIG.HEAL_AMOUNT), "heal_executed")
                -- 第三个参数用于标识回血来源
                player_health_comp:DoDelta(CONFIG.HEAL_AMOUNT, nil, "sjy_buff_execute")
                local x, y, z = player.Transform:GetWorldPosition()
                SpawnPlayerHealEffect(x, y, z)
            else
                Log(inst, "玩家health组件缺少DoDelta方法，无法回血", "heal_method_missing")
            end
        else
            Log(inst, "玩家已死亡，无法回血", "player_dead_no_heal")
        end
    else
        Log(inst, "未触发回血概率", "heal_not_triggered")
    end
end

-- 强化版玩家验证函数
local function ValidatePlayer(inst)
    Log(inst, "执行玩家实体有效性验证", "validate_player")
    local player = GetPlayer(inst)
    
    -- 如果玩家无效，尝试修复
    if not player or not player:IsValid() then
        Log(inst, "玩家实体无效，尝试修复...", "validate_player_invalid")
        
        -- 尝试重新绑定到玩家
        if AllPlayers and #AllPlayers > 0 then
            for _, p in ipairs(AllPlayers) do
                if p and p:IsValid() and p:HasTag("player") and 
                   p.components and p.components.debuffable then
                    -- 重新关联到有效玩家
                    inst.entity:SetParent(p.entity)
                    inst._player = p
                    Log(inst, "已尝试将Buff重新关联到玩家: " .. tostring(p.prefab), "validate_player_rebind")
                    return ValidatePlayer(inst)  -- 重新验证
                end
            end
        end
        
        Log(inst, "玩家实体验证失败，无法修复，移除Buff", "validate_player_failed")
        if inst.components and inst.components.debuff then
            inst.components.debuff:Stop()
        end
        return false
    end
    
    Log(inst, "玩家实体有效", "validate_player_success")
    return true
end

-- Buff附加时触发（优化版）
local function OnAttached(inst, target)
    Log(inst, "Buff开始附加到目标", "buff_attaching")
    
    -- 验证目标有效性
    if not target or not target:IsValid() then
        Log(inst, "目标无效，移除Buff", "invalid_target_remove_buff")
        if inst.components and inst.components.debuff then
            inst.components.debuff:Stop()
        end
        return
    end
    
    -- 验证目标是玩家
    if not target:HasTag("player") then
        Log(inst, "目标不是玩家，移除Buff", "target_not_player")
        if inst.components and inst.components.debuff then
            inst.components.debuff:Stop()
        end
        return
    end
    
    -- 强制绑定到玩家实体
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    Log(inst, "已强制绑定到玩家实体", "entity_parent_set")
    
    -- 缓存玩家引用
    inst._player = target
    Log(inst, "已缓存Buff携带者玩家实体: " .. tostring(target.prefab), "player_cached")
    
    -- 启动玩家实体验证任务（1秒一次，提高响应速度）
    if inst._validation_task then
        inst._validation_task:Cancel()
    end
    inst._validation_task = inst:DoPeriodicTask(1, function()
        ValidatePlayer(inst)
    end)
    Log(inst, "已启动玩家实体验证任务", "validation_task_started")
    
    -- 开始播放持续特效
    if inst._effect_task then
        inst._effect_task:Cancel()
    end
    inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
        local player = GetPlayer(inst)
        if player and player:IsValid() then
            local x, y, z = player.Transform:GetWorldPosition()
            SpawnPlayerContinuousEffect(x, y, z)
        else
            Log(inst, "目标已失效，停止持续特效", "effect_target_invalid")
            if inst._effect_task then
                inst._effect_task:Cancel()
                inst._effect_task = nil
            end
        end
    end)
    Log(inst, string.format("持续特效计时器启动，间隔: %.1f秒", CONFIG.EFFECT_INTERVAL), "effect_task_started")
    
    -- 优化事件监听，只监听玩家的攻击事件
    -- 存储事件回调引用以便后续准确移除
    inst._onattackother_fn = function(_, data)
        OnAttack(inst, data)
    end
    inst:ListenForEvent("onattackother", inst._onattackother_fn, target)
    Log(inst, "已设置攻击事件监听", "attack_listener_set")
    
    -- 监听目标重生事件
    inst._onrespawn_fn = function()
        Log(inst, "目标重生，更新玩家引用", "player_respawned")
        inst._player = target  -- 重生后更新引用
    end
    inst:ListenForEvent("respawnfromghost", inst._onrespawn_fn, target)
    
    -- 监听玩家死亡事件
    inst._ondeath_fn = function()
        Log(inst, "玩家已死亡，移除Buff", "player_death_remove_buff")
        if inst.components and inst.components.debuff then
            inst.components.debuff:Stop()
        end
    end
    inst:ListenForEvent("death", inst._ondeath_fn, target)
    
    Log(inst, "Buff附加流程完成", "buff_attached")
end

-- 计时器结束时触发
local function OnTimerDone(inst, data)
    if data and data.name == "duration" then
        Log(inst, "Buff持续时间结束，停止Buff", "buff_duration_ended")
        if inst.components and inst.components.debuff then
            inst.components.debuff:Stop()
        end
    end
end

-- 重复施加时触发：刷新持续时间
local function OnExtended(inst, target)
    Log(inst, "Buff被重复施加，刷新持续时间", "buff_extended")
    
    -- 刷新计时器
    if inst.components and inst.components.timer then
        inst.components.timer:StopTimer("duration")
        inst.components.timer:StartTimer("duration", CONFIG.DURATION)
    end
    
    -- 强制刷新玩家缓存和绑定
    inst.entity:SetParent(target.entity)
    inst._player = target
    Log(inst, "已强制刷新玩家绑定和缓存", "player_cache_refreshed")
    
    -- 重置特效计时器
    if inst._effect_task then
        inst._effect_task:Cancel()
        Log(inst, "旧特效计时器已取消", "old_effect_cancelled")
    end
    inst._effect_task = inst:DoPeriodicTask(CONFIG.EFFECT_INTERVAL, function()
        local player = GetPlayer(inst)
        if player and player:IsValid() then
            local x, y, z = player.Transform:GetWorldPosition()
            SpawnPlayerContinuousEffect(x, y, z)
        else
            Log(inst, "目标已失效，停止持续特效", "effect_stopped")
        end
    end)
    Log(inst, "新特效计时器启动", "new_effect_started")
end

-- Buff移除时触发
local function OnDetached(inst, target)
    Log(inst, "Buff开始移除流程", "buff_detaching")
    
    -- 移除所有事件监听（使用存储的回调函数引用）
    if target and target:IsValid() then
        if inst._onattackother_fn then
            inst:RemoveEventCallback("onattackother", inst._onattackother_fn, target)
            inst._onattackother_fn = nil
        end
        if inst._onrespawn_fn then
            inst:RemoveEventCallback("respawnfromghost", inst._onrespawn_fn, target)
            inst._onrespawn_fn = nil
        end
        if inst._ondeath_fn then
            inst:RemoveEventCallback("death", inst._ondeath_fn, target)
            inst._ondeath_fn = nil
        end
    end
    
    -- 停止所有任务
    if inst._effect_task then
        inst._effect_task:Cancel()
        inst._effect_task = nil
        Log(inst, "特效计时器已停止", "effect_task_stopped")
    end
    
    if inst._validation_task then
        inst._validation_task:Cancel()
        inst._validation_task = nil
        Log(inst, "玩家验证任务已停止", "validation_task_stopped")
    end
    
    -- 清除缓存数据
    inst._player = nil
    inst._last_attack_data = nil
    inst._logTimestamps = nil
    
    Log(inst, "Buff移除流程完成", "buff_detached")
    inst:Remove()
end

-- 创建Buff实体（优化版）
local function fn()
    local inst = CreateEntity()
    Log(inst, "开始创建Buff实体", "entity_creation_started")

    -- 客户端不生成实体（仅服务器处理）
    if not TheWorld.ismastersim then
        Log(inst, "客户端：移除实体（仅服务器处理）", "client_entity_removed")
        inst:DoTaskInTime(0, inst.Remove)
        return inst
    end

    -- 实体设置
    inst.entity:AddTransform()
    inst.entity:AddNetwork()  -- 添加网络组件确保多端同步
    inst.entity:Hide()
    inst.persists = false
    inst:AddTag("CLASSIFIED")
    inst:AddTag("sjy_buff_execute_tag")  -- 添加独特标签便于识别
    
    -- 初始化存储变量
    inst._player = nil
    inst._last_attack_data = nil
    inst._effect_task = nil
    inst._validation_task = nil
    inst._logTimestamps = nil
    -- 初始化事件回调存储变量
    inst._onattackother_fn = nil
    inst._onrespawn_fn = nil
    inst._ondeath_fn = nil
    
    -- 网络同步设置
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
    
    Log(inst, "实体基础设置完成", "entity_base_setup_done")

    -- 添加Buff组件
    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(OnDetached)
    inst.components.debuff:SetExtendedFn(OnExtended)
    inst.components.debuff.keepondespawn = true
    Log(inst, "已添加debuff组件", "debuff_component_added")

    -- 添加计时器组件
    inst:AddComponent("timer")
    inst.components.timer:StartTimer("duration", CONFIG.DURATION)
    inst:ListenForEvent("timerdone", OnTimerDone)
    Log(inst, "已添加timer组件，持续时间: "..CONFIG.DURATION.."秒", "timer_component_added")

    return inst
end

return Prefab(CONFIG.PREFAB_NAME, fn)