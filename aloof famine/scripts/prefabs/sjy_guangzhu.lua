-- require "prefabutil"

-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_guangzhu.zip"),
--     Asset("INV_IMAGE", "terrarium_cooldown"),
--     Asset("INV_IMAGE", "terrarium_crimson"),
--     Asset("IMAGE", "images/inventoryimages/sjy_guangzhu.tex"),
-- 	Asset("ATLAS", "images/inventoryimages/sjy_guangzhu.xml"),
-- }

-- local prefabs =
-- {
--     "eyeofterror",
--     "shadow_despawn",
--     "sjy_guangzhu_fx",
--     "twinmanager",
-- }

-- -------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------

-- -- 打开
-- local function TurnOn(inst, is_loading)
   
--     if inst.is_on then
--         return
--     end
--     inst.is_on = true

--     inst.components.activatable.inactive = true -- to allow turning off
--     if is_loading then
--         inst.AnimState:PlayAnimation("activated_idle", true)
--     else
--         inst.AnimState:PlayAnimation("activate")
--         inst.AnimState:PushAnimation("activated_idle", true)

-- 		if inst._ShadowDelayTask ~= nil then
-- 			inst._ShadowDelayTask:Cancel()
-- 		end
--     end     
--             if inst.sjy_guangzhuFX == nil then 
              
--                  inst.sjy_guangzhuFX = SpawnPrefab("sjy_guangzhu_fx")
--                  inst.sjy_guangzhuFX.entity:SetParent(inst.entity)
--                  inst.sjy_guangzhuFX.AnimState:PlayAnimation("activate_fx")
--                  inst.sjy_guangzhuFX.AnimState:PushAnimation("activated_idle_fx", true)
--             end
--     inst.SoundEmitter:KillSound("beam")
--     inst.SoundEmitter:PlaySound("terraria1/terrarium/shimmer_loop", "shimmer")
-- end
-- -- 打开灯


-- -- 关闭
-- local function TurnOff(inst)
    
--     if not inst.is_on then
--         return
--     end

--     inst.is_on = false
--     inst.components.activatable.inactive = TUNING.SPAWN_EYEOFTERROR

--     if not inst.components.inventoryitem.canbepickedup then
--         inst.components.inventoryitem.canbepickedup = true
--     end

--     inst.SoundEmitter:KillSound("shimmer")
--     inst.SoundEmitter:KillSound("beam")

--     if inst._TurnLightsOnTask ~= nil then
--         inst._TurnLightsOnTask:Cancel()
--         inst._TurnLightsOnTask = nil
--     end

--     if inst.sjy_guangzhuFX ~= nil then
       
--         inst.sjy_guangzhuFX.AnimState:PlayAnimation("deactivate_fx")
--         inst.sjy_guangzhuFX:DoTaskInTime(0.3, inst.sjy_guangzhuFX.Remove)
--         inst.sjy_guangzhuFX = nil

--         inst.SoundEmitter:PlaySound("terraria1/terrarium/beam_stop")
--     end

--     if inst:IsInLimbo() then
--         inst.AnimState:PlayAnimation("idle", true)

--     else
--         inst.AnimState:PlayAnimation("deactivate")
--         inst.AnimState:PushAnimation("idle", true)

-- 		if inst._ShadowDelayTask ~= nil then
-- 			inst._ShadowDelayTask:Cancel()
-- 		end
--     end
-- end
-- -- 激活时
-- local function OnActivate(inst, doer)
-- 	if not inst.is_on then
--         print("开始开灯")
--         inst.Light:Enable(true)
--         print("开灯成功")
-- 		TurnOn(inst)
        
-- 	else
--         print("开始关灯")
--         inst.Light:Enable(false)
--         print("关灯成功")
-- 		TurnOff(inst)
    
-- 	end
-- end


-- -- 论入库
-- local function OnPutInInventory(inst)
--     print("开始关灯2")
--     inst.Light:Enable(false)
--     print("关灯成功2")
-- 	TurnOff(inst)
-- end


-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddSoundEmitter()
--     inst.entity:AddMiniMapEntity()
-- 	inst.entity:AddLight()
--     inst.entity:AddDynamicShadow()
--     inst.entity:AddNetwork()
    
--     inst.MiniMapEntity:SetIcon("sjy_guangzhu.tex")
--     inst.MiniMapEntity:SetCanUseCache(true)
--     inst.MiniMapEntity:SetDrawOverFogOfWar(true)

--     inst.Light:SetRadius(1800*1800)                       --发光范围:半径2格地皮
--     inst.Light:SetIntensity(0.8)
--     inst.Light:SetFalloff(1.8)
--     inst.Light:SetColour(255, 255, 255)
--     inst.Light:Enable(false)
--     inst.Light:EnableClientModulation(true)
--     inst:ListenForEvent("ondropped", function()
--         inst.Light:Enable(false)
--      end)
--     -- inst.Light:EnableClientModulation(true)
--     -- inst.Light:EnableClientModulation(false)

--     inst.DynamicShadow:SetSize(1.25, 1)
--     inst.DynamicShadow:Enable(false)

--     inst.AnimState:SetBank("sjy_guangzhu")
--     inst.AnimState:SetBuild("sjy_guangzhu")
--     inst.AnimState:PlayAnimation("idle")
--     inst.AnimState:Hide("terrarium_tree_crimson")

--     MakeInventoryPhysics(inst)

--     -- inst:AddTag("irreplaceable")

--     -- tags from trader.lua for optimization
--     -- inst:AddTag("trader")
--     -- inst:AddTag("alltrader")


--     -- inst.entity:SetPristine()

--     inst.scrapbook_hide = {"terrarium_tree_crimson"}

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
--     inst.components.inventoryitem:SetSinks(true)
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_guangzhu.xml"

--     inst:AddComponent("hauntable")
--     inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

--     inst:AddComponent("activatable")
--     inst.components.activatable.OnActivate = OnActivate
-- 	inst.components.activatable.quickaction = true
-- 	inst.components.activatable.inactive = TUNING.SPAWN_EYEOFTERROR


--     return inst
-- end

-- local function sjy_guangzhu_fx()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     inst.AnimState:SetBank("sjy_guangzhu")
--     inst.AnimState:SetBuild("sjy_guangzhu")
--     inst.AnimState:PlayAnimation("activated_idle_fx", true)
--     inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
--     inst.AnimState:SetFinalOffset(-1)
--       --黄色

--     inst:AddTag("DECOR")

--     inst.entity:SetPristine()
--     if not TheWorld.ismastersim then
--         return inst
--     end

--     -- inst.persists = false

--     return inst
-- end

-- return Prefab("sjy_guangzhu", fn, assets, prefabs),
--     Prefab("sjy_guangzhu_fx", sjy_guangzhu_fx, assets)
require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/sjy_guangzhu.zip"),
    Asset("INV_IMAGE", "terrarium_cooldown"),
    Asset("INV_IMAGE", "terrarium_crimson"),
    Asset("IMAGE", "images/inventoryimages/sjy_guangzhu.tex"),
	Asset("ATLAS", "images/inventoryimages/sjy_guangzhu.xml"),
}

local prefabs =
{
    "eyeofterror",
    "shadow_despawn",
    "sjy_guangzhu_fx",
    "twinmanager",
}

-- 范围治愈逻辑（移除goto语句，使用if条件判断）
local function HealPlayers(inst)
    -- 基础有效性检查
    if not inst:IsValid() then
        print("[sjy_guangzhu] HealPlayers: 装置实体无效")
        return
    end
    if not inst.is_on then
        print("[sjy_guangzhu] HealPlayers: 装置未开启，跳过治愈")
        return
    end

    -- 记录治愈周期
    print("[sjy_guangzhu] 执行治愈检查（每2秒）")
    
    -- 获取装置位置
    local x, y, z = inst.Transform:GetWorldPosition()
    print(string.format("[sjy_guangzhu] 装置位置: (%.1f, %.1f, %.1f)", x, y, z))

    -- 查找8格范围内的所有玩家（优化过滤条件）
    local players = TheSim:FindEntities(x, y, z, 8, {"player"}, {"playerghost", "INLIMBO", "dead"})
    
    -- 输出找到的玩家数量
    print(string.format("[sjy_guangzhu] 在8格范围内找到 %d 名玩家", #players))

    -- 遍历玩家进行治愈（使用if条件替代goto continue）
    for i, player in ipairs(players) do
        -- 检查玩家实体有效性
        if player and player:IsValid() then
            print(string.format("[sjy_guangzhu] 处理玩家 %d: %s", i, player:GetDisplayName() or "未知"))
            
            -- 检查玩家是否有必要的组件
            if player.components.health and player.components.sanity then
                -- 检查玩家是否存活
                if not player.components.health:IsDead() then
                    -- 执行治愈逻辑
                    local current_health = player.components.health.currenthealth
                    local max_health = player.components.health.maxhealth
                    print(string.format("[sjy_guangzhu] 玩家当前血量: %d/%d", current_health, max_health))

                    if current_health < max_health then
                        -- 恢复20点生命值
                        player.components.health:DoDelta(20, inst, "sjy_guangzhu_heal")
                        print("[sjy_guangzhu] 为玩家恢复20点生命值")
                    else
                        -- 血量已满，恢复30点精神值
                        player.components.sanity:DoDelta(30)
                        print("[sjy_guangzhu] 玩家血量已满，恢复30点精神值")
                    end
                else
                    print("[sjy_guangzhu] 玩家已死亡，跳过治愈")
                end
            else
                -- 缺少必要组件
                if not player.components.health then
                    print("[sjy_guangzhu] 玩家没有health组件，跳过")
                end
                if not player.components.sanity then
                    print("[sjy_guangzhu] 玩家没有sanity组件，跳过")
                end
            end
        else
            print("[sjy_guangzhu] 无效玩家实体，跳过")
        end
    end
end

-- 打开装置（增强日志和网络同步）
local function TurnOn(inst, is_loading)
    if inst.is_on then
        print("[sjy_guangzhu] TurnOn: 装置已处于开启状态，跳过")
        return
    end
    
    -- 标记状态并记录日志
    inst.is_on = true
    print("[sjy_guangzhu] 开始开启装置")

    -- 更新激活组件状态
    inst.components.activatable.inactive = true -- 允许关闭
    
    -- 处理动画
    if is_loading then
        inst.AnimState:PlayAnimation("activated_idle", true)
        print("[sjy_guangzhu] 加载时直接播放激活状态动画")
    else
        inst.AnimState:PlayAnimation("activate")
        inst.AnimState:PushAnimation("activated_idle", true)
        print("[sjy_guangzhu] 播放激活动画")

        if inst._ShadowDelayTask ~= nil then
            inst._ShadowDelayTask:Cancel()
            inst._ShadowDelayTask = nil
            print("[sjy_guangzhu] 取消阴影延迟任务")
        end
    end     

    -- 创建特效
    if inst.sjy_guangzhuFX == nil then 
        inst.sjy_guangzhuFX = SpawnPrefab("sjy_guangzhu_fx")
        inst.sjy_guangzhuFX.entity:SetParent(inst.entity)
        inst.sjy_guangzhuFX.AnimState:PlayAnimation("activate_fx")
        inst.sjy_guangzhuFX.AnimState:PushAnimation("activated_idle_fx", true)
        print("[sjy_guangzhu] 创建并播放特效")
    end

    -- 音效控制
    inst.SoundEmitter:KillSound("beam")
    inst.SoundEmitter:PlaySound("terraria1/terrarium/shimmer_loop", "shimmer")
    print("[sjy_guangzhu] 播放循环音效")

    -- 开启全图照明（强制同步到客户端）
    inst.Light:Enable(true)
    inst:PushEvent("lightstatechanged", {on = true}) -- 触发光照状态变更事件
    print("[sjy_guangzhu] 已开启全图照明")

    -- 启动治愈循环任务（每2秒一次）
    if inst.heal_task == nil then
        inst.heal_task = inst:DoPeriodicTask(2, HealPlayers)
        print("[sjy_guangzhu] 启动治愈循环任务（每2秒执行一次）")
    else
        print("[sjy_guangzhu] 治愈任务已存在，无需重复启动")
    end
end

-- 关闭装置（增强日志和网络同步）
local function TurnOff(inst)
    if not inst.is_on then
        print("[sjy_guangzhu] TurnOff: 装置已处于关闭状态，跳过")
        return
    end

    -- 标记状态并记录日志
    inst.is_on = false
    print("[sjy_guangzhu] 开始关闭装置")

    inst.components.activatable.inactive = TUNING.SPAWN_EYEOFTERROR

    -- 允许拾取
    if not inst.components.inventoryitem.canbepickedup then
        inst.components.inventoryitem.canbepickedup = true
        print("[sjy_guangzhu] 允许装置被拾取")
    end

    -- 音效控制
    inst.SoundEmitter:KillSound("shimmer")
    inst.SoundEmitter:KillSound("beam")
    print("[sjy_guangzhu] 停止播放音效")

    -- 清理任务
    if inst._TurnLightsOnTask ~= nil then
        inst._TurnLightsOnTask:Cancel()
        inst._TurnLightsOnTask = nil
        print("[sjy_guangzhu] 取消开灯延迟任务")
    end

    -- 停止治愈任务
    if inst.heal_task ~= nil then
        inst.heal_task:Cancel()
        inst.heal_task = nil
        print("[sjy_guangzhu] 停止治愈循环任务")
    end

    -- 清理特效
    if inst.sjy_guangzhuFX ~= nil then
        inst.sjy_guangzhuFX.AnimState:PlayAnimation("deactivate_fx")
        inst.sjy_guangzhuFX:DoTaskInTime(0.3, inst.sjy_guangzhuFX.Remove)
        inst.sjy_guangzhuFX = nil
        inst.SoundEmitter:PlaySound("terraria1/terrarium/beam_stop")
        print("[sjy_guangzhu] 播放关闭特效并清理")
    end

    -- 动画控制
    if inst:IsInLimbo() then
        inst.AnimState:PlayAnimation("idle", true)
        print("[sjy_guangzhu] 装置在Limbo状态，播放闲置动画")
    else
        inst.AnimState:PlayAnimation("deactivate")
        inst.AnimState:PushAnimation("idle", true)
        print("[sjy_guangzhu] 播放关闭动画")

        if inst._ShadowDelayTask ~= nil then
            inst._ShadowDelayTask:Cancel()
            inst._ShadowDelayTask = nil
            print("[sjy_guangzhu] 取消阴影延迟任务")
        end
    end

    -- 关闭照明（强制同步到客户端）
    inst.Light:Enable(false)
    inst:PushEvent("lightstatechanged", {on = false}) -- 触发光照状态变更事件
    print("[sjy_guangzhu] 已关闭照明")
end

-- 激活处理（增强日志）
local function OnActivate(inst, doer)
    print("[sjy_guangzhu] 收到激活事件")
    if doer and doer:IsValid() then
        print(string.format("[sjy_guangzhu] 激活者: %s", doer:GetDisplayName() or "未知实体"))
    end

    if not inst.is_on then
        print("[sjy_guangzhu] 执行开灯操作")
        TurnOn(inst)
        print("[sjy_guangzhu] 开灯操作完成")
    else
        print("[sjy_guangzhu] 执行关灯操作")
        TurnOff(inst)
        print("[sjy_guangzhu] 关灯操作完成")
    end
end

-- 入库处理（增强日志）
local function OnPutInInventory(inst)
    print("[sjy_guangzhu] 装置被放入背包")
    TurnOff(inst)
    print("[sjy_guangzhu] 已在背包中关闭装置")
end

-- 确保实体在服务器端持续加载
local function OnEntityCreated(inst)
    inst.persists = true -- 实体持久化
    inst:AddTag("serverpersists") -- 服务器强制保留标签
    inst:AddTag("NOCLICK") -- 防止被自动清理的额外保险
    inst:AddTag("lightemitter") -- 标记为光源实体
    print("[sjy_guangzhu] 实体创建完成，已设置持久化标签")
end

-- 客户端光照同步处理
local function OnLightStateChanged(inst, data)
    if not TheWorld.ismastersim then
        -- 客户端根据服务器状态更新光照
        inst.Light:Enable(data.on)
        print(string.format("[sjy_guangzhu客户端] 同步光照状态: %s", data.on and "开启" or "关闭"))
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddLight()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
    
    -- 小地图设置
    inst.MiniMapEntity:SetIcon("sjy_guangzhu.tex")
    inst.MiniMapEntity:SetCanUseCache(true)
    inst.MiniMapEntity:SetDrawOverFogOfWar(true)

    -- 全图照明设置（优化参数确保全图可见）
    inst.Light:SetRadius(1000) -- 足够大的半径覆盖全图
    inst.Light:SetIntensity(0.6) -- 适当降低强度避免过亮
    inst.Light:SetFalloff(0.01) -- 极低衰减确保远距离仍有光照
    inst.Light:SetColour(255/255, 255/255, 240/255) -- 温暖白色
    inst.Light:Enable(false)
    inst.Light:EnableClientModulation(true) -- 允许客户端调制
    print("[sjy_guangzhu] 初始化光照参数完成")

    -- 阴影设置
    inst.DynamicShadow:SetSize(1.25, 1)
    inst.DynamicShadow:Enable(false)

    -- 动画设置（保持不变）
    inst.AnimState:SetBank("sjy_guangzhu")
    inst.AnimState:SetBuild("sjy_guangzhu")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("terrarium_tree_crimson")

    MakeInventoryPhysics(inst)

    -- 初始化状态
    inst.is_on = false
    inst.scrapbook_hide = {"terrarium_tree_crimson"}

    -- 监听光照状态变化事件（用于客户端同步）
    inst:ListenForEvent("lightstatechanged", OnLightStateChanged)

    -- 实体创建时的处理
    inst:DoTaskInTime(0, OnEntityCreated)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        print("[sjy_guangzhu客户端] 客户端实体初始化完成")
        return inst
    end

    -- 库存组件
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    inst.components.inventoryitem:SetSinks(true)
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_guangzhu.xml"

    -- 闹鬼组件
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    -- 激活组件
    inst:AddComponent("activatable")
    inst.components.activatable.OnActivate = OnActivate
	inst.components.activatable.quickaction = true
	inst.components.activatable.inactive = TUNING.SPAWN_EYEOFTERROR

    -- 防止实体被服务器清理（修复UpdateComponent错误）
    inst:DoPeriodicTask(15, function() -- 缩短检查间隔至15秒
        if not inst:IsInLimbo() and inst:IsValid() then
            -- 修复：移除不存在的UpdateComponent调用
            -- 替代方案：直接访问组件进行状态刷新
            if inst.components.inventoryitem then
                inst.components.inventoryitem:OnUpdate(0)
            end
            
            -- 维持光照状态（关键修复：强制同步光照状态）
            if inst.is_on then
                inst.Light:Enable(true)
            end
            
            -- 通过轻微位置更新保持活跃（添加微小偏移确保更新生效）
            local x, y, z = inst.Transform:GetWorldPosition()
            inst.Transform:SetPosition(x + 0.0001, y, z + 0.0001)
            inst.Transform:SetPosition(x, y, z) -- 立即恢复原位置
            
            print("[sjy_guangzhu服务器] 执行实体保活更新")
        end
    end)

    -- 服务器端定期同步状态到所有客户端（新增关键修复）
    inst:DoPeriodicTask(5, function()
        if inst:IsValid() then
            inst:PushEvent("lightstatechanged", {on = inst.is_on})
            -- print("[sjy_guangzhu服务器] 同步光照状态到所有客户端")
        end
    end)

    print("[sjy_guangzhu服务器] 服务器实体初始化完成")
    return inst
end

local function sjy_guangzhu_fx()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    -- 特效动画（保持不变）
    inst.AnimState:SetBank("sjy_guangzhu")
    inst.AnimState:SetBuild("sjy_guangzhu")
    inst.AnimState:PlayAnimation("activated_idle_fx", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(-1)

    inst:AddTag("DECOR")
    inst:AddTag("NOCLICK")
    inst:AddTag("FX")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false -- 特效不持久化

    return inst
end

return Prefab("sjy_guangzhu", fn, assets, prefabs),
    Prefab("sjy_guangzhu_fx", sjy_guangzhu_fx, assets)
    