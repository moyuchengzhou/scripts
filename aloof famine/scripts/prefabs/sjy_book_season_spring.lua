-- local assets = {
--     Asset("ANIM", "anim/sjy_book_gemstone.zip"),
--     Asset("ANIM", "anim/fx_books.zip"),
-- }

-- -- 获取季节管理器的兼容方法
-- local function GetSeasonManager()
--     return TheWorld and (TheWorld.components.seasonmanager or TheWorld.state)
-- end

-- -- 显示计时器函数
-- local function UpdateSpringTimerDisplay(inst, remaining_time)
--     -- 确保先清理已存在的计时器
--     if inst.timer_widget ~= nil then
--         inst.timer_widget:Cancel()
--         inst.timer_widget = nil
--     end

--     -- 立即检查剩余时间是否有效
--     if remaining_time <= 0 then
--         return
--     end

--     -- 创建新的周期性任务
--     inst.timer_widget = TheWorld:DoPeriodicTask(1, function()
--         remaining_time = remaining_time - 1
        
--         if remaining_time <= 0 then
--             if inst.timer_widget ~= nil then
--                 inst.timer_widget:Cancel()
--                 inst.timer_widget = nil
--             end
--             return
--         end

--         -- 格式化时间显示（分:秒）
--         local minutes = math.floor(remaining_time / 60)
--         local seconds = remaining_time % 60
--         local time_str = string.format("%02d:%02d", minutes, seconds)
        
--         -- 在玩家屏幕上显示计时器
--         for _, player in ipairs(AllPlayers) do
--             if player ~= nil and player:IsValid() and player.components.talker ~= nil then
--                 player.components.talker:Say("[春之书] 春天剩余时间: " .. time_str, 1)
--             end
--         end
--     end)
-- end

-- -- 春季法术执行函数
-- local function do_sjy_book_season_spring_spell(inst, reader)
--     print("[春之书] 尝试执行季节转换...")

--     if not reader or not reader:IsValid() then
--         print("[春之书] 无效的读者")
--         return false, "INVALID_READER"
--     end

--     -- 获取季节管理相关接口
--     local seasonmanager = GetSeasonManager()
--     if not seasonmanager then
--         print("[春之书] 错误：无法获取季节管理接口")
--         if reader.components.talker ~= nil then
--             reader.components.talker:Say("这里的季节法则很奇怪...")
--         end
--         return false, "NO_SEASON_MANAGER"
--     end

--     -- 记录原始季节状态（兼容两种接口）
--     local original_season
--     local original_days_left = 0
--     local original_season_progress = 0

--     -- 适配官方季节管理器接口
--     if seasonmanager.GetCurrentSeason ~= nil then
--         original_season = seasonmanager:GetCurrentSeason()
--         original_days_left = tonumber(seasonmanager:GetDaysLeftInSeason()) or 0
--         original_season_progress = tonumber(seasonmanager:GetSeasonProgress()) or 0
--     -- 适配直接操作世界状态的接口
--     elseif TheWorld.state.season ~= nil then
--         original_season = TheWorld.state.season
--         original_days_left = TheWorld.state.seasonlength or 0
--         original_season_progress = TheWorld.state.seasonprogress or 0
--     else
--         print("[春之书] 错误：无法识别的季节系统")
--         return false, "UNKNOWN_SEASON_SYSTEM"
--     end

--     if not original_season then
--         print("[春之书] 警告：无法获取当前季节")
--         return false, "INVALID_SEASON"
--     end

--     print(string.format(
--         "[春之书] 原始季节: %s, 剩余天数: %d, 进度: %.2f",
--         original_season, original_days_left, original_season_progress
--     ))

--     -- 安全切换季节（使用官方推荐的双重方式）
--     local success, err = pcall(function()
--         -- 方法1：通过季节管理器接口
--         if seasonmanager.StartSeason ~= nil then
--             seasonmanager:StartSeason("spring")
--             if seasonmanager.SetDaysLeftInSeason ~= nil then
--                 seasonmanager:SetDaysLeftInSeason(1)  -- 明确设置春天只持续1天
--             end
--             if seasonmanager.SetSeasonProgress ~= nil then
--                 seasonmanager:SetSeasonProgress(0)  -- 从季节开始时启动
--             end
--         end

--         -- 方法2：直接设置世界状态并推送事件
--         TheWorld.state.season = "spring"
--         TheWorld.state.seasonprogress = 0
--         TheWorld.state.seasonlength = 1  -- 明确设置春天长度为1天
--         TheWorld:PushEvent("ms_setseason", "spring")
--     end)

--     if not success then
--         print("[春之书] 季节切换失败: " .. tostring(err))
--         return false, "SEASON_CHANGE_FAILED"
--     end

--     -- 播放反馈
--     inst.SoundEmitter:PlaySound("dontstarve/common/book_open")
--     if reader.components.talker ~= nil then
--         reader.components.talker:Say("春天来了！只会持续一天哦。")
--     end

--     -- 获取一天的实际时长（秒）
--     local day_length = 8 * 60  -- 默认8分钟(480秒)
--     if TheWorld ~= nil and TheWorld.state ~= nil then
--         day_length = TheWorld.state.daylength or day_length
--     end
    
--     -- 计算当前天剩余时间 + 完整一天的时间 = 春天总持续时间
--     local time_remaining_in_current_day = (1 - TheWorld.state.time) * day_length
--     local total_spring_duration = time_remaining_in_current_day + day_length  -- 确保总持续时间为完整一天

--     print(string.format("[春之书] 春季将持续 %.2f 秒（1天），之后恢复原季节", total_spring_duration))
    
--     -- 启动可视化计时器
--     UpdateSpringTimerDisplay(inst, math.floor(total_spring_duration))

--     -- 确保任务唯一性
--     if inst._season_task ~= nil then
--         inst._season_task:Cancel()
--         inst._season_task = nil
--     end
    
--     -- 设置恢复原季节的任务
--     inst._season_task = inst:DoTaskInTime(total_spring_duration, function()
--         local sm = GetSeasonManager()
--         if sm ~= nil and original_season ~= nil then
--             print("[春之书] 恢复原始季节: " .. original_season)
--             pcall(function()
--                 -- 恢复原始季节
--                 if sm.StartSeason ~= nil then
--                     sm:StartSeason(original_season)
--                     if sm.SetDaysLeftInSeason ~= nil then
--                         sm:SetDaysLeftInSeason(original_days_left)
--                     end
--                     if sm.SetSeasonProgress ~= nil then
--                         sm:SetSeasonProgress(original_season_progress)
--                     end
--                 end
--                 -- 同步世界状态
--                 TheWorld.state.season = original_season
--                 TheWorld.state.seasonprogress = original_season_progress
--                 TheWorld.state.seasonlength = original_days_left
--                 TheWorld:PushEvent("ms_setseason", original_season)
--             end)
            
--             -- 发送季节恢复的提示
--             if reader ~= nil and reader:IsValid() and reader.components.talker ~= nil then
--                 reader.components.talker:Say("春天结束了，恢复到原来的季节了。")
--             end
--         end
        
--         -- 清理计时器
--         if inst.timer_widget ~= nil then
--             inst.timer_widget:Cancel()
--             inst.timer_widget = nil
--         end
--         inst._season_task = nil
--     end)

--     return true
-- end

-- -- 翻阅函数
-- local function peruse_sjy_book_season_spring(inst, reader)
--     if not reader or not reader:IsValid() then
--         return false
--     end

--     inst.SoundEmitter:PlaySound("dontstarve/common/book_page")
--     local talk_str = GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_SEASON_SPRING") 
--                     or "这本书记载着春天的秘密，能召唤持续一天的春天..."
--     reader.components.talker:Say(talk_str)
    
--     return true
-- end

-- local def = {
--     name = "sjy_book_season_spring",
--     fn = do_sjy_book_season_spring_spell,
--     perusefn = peruse_sjy_book_season_spring,
--     read_sanity = -40,
--     peruse_sanity = -5,
--     fx = "book_fx",
--     fxmount = "swap_object",
--     uses = 3
-- }

-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddSoundEmitter()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_gemstone")
--     inst.AnimState:SetBuild("sjy_book_gemstone")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst:AddComponent("inspectable")
--     inst.components.inspectable:SetDescription("一本能召唤春天的魔法书，春天只会持续一天")
    
--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)
--     inst.components.book:SetFx(def.fx, def.fxmount)

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_gemstone.xml"

--     inst:AddComponent("finiteuses")
--     inst.components.finiteuses:SetMaxUses(def.uses)
--     inst.components.finiteuses:SetUses(def.uses)
--     inst.components.finiteuses:SetOnFinished(function() 
--         local ash = SpawnPrefab("ash")
--         if ash ~= nil then
--             ash.Transform:SetPosition(inst.Transform:GetWorldPosition())
--         end
--         inst:Remove() 
--     end)

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     inst._season_task = nil
--     inst.timer_widget = nil  -- 计时器任务引用

--     inst:ListenForEvent("onremove", function()
--         if inst._season_task ~= nil then
--             inst._season_task:Cancel()
--             inst._season_task = nil
--         end
--         if inst.timer_widget ~= nil then
--             inst.timer_widget:Cancel()
--             inst.timer_widget = nil
--         end
--     end)

--     -- 初始化时检查季节系统
--     local sm = GetSeasonManager()
--     if not sm then
--         print("[春之书] 初始化警告：未检测到季节系统")
--     elseif sm.GetCurrentSeason == nil and TheWorld.state.season == nil then
--         print("[春之书] 初始化警告：季节系统不完整")
--     end

--     return inst
-- end

-- return Prefab(def.name, fn, assets)
























local assets = {
    Asset("ANIM", "anim/sjy_book_gemstone.zip"),
    Asset("ANIM", "anim/fx_books.zip"),
}

-- 获取季节管理器的兼容方法
local function GetSeasonManager()
    return TheWorld and (TheWorld.components.seasonmanager or TheWorld.state)
end

-- 显示计时器函数
local function UpdateSpringTimerDisplay(inst, remaining_time)
    -- 确保先清理已存在的计时器
    if inst.timer_widget ~= nil then
        inst.timer_widget:Cancel()
        inst.timer_widget = nil
    end

    -- 立即检查剩余时间是否有效
    if remaining_time <= 0 then
        return
    end

    -- 创建新的周期性任务
    inst.timer_widget = TheWorld:DoPeriodicTask(1, function()
        remaining_time = remaining_time - 1
        
        if remaining_time <= 0 then
            if inst.timer_widget ~= nil then
                inst.timer_widget:Cancel()
                inst.timer_widget = nil
            end
            return
        end

        -- 格式化时间显示（分:秒）
        local minutes = math.floor(remaining_time / 60)
        local seconds = remaining_time % 60
        local time_str = string.format("%02d:%02d", minutes, seconds)
        
        -- 在玩家屏幕上显示计时器
        for _, player in ipairs(AllPlayers) do
            if player ~= nil and player:IsValid() and player.components.talker ~= nil then
                player.components.talker:Say("[春之书] 春天剩余时间: " .. time_str, 1)
            end
        end
    end)
end

-- 春季法术执行函数
local function do_sjy_book_season_spring_spell(inst, reader)
    print("[春之书] 尝试执行季节转换...")

    if not reader or not reader:IsValid() then
        print("[春之书] 无效的读者")
        return false, "INVALID_READER"
    end

    -- 获取季节管理相关接口
    local seasonmanager = GetSeasonManager()
    if not seasonmanager then
        print("[春之书] 错误：无法获取季节管理接口")
        if reader.components.talker ~= nil then
            reader.components.talker:Say("这里的季节法则很奇怪...")
        end
        return false, "NO_SEASON_MANAGER"
    end

    -- 记录原始季节状态（兼容两种接口）
    local original_season
    local original_days_left = 0
    local original_season_progress = 0
    local original_season_length = 0  -- 新增：记录原始季节总长度

    -- 适配官方季节管理器接口
    if seasonmanager.GetCurrentSeason ~= nil then
        original_season = seasonmanager:GetCurrentSeason()
        original_days_left = tonumber(seasonmanager:GetDaysLeftInSeason()) or 0
        original_season_progress = tonumber(seasonmanager:GetSeasonProgress()) or 0
        original_season_length = original_days_left / (1 - original_season_progress)  -- 计算总长度
    -- 适配直接操作世界状态的接口
    elseif TheWorld.state.season ~= nil then
        original_season = TheWorld.state.season
        original_season_length = TheWorld.state.seasonlength or 0
        original_season_progress = TheWorld.state.seasonprogress or 0
        original_days_left = original_season_length * (1 - original_season_progress)  -- 计算剩余天数
    else
        print("[春之书] 错误：无法识别的季节系统")
        return false, "UNKNOWN_SEASON_SYSTEM"
    end

    if not original_season then
        print("[春之书] 警告：无法获取当前季节")
        return false, "INVALID_SEASON"
    end

    print(string.format(
        "[春之书] 原始季节: %s, 剩余天数: %.2f, 总长度: %.2f, 进度: %.2f",
        original_season, original_days_left, original_season_length, original_season_progress
    ))

    -- 安全切换季节（使用官方推荐的双重方式）
    local success, err = pcall(function()
        -- 方法1：通过季节管理器接口
        if seasonmanager.StartSeason ~= nil then
            seasonmanager:StartSeason("spring")
            if seasonmanager.SetDaysLeftInSeason ~= nil then
                seasonmanager:SetDaysLeftInSeason(1)  -- 明确设置春天只持续1天
            end
            if seasonmanager.SetSeasonProgress ~= nil then
                seasonmanager:SetSeasonProgress(0)  -- 从季节开始时启动
            end
        end

        -- 方法2：直接设置世界状态并推送事件
        TheWorld.state.season = "spring"
        TheWorld.state.seasonprogress = 0
        TheWorld.state.seasonlength = 1  -- 明确设置春天长度为1天
        TheWorld:PushEvent("ms_setseason", "spring")
    end)

    if not success then
        print("[春之书] 季节切换失败: " .. tostring(err))
        return false, "SEASON_CHANGE_FAILED"
    end

    -- 播放反馈
    inst.SoundEmitter:PlaySound("dontstarve/common/book_open")
    if reader.components.talker ~= nil then
        reader.components.talker:Say("春天来了！只会持续一天哦。")
    end

    -- 获取一天的实际时长（秒）
    local day_length = 8 * 60  -- 默认8分钟(480秒)
    if TheWorld ~= nil and TheWorld.state ~= nil then
        day_length = TheWorld.state.daylength or day_length
    end
    
    -- 计算当前天剩余时间 + 完整一天的时间 = 春天总持续时间
    local time_remaining_in_current_day = (1 - TheWorld.state.time) * day_length
    local total_spring_duration = time_remaining_in_current_day + day_length  -- 确保总持续时间为完整一天

    print(string.format("[春之书] 春季将持续 %.2f 秒（1天），之后恢复原季节", total_spring_duration))
    
    -- 启动可视化计时器
    UpdateSpringTimerDisplay(inst, math.floor(total_spring_duration))

    -- 确保任务唯一性
    if inst._season_task ~= nil then
        inst._season_task:Cancel()
        inst._season_task = nil
    end
    
    -- 设置恢复原季节的任务，保存原始季节参数
    inst._season_task = inst:DoTaskInTime(total_spring_duration, function()
        local sm = GetSeasonManager()
        if sm ~= nil and original_season ~= nil then
            print(string.format(
                "[春之书] 恢复原始季节: %s, 剩余天数: %.2f, 进度: %.2f",
                original_season, original_days_left, original_season_progress
            ))
            pcall(function()
                -- 恢复原始季节
                if sm.StartSeason ~= nil then
                    sm:StartSeason(original_season)
                    if sm.SetDaysLeftInSeason ~= nil then
                        sm:SetDaysLeftInSeason(original_days_left)  -- 恢复剩余天数
                    end
                    if sm.SetSeasonProgress ~= nil then
                        sm:SetSeasonProgress(original_season_progress)  -- 恢复进度
                    end
                end
                -- 同步世界状态
                TheWorld.state.season = original_season
                TheWorld.state.seasonprogress = original_season_progress  -- 恢复进度
                TheWorld.state.seasonlength = original_season_length  -- 恢复总长度
                TheWorld:PushEvent("ms_setseason", original_season)
            end)
            
            -- 发送季节恢复的提示
            if reader ~= nil and reader:IsValid() and reader.components.talker ~= nil then
                reader.components.talker:Say("春天结束了，恢复到原来的季节了。")
            end
        end
        
        -- 清理计时器
        if inst.timer_widget ~= nil then
            inst.timer_widget:Cancel()
            inst.timer_widget = nil
        end
        inst._season_task = nil
    end)

    return true
end

-- 翻阅函数
local function peruse_sjy_book_season_spring(inst, reader)
    if not reader or not reader:IsValid() then
        return false
    end

    inst.SoundEmitter:PlaySound("dontstarve/common/book_page")
    local talk_str = GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_SEASON_SPRING") 
                    or "这本书记载着春天的秘密，能召唤持续一天的春天..."
    reader.components.talker:Say(talk_str)
    
    return true
end

local def = {
    name = "sjy_book_season_spring",
    fn = do_sjy_book_season_spring_spell,
    perusefn = peruse_sjy_book_season_spring,
    read_sanity = -40,
    peruse_sanity = -5,
    fx = "book_fx",
    fxmount = "swap_object",
    uses = 3
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sjy_book_gemstone")
    inst.AnimState:SetBuild("sjy_book_gemstone")
    inst.AnimState:PlayAnimation("idle")
    inst.scrapbook_anim = def.name

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst:AddTag("book")
    inst:AddTag("bookcabinet_item")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst.components.inspectable:SetDescription("一本能召唤春天的魔法书，春天只会持续一天")
    
    inst:AddComponent("book")
    inst.components.book:SetOnRead(def.fn)
    inst.components.book:SetOnPeruse(def.perusefn)
    inst.components.book:SetReadSanity(def.read_sanity)
    inst.components.book:SetPeruseSanity(def.peruse_sanity)
    inst.components.book:SetFx(def.fx, def.fxmount)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_gemstone.xml"

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(def.uses)
    inst.components.finiteuses:SetUses(def.uses)
    inst.components.finiteuses:SetOnFinished(function() 
        local ash = SpawnPrefab("ash")
        if ash ~= nil then
            ash.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end
        inst:Remove() 
    end)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    MakeHauntableLaunch(inst)

    inst._season_task = nil
    inst.timer_widget = nil  -- 计时器任务引用

    inst:ListenForEvent("onremove", function()
        if inst._season_task ~= nil then
            inst._season_task:Cancel()
            inst._season_task = nil
        end
        if inst.timer_widget ~= nil then
            inst.timer_widget:Cancel()
            inst.timer_widget = nil
        end
    end)

    -- 初始化时检查季节系统
    local sm = GetSeasonManager()
    if not sm then
        print("[春之书] 初始化警告：未检测到季节系统")
    elseif sm.GetCurrentSeason == nil and TheWorld.state.season == nil then
        print("[春之书] 初始化警告：季节系统不完整")
    end

    return inst
end

return Prefab(def.name, fn, assets)