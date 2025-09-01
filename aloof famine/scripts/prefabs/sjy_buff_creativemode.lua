-- -- 开发者模式Buff配置
-- local CONFIG = {
--     TARGET_KLEI_ID = "KU_bMa3B1qu",  -- 目标科雷ID
--     DURATION =10,              -- 持续时间（5天，每天480秒）
--     PREFAB_NAME = "sjy_buff_creativemode",  -- Buff预制体名称
--     CHAT_INTERVAL = 2,               -- 非目标玩家聊天间隔（秒）
--     CHAT_MESSAGE = "食纪元太好玩啦！我要加入食纪元群聊810972548"  -- 聊天内容
-- }

-- -- 安全地清除配方（兼容不同版本）
-- local function SafeClearRecipes(builder)
--     if builder.ClearAllRecipes then
--         builder:ClearAllRecipes()
--         return true
--     else
--         for k in pairs(builder.recipes) do
--             builder.recipes[k] = nil
--         end
--         print("[开发者模式Buff] 使用兼容方式清空配方")
--         return true
--     end
-- end

-- -- 给予开发者模式权限（基于官方方法优化）
-- local function GrantCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法授予开发者模式")
--         return false
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件")
--         return false
--     end
    
--     -- 只在首次应用时记录原始状态（解决重复施加问题）
--     if player._creative_buff_applied ~= true then
--         -- 记录原始状态
--         player._original_freebuildmode = builder.freebuildmode or false
--         player._original_recipes = {}
--         for k, v in pairs(builder.recipes) do
--             player._original_recipes[k] = v
--         end
--         print("[开发者模式Buff] 已记录原始开发者模式状态")
        
--         -- 标记为已应用
--         player._creative_buff_applied = true
--     end
    
--     -- 强制开启开发者模式（增加延迟设置，避免被立即覆盖）
--     player:DoTaskInTime(0, function()
--         if builder then
--             builder.freebuildmode = true
--             print("[开发者模式Buff] 延迟设置freebuildmode为true")
--         end
--     end)
    
--     -- 先清除再授予所有配方（完全遵循官方方式）
--     SafeClearRecipes(builder)
--     builder:GiveAllRecipes()  -- 官方核心方法
--     print("[开发者模式Buff] 已执行官方GiveAllRecipes方法")
    
--     -- 触发官方事件，确保UI同步
--     player:PushEvent("unlockallrecipes")
--     player:PushEvent("buildmodechanged", {mode = true})
    
--     -- 增加额外验证和强制设置
--     player:DoTaskInTime(0.5, function()
--         if builder and not builder.freebuildmode then
--             print("[开发者模式Buff] 检测到freebuildmode被覆盖，重新设置")
--             builder.freebuildmode = true
--             builder:GiveAllRecipes()  -- 再次调用确保配方生效
--         end
--     end)
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已开启！")
--     end
    
--     -- 最终验证
--     print(string.format("[开发者模式Buff] 开发者模式状态最终验证: %s", tostring(builder.freebuildmode)))
--     return true
-- end

-- -- 移除开发者模式权限（修复移除逻辑）
-- local function RevokeCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法移除开发者模式")
--         return
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件，无法移除")
--         return
--     end
    
--     -- 只有应用过Buff的玩家才执行恢复
--     if player._creative_buff_applied == true then
--         -- 恢复原始开发者模式状态
--         if player._original_freebuildmode ~= nil then
--             builder.freebuildmode = player._original_freebuildmode
--             print(string.format("[开发者模式Buff] 恢复原始freebuildmode: %s", tostring(player._original_freebuildmode)))
--         else
--             builder.freebuildmode = false
--             print("[开发者模式Buff] 无原始记录，强制关闭开发者模式")
--         end
        
--         -- 恢复原始配方
--         if player._original_recipes then
--             SafeClearRecipes(builder)
--             for k, v in pairs(player._original_recipes) do
--                 builder.recipes[k] = v
--             end
--             print("[开发者模式Buff] 已恢复原始配方")
--         else
--             SafeClearRecipes(builder)
--             print("[开发者模式Buff] 无原始配方记录，已清除")
--         end
        
--         -- 触发官方关闭事件
--         player:PushEvent("lockallrecipes")
--         player:PushEvent("buildmodechanged", {mode = false})
        
--         -- 清理标记和记录
--         player._original_freebuildmode = nil
--         player._original_recipes = nil
--         player._creative_buff_applied = nil
--     end
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已关闭！")
--     end
    
--     print(string.format("[开发者模式Buff] 已为玩家 %s 移除开发者模式", tostring(player.name)))
-- end

-- -- Buff附加时触发
-- local function OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
    
--     if target:HasTag("player") then
--         inst._is_target_player = (target.userid == CONFIG.TARGET_KLEI_ID)
--         print(string.format("[开发者模式Buff] 玩家匹配结果: %s", tostring(inst._is_target_player)))
        
--         if inst._is_target_player then
--             -- 立即尝试授予权限
--             local granted = GrantCreativeMode(target)
            
--             -- 增强重试机制：0.5秒、1秒、2秒后多次重试
--             if not granted then
--                 local retryTimes = {0.5, 1, 2}
--                 for _, delay in ipairs(retryTimes) do
--                     inst:DoTaskInTime(delay, function()
--                         if target and target:IsValid() then
--                             print(string.format("[开发者模式Buff] 第%d次重试开启开发者模式", _))
--                             GrantCreativeMode(target)
--                         end
--                     end)
--                 end
--             end
            
--             inst._chat_task = nil
--         else
--             -- 非目标玩家聊天逻辑
--             inst._chat_task = inst:DoPeriodicTask(CONFIG.CHAT_INTERVAL, function()
--                 if target:IsValid() and not target:HasTag("playerghost") and 
--                    target.components and target.components.talker then
--                     target.components.talker:Say(CONFIG.CHAT_MESSAGE)
--                 end
--             end)
--         end
--     end
    
--     -- 监听死亡事件
--     inst:ListenForEvent("death", function()
--         if inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end, target)
-- end

-- -- 计时器结束时触发
-- local function OnTimerDone(inst, data)
--     if data and data.name == "duration" and inst.components.debuff then
--         print("[开发者模式Buff] 持续时间结束，准备移除Buff")
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发
-- local function OnExtended(inst, target)
--     if inst.components.timer then
--         inst.components.timer:StopTimer("duration")
--         inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--         print("[开发者模式Buff] 持续时间已刷新")
        
--         -- 延长Buff时重新确认开发者模式状态
--         if inst._is_target_player and target and target:IsValid() then
--             GrantCreativeMode(target)
--         end
--     end
-- end

-- -- Buff移除时触发
-- local function OnDetached(inst, target)
--     if inst._chat_task then
--         inst._chat_task:Cancel()
--         inst._chat_task = nil
--     end
    
--     if inst._is_target_player and target and target:IsValid() then
--         RevokeCreativeMode(target)
--     end
    
--     print("[开发者模式Buff] 已从玩家身上移除")
--     inst:Remove()
-- end

-- -- 创建Buff实体
-- local function fn()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()
--     inst.entity:Hide()
--     inst.persists = false
--     inst:AddTag("CLASSIFIED")
    
--     inst._is_target_player = false
--     inst._chat_task = nil

--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true

--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)
    



















-- -- 开发者模式Buff配置
-- local CONFIG = {
--     TARGET_KLEI_ID = "KU_bMa3B2qu",  -- 目标科雷ID
--     DURATION = 5 * 480,              -- 持续时间（秒）
--     PREFAB_NAME = "sjy_buff_creativemode",  -- Buff预制体名称
--     CHAT_INTERVAL = 2,               -- 非目标玩家聊天间隔（秒）
--     CHAT_MESSAGE = "食纪元太好玩啦！我要加入食纪元群聊810972548"  -- 聊天内容
-- }

-- -- 安全地清除配方（兼容不同版本）
-- local function SafeClearRecipes(builder)
--     if builder.ClearAllRecipes then
--         builder:ClearAllRecipes()
--         return true
--     else
--         for k in pairs(builder.recipes) do
--             builder.recipes[k] = nil
--         end
--         print("[开发者模式Buff] 使用兼容方式清空配方")
--         return true
--     end
-- end

-- -- 安全获取配方名称（防止nil值）
-- local function GetSafeRecipeName(recipe)
--     if not recipe then return "unknown" end
--     return recipe.name or "unknown"
-- end

-- -- 安全获取配方对应的字符串名称
-- local function GetSafeRecipeString(recipe_name)
--     if not recipe_name then return STRINGS.NAMES.UNKNOWN end
--     return STRINGS.NAMES[string.upper(recipe_name)] or STRINGS.NAMES.UNKNOWN
-- end

-- -- 给予开发者模式权限（基于官方方法优化）
-- local function GrantCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法授予开发者模式")
--         return false
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件")
--         return false
--     end
    
--     -- 只在首次应用时记录原始状态（解决重复施加问题）
--     if player._creative_buff_applied ~= true then
--         -- 记录原始状态
--         player._original_freebuildmode = builder.freebuildmode or false
--         player._original_recipes = {}
--         for k, v in pairs(builder.recipes) do
--             -- 存储配方名称而非整个配方对象，避免引用问题
--             player._original_recipes[GetSafeRecipeName(k)] = v
--         end
--         print("[开发者模式Buff] 已记录原始开发者模式状态")
        
--         -- 标记为已应用
--         player._creative_buff_applied = true
--     end
    
--     -- 强制开启开发者模式（增加延迟设置，避免被立即覆盖）
--     player:DoTaskInTime(0, function()
--         if builder and builder.freebuildmode ~= true then
--             builder.freebuildmode = true
--             print("[开发者模式Buff] 延迟设置freebuildmode为true")
--         end
--     end)
    
--     -- 先清除再授予所有配方（完全遵循官方方式）
--     SafeClearRecipes(builder)
    
--     -- 安全地授予所有配方，过滤掉可能导致问题的配方
--     for k, v in pairs(AllRecipes) do
--         if v and v.name and not v.nounlock and v.builder_tag == nil then
--             -- 验证配方是否有对应的字符串名称
--             local recipe_name = GetSafeRecipeName(v)
--             local recipe_string = GetSafeRecipeString(recipe_name)
--             if recipe_string ~= STRINGS.NAMES.UNKNOWN then
--                 builder:AddRecipe(recipe_name)
--             else
--                 print(string.format("[开发者模式Buff] 跳过无效配方: %s (缺少名称字符串)", recipe_name))
--             end
--         end
--     end
    
--     print("[开发者模式Buff] 已安全授予所有有效配方")
    
--     -- 触发官方事件，确保UI同步
--     player:PushEvent("unlockallrecipes")
--     player:PushEvent("buildmodechanged", {mode = true})
    
--     -- 增加额外验证和强制设置
--     player:DoTaskInTime(0.5, function()
--         if builder and not builder.freebuildmode then
--             print("[开发者模式Buff] 检测到freebuildmode被覆盖，重新设置")
--             builder.freebuildmode = true
--             -- 再次调用确保配方生效
--             for k, v in pairs(AllRecipes) do
--                 if v and v.name and not v.nounlock and v.builder_tag == nil then
--                     builder:AddRecipe(v.name)
--                 end
--             end
--         end
--     end)
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已开启！")
--     end
    
--     -- 最终验证
--     print(string.format("[开发者模式Buff] 开发者模式状态最终验证: %s", tostring(builder.freebuildmode)))
--     return true
-- end

-- -- 移除开发者模式权限（修复移除逻辑）
-- local function RevokeCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法移除开发者模式")
--         return
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件，无法移除")
--         return
--     end
    
--     -- 只有应用过Buff的玩家才执行恢复
--     if player._creative_buff_applied == true then
--         -- 恢复原始开发者模式状态
--         if player._original_freebuildmode ~= nil then
--             builder.freebuildmode = player._original_freebuildmode
--             print(string.format("[开发者模式Buff] 恢复原始freebuildmode: %s", tostring(player._original_freebuildmode)))
--         else
--             builder.freebuildmode = false
--             print("[开发者模式Buff] 无原始记录，强制关闭开发者模式")
--         end
        
--         -- 恢复原始配方
--         if player._original_recipes then
--             SafeClearRecipes(builder)
--             for k, v in pairs(player._original_recipes) do
--                 -- 只恢复有效的配方
--                 if GetValidRecipe(k) then
--                     builder.recipes[k] = v
--                 end
--             end
--             print("[开发者模式Buff] 已恢复原始配方")
--         else
--             SafeClearRecipes(builder)
--             print("[开发者模式Buff] 无原始配方记录，已清除")
--         end
        
--         -- 触发官方关闭事件
--         player:PushEvent("lockallrecipes")
--         player:PushEvent("buildmodechanged", {mode = false})
        
--         -- 清理标记和记录
--         player._original_freebuildmode = nil
--         player._original_recipes = nil
--         player._creative_buff_applied = nil
--     end
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已关闭！")
--     end
    
--     print(string.format("[开发者模式Buff] 已为玩家 %s 移除开发者模式", tostring(player.name)))
-- end

-- -- Buff附加时触发
-- local function OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
    
--     if target:HasTag("player") then
--         inst._is_target_player = (target.userid == CONFIG.TARGET_KLEI_ID)
--         print(string.format("[开发者模式Buff] 玩家匹配结果: %s", tostring(inst._is_target_player)))
        
--         if inst._is_target_player then
--             -- 立即尝试授予权限
--             local granted = GrantCreativeMode(target)
            
--             -- 增强重试机制：0.5秒、1秒、2秒后多次重试
--             if not granted then
--                 local retryTimes = {0.5, 1, 2}
--                 for _, delay in ipairs(retryTimes) do
--                     inst:DoTaskInTime(delay, function()
--                         if target and target:IsValid() then
--                             print(string.format("[开发者模式Buff] 第%d次重试开启开发者模式", _))
--                             GrantCreativeMode(target)
--                         end
--                     end)
--                 end
--             end
            
--             inst._chat_task = nil
--         else
--             -- 非目标玩家聊天逻辑
--             inst._chat_task = inst:DoPeriodicTask(CONFIG.CHAT_INTERVAL, function()
--                 if target:IsValid() and not target:HasTag("playerghost") and 
--                    target.components and target.components.talker then
--                     target.components.talker:Say(CONFIG.CHAT_MESSAGE)
--                 end
--             end)
--         end
--     end
    
--     -- 监听死亡事件
--     inst:ListenForEvent("death", function()
--         if inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end, target)
-- end

-- -- 计时器结束时触发
-- local function OnTimerDone(inst, data)
--     if data and data.name == "duration" and inst.components.debuff then
--         print("[开发者模式Buff] 持续时间结束，准备移除Buff")
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发
-- local function OnExtended(inst, target)
--     if inst.components.timer then
--         inst.components.timer:StopTimer("duration")
--         inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--         print("[开发者模式Buff] 持续时间已刷新")
        
--         -- 延长Buff时重新确认开发者模式状态
--         if inst._is_target_player and target and target:IsValid() then
--             GrantCreativeMode(target)
--         end
--     end
-- end

-- -- Buff移除时触发
-- local function OnDetached(inst, target)
--     if inst._chat_task then
--         inst._chat_task:Cancel()
--         inst._chat_task = nil
--     end
    
--     if inst._is_target_player and target and target:IsValid() then
--         RevokeCreativeMode(target)
--     end
    
--     print("[开发者模式Buff] 已从玩家身上移除")
--     inst:Remove()
-- end

-- -- 创建Buff实体
-- local function fn()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()
--     inst.entity:Hide()
--     inst.persists = false
--     inst:AddTag("CLASSIFIED")
    
--     inst._is_target_player = false
--     inst._chat_task = nil

--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true

--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)


























-- -- 开发者模式Buff配置
-- local CONFIG = {
--     TARGET_KLEI_ID = "KU_bMa3B2qu",  -- 目标科雷ID
--     DURATION = 5 * 480,              -- 持续时间（秒）
--     PREFAB_NAME = "sjy_buff_creativemode",  -- Buff预制体名称
--     SELF_CHAT_INTERVAL = 2,          -- 自身聊天间隔（秒）
--     OTHER_CHAT_INTERVAL = 5,         -- 其他玩家聊天间隔（秒）
--     INFLUENCE_RANGE = 8,             -- 影响范围（格）
    
--     -- 说话内容列表
--     CHAT_MESSAGES = {
--         self = {--中buff玩家说的内容
--             "食纪元太好玩啦！我要加入食纪元群聊810972548",
--             "食纪元真有趣，快来群810972548一起玩！",
--             "强烈推荐食纪元，群号810972548等你加入！",
--             "我分手了 现在只有食纪元才能让我忘记前男友",
--             "我重生了在我加入食纪元的那一天！"
--         },
--         others = {--周围围观玩家的吐槽
--             "这个人疯了吧",
--             "好奇怪呀他一个人在说什么",
--             "他在自言自语些什么呢？",
--             "这人是不是有点不正常？",
--             "为什么他一直在说同样的话？",
--             "食纪元作者都说食纪元没意思",
--             "我估计他玩饥荒玩傻了",
--             "破案了玩饥荒玩的",
--             "这个作者也好懒老是拖更",
--             "食纪元有啥好玩的，说来听听",
--             "听说食纪元作者自掏腰包给群里人开服务器",
--             "我们要不去食纪元服务器去看看",
--             "要不也去加一下群聊",
--             "真是什么人都能玩食纪元了",
--             "还是看看远处的雪山吧家人们",
--             "听说群里有人鼠愿成功，我也要去试试",
--             "太好了是胖胖我们有救了",
--             "什么年代了还玩食纪元呢？",
--             "那什么时候更新",
--             "姥姥你订阅的那个叫食什么的mod更新了",
--             "什么？你染上食纪元了！？",
--             "太好了，是胖胖，我们没救了（）",
--             "一定是彩虹罐干的.jpg",
--             "玩食纪元那我还不如去玩隔壁的负重前行呢！",
--             "食纪元是什么冷门MOD，我们去玩武器成长吧！",
--             "太好了是食纪元我们有救了",
--             "韭菜根本薅不完割了一茬又一茬",
--             "我觉得缘之书也挺不错的，就别玩食纪元了吧！",
--             "我得在天黑之前找点吃的",
--             "胖胖是谁",
--             "我的评价是不如“原始人，起洞！",
--             "胖胖是，在我被几十只蜘蛛围住拯救我的人",
--             "帮你找了个试金石吗",
--             "自从加了食纪元实现了草莓自由",
--             "自从加了食纪元实现了韭菜自由",
--             "我爱吃草莓",
--             "韭菜还是太吃手法了，有没有什么鸡强势有简单食物推荐一下",
--             "有的兄弟有的"
            

--         }
--     }
-- }

-- -- 安全地清除配方（兼容不同版本）
-- local function SafeClearRecipes(builder)
--     if builder.ClearAllRecipes then
--         builder:ClearAllRecipes()
--         return true
--     else
--         for k in pairs(builder.recipes) do
--             builder.recipes[k] = nil
--         end
--         print("[开发者模式Buff] 使用兼容方式清空配方")
--         return true
--     end
-- end

-- -- 安全获取配方名称（防止nil值）
-- local function GetSafeRecipeName(recipe)
--     if not recipe then return "unknown" end
--     return recipe.name or "unknown"
-- end

-- -- 安全获取配方对应的字符串名称
-- local function GetSafeRecipeString(recipe_name)
--     if not recipe_name then return STRINGS.NAMES.UNKNOWN end
--     return STRINGS.NAMES[string.upper(recipe_name)] or STRINGS.NAMES.UNKNOWN
-- end

-- -- 给予开发者模式权限（基于官方方法优化）
-- local function GrantCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法授予开发者模式")
--         return false
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件")
--         return false
--     end
    
--     -- 只在首次应用时记录原始状态（解决重复施加问题）
--     if player._creative_buff_applied ~= true then
--         -- 记录原始状态
--         player._original_freebuildmode = builder.freebuildmode or false
--         player._original_recipes = {}
--         for k, v in pairs(builder.recipes) do
--             -- 存储配方名称而非整个配方对象，避免引用问题
--             player._original_recipes[GetSafeRecipeName(k)] = v
--         end
--         print("[开发者模式Buff] 已记录原始开发者模式状态")
        
--         -- 标记为已应用
--         player._creative_buff_applied = true
--     end
    
--     -- 强制开启开发者模式（增加延迟设置，避免被立即覆盖）
--     player:DoTaskInTime(0, function()
--         if builder and builder.freebuildmode ~= true then
--             builder.freebuildmode = true
--             print("[开发者模式Buff] 延迟设置freebuildmode为true")
--         end
--     end)
    
--     -- 先清除再授予所有配方（完全遵循官方方式）
--     SafeClearRecipes(builder)
    
--     -- 安全地授予所有配方，过滤掉可能导致问题的配方
--     for k, v in pairs(AllRecipes) do
--         if v and v.name and not v.nounlock and v.builder_tag == nil then
--             -- 验证配方是否有对应的字符串名称
--             local recipe_name = GetSafeRecipeName(v)
--             local recipe_string = GetSafeRecipeString(recipe_name)
--             if recipe_string ~= STRINGS.NAMES.UNKNOWN then
--                 builder:AddRecipe(recipe_name)
--             else
--                 print(string.format("[开发者模式Buff] 跳过无效配方: %s (缺少名称字符串)", recipe_name))
--             end
--         end
--     end
    
--     print("[开发者模式Buff] 已安全授予所有有效配方")
    
--     -- 触发官方事件，确保UI同步
--     player:PushEvent("unlockallrecipes")
--     player:PushEvent("buildmodechanged", {mode = true})
    
--     -- 增加额外验证和强制设置
--     player:DoTaskInTime(0.5, function()
--         if builder and not builder.freebuildmode then
--             print("[开发者模式Buff] 检测到freebuildmode被覆盖，重新设置")
--             builder.freebuildmode = true
--             -- 再次调用确保配方生效
--             for k, v in pairs(AllRecipes) do
--                 if v and v.name and not v.nounlock and v.builder_tag == nil then
--                     builder:AddRecipe(v.name)
--                 end
--             end
--         end
--     end)
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已开启！")
--     end
    
--     -- 最终验证
--     print(string.format("[开发者模式Buff] 开发者模式状态最终验证: %s", tostring(builder.freebuildmode)))
--     return true
-- end

-- -- 移除开发者模式权限（修复移除逻辑）
-- local function RevokeCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法移除开发者模式")
--         return
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件，无法移除")
--         return
--     end
    
--     -- 只有应用过Buff的玩家才执行恢复
--     if player._creative_buff_applied == true then
--         -- 恢复原始开发者模式状态
--         if player._original_freebuildmode ~= nil then
--             builder.freebuildmode = player._original_freebuildmode
--             print(string.format("[开发者模式Buff] 恢复原始freebuildmode: %s", tostring(player._original_freebuildmode)))
--         else
--             builder.freebuildmode = false
--             print("[开发者模式Buff] 无原始记录，强制关闭开发者模式")
--         end
        
--         -- 恢复原始配方
--         if player._original_recipes then
--             SafeClearRecipes(builder)
--             for k, v in pairs(player._original_recipes) do
--                 -- 只恢复有效的配方
--                 if GetValidRecipe(k) then
--                     builder.recipes[k] = v
--                 end
--             end
--             print("[开发者模式Buff] 已恢复原始配方")
--         else
--             SafeClearRecipes(builder)
--             print("[开发者模式Buff] 无原始配方记录，已清除")
--         end
        
--         -- 触发官方关闭事件
--         player:PushEvent("lockallrecipes")
--         player:PushEvent("buildmodechanged", {mode = false})
        
--         -- 清理标记和记录
--         player._original_freebuildmode = nil
--         player._original_recipes = nil
--         player._creative_buff_applied = nil
--     end
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已关闭！")
--     end
    
--     print(string.format("[开发者模式Buff] 已为玩家 %s 移除开发者模式", tostring(player.name)))
-- end

-- -- 获取范围内的其他玩家
-- local function GetPlayersInRange(inst, range)
--     local x, y, z = inst.Transform:GetWorldPosition()
--     local players = TheSim:FindEntities(x, y, z, range, {"player"}, {"playerghost", "INLIMBO"})
    
--     -- 过滤掉自身
--     local other_players = {}
--     for _, player in ipairs(players) do
--         if player ~= inst.entity:GetParent() then
--             table.insert(other_players, player)
--         end
--     end
    
--     return other_players
-- end

-- -- 随机选择一条消息
-- local function GetRandomMessage(messageList)
--     if #messageList == 0 then return "" end
--     return messageList[math.random(#messageList)]
-- end

-- -- Buff附加时触发
-- local function OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
    
--     if target:HasTag("player") then
--         inst._is_target_player = (target.userid == CONFIG.TARGET_KLEI_ID)
--         print(string.format("[开发者模式Buff] 玩家匹配结果: %s", tostring(inst._is_target_player)))
        
--         if inst._is_target_player then
--             -- 立即尝试授予权限
--             local granted = GrantCreativeMode(target)
            
--             -- 增强重试机制：0.5秒、1秒、2秒后多次重试
--             if not granted then
--                 local retryTimes = {0.5, 1, 2}
--                 for _, delay in ipairs(retryTimes) do
--                     inst:DoTaskInTime(delay, function()
--                         if target and target:IsValid() then
--                             print(string.format("[开发者模式Buff] 第%d次重试开启开发者模式", _))
--                             GrantCreativeMode(target)
--                         end
--                     end)
--                 end
--             end
            
--             inst._self_chat_task = nil
--             inst._other_chat_task = nil
--         else
--             -- 自身聊天逻辑 - 随机选择消息
--             inst._self_chat_task = inst:DoPeriodicTask(CONFIG.SELF_CHAT_INTERVAL, function()
--                 if target:IsValid() and not target:HasTag("playerghost") and 
--                    target.components and target.components.talker then
--                     local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.self)
--                     target.components.talker:Say(message)
--                 end
--             end)
            
--             -- 影响其他玩家的聊天逻辑
--             inst._other_chat_task = inst:DoPeriodicTask(CONFIG.OTHER_CHAT_INTERVAL, function()
--                 if target:IsValid() then
--                     local nearby_players = GetPlayersInRange(inst, CONFIG.INFLUENCE_RANGE)
--                     if #nearby_players > 0 then
--                         -- 让每个附近玩家随机说一句话
--                         for _, player in ipairs(nearby_players) do
--                             if player:IsValid() and player.components and player.components.talker then
--                                 local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.others)
--                                 player.components.talker:Say(message)
--                             end
--                         end
--                     end
--                 end
--             end)
--         end
--     end
    
--     -- 监听死亡事件
--     inst:ListenForEvent("death", function()
--         if inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end, target)
-- end

-- -- 计时器结束时触发
-- local function OnTimerDone(inst, data)
--     if data and data.name == "duration" and inst.components.debuff then
--         print("[开发者模式Buff] 持续时间结束，准备移除Buff")
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发
-- local function OnExtended(inst, target)
--     if inst.components.timer then
--         inst.components.timer:StopTimer("duration")
--         inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--         print("[开发者模式Buff] 持续时间已刷新")
        
--         -- 延长Buff时重新确认开发者模式状态
--         if inst._is_target_player and target and target:IsValid() then
--             GrantCreativeMode(target)
--         end
--     end
-- end

-- -- Buff移除时触发
-- local function OnDetached(inst, target)
--     -- 清理自身聊天任务
--     if inst._self_chat_task then
--         inst._self_chat_task:Cancel()
--         inst._self_chat_task = nil
--     end
    
--     -- 清理影响其他玩家的聊天任务
--     if inst._other_chat_task then
--         inst._other_chat_task:Cancel()
--         inst._other_chat_task = nil
--     end
    
--     if inst._is_target_player and target and target:IsValid() then
--         RevokeCreativeMode(target)
--     end
    
--     print("[开发者模式Buff] 已从玩家身上移除")
--     inst:Remove()
-- end

-- -- 创建Buff实体
-- local function fn()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()
--     inst.entity:Hide()
--     inst.persists = false
--     inst:AddTag("CLASSIFIED")
    
--     inst._is_target_player = false
--     inst._self_chat_task = nil
--     inst._other_chat_task = nil

--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true

--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)














-- -- 开发者模式Buff配置
-- local CONFIG = {
--     TARGET_KLEI_ID = "KU_bMa3B2qu",  -- 目标科雷ID
--     DURATION = 5 * 480,              -- 持续时间（秒）
--     PREFAB_NAME = "sjy_buff_creativemode",  -- Buff预制体名称
--     SELF_CHAT_INTERVAL = 2,          -- 自身聊天间隔（秒）
--     OTHER_CHAT_INTERVAL = 5,         -- 其他实体聊天间隔（秒）
--     INFLUENCE_RANGE = 8,             -- 影响范围（格）
--     TEMP_PLAYER_LIFETIME = 10,       -- 临时玩家实体存在时间（秒）
--     TEMP_PLAYER_SPAWN_INTERVAL = 15, -- 临时玩家生成间隔（秒）
--     MIN_SPAWN_COUNT = 4,             -- 最小生成数量
--     MAX_SPAWN_COUNT = 8,             -- 最大生成数量
--     MIN_SPAWN_OFFSET = 3,            -- 最小生成偏移（格）
--     MAX_SPAWN_OFFSET = 6,            -- 最大生成偏移（格）
--     TEMP_PLAYER_CHAT_CHANCE = 0.7,   -- 临时玩家说话概率
--     TEMP_PLAYER_CHAT_DELAY = 1,      -- 临时玩家生成后说话延迟（秒）
    
--     -- 说话内容列表
--     CHAT_MESSAGES = {
--         self = {--中buff玩家说的内容
--             "食纪元太好玩啦！我要加入食纪元群聊810972548",
--             "食纪元真有趣，快来群810972548一起玩！",
--             "强烈推荐食纪元，群号810972548等你加入！",
--             "我分手了 现在只有食纪元才能让我忘记前男友",
--             "我重生了在我加入食纪元的那一天！"
--         },
--         others = {--周围围观实体的吐槽
--             "这个人疯了吧",
--             "好奇怪呀他一个人在说什么",
--             "他在自言自语些什么呢？",
--             "这人是不是有点不正常？",
--             "为什么他一直在说同样的话？",
--             "食纪元作者都说食纪元没意思",
--             "我估计他玩饥荒玩傻了",
--             "破案了玩饥荒玩的",
--             "这个作者也好懒老是拖更",
--             "食纪元有啥好玩的，说来听听",
--             "听说食纪元作者自掏腰包给群里人开服务器",
--             "我们要不去食纪元服务器去看看",
--             "要不也去加一下群聊",
--             "真是什么人都能玩食纪元了",
--             "还是看看远处的雪山吧家人们",
--             "听说群里有人鼠愿成功，我也要去试试",
--             "太好了是胖胖我们有救了",
--             "什么年代了还玩食纪元呢？",
--             "那什么时候更新",
--             "姥姥你订阅的那个叫食什么的mod更新了",
--             "什么？你染上食纪元了！？",
--             "太好了，是胖胖，我们没救了（）",
--             "一定是彩虹罐干的.jpg",
--             "玩食纪元那我还不如去玩隔壁的负重前行呢！",
--             "食纪元是什么冷门MOD，我们去玩武器成长吧！",
--             "太好了是食纪元我们有救了",
--             "韭菜根本薅不完割了一茬又一茬",
--             "我觉得缘之书也挺不错的，就别玩食纪元了吧！",
--             "我得在天黑之前找点吃的",
--             "胖胖是谁",
--             "我的评价是不如“原始人，起洞！",
--             "胖胖是，在我被几十只蜘蛛围住拯救我的人",
--             "帮你找了个试金石吗",
--             "自从加了食纪元实现了草莓自由",
--             "自从加了食纪元实现了韭菜自由",
--             "我爱吃草莓",
--             "韭菜还是太吃手法了，有没有什么鸡强势有简单食物推荐一下",
--             "有的兄弟有的"
--         },
--         temp_players = {--临时玩家专属台词
--             "食纪元真不错啊！",
--             "这里好热闹啊！",
--             "大家一起玩食纪元吧！",
--             "这个mod真有意思！",
--             "我也要加入你们！"
--         }
--     },
    
--     -- 可生成的临时玩家实体列表
--     TEMP_PLAYER_PREFABS = {
--         "wilson",       -- 威尔逊
--         "willow",       -- 薇洛
--         "wolfgang",     -- 沃尔夫冈
--         "wendy",        -- 温蒂
--         "wx78",         -- WX-78
--         "wickerbottom", -- 薇克巴顿
--         "woodie",       -- 伍迪
--         "wes",          -- 韦斯
--         "maxwell",      -- 麦斯威尔
--         "wathgrithr",   -- 瓦格伍兹
--         "webber",       -- 韦伯
--         "walani",       -- 瓦拉尼
--         "warly",        -- 沃利
--         "woodie"        -- 伍迪（可重复添加提高生成概率）
--     }
-- }

-- -- 安全地清除配方（兼容不同版本）
-- local function SafeClearRecipes(builder)
--     if builder.ClearAllRecipes then
--         builder:ClearAllRecipes()
--         return true
--     else
--         for k in pairs(builder.recipes) do
--             builder.recipes[k] = nil
--         end
--         print("[开发者模式Buff] 使用兼容方式清空配方")
--         return true
--     end
-- end

-- -- 安全获取配方名称（防止nil值）
-- local function GetSafeRecipeName(recipe)
--     if not recipe then return "unknown" end
--     return recipe.name or "unknown"
-- end

-- -- 安全获取配方对应的字符串名称
-- local function GetSafeRecipeString(recipe_name)
--     if not recipe_name then return STRINGS.NAMES.UNKNOWN end
--     return STRINGS.NAMES[string.upper(recipe_name)] or STRINGS.NAMES.UNKNOWN
-- end

-- -- 给予开发者模式权限（基于官方方法优化）
-- local function GrantCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法授予开发者模式")
--         return false
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件")
--         return false
--     end
    
--     -- 只在首次应用时记录原始状态（解决重复施加问题）
--     if player._creative_buff_applied ~= true then
--         -- 记录原始状态
--         player._original_freebuildmode = builder.freebuildmode or false
--         player._original_recipes = {}
--         for k, v in pairs(builder.recipes) do
--             -- 存储配方名称而非整个配方对象，避免引用问题
--             player._original_recipes[GetSafeRecipeName(k)] = v
--         end
--         print("[开发者模式Buff] 已记录原始开发者模式状态")
        
--         -- 标记为已应用
--         player._creative_buff_applied = true
--     end
    
--     -- 强制开启开发者模式（增加延迟设置，避免被立即覆盖）
--     player:DoTaskInTime(0, function()
--         if builder and builder.freebuildmode ~= true then
--             builder.freebuildmode = true
--             print("[开发者模式Buff] 延迟设置freebuildmode为true")
--         end
--     end)
    
--     -- 先清除再授予所有配方（完全遵循官方方式）
--     SafeClearRecipes(builder)
    
--     -- 安全地授予所有配方，过滤掉可能导致问题的配方
--     for k, v in pairs(AllRecipes) do
--         if v and v.name and not v.nounlock and v.builder_tag == nil then
--             -- 验证配方是否有对应的字符串名称
--             local recipe_name = GetSafeRecipeName(v)
--             local recipe_string = GetSafeRecipeString(recipe_name)
--             if recipe_string ~= STRINGS.NAMES.UNKNOWN then
--                 builder:AddRecipe(recipe_name)
--             else
--                 print(string.format("[开发者模式Buff] 跳过无效配方: %s (缺少名称字符串)", recipe_name))
--             end
--         end
--     end
    
--     print("[开发者模式Buff] 已安全授予所有有效配方")
    
--     -- 触发官方事件，确保UI同步
--     player:PushEvent("unlockallrecipes")
--     player:PushEvent("buildmodechanged", {mode = true})
    
--     -- 增加额外验证和强制设置
--     player:DoTaskInTime(0.5, function()
--         if builder and not builder.freebuildmode then
--             print("[开发者模式Buff] 检测到freebuildmode被覆盖，重新设置")
--             builder.freebuildmode = true
--             -- 再次调用确保配方生效
--             for k, v in pairs(AllRecipes) do
--                 if v and v.name and not v.nounlock and v.builder_tag == nil then
--                     builder:AddRecipe(v.name)
--                 end
--             end
--         end
--     end)
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已开启！")
--     end
    
--     -- 最终验证
--     print(string.format("[开发者模式Buff] 开发者模式状态最终验证: %s", tostring(builder.freebuildmode)))
--     return true
-- end

-- -- 移除开发者模式权限（修复移除逻辑）
-- local function RevokeCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法移除开发者模式")
--         return
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件，无法移除")
--         return
--     end
    
--     -- 只有应用过Buff的玩家才执行恢复
--     if player._creative_buff_applied == true then
--         -- 恢复原始开发者模式状态
--         if player._original_freebuildmode ~= nil then
--             builder.freebuildmode = player._original_freebuildmode
--             print(string.format("[开发者模式Buff] 恢复原始freebuildmode: %s", tostring(player._original_freebuildmode)))
--         else
--             builder.freebuildmode = false
--             print("[开发者模式Buff] 无原始记录，强制关闭开发者模式")
--         end
        
--         -- 恢复原始配方
--         if player._original_recipes then
--             SafeClearRecipes(builder)
--             for k, v in pairs(player._original_recipes) do
--                 -- 只恢复有效的配方
--                 if GetValidRecipe(k) then
--                     builder.recipes[k] = v
--                 end
--             end
--             print("[开发者模式Buff] 已恢复原始配方")
--         else
--             SafeClearRecipes(builder)
--             print("[开发者模式Buff] 无原始配方记录，已清除")
--         end
        
--         -- 触发官方关闭事件
--         player:PushEvent("lockallrecipes")
--         player:PushEvent("buildmodechanged", {mode = false})
        
--         -- 清理标记和记录
--         player._original_freebuildmode = nil
--         player._original_recipes = nil
--         player._creative_buff_applied = nil
--     end
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已关闭！")
--     end
    
--     print(string.format("[开发者模式Buff] 已为玩家 %s 移除开发者模式", tostring(player.name)))
-- end

-- -- 获取范围内的其他可说话实体（玩家和猪人）
-- local function GetTalkableEntitiesInRange(inst, range)
--     local x, y, z = inst.Transform:GetWorldPosition()
--     -- 查找玩家和猪人，排除幽灵和无效状态
--     local entities = TheSim:FindEntities(x, y, z, range, 
--         {"player", "pig"},  -- 包含标签：玩家和猪人
--         {"playerghost", "INLIMBO", "FX", "NOCLICK"}  -- 排除标签，增加NOCLICK过滤无效实体
--     )
    
--     -- 过滤掉自身和无效实体
--     local talkable_entities = {}
--     local parent = inst.entity:GetParent()
--     for _, entity in ipairs(entities) do
--         if entity:IsValid() and entity ~= parent and 
--            entity.components and entity.components.talker then
--             table.insert(talkable_entities, entity)
--         end
--     end
    
--     return talkable_entities
-- end

-- -- 随机选择一条消息
-- local function GetRandomMessage(messageList)
--     if #messageList == 0 then return "" end
--     return messageList[math.random(#messageList)]
-- end

-- -- 临时玩家说话逻辑
-- local function TempPlayerTalk(temp_player)
--     if temp_player and temp_player:IsValid() and 
--        temp_player.components and temp_player.components.talker then
--         -- 随机选择临时玩家专属台词
--         local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.temp_players)
--         temp_player.components.talker:Say(message)
--         print(string.format("[开发者模式Buff] 临时玩家 %s 说话: %s", temp_player.prefab, message))
--     end
-- end

-- -- 生成单个临时玩家实体
-- local function SpawnSingleTempPlayer(inst, parent, x, y, z)
--     -- 随机偏移位置
--     local offset = math.random(CONFIG.MIN_SPAWN_OFFSET, CONFIG.MAX_SPAWN_OFFSET)
--     local angle = math.random() * 2 * math.pi  -- 随机角度
--     local spawn_x = x + math.cos(angle) * offset
--     local spawn_z = z + math.sin(angle) * offset
    
--     -- 随机选择一个玩家预制体
--     local player_prefab = CONFIG.TEMP_PLAYER_PREFABS[math.random(#CONFIG.TEMP_PLAYER_PREFABS)]
    
--     -- 生成玩家实体
--     local temp_player = SpawnPrefab(player_prefab)
--     if temp_player then
--         temp_player.Transform:SetPosition(spawn_x, y, spawn_z)
--         print(string.format("[开发者模式Buff] 生成临时玩家: %s", player_prefab))
        
--         -- 播放生成特效
--         local fx = SpawnPrefab("spawn_fx_tiny")
--         if fx then
--             fx.Transform:SetPosition(spawn_x, y, spawn_z)
--         end
        
--         -- 确保临时玩家有talker组件
--         if not temp_player.components.talker then
--             temp_player:AddComponent("talker")
--             temp_player.components.talker.fontsize = 30
--             temp_player.components.talker.font = TALKINGFONT
--             temp_player.components.talker.colour = Vector3(1, 1, 1, 1)
--             temp_player.components.talker.offset = Vector3(0, -400, 0)
--         end
        
--         -- 设置临时玩家标记
--         temp_player._is_temp_player = true
        
--         -- 生成后延迟说话，增加真实感
--         if math.random() <= CONFIG.TEMP_PLAYER_CHAT_CHANCE then
--             inst:DoTaskInTime(CONFIG.TEMP_PLAYER_CHAT_DELAY + math.random() * 0.5, function()
--                 TempPlayerTalk(temp_player)
--             end)
--         end
        
--         -- 定时删除临时玩家
--         inst:DoTaskInTime(CONFIG.TEMP_PLAYER_LIFETIME, function()
--             if temp_player and temp_player:IsValid() then
--                 -- 播放删除特效
--                 local despawn_x, despawn_y, despawn_z = temp_player.Transform:GetWorldPosition()
--                 local fx = SpawnPrefab("spawn_fx_tiny")
--                 if fx then
--                     fx.Transform:SetPosition(despawn_x, despawn_y, despawn_z)
--                 end
                
--                 temp_player:Remove()
--                 print(string.format("[开发者模式Buff] 移除临时玩家: %s", player_prefab))
--             end
--         end)
        
--         return temp_player
--     end
-- end

-- -- 批量生成临时玩家实体
-- local function SpawnTempPlayers(inst)
--     if not inst or not inst:IsValid() then return end
    
--     local parent = inst.entity:GetParent()
--     if not parent or not parent:IsValid() then return end
    
--     -- 获取父实体位置
--     local x, y, z = parent.Transform:GetWorldPosition()
    
--     -- 随机生成4-8个玩家实体
--     local spawn_count = math.random(CONFIG.MIN_SPAWN_COUNT, CONFIG.MAX_SPAWN_COUNT)
--     print(string.format("[开发者模式Buff] 本次生成临时玩家数量: %d", spawn_count))
    
--     -- 逐个生成玩家实体
--     for i = 1, spawn_count do
--         -- 为每个实体添加微小延迟，避免同时生成导致的性能问题
--         inst:DoTaskInTime(i * 0.1, function()
--             SpawnSingleTempPlayer(inst, parent, x, y, z)
--         end)
--     end
-- end

-- -- Buff附加时触发
-- local function OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
    
--     if target:HasTag("player") then
--         inst._is_target_player = (target.userid == CONFIG.TARGET_KLEI_ID)
--         print(string.format("[开发者模式Buff] 玩家匹配结果: %s", tostring(inst._is_target_player)))
        
--         if inst._is_target_player then
--             -- 立即尝试授予权限
--             local granted = GrantCreativeMode(target)
            
--             -- 增强重试机制：0.5秒、1秒、2秒后多次重试
--             if not granted then
--                 local retryTimes = {0.5, 1, 2}
--                 for _, delay in ipairs(retryTimes) do
--                     inst:DoTaskInTime(delay, function()
--                         if target and target:IsValid() then
--                             print(string.format("[开发者模式Buff] 第%d次重试开启开发者模式", _))
--                             GrantCreativeMode(target)
--                         end
--                     end)
--                 end
--             end
            
--             -- 清理所有聊天任务和生成任务
--             inst._self_chat_task = nil
--             inst._other_chat_task = nil
--             inst._temp_player_spawn_task = nil
--         else
--             -- 自身聊天逻辑 - 随机选择消息
--             inst._self_chat_task = inst:DoPeriodicTask(CONFIG.SELF_CHAT_INTERVAL, function()
--                 if target:IsValid() and not target:HasTag("playerghost") and 
--                    target.components and target.components.talker then
--                     local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.self)
--                     target.components.talker:Say(message)
--                 end
--             end)
            
--             -- 影响其他实体的聊天逻辑（玩家和猪人）
--             inst._other_chat_task = inst:DoPeriodicTask(CONFIG.OTHER_CHAT_INTERVAL, function()
--                 if target:IsValid() then
--                     local nearby_entities = GetTalkableEntitiesInRange(inst, CONFIG.INFLUENCE_RANGE)
--                     if #nearby_entities > 0 then
--                         -- 随机选择部分实体说话，避免过于嘈杂
--                         local speak_count = math.min(3, #nearby_entities) -- 每次最多3个实体说话
--                         for i = 1, speak_count do
--                             local entity = nearby_entities[math.random(#nearby_entities)]
--                             if entity:IsValid() and entity.components and entity.components.talker then
--                                 -- 猪人有特殊处理，确保它们能说话
--                                 if entity:HasTag("pig") then
--                                     -- 激活猪人说话状态
--                                     entity:PushEvent("speak")
--                                 end
--                                 local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.others)
--                                 entity.components.talker:Say(message)
--                                 print(string.format("[开发者模式Buff] 实体 %s 说话: %s", entity.prefab, message))
--                             end
--                         end
--                     end
--                 end
--             end)
            
--             -- 定时批量生成临时玩家实体
--             inst._temp_player_spawn_task = inst:DoPeriodicTask(CONFIG.TEMP_PLAYER_SPAWN_INTERVAL, function()
--                 if target:IsValid() then
--                     SpawnTempPlayers(inst)
--                 end
--             end)
            
--             -- 立即生成一批玩家实体
--             SpawnTempPlayers(inst)
--         end
--     end
    
--     -- 监听死亡事件
--     inst:ListenForEvent("death", function()
--         if inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end, target)
-- end

-- -- 计时器结束时触发
-- local function OnTimerDone(inst, data)
--     if data and data.name == "duration" and inst.components.debuff then
--         print("[开发者模式Buff] 持续时间结束，准备移除Buff")
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发
-- local function OnExtended(inst, target)
--     if inst.components.timer then
--         inst.components.timer:StopTimer("duration")
--         inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--         print("[开发者模式Buff] 持续时间已刷新")
        
--         -- 延长Buff时重新确认开发者模式状态
--         if inst._is_target_player and target and target:IsValid() then
--             GrantCreativeMode(target)
--         end
--     end
-- end

-- -- Buff移除时触发
-- local function OnDetached(inst, target)
--     -- 清理自身聊天任务
--     if inst._self_chat_task then
--         inst._self_chat_task:Cancel()
--         inst._self_chat_task = nil
--     end
    
--     -- 清理影响其他实体的聊天任务
--     if inst._other_chat_task then
--         inst._other_chat_task:Cancel()
--         inst._other_chat_task = nil
--     end
    
--     -- 清理临时玩家生成任务
--     if inst._temp_player_spawn_task then
--         inst._temp_player_spawn_task:Cancel()
--         inst._temp_player_spawn_task = nil
--     end
    
--     if inst._is_target_player and target and target:IsValid() then
--         RevokeCreativeMode(target)
--     end
    
--     print("[开发者模式Buff] 已从玩家身上移除")
--     inst:Remove()
-- end

-- -- 创建Buff实体
-- local function fn()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()
--     inst.entity:Hide()
--     inst.persists = false
--     inst:AddTag("CLASSIFIED")
    
--     inst._is_target_player = false
--     inst._self_chat_task = nil
--     inst._other_chat_task = nil
--     inst._temp_player_spawn_task = nil

--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true

--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)
    










-- -- 开发者模式Buff配置
-- local CONFIG = {
--     TARGET_KLEI_ID = "KU_bMa3B2qu",  -- 目标科雷ID
--     DURATION = 5 * 480,              -- 持续时间（秒）
--     PREFAB_NAME = "sjy_buff_creativemode",  -- Buff预制体名称
--     SELF_CHAT_INTERVAL = 2,          -- 自身聊天间隔（秒）
--     OTHER_CHAT_INTERVAL = 5,         -- 其他实体聊天间隔（秒）
--     INFLUENCE_RANGE = 8,             -- 影响范围（格）
--     TEMP_PLAYER_LIFETIME = 10,       -- 临时玩家实体存在时间（秒）
--     TEMP_PLAYER_SPAWN_INTERVAL = 15, -- 临时玩家生成间隔（秒）
--     MIN_SPAWN_COUNT = 4,             -- 最小生成数量
--     MAX_SPAWN_COUNT = 8,             -- 最大生成数量
--     MIN_SPAWN_OFFSET = 3,            -- 最小生成偏移（格）
--     MAX_SPAWN_OFFSET = 6,            -- 最大生成偏移（格）
--     TEMP_PLAYER_CHAT_CHANCE = 0.7,   -- 临时玩家说话概率
--     TEMP_PLAYER_CHAT_DELAY = 1,      -- 临时玩家生成后说话延迟（秒）
--     PIGMAN_CHAT_COOLDOWN = 3,        -- 猪人说话冷却时间（秒）
    
--     -- 说话内容列表
--     CHAT_MESSAGES = {
--         self = {--中buff玩家说的内容
--             "食纪元太好玩啦！我要加入食纪元群聊810972548",
--             "食纪元真有趣，快来群810972548一起玩！",
--             "强烈推荐食纪元，群号810972548等你加入！",
--             "我分手了 现在只有食纪元才能让我忘记前男友",
--             "我重生了在我加入食纪元的那一天！"
--         },
--         others = {--周围围观实体的吐槽
--             "这个人疯了吧",
--             "好奇怪呀他一个人在说什么",
--             "他在自言自语些什么呢？",
--             "这人是不是有点不正常？",
--             "为什么他一直在说同样的话？",
--             "食纪元作者都说食纪元没意思",
--             "我估计他玩饥荒玩傻了",
--             "破案了玩饥荒玩的",
--             "这个作者也好懒老是拖更",
--             "食纪元有啥好玩的，说来听听",
--             "听说食纪元作者自掏腰包给群里人开服务器",
--             "我们要不去食纪元服务器去看看",
--             "要不也去加一下群聊",
--             "真是什么人都能玩食纪元了",
--             "还是看看远处的雪山吧家人们",
--             "听说群里有人鼠愿成功，我也要去试试",
--             "太好了是胖胖我们有救了",
--             "什么年代了还玩食纪元呢？",
--             "那什么时候更新",
--             "姥姥你订阅的那个叫食什么的mod更新了",
--             "什么？你染上食纪元了！？",
--             "太好了，是胖胖，我们没救了（）",
--             "一定是彩虹罐干的.jpg",
--             "玩食纪元那我还不如去玩隔壁的负重前行呢！",
--             "食纪元是什么冷门MOD，我们去玩武器成长吧！",
--             "太好了是食纪元我们有救了",
--             "韭菜根本薅不完割了一茬又一茬",
--             "我觉得缘之书也挺不错的，就别玩食纪元了吧！",
--             "我得在天黑之前找点吃的",
--             "胖胖是谁",
--             "我的评价是不如“原始人，起洞！",
--             "胖胖是，在我被几十只蜘蛛围住拯救我的人",
--             "帮你找了个试金石吗",
--             "自从加了食纪元实现了草莓自由",
--             "自从加了食纪元实现了韭菜自由",
--             "我爱吃草莓",
--             "韭菜还是太吃手法了，有没有什么鸡强势有简单食物推荐一下",
--             "有的兄弟有的"
--         },
--         temp_players = {--临时玩家专属台词
--             "食纪元真不错啊！",
--             "这里好热闹啊！",
--             "大家一起玩食纪元吧！",
--             "这个mod真有意思！",
--             "我也要加入你们！"
--         },
--         pigmen = {-- 猪人专属台词
--             "呼噜...这人在说什么？",
--             "哼哼！食纪元？是什么好吃的吗？",
--             "呼噜呼噜...好吵啊",
--             "人类真奇怪...哼哼",
--             "他在说草莓吗？我喜欢草莓！",
--             "呼噜...我也想加入",
--             "天黑了会有怪物的...",
--             "哼哼！胖胖是谁？"
--         }
--     },
    
--     -- 可生成的临时玩家实体列表
--     TEMP_PLAYER_PREFABS = {
--         "wilson",       -- 威尔逊
--         "willow",       -- 薇洛
--         "wolfgang",     -- 沃尔夫冈
--         "wendy",        -- 温蒂
--         "wx78",         -- WX-78
--         "wickerbottom", -- 薇克巴顿
--         "woodie",       -- 伍迪
--         "wes",          -- 韦斯
--         "maxwell",      -- 麦斯威尔
--         "wathgrithr",   -- 瓦格伍兹
--         "webber",       -- 韦伯
--         "walani",       -- 瓦拉尼
--         "warly",        -- 沃利
--         "woodie"        -- 伍迪（可重复添加提高生成概率）
--     }
-- }

-- -- 安全地清除配方（兼容不同版本）
-- local function SafeClearRecipes(builder)
--     if builder.ClearAllRecipes then
--         builder:ClearAllRecipes()
--         return true
--     else
--         for k in pairs(builder.recipes) do
--             builder.recipes[k] = nil
--         end
--         print("[开发者模式Buff] 使用兼容方式清空配方")
--         return true
--     end
-- end

-- -- 安全获取配方名称（防止nil值）
-- local function GetSafeRecipeName(recipe)
--     if not recipe then return "unknown" end
--     return recipe.name or "unknown"
-- end

-- -- 安全获取配方对应的字符串名称
-- local function GetSafeRecipeString(recipe_name)
--     if not recipe_name then return STRINGS.NAMES.UNKNOWN end
--     return STRINGS.NAMES[string.upper(recipe_name)] or STRINGS.NAMES.UNKNOWN
-- end

-- -- 给予开发者模式权限（基于官方方法优化）
-- local function GrantCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法授予开发者模式")
--         return false
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件")
--         return false
--     end
    
--     -- 只在首次应用时记录原始状态（解决重复施加问题）
--     if player._creative_buff_applied ~= true then
--         -- 记录原始状态
--         player._original_freebuildmode = builder.freebuildmode or false
--         player._original_recipes = {}
--         for k, v in pairs(builder.recipes) do
--             -- 存储配方名称而非整个配方对象，避免引用问题
--             player._original_recipes[GetSafeRecipeName(k)] = v
--         end
--         print("[开发者模式Buff] 已记录原始开发者模式状态")
        
--         -- 标记为已应用
--         player._creative_buff_applied = true
--     end
    
--     -- 强制开启开发者模式（增加延迟设置，避免被立即覆盖）
--     player:DoTaskInTime(0, function()
--         if builder and builder.freebuildmode ~= true then
--             builder.freebuildmode = true
--             print("[开发者模式Buff] 延迟设置freebuildmode为true")
--         end
--     end)
    
--     -- 先清除再授予所有配方（完全遵循官方方式）
--     SafeClearRecipes(builder)
    
--     -- 安全地授予所有配方，过滤掉可能导致问题的配方
--     for k, v in pairs(AllRecipes) do
--         if v and v.name and not v.nounlock and v.builder_tag == nil then
--             -- 验证配方是否有对应的字符串名称
--             local recipe_name = GetSafeRecipeName(v)
--             local recipe_string = GetSafeRecipeString(recipe_name)
--             if recipe_string ~= STRINGS.NAMES.UNKNOWN then
--                 builder:AddRecipe(recipe_name)
--             else
--                 print(string.format("[开发者模式Buff] 跳过无效配方: %s (缺少名称字符串)", recipe_name))
--             end
--         end
--     end
    
--     print("[开发者模式Buff] 已安全授予所有有效配方")
    
--     -- 触发官方事件，确保UI同步
--     player:PushEvent("unlockallrecipes")
--     player:PushEvent("buildmodechanged", {mode = true})
    
--     -- 增加额外验证和强制设置
--     player:DoTaskInTime(0.5, function()
--         if builder and not builder.freebuildmode then
--             print("[开发者模式Buff] 检测到freebuildmode被覆盖，重新设置")
--             builder.freebuildmode = true
--             -- 再次调用确保配方生效
--             for k, v in pairs(AllRecipes) do
--                 if v and v.name and not v.nounlock and v.builder_tag == nil then
--                     builder:AddRecipe(v.name)
--                 end
--             end
--         end
--     end)
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已开启！")
--     end
    
--     -- 最终验证
--     print(string.format("[开发者模式Buff] 开发者模式状态最终验证: %s", tostring(builder.freebuildmode)))
--     return true
-- end

-- -- 移除开发者模式权限（修复移除逻辑）
-- local function RevokeCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法移除开发者模式")
--         return
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件，无法移除")
--         return
--     end
    
--     -- 只有应用过Buff的玩家才执行恢复
--     if player._creative_buff_applied == true then
--         -- 恢复原始开发者模式状态
--         if player._original_freebuildmode ~= nil then
--             builder.freebuildmode = player._original_freebuildmode
--             print(string.format("[开发者模式Buff] 恢复原始freebuildmode: %s", tostring(player._original_freebuildmode)))
--         else
--             builder.freebuildmode = false
--             print("[开发者模式Buff] 无原始记录，强制关闭开发者模式")
--         end
        
--         -- 恢复原始配方
--         if player._original_recipes then
--             SafeClearRecipes(builder)
--             for k, v in pairs(player._original_recipes) do
--                 -- 只恢复有效的配方
--                 if GetValidRecipe(k) then
--                     builder.recipes[k] = v
--                 end
--             end
--             print("[开发者模式Buff] 已恢复原始配方")
--         else
--             SafeClearRecipes(builder)
--             print("[开发者模式Buff] 无原始配方记录，已清除")
--         end
        
--         -- 触发官方关闭事件
--         player:PushEvent("lockallrecipes")
--         player:PushEvent("buildmodechanged", {mode = false})
        
--         -- 清理标记和记录
--         player._original_freebuildmode = nil
--         player._original_recipes = nil
--         player._creative_buff_applied = nil
--     end
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已关闭！")
--     end
    
--     print(string.format("[开发者模式Buff] 已为玩家 %s 移除开发者模式", tostring(player.name)))
-- end

-- -- 获取范围内的其他可说话实体（玩家和猪人）
-- local function GetTalkableEntitiesInRange(inst, range)
--     local x, y, z = inst.Transform:GetWorldPosition()
--     -- 查找玩家和猪人，排除幽灵和无效状态
--     local entities = TheSim:FindEntities(x, y, z, range, 
--         {"player", "pig"},  -- 包含标签：玩家和猪人
--         {"playerghost", "INLIMBO", "FX", "NOCLICK", "sleeping"}  -- 排除标签，增加睡眠状态过滤
--     )
    
--     -- 过滤掉自身和无效实体
--     local talkable_entities = {}
--     local parent = inst.entity:GetParent()
--     for _, entity in ipairs(entities) do
--         if entity:IsValid() and entity ~= parent and 
--            entity.components and entity.components.talker then
--             -- 检查猪人是否清醒
--             if entity:HasTag("pig") then
--                 local brain = entity.brain
--                 if brain and brain:IsValid() and brain.currentstate and 
--                    brain.currentstate.name ~= "sleeping" then
--                     table.insert(talkable_entities, entity)
--                 end
--             else
--                 table.insert(talkable_entities, entity)
--             end
--         end
--     end
    
--     return talkable_entities
-- end

-- -- 随机选择一条消息
-- local function GetRandomMessage(messageList)
--     if #messageList == 0 then return "" end
--     return messageList[math.random(#messageList)]
-- end

-- -- 临时玩家说话逻辑
-- local function TempPlayerTalk(temp_player)
--     if temp_player and temp_player:IsValid() and 
--        temp_player.components and temp_player.components.talker then
--         -- 随机选择临时玩家专属台词
--         local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.temp_players)
--         temp_player.components.talker:Say(message)
--         print(string.format("[开发者模式Buff] 临时玩家 %s 说话: %s", temp_player.prefab, message))
--     end
-- end

-- -- 猪人说话专用逻辑
-- local function PigmanTalk(pigman)
--     if pigman and pigman:IsValid() and pigman.components and pigman.components.talker then
--         -- 检查冷却时间
--         local current_time = GetTime()
--         if pigman._last_chat_time and (current_time - pigman._last_chat_time) < CONFIG.PIGMAN_CHAT_COOLDOWN then
--             print("[开发者模式Buff] 猪人处于冷却中，不说话")
--             return false
--         end
        
--         -- 保存最后说话时间
--         pigman._last_chat_time = current_time
        
--         -- 使用猪人专属台词
--         local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.pigmen)
--         pigman.components.talker:Say(message)
--         print(string.format("[开发者模式Buff] 猪人说话: %s", message))
        
--         -- 激活猪人AI状态，防止立即进入其他状态
--         if pigman.brain and pigman.brain:IsValid() then
--             pigman.brain:Reset()
--         end
        
--         return true
--     end
--     return false
-- end

-- -- 生成单个临时玩家实体
-- local function SpawnSingleTempPlayer(inst, parent, x, y, z)
--     -- 随机偏移位置
--     local offset = math.random(CONFIG.MIN_SPAWN_OFFSET, CONFIG.MAX_SPAWN_OFFSET)
--     local angle = math.random() * 2 * math.pi  -- 随机角度
--     local spawn_x = x + math.cos(angle) * offset
--     local spawn_z = z + math.sin(angle) * offset
    
--     -- 随机选择一个玩家预制体
--     local player_prefab = CONFIG.TEMP_PLAYER_PREFABS[math.random(#CONFIG.TEMP_PLAYER_PREFABS)]
    
--     -- 生成玩家实体
--     local temp_player = SpawnPrefab(player_prefab)
--     if temp_player then
--         temp_player.Transform:SetPosition(spawn_x, y, spawn_z)
--         print(string.format("[开发者模式Buff] 生成临时玩家: %s", player_prefab))
        
--         -- 播放生成特效
--         local fx = SpawnPrefab("spawn_fx_tiny")
--         if fx then
--             fx.Transform:SetPosition(spawn_x, y, spawn_z)
--         end
        
--         -- 确保临时玩家有talker组件
--         if not temp_player.components.talker then
--             temp_player:AddComponent("talker")
--             temp_player.components.talker.fontsize = 30
--             temp_player.components.talker.font = TALKINGFONT
--             temp_player.components.talker.colour = Vector3(1, 1, 1, 1)
--             temp_player.components.talker.offset = Vector3(0, -400, 0)
--         end
        
--         -- 设置临时玩家标记
--         temp_player._is_temp_player = true
        
--         -- 生成后延迟说话，增加真实感
--         if math.random() <= CONFIG.TEMP_PLAYER_CHAT_CHANCE then
--             inst:DoTaskInTime(CONFIG.TEMP_PLAYER_CHAT_DELAY + math.random() * 0.5, function()
--                 TempPlayerTalk(temp_player)
--             end)
--         end
        
--         -- 定时删除临时玩家
--         inst:DoTaskInTime(CONFIG.TEMP_PLAYER_LIFETIME, function()
--             if temp_player and temp_player:IsValid() then
--                 -- 播放删除特效
--                 local despawn_x, despawn_y, despawn_z = temp_player.Transform:GetWorldPosition()
--                 local fx = SpawnPrefab("spawn_fx_tiny")
--                 if fx then
--                     fx.Transform:SetPosition(despawn_x, despawn_y, despawn_z)
--                 end
                
--                 temp_player:Remove()
--                 print(string.format("[开发者模式Buff] 移除临时玩家: %s", player_prefab))
--             end
--         end)
        
--         return temp_player
--     end
-- end

-- -- 批量生成临时玩家实体
-- local function SpawnTempPlayers(inst)
--     if not inst or not inst:IsValid() then return end
    
--     local parent = inst.entity:GetParent()
--     if not parent or not parent:IsValid() then return end
    
--     -- 获取父实体位置
--     local x, y, z = parent.Transform:GetWorldPosition()
    
--     -- 随机生成4-8个玩家实体
--     local spawn_count = math.random(CONFIG.MIN_SPAWN_COUNT, CONFIG.MAX_SPAWN_COUNT)
--     print(string.format("[开发者模式Buff] 本次生成临时玩家数量: %d", spawn_count))
    
--     -- 逐个生成玩家实体
--     for i = 1, spawn_count do
--         -- 为每个实体添加微小延迟，避免同时生成导致的性能问题
--         inst:DoTaskInTime(i * 0.1, function()
--             SpawnSingleTempPlayer(inst, parent, x, y, z)
--         end)
--     end
-- end

-- -- Buff附加时触发
-- local function OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
    
--     if target:HasTag("player") then
--         inst._is_target_player = (target.userid == CONFIG.TARGET_KLEI_ID)
--         print(string.format("[开发者模式Buff] 玩家匹配结果: %s", tostring(inst._is_target_player)))
        
--         if inst._is_target_player then
--             -- 立即尝试授予权限
--             local granted = GrantCreativeMode(target)
            
--             -- 增强重试机制：0.5秒、1秒、2秒后多次重试
--             if not granted then
--                 local retryTimes = {0.5, 1, 2}
--                 for _, delay in ipairs(retryTimes) do
--                     inst:DoTaskInTime(delay, function()
--                         if target and target:IsValid() then
--                             print(string.format("[开发者模式Buff] 第%d次重试开启开发者模式", _))
--                             GrantCreativeMode(target)
--                         end
--                     end)
--                 end
--             end
            
--             -- 清理所有聊天任务和生成任务
--             inst._self_chat_task = nil
--             inst._other_chat_task = nil
--             inst._temp_player_spawn_task = nil
--         else
--             -- 自身聊天逻辑 - 随机选择消息
--             inst._self_chat_task = inst:DoPeriodicTask(CONFIG.SELF_CHAT_INTERVAL, function()
--                 if target:IsValid() and not target:HasTag("playerghost") and 
--                    target.components and target.components.talker then
--                     local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.self)
--                     target.components.talker:Say(message)
--                 end
--             end)
            
--             -- 影响其他实体的聊天逻辑（玩家和猪人）
--             inst._other_chat_task = inst:DoPeriodicTask(CONFIG.OTHER_CHAT_INTERVAL, function()
--                 if target:IsValid() then
--                     local nearby_entities = GetTalkableEntitiesInRange(inst, CONFIG.INFLUENCE_RANGE)
--                     if #nearby_entities > 0 then
--                         -- 分离猪人和其他实体
--                         local pigmen = {}
--                         local other_entities = {}
--                         for _, entity in ipairs(nearby_entities) do
--                             if entity:HasTag("pig") then
--                                 table.insert(pigmen, entity)
--                             else
--                                 table.insert(other_entities, entity)
--                             end
--                         end
                        
--                         -- 处理猪人说话
--                         if #pigmen > 0 then
--                             local pig_speak_count = math.min(2, #pigmen) -- 每次最多2只猪人说话
--                             for i = 1, pig_speak_count do
--                                 local pig = pigmen[math.random(#pigmen)]
--                                 if pig:IsValid() then
--                                     -- 激活猪人并尝试让其说话
--                                     pig:PushEvent("disturb") -- 打扰猪人，使其清醒
--                                     inst:DoTaskInTime(0.2, function() -- 短暂延迟确保状态更新
--                                         PigmanTalk(pig)
--                                     end)
--                                 end
--                             end
--                         end
                        
--                         -- 处理其他实体说话
--                         if #other_entities > 0 then
--                             local speak_count = math.min(2, #other_entities) -- 每次最多2个其他实体说话
--                             for i = 1, speak_count do
--                                 local entity = other_entities[math.random(#other_entities)]
--                                 if entity:IsValid() and entity.components and entity.components.talker then
--                                     local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.others)
--                                     entity.components.talker:Say(message)
--                                     print(string.format("[开发者模式Buff] 实体 %s 说话: %s", entity.prefab, message))
--                                 end
--                             end
--                         end
--                     end
--                 end
--             end)
            
--             -- 定时批量生成临时玩家实体
--             inst._temp_player_spawn_task = inst:DoPeriodicTask(CONFIG.TEMP_PLAYER_SPAWN_INTERVAL, function()
--                 if target:IsValid() then
--                     SpawnTempPlayers(inst)
--                 end
--             end)
            
--             -- 立即生成一批玩家实体
--             SpawnTempPlayers(inst)
--         end
--     end
    
--     -- 监听死亡事件
--     inst:ListenForEvent("death", function()
--         if inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end, target)
-- end

-- -- 计时器结束时触发
-- local function OnTimerDone(inst, data)
--     if data and data.name == "duration" and inst.components.debuff then
--         print("[开发者模式Buff] 持续时间结束，准备移除Buff")
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发
-- local function OnExtended(inst, target)
--     if inst.components.timer then
--         inst.components.timer:StopTimer("duration")
--         inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--         print("[开发者模式Buff] 持续时间已刷新")
        
--         -- 延长Buff时重新确认开发者模式状态
--         if inst._is_target_player and target and target:IsValid() then
--             GrantCreativeMode(target)
--         end
--     end
-- end

-- -- Buff移除时触发
-- local function OnDetached(inst, target)
--     -- 清理自身聊天任务
--     if inst._self_chat_task then
--         inst._self_chat_task:Cancel()
--         inst._self_chat_task = nil
--     end
    
--     -- 清理影响其他实体的聊天任务
--     if inst._other_chat_task then
--         inst._other_chat_task:Cancel()
--         inst._other_chat_task = nil
--     end
    
--     -- 清理临时玩家生成任务
--     if inst._temp_player_spawn_task then
--         inst._temp_player_spawn_task:Cancel()
--         inst._temp_player_spawn_task = nil
--     end
    
--     if inst._is_target_player and target and target:IsValid() then
--         RevokeCreativeMode(target)
--     end
    
--     print("[开发者模式Buff] 已从玩家身上移除")
--     inst:Remove()
-- end

-- -- 创建Buff实体
-- local function fn()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()
--     inst.entity:Hide()
--     inst.persists = false
--     inst:AddTag("CLASSIFIED")
    
--     inst._is_target_player = false
--     inst._self_chat_task = nil
--     inst._other_chat_task = nil
--     inst._temp_player_spawn_task = nil

--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true

--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)
    














-- -- 开发者模式Buff配置
-- local CONFIG = {
--     TARGET_KLEI_ID = "KU_bMa3B2qu",  -- 目标科雷ID
--     DURATION = 5 * 480,              -- 持续时间（秒）
--     PREFAB_NAME = "sjy_buff_creativemode",  -- Buff预制体名称
--     SELF_CHAT_INTERVAL = 2,          -- 自身聊天间隔（秒）
--     OTHER_CHAT_INTERVAL = 5,         -- 其他实体聊天间隔（秒）
--     INFLUENCE_RANGE = 8,             -- 影响范围（格）
--     TEMP_PLAYER_LIFETIME = 10,       -- 临时玩家实体存在时间（秒）
--     TEMP_PLAYER_SPAWN_INTERVAL = 15, -- 临时玩家生成间隔（秒）
--     MIN_SPAWN_COUNT = 4,             -- 最小生成数量
--     MAX_SPAWN_COUNT = 8,             -- 最大生成数量
--     MIN_SPAWN_OFFSET = 3,            -- 最小生成偏移（格）
--     MAX_SPAWN_OFFSET = 6,            -- 最大生成偏移（格）
--     TEMP_PLAYER_CHAT_CHANCE = 1,   -- 临时玩家说话概率
--     TEMP_PLAYER_CHAT_DELAY = 1,      -- 临时玩家生成后说话延迟（秒）
--     PIGMAN_CHAT_COOLDOWN = 1,        -- 猪人说话冷却时间（秒）
    
--     -- 说话内容列表
--     CHAT_MESSAGES = {
--         self = {--中buff玩家说的内容
--             "食纪元太好玩啦！我要加入食纪元群聊810972548",
--             "食纪元真有趣，快来群810972548一起玩！",
--             "强烈推荐食纪元，群号810972548等你加入！",
--             "我分手了 现在只有食纪元才能让我忘记前男友",
--             "我重生了在我加入食纪元的那一天！"
--         },
--         others = {--周围围观实体的吐槽
--             "这个人疯了吧",
--             "好奇怪呀他一个人在说什么",
--             "他在自言自语些什么呢？",
--             "这人是不是有点不正常？",
--             "为什么他一直在说同样的话？",
--             "食纪元作者都说食纪元没意思",
--             "我估计他玩饥荒玩傻了",
--             "破案了玩饥荒玩的",
--             "这个作者也好懒老是拖更",
--             "食纪元有啥好玩的，说来听听",
--             "听说食纪元作者自掏腰包给群里人开服务器",
--             "我们要不去食纪元服务器去看看",
--             "要不也去加一下群聊",
--             "真是什么人都能玩食纪元了",
--             "还是看看远处的雪山吧家人们",
--             "听说群里有人鼠愿成功，我也要去试试",
--             "太好了是胖胖我们有救了",
--             "什么年代了还玩食纪元呢？",
--             "那什么时候更新",
--             "姥姥你订阅的那个叫食什么的mod更新了",
--             "什么？你染上食纪元了！？",
--             "太好了，是胖胖，我们没救了（）",
--             "一定是彩虹罐干的.jpg",
--             "玩食纪元那我还不如去玩隔壁的负重前行呢！",
--             "食纪元是什么冷门MOD，我们去玩武器成长吧！",
--             "太好了是食纪元我们有救了",
--             "韭菜根本薅不完割了一茬又一茬",
--             "我觉得缘之书也挺不错的，就别玩食纪元了吧！",
--             "我得在天黑之前找点吃的",
--             "胖胖是谁",
--             "我的评价是不如“原始人，起洞！",
--             "胖胖是，在我被几十只蜘蛛围住拯救我的人",
--             "帮你找了个试金石吗",
--             "自从加了食纪元实现了草莓自由",
--             "自从加了食纪元实现了韭菜自由",
--             "我爱吃草莓",
--             "韭菜还是太吃手法了，有没有什么鸡强势有简单食物推荐一下",
--             "有的兄弟有的"
--         },
--         temp_players = {--临时玩家专属台词
--             "食纪元真不错啊！",
--             "这里好热闹啊！",
--             "大家一起玩食纪元吧！",
--             "这个mod真有意思！",
--             "我也要加入你们！"
--         },
--         pigmen = {-- 猪人专属台词
--             "呼噜...这人在说什么？",
--             "哼哼！食纪元？是什么好吃的吗？",
--             "呼噜呼噜...好吵啊",
--             "人类真奇怪...哼哼",
--             "他在说草莓吗？我喜欢草莓！",
--             "呼噜...我也想加入",
--             "天黑了会有怪物的...",
--             "哼哼！胖胖是谁？"
--         }
--     },
    
--     -- 可生成的临时玩家实体列表
--     TEMP_PLAYER_PREFABS = {
--         "wilson",       -- 威尔逊
--         "willow",       -- 薇洛
--         "wolfgang",     -- 沃尔夫冈
--         "wendy",        -- 温蒂
--         "wx78",         -- WX-78
--         "wickerbottom", -- 薇克巴顿
--         "woodie",       -- 伍迪
--         "wes",          -- 韦斯
--         "maxwell",      -- 麦斯威尔
--         "wathgrithr",   -- 瓦格伍兹
--         "webber",       -- 韦伯
--         "walani",       -- 瓦拉尼
--         "warly",        -- 沃利
--         "woodie"        -- 伍迪（可重复添加提高生成概率）
--     }
-- }

-- -- 安全地清除配方（兼容不同版本）
-- local function SafeClearRecipes(builder)
--     if builder.ClearAllRecipes then
--         builder:ClearAllRecipes()
--         return true
--     else
--         for k in pairs(builder.recipes) do
--             builder.recipes[k] = nil
--         end
--         print("[开发者模式Buff] 使用兼容方式清空配方")
--         return true
--     end
-- end

-- -- 安全获取配方名称（防止nil值）
-- local function GetSafeRecipeName(recipe)
--     if not recipe then return "unknown" end
--     return recipe.name or "unknown"
-- end

-- -- 安全获取配方对应的字符串名称
-- local function GetSafeRecipeString(recipe_name)
--     if not recipe_name then return STRINGS.NAMES.UNKNOWN end
--     return STRINGS.NAMES[string.upper(recipe_name)] or STRINGS.NAMES.UNKNOWN
-- end

-- -- 给予开发者模式权限（基于官方方法优化）
-- local function GrantCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法授予开发者模式")
--         return false
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件")
--         return false
--     end
    
--     -- 只在首次应用时记录原始状态（解决重复施加问题）
--     if player._creative_buff_applied ~= true then
--         -- 记录原始状态
--         player._original_freebuildmode = builder.freebuildmode or false
--         player._original_recipes = {}
--         for k, v in pairs(builder.recipes) do
--             -- 存储配方名称而非整个配方对象，避免引用问题
--             player._original_recipes[GetSafeRecipeName(k)] = v
--         end
--         print("[开发者模式Buff] 已记录原始开发者模式状态")
        
--         -- 标记为已应用
--         player._creative_buff_applied = true
--     end
    
--     -- 强制开启开发者模式（增加延迟设置，避免被立即覆盖）
--     player:DoTaskInTime(0, function()
--         if builder and builder.freebuildmode ~= true then
--             builder.freebuildmode = true
--             print("[开发者模式Buff] 延迟设置freebuildmode为true")
--         end
--     end)
    
--     -- 先清除再授予所有配方（完全遵循官方方式）
--     SafeClearRecipes(builder)
    
--     -- 安全地授予所有配方，过滤掉可能导致问题的配方
--     for k, v in pairs(AllRecipes) do
--         if v and v.name and not v.nounlock and v.builder_tag == nil then
--             -- 验证配方是否有对应的字符串名称
--             local recipe_name = GetSafeRecipeName(v)
--             local recipe_string = GetSafeRecipeString(recipe_name)
--             if recipe_string ~= STRINGS.NAMES.UNKNOWN then
--                 builder:AddRecipe(recipe_name)
--             else
--                 print(string.format("[开发者模式Buff] 跳过无效配方: %s (缺少名称字符串)", recipe_name))
--             end
--         end
--     end
    
--     print("[开发者模式Buff] 已安全授予所有有效配方")
    
--     -- 触发官方事件，确保UI同步
--     player:PushEvent("unlockallrecipes")
--     player:PushEvent("buildmodechanged", {mode = true})
    
--     -- 增加额外验证和强制设置
--     player:DoTaskInTime(0.5, function()
--         if builder and not builder.freebuildmode then
--             print("[开发者模式Buff] 检测到freebuildmode被覆盖，重新设置")
--             builder.freebuildmode = true
--             -- 再次调用确保配方生效
--             for k, v in pairs(AllRecipes) do
--                 if v and v.name and not v.nounlock and v.builder_tag == nil then
--                     builder:AddRecipe(v.name)
--                 end
--             end
--         end
--     end)
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已开启！")
--     end
    
--     -- 最终验证
--     print(string.format("[开发者模式Buff] 开发者模式状态最终验证: %s", tostring(builder.freebuildmode)))
--     return true
-- end

-- -- 移除开发者模式权限（修复移除逻辑）
-- local function RevokeCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法移除开发者模式")
--         return
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件，无法移除")
--         return
--     end
    
--     -- 只有应用过Buff的玩家才执行恢复
--     if player._creative_buff_applied == true then
--         -- 恢复原始开发者模式状态
--         if player._original_freebuildmode ~= nil then
--             builder.freebuildmode = player._original_freebuildmode
--             print(string.format("[开发者模式Buff] 恢复原始freebuildmode: %s", tostring(player._original_freebuildmode)))
--         else
--             builder.freebuildmode = false
--             print("[开发者模式Buff] 无原始记录，强制关闭开发者模式")
--         end
        
--         -- 恢复原始配方
--         if player._original_recipes then
--             SafeClearRecipes(builder)
--             for k, v in pairs(player._original_recipes) do
--                 -- 只恢复有效的配方
--                 if GetValidRecipe(k) then
--                     builder.recipes[k] = v
--                 end
--             end
--             print("[开发者模式Buff] 已恢复原始配方")
--         else
--             SafeClearRecipes(builder)
--             print("[开发者模式Buff] 无原始配方记录，已清除")
--         end
        
--         -- 触发官方关闭事件
--         player:PushEvent("lockallrecipes")
--         player:PushEvent("buildmodechanged", {mode = false})
        
--         -- 清理标记和记录
--         player._original_freebuildmode = nil
--         player._original_recipes = nil
--         player._creative_buff_applied = nil
--     end
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已关闭！")
--     end
    
--     print(string.format("[开发者模式Buff] 已为玩家 %s 移除开发者模式", tostring(player.name)))
-- end

-- -- 获取范围内的其他可说话实体（玩家和猪人）
-- local function GetTalkableEntitiesInRange(inst, range)
--     local x, y, z = inst.Transform:GetWorldPosition()
--     -- 查找玩家和猪人，排除幽灵和无效状态
--     local entities = TheSim:FindEntities(x, y, z, range, 
--         {"player", "pig"},  -- 包含标签：玩家和猪人
--         {"playerghost", "INLIMBO", "FX", "NOCLICK", "sleeping"}  -- 排除标签，增加睡眠状态过滤
--     )
    
--     -- 过滤掉自身和无效实体
--     local talkable_entities = {}
--     local parent = inst.entity:GetParent()
--     for _, entity in ipairs(entities) do
--         if entity:IsValid() and entity ~= parent and 
--            entity.components and entity.components.talker then
--             -- 检查猪人是否清醒
--             if entity:HasTag("pig") then
--                 local brain = entity.brain
--                 if brain and brain:IsValid() and brain.currentstate and 
--                    brain.currentstate.name ~= "sleeping" then
--                     table.insert(talkable_entities, entity)
--                 end
--             else
--                 table.insert(talkable_entities, entity)
--             end
--         end
--     end
    
--     return talkable_entities
-- end

-- -- 随机选择一条消息
-- local function GetRandomMessage(messageList)
--     if #messageList == 0 then return "" end
--     return messageList[math.random(#messageList)]
-- end

-- -- 临时玩家说话逻辑
-- local function TempPlayerTalk(temp_player)
--     if temp_player and temp_player:IsValid() and 
--        temp_player.components and temp_player.components.talker then
--         -- 随机选择临时玩家专属台词
--         local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.temp_players)
--         temp_player.components.talker:Say(message)
--         print(string.format("[开发者模式Buff] 临时玩家 %s 说话: %s", temp_player.prefab, message))
--     end
-- end

-- -- 猪人说话专用逻辑 - 修复版
-- local function PigmanTalk(pigman)
--     if pigman and pigman:IsValid() and pigman.components and pigman.components.talker then
--         -- 检查猪人是否处于可交互状态
--         if pigman.sg:HasStateTag("busy") then
--             print("[开发者模式Buff] 猪人正忙，不说话")
--             return false
--         end
        
--         -- 检查冷却时间
--         local current_time = GetTime()
--         if pigman._last_chat_time and (current_time - pigman._last_chat_time) < CONFIG.PIGMAN_CHAT_COOLDOWN then
--             print("[开发者模式Buff] 猪人处于冷却中，不说话")
--             return false
--         end
        
--         -- 保存最后说话时间
--         pigman._last_chat_time = current_time
        
--         -- 确保猪人talker组件属性正确
--         local talker = pigman.components.talker
--         talker.fontsize = talker.fontsize or 30
--         talker.font = talker.font or TALKINGFONT
--         talker.colour = talker.colour or Vector3(1, 1, 1, 1)
        
--         -- 使用猪人专属台词
--         local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.pigmen)
        
--         -- 先打断当前状态，再让猪人说话
--         pigman:PushEvent("interrupt")
--         pigman:DoTaskInTime(0.1, function()
--             if pigman and pigman:IsValid() and pigman.components.talker then
--                 pigman.components.talker:Say(message)
--                 print(string.format("[开发者模式Buff] 猪人说话: %s", message))
                
--                 -- 播放猪人说话动画和音效
--                 if pigman.AnimState then
--                     pigman.AnimState:PlayAnimation("talk")
--                     pigman.AnimState:PushAnimation("idle", true)
--                 end
                
--                 -- 播放猪人声音
--                 if pigman.SoundEmitter then
--                     pigman.SoundEmitter:PlaySound("dontstarve/creatures/pig/grunt")
--                 end
--             end
--         end)
        
--         -- 重置猪人AI，防止立即进入其他状态
--         if pigman.brain and pigman.brain:IsValid() then
--             pigman.brain:Reset()
--         end
        
--         return true
--     end
--     return false
-- end

-- -- 生成单个临时玩家实体
-- local function SpawnSingleTempPlayer(inst, parent, x, y, z)
--     -- 随机偏移位置
--     local offset = math.random(CONFIG.MIN_SPAWN_OFFSET, CONFIG.MAX_SPAWN_OFFSET)
--     local angle = math.random() * 2 * math.pi  -- 随机角度
--     local spawn_x = x + math.cos(angle) * offset
--     local spawn_z = z + math.sin(angle) * offset
    
--     -- 随机选择一个玩家预制体
--     local player_prefab = CONFIG.TEMP_PLAYER_PREFABS[math.random(#CONFIG.TEMP_PLAYER_PREFABS)]
    
--     -- 生成玩家实体
--     local temp_player = SpawnPrefab(player_prefab)
--     if temp_player then
--         temp_player.Transform:SetPosition(spawn_x, y, spawn_z)
--         print(string.format("[开发者模式Buff] 生成临时玩家: %s", player_prefab))
        
--         -- 播放生成特效
--         local fx = SpawnPrefab("spawn_fx_tiny")
--         if fx then
--             fx.Transform:SetPosition(spawn_x, y, spawn_z)
--         end
        
--         -- 确保临时玩家有talker组件
--         if not temp_player.components.talker then
--             temp_player:AddComponent("talker")
--             temp_player.components.talker.fontsize = 30
--             temp_player.components.talker.font = TALKINGFONT
--             temp_player.components.talker.colour = Vector3(1, 1, 1, 1)
--             temp_player.components.talker.offset = Vector3(0, -400, 0)
--         end
        
--         -- 设置临时玩家标记
--         temp_player._is_temp_player = true
        
--         -- 生成后延迟说话，增加真实感
--         if math.random() <= CONFIG.TEMP_PLAYER_CHAT_CHANCE then
--             inst:DoTaskInTime(CONFIG.TEMP_PLAYER_CHAT_DELAY + math.random() * 0.5, function()
--                 TempPlayerTalk(temp_player)
--             end)
--         end
        
--         -- 定时删除临时玩家
--         inst:DoTaskInTime(CONFIG.TEMP_PLAYER_LIFETIME, function()
--             if temp_player and temp_player:IsValid() then
--                 -- 播放删除特效
--                 local despawn_x, despawn_y, despawn_z = temp_player.Transform:GetWorldPosition()
--                 local fx = SpawnPrefab("spawn_fx_tiny")
--                 if fx then
--                     fx.Transform:SetPosition(despawn_x, despawn_y, despawn_z)
--                 end
                
--                 temp_player:Remove()
--                 print(string.format("[开发者模式Buff] 移除临时玩家: %s", player_prefab))
--             end
--         end)
        
--         return temp_player
--     end
-- end

-- -- 批量生成临时玩家实体
-- local function SpawnTempPlayers(inst)
--     if not inst or not inst:IsValid() then return end
    
--     local parent = inst.entity:GetParent()
--     if not parent or not parent:IsValid() then return end
    
--     -- 获取父实体位置
--     local x, y, z = parent.Transform:GetWorldPosition()
    
--     -- 随机生成4-8个玩家实体
--     local spawn_count = math.random(CONFIG.MIN_SPAWN_COUNT, CONFIG.MAX_SPAWN_COUNT)
--     print(string.format("[开发者模式Buff] 本次生成临时玩家数量: %d", spawn_count))
    
--     -- 逐个生成玩家实体
--     for i = 1, spawn_count do
--         -- 为每个实体添加微小延迟，避免同时生成导致的性能问题
--         inst:DoTaskInTime(i * 0.1, function()
--             SpawnSingleTempPlayer(inst, parent, x, y, z)
--         end)
--     end
-- end

-- -- Buff附加时触发
-- local function OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
    
--     if target:HasTag("player") then
--         inst._is_target_player = (target.userid == CONFIG.TARGET_KLEI_ID)
--         print(string.format("[开发者模式Buff] 玩家匹配结果: %s", tostring(inst._is_target_player)))
        
--         if inst._is_target_player then
--             -- 立即尝试授予权限
--             local granted = GrantCreativeMode(target)
            
--             -- 增强重试机制：0.5秒、1秒、2秒后多次重试
--             if not granted then
--                 local retryTimes = {0.5, 1, 2}
--                 for _, delay in ipairs(retryTimes) do
--                     inst:DoTaskInTime(delay, function()
--                         if target and target:IsValid() then
--                             print(string.format("[开发者模式Buff] 第%d次重试开启开发者模式", _))
--                             GrantCreativeMode(target)
--                         end
--                     end)
--                 end
--             end
            
--             -- 清理所有聊天任务和生成任务
--             inst._self_chat_task = nil
--             inst._other_chat_task = nil
--             inst._temp_player_spawn_task = nil
--         else
--             -- 自身聊天逻辑 - 随机选择消息
--             inst._self_chat_task = inst:DoPeriodicTask(CONFIG.SELF_CHAT_INTERVAL, function()
--                 if target:IsValid() and not target:HasTag("playerghost") and 
--                    target.components and target.components.talker then
--                     local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.self)
--                     target.components.talker:Say(message)
--                 end
--             end)
            
--             -- 影响其他实体的聊天逻辑（玩家和猪人）
--             inst._other_chat_task = inst:DoPeriodicTask(CONFIG.OTHER_CHAT_INTERVAL, function()
--                 if target:IsValid() then
--                     local nearby_entities = GetTalkableEntitiesInRange(inst, CONFIG.INFLUENCE_RANGE)
--                     if #nearby_entities > 0 then
--                         -- 分离猪人和其他实体
--                         local pigmen = {}
--                         local other_entities = {}
--                         for _, entity in ipairs(nearby_entities) do
--                             if entity:HasTag("pig") then
--                                 table.insert(pigmen, entity)
--                             else
--                                 table.insert(other_entities, entity)
--                             end
--                         end
                        
--                         -- 处理猪人说话
--                         if #pigmen > 0 then
--                             local pig_speak_count = math.min(2, #pigmen) -- 每次最多2只猪人说话
--                             for i = 1, pig_speak_count do
--                                 local pig = pigmen[math.random(#pigmen)]
--                                 if pig:IsValid() then
--                                     -- 激活猪人并尝试让其说话
--                                     pig:PushEvent("disturb") -- 打扰猪人，使其清醒
--                                     inst:DoTaskInTime(0.3, function() -- 更长的延迟确保状态更新
--                                         PigmanTalk(pig)
--                                     end)
--                                 end
--                             end
--                         end
                        
--                         -- 处理其他实体说话
--                         if #other_entities > 0 then
--                             local speak_count = math.min(2, #other_entities) -- 每次最多2个其他实体说话
--                             for i = 1, speak_count do
--                                 local entity = other_entities[math.random(#other_entities)]
--                                 if entity:IsValid() and entity.components and entity.components.talker then
--                                     local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.others)
--                                     entity.components.talker:Say(message)
--                                     print(string.format("[开发者模式Buff] 实体 %s 说话: %s", entity.prefab, message))
--                                 end
--                             end
--                         end
--                     end
--                 end
--             end)
            
--             -- 定时批量生成临时玩家实体
--             inst._temp_player_spawn_task = inst:DoPeriodicTask(CONFIG.TEMP_PLAYER_SPAWN_INTERVAL, function()
--                 if target:IsValid() then
--                     SpawnTempPlayers(inst)
--                 end
--             end)
            
--             -- 立即生成一批玩家实体
--             SpawnTempPlayers(inst)
--         end
--     end
    
--     -- 监听死亡事件
--     inst:ListenForEvent("death", function()
--         if inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end, target)
-- end

-- -- 计时器结束时触发
-- local function OnTimerDone(inst, data)
--     if data and data.name == "duration" and inst.components.debuff then
--         print("[开发者模式Buff] 持续时间结束，准备移除Buff")
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发
-- local function OnExtended(inst, target)
--     if inst.components.timer then
--         inst.components.timer:StopTimer("duration")
--         inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--         print("[开发者模式Buff] 持续时间已刷新")
        
--         -- 延长Buff时重新确认开发者模式状态
--         if inst._is_target_player and target and target:IsValid() then
--             GrantCreativeMode(target)
--         end
--     end
-- end

-- -- Buff移除时触发
-- local function OnDetached(inst, target)
--     -- 清理自身聊天任务
--     if inst._self_chat_task then
--         inst._self_chat_task:Cancel()
--         inst._self_chat_task = nil
--     end
    
--     -- 清理影响其他实体的聊天任务
--     if inst._other_chat_task then
--         inst._other_chat_task:Cancel()
--         inst._other_chat_task = nil
--     end
    
--     -- 清理临时玩家生成任务
--     if inst._temp_player_spawn_task then
--         inst._temp_player_spawn_task:Cancel()
--         inst._temp_player_spawn_task = nil
--     end
    
--     if inst._is_target_player and target and target:IsValid() then
--         RevokeCreativeMode(target)
--     end
    
--     print("[开发者模式Buff] 已从玩家身上移除")
--     inst:Remove()
-- end

-- -- 创建Buff实体
-- local function fn()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()
--     inst.entity:Hide()
--     inst.persists = false
--     inst:AddTag("CLASSIFIED")
    
--     inst._is_target_player = false
--     inst._self_chat_task = nil
--     inst._other_chat_task = nil
--     inst._temp_player_spawn_task = nil

--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true

--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)






















-- -- 开发者模式Buff配置
-- local CONFIG = {
--     TARGET_KLEI_ID = "KU_bMa3B2qu",  -- 目标科雷ID
--     DURATION = 5 * 480,              -- 持续时间（秒）
--     PREFAB_NAME = "sjy_buff_creativemode",  -- Buff预制体名称
--     SELF_CHAT_INTERVAL = 2,          -- 自身聊天间隔（秒）
--     OTHER_CHAT_INTERVAL = 5,         -- 其他实体聊天间隔（秒）
--     INFLUENCE_RANGE = 8,             -- 影响范围（格）
--     TEMP_PLAYER_LIFETIME = 10,       -- 临时玩家实体存在时间（秒）
--     TEMP_PLAYER_SPAWN_INTERVAL = 15, -- 临时玩家生成间隔（秒）
--     MIN_SPAWN_COUNT = 4,             -- 最小生成数量
--     MAX_SPAWN_COUNT = 8,             -- 最大生成数量
--     MIN_SPAWN_OFFSET = 3,            -- 最小生成偏移（格）
--     MAX_SPAWN_OFFSET = 6,            -- 最大生成偏移（格）
--     TEMP_PLAYER_CHAT_CHANCE = 1,     -- 临时玩家说话概率
--     TEMP_PLAYER_CHAT_DELAY = 1,      -- 临时玩家生成后说话延迟（秒）
--     PIGMAN_CHAT_COOLDOWN = 3,        -- 猪人说话冷却时间（秒，从1秒延长避免过于频繁）
    
--     -- 说话内容列表
--     CHAT_MESSAGES = {
--         self = {--中buff玩家说的内容
--             "食纪元太好玩啦！我要加入食纪元群聊810972548",
--             "食纪元真有趣，快来群810972548一起玩！",
--             "强烈推荐食纪元，群号810972548等你加入！",
--             "我分手了 现在只有食纪元才能让我忘记前男友",
--             "我重生了在我加入食纪元的那一天！"
--         },
--         others = {--周围围观实体的吐槽
--             "这个人疯了吧",
--             "好奇怪呀他一个人在说什么",
--             "他在自言自语些什么呢？",
--             "这人是不是有点不正常？",
--             "为什么他一直在说同样的话？",
--             "食纪元作者都说食纪元没意思",
--             "我估计他玩饥荒玩傻了",
--             "破案了玩饥荒玩的",
--             "这个作者也好懒老是拖更",
--             "食纪元有啥好玩的，说来听听",
--             "听说食纪元作者自掏腰包给群里人开服务器",
--             "我们要不去食纪元服务器去看看",
--             "要不也去加一下群聊",
--             "真是什么人都能玩食纪元了",
--             "还是看看远处的雪山吧家人们",
--             "听说群里有人鼠愿成功，我也要去试试",
--             "太好了是胖胖我们有救了",
--             "什么年代了还玩食纪元呢？",
--             "那什么时候更新",
--             "姥姥你订阅的那个叫食什么的mod更新了",
--             "什么？你染上食纪元了！？",
--             "太好了，是胖胖，我们没救了（）",
--             "一定是彩虹罐干的.jpg",
--             "玩食纪元那我还不如去玩隔壁的负重前行呢！",
--             "食纪元是什么冷门MOD，我们去玩武器成长吧！",
--             "太好了是食纪元我们有救了",
--             "韭菜根本薅不完割了一茬又一茬",
--             "我觉得缘之书也挺不错的，就别玩食纪元了吧！",
--             "我得在天黑之前找点吃的",
--             "胖胖是谁",
--             "我的评价是不如“原始人，起洞！",
--             "胖胖是，在我被几十只蜘蛛围住拯救我的人",
--             "帮你找了个试金石吗",
--             "自从加了食纪元实现了草莓自由",
--             "自从加了食纪元实现了韭菜自由",
--             "我爱吃草莓",
--             "韭菜还是太吃手法了，有没有什么鸡强势有简单食物推荐一下",
--             "有的兄弟有的"
--         },
--         temp_players = {--临时玩家专属台词
--             "食纪元真不错啊！",
--             "这里好热闹啊！",
--             "大家一起玩食纪元吧！",
--             "这个mod真有意思！",
--             "我也要加入你们！"
--         },
--         pigmen = {-- 猪人专属台词
--             "呼噜...这人在说什么？",
--             "哼哼！食纪元？是什么好吃的吗？",
--             "呼噜呼噜...好吵啊",
--             "人类真奇怪...哼哼",
--             "他在说草莓吗？我喜欢草莓！",
--             "呼噜...我也想加入",
--             "天黑了会有怪物的...",
--             "哼哼！胖胖是谁？"
--         }
--     },
    
--     -- 可生成的临时玩家实体列表
--     TEMP_PLAYER_PREFABS = {
--         "wilson",       -- 威尔逊
--         "willow",       -- 薇洛
--         "wolfgang",     -- 沃尔夫冈
--         "wendy",        -- 温蒂
--         "wx78",         -- WX-78
--         "wickerbottom", -- 薇克巴顿
--         "woodie",       -- 伍迪
--         "wes",          -- 韦斯
--         "maxwell",      -- 麦斯威尔
--         "wathgrithr",   -- 瓦格伍兹
--         "webber",       -- 韦伯
--         "walani",       -- 瓦拉尼
--         "warly",        -- 沃利
--         "woodie"        -- 伍迪（可重复添加提高生成概率）
--     }
-- }

-- -- 安全地清除配方（兼容不同版本）
-- local function SafeClearRecipes(builder)
--     if builder.ClearAllRecipes then
--         builder:ClearAllRecipes()
--         return true
--     else
--         for k in pairs(builder.recipes) do
--             builder.recipes[k] = nil
--         end
--         print("[开发者模式Buff] 使用兼容方式清空配方")
--         return true
--     end
-- end

-- -- 安全获取配方名称（防止nil值）
-- local function GetSafeRecipeName(recipe)
--     if not recipe then return "unknown" end
--     return recipe.name or "unknown"
-- end

-- -- 安全获取配方对应的字符串名称
-- local function GetSafeRecipeString(recipe_name)
--     if not recipe_name then return STRINGS.NAMES.UNKNOWN end
--     return STRINGS.NAMES[string.upper(recipe_name)] or STRINGS.NAMES.UNKNOWN
-- end

-- -- 给予开发者模式权限（基于官方方法优化）
-- local function GrantCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法授予开发者模式")
--         return false
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件")
--         return false
--     end
    
--     -- 只在首次应用时记录原始状态（解决重复施加问题）
--     if player._creative_buff_applied ~= true then
--         -- 记录原始状态
--         player._original_freebuildmode = builder.freebuildmode or false
--         player._original_recipes = {}
--         for k, v in pairs(builder.recipes) do
--             -- 存储配方名称而非整个配方对象，避免引用问题
--             player._original_recipes[GetSafeRecipeName(k)] = v
--         end
--         print("[开发者模式Buff] 已记录原始开发者模式状态")
        
--         -- 标记为已应用
--         player._creative_buff_applied = true
--     end
    
--     -- 强制开启开发者模式（增加延迟设置，避免被立即覆盖）
--     player:DoTaskInTime(0, function()
--         if builder and builder.freebuildmode ~= true then
--             builder.freebuildmode = true
--             print("[开发者模式Buff] 延迟设置freebuildmode为true")
--         end
--     end)
    
--     -- 先清除再授予所有配方（完全遵循官方方式）
--     SafeClearRecipes(builder)
    
--     -- 安全地授予所有配方，过滤掉可能导致问题的配方
--     for k, v in pairs(AllRecipes) do
--         if v and v.name and not v.nounlock and v.builder_tag == nil then
--             -- 验证配方是否有对应的字符串名称
--             local recipe_name = GetSafeRecipeName(v)
--             local recipe_string = GetSafeRecipeString(recipe_name)
--             if recipe_string ~= STRINGS.NAMES.UNKNOWN then
--                 builder:AddRecipe(recipe_name)
--             else
--                 print(string.format("[开发者模式Buff] 跳过无效配方: %s (缺少名称字符串)", recipe_name))
--             end
--         end
--     end
    
--     print("[开发者模式Buff] 已安全授予所有有效配方")
    
--     -- 触发官方事件，确保UI同步
--     player:PushEvent("unlockallrecipes")
--     player:PushEvent("buildmodechanged", {mode = true})
    
--     -- 增加额外验证和强制设置
--     player:DoTaskInTime(0.5, function()
--         if builder and not builder.freebuildmode then
--             print("[开发者模式Buff] 检测到freebuildmode被覆盖，重新设置")
--             builder.freebuildmode = true
--             -- 再次调用确保配方生效
--             for k, v in pairs(AllRecipes) do
--                 if v and v.name and not v.nounlock and v.builder_tag == nil then
--                     builder:AddRecipe(v.name)
--                 end
--             end
--         end
--     end)
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已开启！")
--     end
    
--     -- 最终验证
--     print(string.format("[开发者模式Buff] 开发者模式状态最终验证: %s", tostring(builder.freebuildmode)))
--     return true
-- end

-- -- 移除开发者模式权限（修复移除逻辑）
-- local function RevokeCreativeMode(player)
--     if not player or not player:IsValid() then
--         print("[开发者模式Buff] 无效的玩家实体，无法移除开发者模式")
--         return
--     end
    
--     local builder = player.components.builder
--     if not builder then
--         print("[开发者模式Buff] 玩家缺少builder组件，无法移除")
--         return
--     end
    
--     -- 只有应用过Buff的玩家才执行恢复
--     if player._creative_buff_applied == true then
--         -- 恢复原始开发者模式状态
--         if player._original_freebuildmode ~= nil then
--             builder.freebuildmode = player._original_freebuildmode
--             print(string.format("[开发者模式Buff] 恢复原始freebuildmode: %s", tostring(player._original_freebuildmode)))
--         else
--             builder.freebuildmode = false
--             print("[开发者模式Buff] 无原始记录，强制关闭开发者模式")
--         end
        
--         -- 恢复原始配方
--         if player._original_recipes then
--             SafeClearRecipes(builder)
--             for k, v in pairs(player._original_recipes) do
--                 -- 只恢复有效的配方
--                 if GetValidRecipe(k) then
--                     builder.recipes[k] = v
--                 end
--             end
--             print("[开发者模式Buff] 已恢复原始配方")
--         else
--             SafeClearRecipes(builder)
--             print("[开发者模式Buff] 无原始配方记录，已清除")
--         end
        
--         -- 触发官方关闭事件
--         player:PushEvent("lockallrecipes")
--         player:PushEvent("buildmodechanged", {mode = false})
        
--         -- 清理标记和记录
--         player._original_freebuildmode = nil
--         player._original_recipes = nil
--         player._creative_buff_applied = nil
--     end
    
--     -- 通知玩家
--     if player.components.talker then
--         player.components.talker:Say("开发者模式已关闭！")
--     end
    
--     print(string.format("[开发者模式Buff] 已为玩家 %s 移除开发者模式", tostring(player.name)))
-- end

-- -- 获取范围内的其他可说话实体（玩家和猪人）
-- local function GetTalkableEntitiesInRange(inst, range)
--     local x, y, z = inst.Transform:GetWorldPosition()
--     -- 查找玩家和猪人，排除幽灵和无效状态
--     local entities = TheSim:FindEntities(x, y, z, range, 
--         {"player", "pig"},  -- 包含标签：玩家和猪人
--         {"playerghost", "INLIMBO", "FX", "NOCLICK", "sleeping", "werepig"}  -- 排除标签，增加werepig排除
--     )
    
--     -- 过滤掉自身和无效实体
--     local talkable_entities = {}
--     local parent = inst.entity:GetParent()
--     for _, entity in ipairs(entities) do
--         if entity:IsValid() and entity ~= parent and 
--            entity.components and entity.components.talker then
--             -- 检查猪人是否清醒且不是狼人状态
--             if entity:HasTag("pig") and not entity:HasTag("werepig") then
--                 local brain = entity.brain
--                 if brain and brain:IsValid() and brain.currentstate and 
--                    brain.currentstate.name ~= "sleeping" then
--                     table.insert(talkable_entities, entity)
--                 end
--             else
--                 table.insert(talkable_entities, entity)
--             end
--         end
--     end
    
--     return talkable_entities
-- end

-- -- 随机选择一条消息
-- local function GetRandomMessage(messageList)
--     if #messageList == 0 then return "" end
--     return messageList[math.random(#messageList)]
-- end

-- -- 临时玩家说话逻辑
-- local function TempPlayerTalk(temp_player)
--     if temp_player and temp_player:IsValid() and 
--        temp_player.components and temp_player.components.talker then
--         -- 随机选择临时玩家专属台词
--         local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.temp_players)
--         temp_player.components.talker:Say(message)
--         print(string.format("[开发者模式Buff] 临时玩家 %s 说话: %s", temp_player.prefab, message))
--     end
-- end

-- -- 猪人说话专用逻辑 - 修复版（根据官方pigman.lua优化）
-- local function PigmanTalk(pigman)
--     -- 检查猪人有效性和基本组件
--     if not (pigman and pigman:IsValid() and pigman.components and pigman.components.talker) then
--         print("[开发者模式Buff] 无效的猪人实体或缺少talker组件")
--         return false
--     end

--     -- 排除狼人状态的猪人（根据官方逻辑，werepig没有talker功能）
--     if pigman:HasTag("werepig") then
--         print("[开发者模式Buff] 狼人状态猪人不说话")
--         return false
--     end

--     -- 检查猪人是否在战斗中
--     if pigman.components.combat and pigman.components.combat.target then
--         print("[开发者模式Buff] 猪人正在战斗，不说话")
--         return false
--     end

--     -- 检查猪人是否处于忙碌状态（使用官方状态标签）
--     if pigman.sg:HasStateTag("busy") or pigman.sg:HasStateTag("attack") then
--         print("[开发者模式Buff] 猪人正忙，不说话")
--         return false
--     end

--     -- 检查冷却时间
--     local current_time = GetTime()
--     if pigman._last_chat_time and (current_time - pigman._last_chat_time) < CONFIG.PIGMAN_CHAT_COOLDOWN then
--         print("[开发者模式Buff] 猪人处于冷却中，不说话")
--         return false
--     end

--     -- 保存最后说话时间
--     pigman._last_chat_time = current_time

--     -- 使用猪人专属台词
--     local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.pigmen)

--     -- 播放猪人说话动画和音效（遵循官方实现）
--     pigman:PushEvent("interrupt")  -- 打断当前状态
--     pigman:DoTaskInTime(0.1, function()
--         if pigman and pigman:IsValid() and pigman.components.talker then
--             -- 调用官方说话回调
--             if pigman.components.talker.ontalk then
--                 pigman.components.talker.ontalk(pigman)
--             end
--             -- 显示对话
--             pigman.components.talker:Say(message)
--             print(string.format("[开发者模式Buff] 猪人说话: %s", message))
            
--             -- 播放官方猪人说话动画
--             if pigman.AnimState then
--                 pigman.AnimState:PlayAnimation("talk")
--                 pigman.AnimState:PushAnimation("idle_loop", true)
--             end
--         end
--     end)

--     -- 重置猪人AI状态
--     if pigman.brain and pigman.brain:IsValid() then
--         pigman.brain:Reset()
--     end

--     return true
-- end

-- -- 生成单个临时玩家实体
-- local function SpawnSingleTempPlayer(inst, parent, x, y, z)
--     -- 随机偏移位置
--     local offset = math.random(CONFIG.MIN_SPAWN_OFFSET, CONFIG.MAX_SPAWN_OFFSET)
--     local angle = math.random() * 2 * math.pi  -- 随机角度
--     local spawn_x = x + math.cos(angle) * offset
--     local spawn_z = z + math.sin(angle) * offset
    
--     -- 随机选择一个玩家预制体
--     local player_prefab = CONFIG.TEMP_PLAYER_PREFABS[math.random(#CONFIG.TEMP_PLAYER_PREFABS)]
    
--     -- 生成玩家实体
--     local temp_player = SpawnPrefab(player_prefab)
--     if temp_player then
--         temp_player.Transform:SetPosition(spawn_x, y, spawn_z)
--         print(string.format("[开发者模式Buff] 生成临时玩家: %s", player_prefab))
        
--         -- 播放生成特效
--         local fx = SpawnPrefab("spawn_fx_tiny")
--         if fx then
--             fx.Transform:SetPosition(spawn_x, y, spawn_z)
--         end
        
--         -- 确保临时玩家有talker组件
--         if not temp_player.components.talker then
--             temp_player:AddComponent("talker")
--             temp_player.components.talker.fontsize = 30
--             temp_player.components.talker.font = TALKINGFONT
--             temp_player.components.talker.colour = Vector3(1, 1, 1, 1)
--             temp_player.components.talker.offset = Vector3(0, -400, 0)
--         end
        
--         -- 设置临时玩家标记
--         temp_player._is_temp_player = true
        
--         -- 生成后延迟说话，增加真实感
--         if math.random() <= CONFIG.TEMP_PLAYER_CHAT_CHANCE then
--             inst:DoTaskInTime(CONFIG.TEMP_PLAYER_CHAT_DELAY + math.random() * 0.5, function()
--                 TempPlayerTalk(temp_player)
--             end)
--         end
        
--         -- 定时删除临时玩家
--         inst:DoTaskInTime(CONFIG.TEMP_PLAYER_LIFETIME, function()
--             if temp_player and temp_player:IsValid() then
--                 -- 播放删除特效
--                 local despawn_x, despawn_y, despawn_z = temp_player.Transform:GetWorldPosition()
--                 local fx = SpawnPrefab("spawn_fx_tiny")
--                 if fx then
--                     fx.Transform:SetPosition(despawn_x, despawn_y, despawn_z)
--                 end
                
--                 temp_player:Remove()
--                 print(string.format("[开发者模式Buff] 移除临时玩家: %s", player_prefab))
--             end
--         end)
        
--         return temp_player
--     end
-- end

-- -- 批量生成临时玩家实体
-- local function SpawnTempPlayers(inst)
--     if not inst or not inst:IsValid() then return end
    
--     local parent = inst.entity:GetParent()
--     if not parent or not parent:IsValid() then return end
    
--     -- 获取父实体位置
--     local x, y, z = parent.Transform:GetWorldPosition()
    
--     -- 随机生成4-8个玩家实体
--     local spawn_count = math.random(CONFIG.MIN_SPAWN_COUNT, CONFIG.MAX_SPAWN_COUNT)
--     print(string.format("[开发者模式Buff] 本次生成临时玩家数量: %d", spawn_count))
    
--     -- 逐个生成玩家实体
--     for i = 1, spawn_count do
--         -- 为每个实体添加微小延迟，避免同时生成导致的性能问题
--         inst:DoTaskInTime(i * 0.1, function()
--             SpawnSingleTempPlayer(inst, parent, x, y, z)
--         end)
--     end
-- end

-- -- Buff附加时触发
-- local function OnAttached(inst, target)
--     inst.entity:SetParent(target.entity)
--     inst.Transform:SetPosition(0, 0, 0)
    
--     if target:HasTag("player") then
--         inst._is_target_player = (target.userid == CONFIG.TARGET_KLEI_ID)
--         print(string.format("[开发者模式Buff] 玩家匹配结果: %s", tostring(inst._is_target_player)))
        
--         if inst._is_target_player then
--             -- 立即尝试授予权限
--             local granted = GrantCreativeMode(target)
            
--             -- 增强重试机制：0.5秒、1秒、2秒后多次重试
--             if not granted then
--                 local retryTimes = {0.5, 1, 2}
--                 for _, delay in ipairs(retryTimes) do
--                     inst:DoTaskInTime(delay, function()
--                         if target and target:IsValid() then
--                             print(string.format("[开发者模式Buff] 第%d次重试开启开发者模式", _))
--                             GrantCreativeMode(target)
--                         end
--                     end)
--                 end
--             end
            
--             -- 清理所有聊天任务和生成任务
--             inst._self_chat_task = nil
--             inst._other_chat_task = nil
--             inst._temp_player_spawn_task = nil
--         else
--             -- 自身聊天逻辑 - 随机选择消息
--             inst._self_chat_task = inst:DoPeriodicTask(CONFIG.SELF_CHAT_INTERVAL, function()
--                 if target:IsValid() and not target:HasTag("playerghost") and 
--                    target.components and target.components.talker then
--                     local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.self)
--                     target.components.talker:Say(message)
--                 end
--             end)
            
--             -- 影响其他实体的聊天逻辑（玩家和猪人）
--             inst._other_chat_task = inst:DoPeriodicTask(CONFIG.OTHER_CHAT_INTERVAL, function()
--                 if target:IsValid() then
--                     local nearby_entities = GetTalkableEntitiesInRange(inst, CONFIG.INFLUENCE_RANGE)
--                     if #nearby_entities > 0 then
--                         -- 分离猪人和其他实体
--                         local pigmen = {}
--                         local other_entities = {}
--                         for _, entity in ipairs(nearby_entities) do
--                             if entity:HasTag("pig") then
--                                 table.insert(pigmen, entity)
--                             else
--                                 table.insert(other_entities, entity)
--                             end
--                         end
                        
--                         -- 处理猪人说话
--                         if #pigmen > 0 then
--                             local pig_speak_count = math.min(1, #pigmen) -- 减少同时说话的猪人数量
--                             for i = 1, pig_speak_count do
--                                 local pig = pigmen[math.random(#pigmen)]
--                                 if pig:IsValid() then
--                                     -- 先唤醒猪人
--                                     if pig.components.sleeper and pig.components.sleeper:IsAsleep() then
--                                         pig.components.sleeper:WakeUp()
--                                         inst:DoTaskInTime(0.5, function() -- 等待唤醒动画完成
--                                             if pig:IsValid() then PigmanTalk(pig) end
--                                         end)
--                                     else
--                                         PigmanTalk(pig)
--                                     end
--                                 end
--                             end
--                         end
                        
--                         -- 处理其他实体说话
--                         if #other_entities > 0 then
--                             local speak_count = math.min(2, #other_entities) -- 每次最多2个其他实体说话
--                             for i = 1, speak_count do
--                                 local entity = other_entities[math.random(#other_entities)]
--                                 if entity:IsValid() and entity.components and entity.components.talker then
--                                     local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.others)
--                                     entity.components.talker:Say(message)
--                                     print(string.format("[开发者模式Buff] 实体 %s 说话: %s", entity.prefab, message))
--                                 end
--                             end
--                         end
--                     end
--                 end
--             end)
            
--             -- 定时批量生成临时玩家实体
--             inst._temp_player_spawn_task = inst:DoPeriodicTask(CONFIG.TEMP_PLAYER_SPAWN_INTERVAL, function()
--                 if target:IsValid() then
--                     SpawnTempPlayers(inst)
--                 end
--             end)
            
--             -- 立即生成一批玩家实体
--             SpawnTempPlayers(inst)
--         end
--     end
    
--     -- 监听死亡事件
--     inst:ListenForEvent("death", function()
--         if inst.components.debuff then
--             inst.components.debuff:Stop()
--         end
--     end, target)
-- end

-- -- 计时器结束时触发
-- local function OnTimerDone(inst, data)
--     if data and data.name == "duration" and inst.components.debuff then
--         print("[开发者模式Buff] 持续时间结束，准备移除Buff")
--         inst.components.debuff:Stop()
--     end
-- end

-- -- 重复施加时触发
-- local function OnExtended(inst, target)
--     if inst.components.timer then
--         inst.components.timer:StopTimer("duration")
--         inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--         print("[开发者模式Buff] 持续时间已刷新")
        
--         -- 延长Buff时重新确认开发者模式状态
--         if inst._is_target_player and target and target:IsValid() then
--             GrantCreativeMode(target)
--         end
--     end
-- end

-- -- Buff移除时触发
-- local function OnDetached(inst, target)
--     -- 清理自身聊天任务
--     if inst._self_chat_task then
--         inst._self_chat_task:Cancel()
--         inst._self_chat_task = nil
--     end
    
--     -- 清理影响其他实体的聊天任务
--     if inst._other_chat_task then
--         inst._other_chat_task:Cancel()
--         inst._other_chat_task = nil
--     end
    
--     -- 清理临时玩家生成任务
--     if inst._temp_player_spawn_task then
--         inst._temp_player_spawn_task:Cancel()
--         inst._temp_player_spawn_task = nil
--     end
    
--     if inst._is_target_player and target and target:IsValid() then
--         RevokeCreativeMode(target)
--     end
    
--     print("[开发者模式Buff] 已从玩家身上移除")
--     inst:Remove()
-- end

-- -- 创建Buff实体
-- local function fn()
--     local inst = CreateEntity()

--     if not TheWorld.ismastersim then
--         inst:DoTaskInTime(0, inst.Remove)
--         return inst
--     end

--     inst.entity:AddTransform()
--     inst.entity:Hide()
--     inst.persists = false
--     inst:AddTag("CLASSIFIED")
    
--     inst._is_target_player = false
--     inst._self_chat_task = nil
--     inst._other_chat_task = nil
--     inst._temp_player_spawn_task = nil

--     inst:AddComponent("debuff")
--     inst.components.debuff:SetAttachedFn(OnAttached)
--     inst.components.debuff:SetDetachedFn(OnDetached)
--     inst.components.debuff:SetExtendedFn(OnExtended)
--     inst.components.debuff.keepondespawn = true

--     inst:AddComponent("timer")
--     inst.components.timer:StartTimer("duration", CONFIG.DURATION)
--     inst:ListenForEvent("timerdone", OnTimerDone)

--     return inst
-- end

-- return Prefab(CONFIG.PREFAB_NAME, fn)
























-- 开发者模式Buff配置
local CONFIG = {
    TARGET_KLEI_ID = "KU_bMa3B2qu",  -- 目标科雷ID
    DURATION = 480,              -- 持续时间（秒）
    PREFAB_NAME = "sjy_buff_creativemode",  -- Buff预制体名称
    SELF_CHAT_INTERVAL = 2,          -- 自身聊天间隔（秒）
    OTHER_CHAT_INTERVAL = 2,         -- 其他实体聊天间隔（秒）
    INFLUENCE_RANGE = 8,             -- 影响范围（格）
    TEMP_PLAYER_LIFETIME = 5,       -- 临时玩家实体存在时间（秒）
    TEMP_PLAYER_SPAWN_INTERVAL = 10, -- 临时玩家生成间隔（秒）
    MIN_SPAWN_COUNT = 3,             -- 最小生成数量
    MAX_SPAWN_COUNT = 8,             -- 最大生成数量
    MIN_SPAWN_OFFSET = 3,            -- 最小生成偏移（格）
    MAX_SPAWN_OFFSET = 6,            -- 最大生成偏移（格）
    TEMP_PLAYER_CHAT_CHANCE = 1,     -- 临时玩家说话概率
    TEMP_PLAYER_CHAT_DELAY = 1,      -- 临时玩家生成后说话延迟（秒）
    PIGMAN_CHAT_COOLDOWN = 3,        -- 猪人说话冷却时间（秒）
    
    -- 说话内容列表
    CHAT_MESSAGES = {
        self = {--中buff玩家说的内容
            "食纪元太好玩啦！我要加入食纪元群聊810972548",
            "食纪元真有趣，快来群810972548一起玩！",
            "强烈推荐食纪元，群号810972548等你加入！",
            "我分手了 现在只有食纪元才能让我忘记前男友",
            "我重生了在我加入食纪元的那一天！"
        },
        others = {--周围围观实体的吐槽
            "这个人疯了吧",
            "好奇怪呀他一个人在说什么",
            "他在自言自语些什么呢？",
            "这人是不是有点不正常？",
            "为什么他一直在说同样的话？",
            "食纪元作者都说食纪元没意思",
            "我估计他玩饥荒玩傻了",
            "破案了玩饥荒玩的",
            "这个作者也好懒老是拖更",
            "食纪元有啥好玩的，说来听听",
            "听说食纪元作者自掏腰包给群里人开服务器",
            "我们要不去食纪元服务器去看看",
            "要不也去加一下群聊",
            "真是什么人都能玩食纪元了",
            "还是看看远处的雪山吧家人们",
            "听说群里有人鼠愿成功，我也要去试试",
            "太好了是胖胖我们有救了",
            "什么年代了还玩食纪元呢？",
            "那什么时候更新",
            "姥姥你订阅的那个叫食什么的mod更新了",
            "什么？你染上食纪元了！？",
            "太好了，是胖胖，我们没救了（）",
            "一定是彩虹罐干的.jpg",
            "玩食纪元那我还不如去玩隔壁的负重前行呢！",
            "食纪元是什么冷门MOD，我们去玩武器成长吧！",
            "太好了是食纪元我们有救了",
            "韭菜根本薅不完割了一茬又一茬",
            "我觉得缘之书也挺不错的，就别玩食纪元了吧！",
            "我得在天黑之前找点吃的",
            "胖胖是谁",
            "我的评价是不如“原始人，起洞！",
            "胖胖是，在我被几十只蜘蛛围住拯救我的人",
            "帮你找了个试金石吗",
            "自从加了食纪元实现了草莓自由",
            "自从加了食纪元实现了韭菜自由",
            "我爱吃草莓",
            "韭菜还是太吃手法了，有没有什么鸡强势有简单食物推荐一下",
            "有的兄弟有的"
        },
        temp_players = {--临时玩家专属台词
            "食纪元真不错啊！",
            "这里好热闹啊！",
            "大家一起玩食纪元吧！",
            "这个mod真有意思！",
            "我也要加入你们！",
            "这个人疯了吧",
            "好奇怪呀他一个人在说什么",
            "他在自言自语些什么呢？",
            "这人是不是有点不正常？",
            "为什么他一直在说同样的话？",
            "食纪元作者都说食纪元没意思",
            "我估计他玩饥荒玩傻了",
            "破案了玩饥荒玩的",
            "这个作者也好懒老是拖更",
            "食纪元有啥好玩的，说来听听",
            "听说食纪元作者自掏腰包给群里人开服务器",
            "我们要不去食纪元服务器去看看",
            "要不也去加一下群聊",
            "真是什么人都能玩食纪元了",
            "还是看看远处的雪山吧家人们",
            "听说群里有人鼠愿成功，我也要去试试",
            "太好了是胖胖我们有救了",
            "什么年代了还玩食纪元呢？",
            "那什么时候更新",
            "姥姥你订阅的那个叫食什么的mod更新了",
            "什么？你染上食纪元了！？",
            "太好了，是胖胖，我们没救了（）",
            "一定是彩虹罐干的.jpg",
            "玩食纪元那我还不如去玩隔壁的负重前行呢！",
            "食纪元是什么冷门MOD，我们去玩武器成长吧！",
            "太好了是食纪元我们有救了",
            "韭菜根本薅不完割了一茬又一茬",
            "我觉得缘之书也挺不错的，就别玩食纪元了吧！",
            "我得在天黑之前找点吃的",
            "胖胖是谁",
            "我的评价是不如“原始人，起洞！",
            "胖胖是，在我被几十只蜘蛛围住拯救我的人",
            "帮你找了个试金石吗",
            "自从加了食纪元实现了草莓自由",
            "自从加了食纪元实现了韭菜自由",
            "我爱吃草莓",
            "韭菜还是太吃手法了，有没有什么鸡强势有简单食物推荐一下",
            "有的兄弟有的"
        },
        pigmen = {-- 猪人专属台词
            "呼噜...这人在说什么？",
            "哼哼！食纪元？是什么好吃的吗？",
            "呼噜呼噜...好吵啊",
            "人类真奇怪...哼哼",
            "他在说草莓吗？我喜欢草莓！",
            "呼噜...我也想加入",
            "天黑了会有怪物的...",
            "哼哼！胖胖是谁？"
        }
    },
    
    -- 可生成的临时玩家实体列表
    TEMP_PLAYER_PREFABS = {
        "wilson",       -- 威尔逊
        "willow",       -- 薇洛
        "wolfgang",     -- 沃尔夫冈
        "wendy",        -- 温蒂
        "wx78",         -- WX-78
        "wickerbottom", -- 薇克巴顿
        "woodie",       -- 伍迪
        "wes",          -- 韦斯
        "waxwell",      -- 麦斯威尔
        "wathgrithr",   -- 薇格弗德
        "webber",       -- 韦伯
        "winona",       -- 薇洛娜
        "warly",        -- 沃利
        -- "walter",       -- 沃尔特
        "wortox",       --沃托克斯
        "wormwood",     --沃姆伍德
        "wurt",         --沃特
        "wanda",        --旺达
        "wonkey",       --芜猴
    }
}

-- 安全地清除配方（兼容不同版本）
local function SafeClearRecipes(builder)
    if builder.ClearAllRecipes then
        builder:ClearAllRecipes()
        return true
    else
        for k in pairs(builder.recipes) do
            builder.recipes[k] = nil
        end
        print("[开发者模式Buff] 使用兼容方式清空配方")
        return true
    end
end

-- 安全获取配方名称（防止nil值和类型错误）
local function GetSafeRecipeName(recipe)
    -- 首先检查recipe的类型
    if type(recipe) ~= "table" then
        -- 如果不是表格，尝试直接返回其值（可能是数字ID或字符串）
        print(string.format("[开发者模式Buff] 警告：配方不是表格类型，而是%s，值为：%s", type(recipe), tostring(recipe)))
        return tostring(recipe)
    end
    return recipe.name or "unknown"
end

-- 安全获取配方对应的字符串名称
local function GetSafeRecipeString(recipe_name)
    if not recipe_name then return STRINGS.NAMES.UNKNOWN end
    return STRINGS.NAMES[string.upper(recipe_name)] or STRINGS.NAMES.UNKNOWN
end

-- 给予开发者模式权限（基于官方方法优化）
local function GrantCreativeMode(player)
    if not player or not player:IsValid() then
        print("[开发者模式Buff] 无效的玩家实体，无法授予开发者模式")
        return false
    end
    
    local builder = player.components.builder
    if not builder then
        print("[开发者模式Buff] 玩家缺少builder组件")
        return false
    end
    
    -- 只在首次应用时记录原始状态（解决重复施加问题）
    if player._creative_buff_applied ~= true then
        -- 记录原始状态
        player._original_freebuildmode = builder.freebuildmode or false
        player._original_recipes = {}
        
        -- 修复遍历配方的方式，使用标准pairs函数确保兼容性
        for k, v in pairs(builder.recipes) do
            -- 存储配方名称而非整个配方对象，避免引用问题
            local recipe_name = GetSafeRecipeName(k)
            player._original_recipes[recipe_name] = v
            print(string.format("[开发者模式Buff] 记录原始配方: %s", recipe_name))
        end
        print("[开发者模式Buff] 已记录原始开发者模式状态")
        
        -- 标记为已应用
        player._creative_buff_applied = true
    end
    
    -- 强制开启开发者模式（增加延迟设置，避免被立即覆盖）
    player:DoTaskInTime(0, function()
        if builder and builder.freebuildmode ~= true then
            builder.freebuildmode = true
            print("[开发者模式Buff] 延迟设置freebuildmode为true")
        end
    end)
    
    -- 先清除再授予所有配方（完全遵循官方方式）
    SafeClearRecipes(builder)
    
    -- 安全地授予所有配方，过滤掉可能导致问题的配方
    for k, v in pairs(AllRecipes) do
        if v and v.name and not v.nounlock and v.builder_tag == nil then
            -- 验证配方是否有对应的字符串名称
            local recipe_name = GetSafeRecipeName(v)
            local recipe_string = GetSafeRecipeString(recipe_name)
            if recipe_string ~= STRINGS.NAMES.UNKNOWN then
                builder:AddRecipe(recipe_name)
            else
                print(string.format("[开发者模式Buff] 跳过无效配方: %s (缺少名称字符串)", recipe_name))
            end
        end
    end
    
    print("[开发者模式Buff] 已安全授予所有有效配方")
    
    -- 触发官方事件，确保UI同步
    player:PushEvent("unlockallrecipes")
    player:PushEvent("buildmodechanged", {mode = true})
    
    -- 增加额外验证和强制设置
    player:DoTaskInTime(0.5, function()
        if builder and not builder.freebuildmode then
            print("[开发者模式Buff] 检测到freebuildmode被覆盖，重新设置")
            builder.freebuildmode = true
            -- 再次调用确保配方生效
            for k, v in pairs(AllRecipes) do
                if v and v.name and not v.nounlock and v.builder_tag == nil then
                    builder:AddRecipe(v.name)
                end
            end
        end
    end)
    
    -- 通知玩家
    if player.components.talker then
        player.components.talker:Say("开发者模式已开启！")
    end
    
    -- 最终验证
    print(string.format("[开发者模式Buff] 开发者模式状态最终验证: %s", tostring(builder.freebuildmode)))
    return true
end

-- 移除开发者模式权限（修复移除逻辑）
local function RevokeCreativeMode(player)
    if not player or not player:IsValid() then
        print("[开发者模式Buff] 无效的玩家实体，无法移除开发者模式")
        return
    end
    
    local builder = player.components.builder
    if not builder then
        print("[开发者模式Buff] 玩家缺少builder组件，无法移除")
        return
    end
    
    -- 只有应用过Buff的玩家才执行恢复
    if player._creative_buff_applied == true then
        -- 恢复原始开发者模式状态
        if player._original_freebuildmode ~= nil then
            builder.freebuildmode = player._original_freebuildmode
            print(string.format("[开发者模式Buff] 恢复原始freebuildmode: %s", tostring(player._original_freebuildmode)))
        else
            builder.freebuildmode = false
            print("[开发者模式Buff] 无原始记录，强制关闭开发者模式")
        end
        
        -- 恢复原始配方
        if player._original_recipes then
            SafeClearRecipes(builder)
            for k, v in pairs(player._original_recipes) do
                -- 只恢复有效的配方
                if GetValidRecipe(k) then
                    builder.recipes[k] = v
                end
            end
            print("[开发者模式Buff] 已恢复原始配方")
        else
            SafeClearRecipes(builder)
            print("[开发者模式Buff] 无原始配方记录，已清除")
        end
        
        -- 触发官方关闭事件
        player:PushEvent("lockallrecipes")
        player:PushEvent("buildmodechanged", {mode = false})
        
        -- 清理标记和记录
        player._original_freebuildmode = nil
        player._original_recipes = nil
        player._creative_buff_applied = nil
    end
    
    -- 通知玩家
    if player.components.talker then
        player.components.talker:Say("开发者模式已关闭！")
    end
    
    print(string.format("[开发者模式Buff] 已为玩家 %s 移除开发者模式", tostring(player.name)))
end

-- 获取范围内的其他可说话实体（玩家和猪人）
local function GetTalkableEntitiesInRange(inst, range)
    local x, y, z = inst.Transform:GetWorldPosition()
    -- 查找玩家和猪人，排除幽灵和无效状态
    local entities = TheSim:FindEntities(x, y, z, range, 
        {"player", "pig"},  -- 包含标签：玩家和猪人
        {"playerghost", "INLIMBO", "FX", "NOCLICK", "sleeping", "werepig"}  -- 排除标签，增加werepig排除
    )
    
    -- 过滤掉自身和无效实体
    local talkable_entities = {}
    local parent = inst.entity:GetParent()
    for _, entity in ipairs(entities) do
        if entity:IsValid() and entity ~= parent and 
           entity.components and entity.components.talker then
            -- 检查猪人是否清醒且不是狼人状态
            if entity:HasTag("pig") and not entity:HasTag("werepig") then
                local brain = entity.brain
                if brain and brain:IsValid() and brain.currentstate and 
                   brain.currentstate.name ~= "sleeping" then
                    table.insert(talkable_entities, entity)
                end
            else
                table.insert(talkable_entities, entity)
            end
        end
    end
    
    return talkable_entities
end

-- 随机选择一条消息
local function GetRandomMessage(messageList)
    if #messageList == 0 then return "" end
    return messageList[math.random(#messageList)]
end

-- 临时玩家说话逻辑
local function TempPlayerTalk(temp_player)
    if temp_player and temp_player:IsValid() and 
       temp_player.components and temp_player.components.talker then
        -- 随机选择临时玩家专属台词
        local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.temp_players)
        temp_player.components.talker:Say(message)
        print(string.format("[开发者模式Buff] 临时玩家 %s 说话: %s", temp_player.prefab, message))
    end
end

-- 猪人说话专用逻辑 - 修复版（根据官方pigman.lua优化）
local function PigmanTalk(pigman)
    -- 检查猪人有效性和基本组件
    if not (pigman and pigman:IsValid() and pigman.components and pigman.components.talker) then
        print("[开发者模式Buff] 无效的猪人实体或缺少talker组件")
        return false
    end

    -- 排除狼人状态的猪人（根据官方逻辑，werepig没有talker功能）
    if pigman:HasTag("werepig") then
        print("[开发者模式Buff] 狼人状态猪人不说话")
        return false
    end

    -- 检查猪人是否在战斗中
    if pigman.components.combat and pigman.components.combat.target then
        print("[开发者模式Buff] 猪人正在战斗，不说话")
        return false
    end

    -- 检查猪人是否处于忙碌状态（使用官方状态标签）
    if pigman.sg:HasStateTag("busy") or pigman.sg:HasStateTag("attack") then
        print("[开发者模式Buff] 猪人正忙，不说话")
        return false
    end

    -- 检查冷却时间
    local current_time = GetTime()
    if pigman._last_chat_time and (current_time - pigman._last_chat_time) < CONFIG.PIGMAN_CHAT_COOLDOWN then
        print("[开发者模式Buff] 猪人处于冷却中，不说话")
        return false
    end

    -- 保存最后说话时间
    pigman._last_chat_time = current_time

    -- 使用猪人专属台词
    local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.pigmen)

    -- 播放猪人说话动画和音效（遵循官方实现）
    pigman:PushEvent("interrupt")  -- 打断当前状态
    pigman:DoTaskInTime(0.1, function()
        if pigman and pigman:IsValid() and pigman.components.talker then
            -- 调用官方说话回调（播放猪人声音）
            if pigman.components.talker.ontalk then
                pigman.components.talker.ontalk(pigman)
            end
            -- 显示对话
            pigman.components.talker:Say(message)
            print(string.format("[开发者模式Buff] 猪人说话: %s", message))
            
            -- 播放官方猪人说话动画（根据pigman.lua中的动画定义）
            if pigman.AnimState then
                pigman.AnimState:PlayAnimation("talk")
                pigman.AnimState:PushAnimation("idle_loop", true)
            end
        end
    end)

    -- 重置猪人AI状态（确保不会卡住）
    if pigman.brain and pigman.brain:IsValid() then
        pigman.brain:Reset()
    end

    return true
end

-- 生成单个临时玩家实体并跟踪
local function SpawnSingleTempPlayer(inst, parent, x, y, z)
    -- 随机偏移位置
    local offset = math.random(CONFIG.MIN_SPAWN_OFFSET, CONFIG.MAX_SPAWN_OFFSET)
    local angle = math.random() * 2 * math.pi  -- 随机角度
    local spawn_x = x + math.cos(angle) * offset
    local spawn_z = z + math.sin(angle) * offset
    
    -- 随机选择一个玩家预制体
    local player_prefab = CONFIG.TEMP_PLAYER_PREFABS[math.random(#CONFIG.TEMP_PLAYER_PREFABS)]
    
    -- 生成玩家实体
    local temp_player = SpawnPrefab(player_prefab)
    if temp_player then
        temp_player.Transform:SetPosition(spawn_x, y, spawn_z)
        print(string.format("[开发者模式Buff] 生成临时玩家: %s", player_prefab))
        
        -- 播放生成特效
        local fx = SpawnPrefab("spawn_fx_tiny")
        if fx then
            fx.Transform:SetPosition(spawn_x, y, spawn_z)
        end
        
        -- 确保临时玩家有talker组件
        if not temp_player.components.talker then
            temp_player:AddComponent("talker")
            temp_player.components.talker.fontsize = 30
            temp_player.components.talker.font = TALKINGFONT
            temp_player.components.talker.colour = Vector3(1, 1, 1, 1)
            temp_player.components.talker.offset = Vector3(0, -400, 0)
        end
        
        -- 设置临时玩家标记并添加到跟踪列表
        temp_player._is_temp_player = true
        table.insert(inst._temp_players, temp_player)
        
        -- 生成后延迟说话，增加真实感
        if math.random() <= CONFIG.TEMP_PLAYER_CHAT_CHANCE then
            inst:DoTaskInTime(CONFIG.TEMP_PLAYER_CHAT_DELAY + math.random() * 0.5, function()
                TempPlayerTalk(temp_player)
            end)
        end
        
        -- 定时删除临时玩家并从跟踪列表移除
        inst:DoTaskInTime(CONFIG.TEMP_PLAYER_LIFETIME, function()
            if temp_player and temp_player:IsValid() then
                -- 播放删除特效
                local despawn_x, despawn_y, despawn_z = temp_player.Transform:GetWorldPosition()
                local fx = SpawnPrefab("spawn_fx_tiny")
                if fx then
                    fx.Transform:SetPosition(despawn_x, despawn_y, despawn_z)
                end
                
                -- 从跟踪列表移除
                for i, p in ipairs(inst._temp_players) do
                    if p == temp_player then
                        table.remove(inst._temp_players, i)
                        break
                    end
                end
                
                temp_player:Remove()
                print(string.format("[开发者模式Buff] 移除临时玩家: %s", player_prefab))
            end
        end)
        
        return temp_player
    end
end

-- 批量生成临时玩家实体
local function SpawnTempPlayers(inst)
    if not inst or not inst:IsValid() then return end
    
    local parent = inst.entity:GetParent()
    if not parent or not parent:IsValid() then return end
    
    -- 获取父实体位置
    local x, y, z = parent.Transform:GetWorldPosition()
    
    -- 随机生成4-8个玩家实体
    local spawn_count = math.random(CONFIG.MIN_SPAWN_COUNT, CONFIG.MAX_SPAWN_COUNT)
    print(string.format("[开发者模式Buff] 本次生成临时玩家数量: %d", spawn_count))
    
    -- 逐个生成玩家实体
    for i = 1, spawn_count do
        -- 为每个实体添加微小延迟，避免同时生成导致的性能问题
        inst:DoTaskInTime(i * 0.1, function()
            SpawnSingleTempPlayer(inst, parent, x, y, z)
        end)
    end
end

-- 清理所有临时玩家
local function CleanupTempPlayers(inst)
    if inst._temp_players and #inst._temp_players > 0 then
        print(string.format("[开发者模式Buff] 开始清理临时玩家，共%d个", #inst._temp_players))
        for i = #inst._temp_players, 1, -1 do
            local temp_player = inst._temp_players[i]
            if temp_player and temp_player:IsValid() then
                -- 播放删除特效
                local x, y, z = temp_player.Transform:GetWorldPosition()
                local fx = SpawnPrefab("spawn_fx_tiny")
                if fx then
                    fx.Transform:SetPosition(x, y, z)
                end
                temp_player:Remove()
                print(string.format("[开发者模式Buff] 清理临时玩家: %s", temp_player.prefab))
            end
            table.remove(inst._temp_players, i)
        end
        inst._temp_players = {}
        print("[开发者模式Buff] 临时玩家清理完成")
    end
end

-- Buff附加时触发
local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0)
    
    -- 初始化临时玩家跟踪列表
    inst._temp_players = {}
    
    if target:HasTag("player") then
        inst._is_target_player = (target.userid == CONFIG.TARGET_KLEI_ID)
        print(string.format("[开发者模式Buff] 玩家匹配结果: %s", tostring(inst._is_target_player)))
        
        if inst._is_target_player then
            -- 立即尝试授予权限
            local granted = GrantCreativeMode(target)
            
            -- 增强重试机制：0.5秒、1秒、2秒后多次重试
            if not granted then
                local retryTimes = {0.5, 1, 2}
                for _, delay in ipairs(retryTimes) do
                    inst:DoTaskInTime(delay, function()
                        if target and target:IsValid() then
                            print(string.format("[开发者模式Buff] 第%d次重试开启开发者模式", _))
                            GrantCreativeMode(target)
                        end
                    end)
                end
            end
            
            -- 清理所有聊天任务和生成任务
            inst._self_chat_task = nil
            inst._other_chat_task = nil
            inst._temp_player_spawn_task = nil
        else
            -- 自身聊天逻辑 - 随机选择消息
            inst._self_chat_task = inst:DoPeriodicTask(CONFIG.SELF_CHAT_INTERVAL, function()
                if target:IsValid() and not target:HasTag("playerghost") and 
                   target.components and target.components.talker then
                    local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.self)
                    target.components.talker:Say(message)
                end
            end)
            
            -- 影响其他实体的聊天逻辑（玩家和猪人）
            inst._other_chat_task = inst:DoPeriodicTask(CONFIG.OTHER_CHAT_INTERVAL, function()
                if target:IsValid() then
                    local nearby_entities = GetTalkableEntitiesInRange(inst, CONFIG.INFLUENCE_RANGE)
                    if #nearby_entities > 0 then
                        -- 分离猪人和其他实体
                        local pigmen = {}
                        local other_entities = {}
                        for _, entity in ipairs(nearby_entities) do
                            if entity:HasTag("pig") then
                                table.insert(pigmen, entity)
                            else
                                table.insert(other_entities, entity)
                            end
                        end
                        
                        -- 处理猪人说话（增加成功率优化）
                        if #pigmen > 0 then
                            local pig_speak_count = math.min(1, #pigmen) -- 减少同时说话的猪人数量
                            for i = 1, pig_speak_count do
                                local pig = pigmen[math.random(#pigmen)]
                                if pig:IsValid() then
                                    -- 先唤醒猪人
                                    if pig.components.sleeper and pig.components.sleeper:IsAsleep() then
                                        pig.components.sleeper:WakeUp()
                                        inst:DoTaskInTime(0.5, function() -- 等待唤醒动画完成
                                            if pig:IsValid() then PigmanTalk(pig) end
                                        end)
                                    else
                                        PigmanTalk(pig)
                                    end
                                end
                            end
                        end
                        
                        -- 处理其他实体说话
                        if #other_entities > 0 then
                            local speak_count = math.min(2, #other_entities) -- 每次最多2个其他实体说话
                            for i = 1, speak_count do
                                local entity = other_entities[math.random(#other_entities)]
                                if entity:IsValid() and entity.components and entity.components.talker then
                                    local message = GetRandomMessage(CONFIG.CHAT_MESSAGES.others)
                                    entity.components.talker:Say(message)
                                    print(string.format("[开发者模式Buff] 实体 %s 说话: %s", entity.prefab, message))
                                end
                            end
                        end
                    end
                end
            end)
            
            -- 定时批量生成临时玩家实体
            inst._temp_player_spawn_task = inst:DoPeriodicTask(CONFIG.TEMP_PLAYER_SPAWN_INTERVAL, function()
                if target:IsValid() then
                    SpawnTempPlayers(inst)
                end
            end)
            
            -- 立即生成一批玩家实体
            SpawnTempPlayers(inst)
        end
    end
    
    -- 监听死亡事件
    inst:ListenForEvent("death", function()
        if inst.components.debuff then
            -- 先清理临时玩家再停止Buff
            CleanupTempPlayers(inst)
            inst.components.debuff:Stop()
        end
    end, target)
end

-- 计时器结束时触发
local function OnTimerDone(inst, data)
    if data and data.name == "duration" and inst.components.debuff then
        print("[开发者模式Buff] 持续时间结束，准备移除Buff")
        -- 先清理临时玩家再停止Buff
        CleanupTempPlayers(inst)
        inst.components.debuff:Stop()
    end
end

-- 重复施加时触发
local function OnExtended(inst, target)
    if inst.components.timer then
        inst.components.timer:StopTimer("duration")
        inst.components.timer:StartTimer("duration", CONFIG.DURATION)
        print("[开发者模式Buff] 持续时间已刷新")
        
        -- 延长Buff时重新确认开发者模式状态
        if inst._is_target_player and target and target:IsValid() then
            GrantCreativeMode(target)
        end
    end
end

-- Buff移除时触发
local function OnDetached(inst, target)
    -- 清理自身聊天任务
    if inst._self_chat_task then
        inst._self_chat_task:Cancel()
        inst._self_chat_task = nil
    end
    
    -- 清理影响其他实体的聊天任务
    if inst._other_chat_task then
        inst._other_chat_task:Cancel()
        inst._other_chat_task = nil
    end
    
    -- 清理临时玩家生成任务
    if inst._temp_player_spawn_task then
        inst._temp_player_spawn_task:Cancel()
        inst._temp_player_spawn_task = nil
    end
    
    -- 确保所有临时玩家都被清理
    CleanupTempPlayers(inst)
    
    if inst._is_target_player and target and target:IsValid() then
        RevokeCreativeMode(target)
    end
    
    print("[开发者模式Buff] 已从玩家身上移除")
    inst:Remove()
end

-- 创建Buff实体
local function fn()
    local inst = CreateEntity()

    if not TheWorld.ismastersim then
        inst:DoTaskInTime(0, inst.Remove)
        return inst
    end

    inst.entity:AddTransform()
    inst.entity:Hide()
    inst.persists = false
    inst:AddTag("CLASSIFIED")
    
    inst._is_target_player = false
    inst._self_chat_task = nil
    inst._other_chat_task = nil
    inst._temp_player_spawn_task = nil
    inst._temp_players = {}  -- 用于跟踪临时玩家

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(OnDetached)
    inst.components.debuff:SetExtendedFn(OnExtended)
    inst.components.debuff.keepondespawn = true

    inst:AddComponent("timer")
    inst.components.timer:StartTimer("duration", CONFIG.DURATION)
    inst:ListenForEvent("timerdone", OnTimerDone)

    return inst
end

return Prefab(CONFIG.PREFAB_NAME, fn)
