-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 8
--     local CANT_TAGS = { "player", "INLIMBO", "FX" }
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)

--     -- 初始化自定义使用次数变量
--     if inst._max_uses == nil then
--         inst._max_uses = 1  -- 默认最大使用次数为1，可以根据需要调整
--     end
--     if inst._uses == nil then
--         inst._uses = 0  -- 初始使用次数为0
--     end

--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #ents > 0 then
--             for i, v in ipairs(ents) do
--                 table.insert(inst._stored_entities, v.prefab)
--                 v:Remove()
--             end
--             -- 重置使用次数为最大值
--             inst._uses = inst._max_uses
            
--             -- 更新物品状态（如果需要显示使用次数）
--             if inst.components.inventoryitem then
--                 inst.components.inventoryitem:ChangeImageName("sjy_book_devour_" .. inst._uses)
--             end
--         end
--         return true
--     else
--         for i, prefab in ipairs(inst._stored_entities) do
--             local theta = math.random() * TWOPI
--             local random_radius = math.random(0, range)
--             local pos_x = x + random_radius * math.cos(theta)
--             local pos_z = z + random_radius * math.sin(theta)
--             local entity = SpawnPrefab(prefab)
--             entity.Transform:SetPosition(pos_x, 0, pos_z)
--         end
--         inst._stored_entities = nil
--         -- 消耗使用次数
--         inst._uses = 0
        
--         -- 更新物品状态（如果需要显示使用次数）
--         if inst.components.inventoryitem then
--             inst.components.inventoryitem:ChangeImageName("sjy_book_devour_" .. inst._uses)
--         end
        
--         -- 如果使用次数为0，可以选择移除物品
--         if inst._uses <= 0 then
--             inst:Remove()
--         end
        
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
--     uses = 1  -- 这个值现在用于初始化_max_uses
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     -----------------------------------

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     -- 添加空值检查
--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     -- 不再需要finiteuses组件，可以注释掉
--     -- inst:AddComponent("finiteuses")
--     -- inst.components.finiteuses:SetMaxUses(def.uses)
--     -- inst.components.finiteuses:SetUses(0)
--     -- inst.components.finiteuses:SetOnFinished(inst.Remove)

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 初始化自定义使用次数变量
--     inst._max_uses = def.uses or 1
--     inst._uses = 0

--     -- 添加一个检查使用次数的函数
--     inst:ListenForEvent("onload", function()
--         if inst._uses == nil then
--             inst._uses = 0
--         end
--         if inst._max_uses == nil then
--             inst._max_uses = def.uses or 1
--         end
--     end)

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)



















-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 8
--     local CANT_TAGS = { "player", "INLIMBO", "FX" }
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)

--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #ents > 0 then
--             for i, v in ipairs(ents) do
--                 table.insert(inst._stored_entities, v.prefab)
--                 v:Remove()
--             end
--             -- 播放吞噬成功的动画或特效
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
--         end
--         return true
--     else
--         for i, prefab in ipairs(inst._stored_entities) do
--             local theta = math.random() * TWOPI
--             local random_radius = math.random(0, range)
--             local pos_x = x + random_radius * math.cos(theta)
--             local pos_z = z + random_radius * math.sin(theta)
--             local entity = SpawnPrefab(prefab)
--             entity.Transform:SetPosition(pos_x, 0, pos_z)
--         end
--         inst._stored_entities = nil
--         -- 播放释放成功的动画或特效
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     -----------------------------------

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     -- 添加空值检查
--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     -- 不再需要finiteuses组件，完全移除
--     -- inst:AddComponent("finiteuses")
--     -- inst.components.finiteuses:SetMaxUses(def.uses)
--     -- inst.components.finiteuses:SetUses(0)
--     -- inst.components.finiteuses:SetOnFinished(inst.Remove)

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 添加保存/加载逻辑
--     inst.OnSave = function(inst, data)
--         if inst._stored_entities then
--             data.stored_entities = inst._stored_entities
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stored_entities then
--             inst._stored_entities = data.stored_entities
--         end
--     end

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)
























--- 无bug版本
-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 不可吞噬的实体清单（使用哈希表结构）
-- local BLACKLISTED_ENTITIES = {
--     -- 玩家相关
--     ["player"] = true,
--     ["playerghost"] = true,
--     ["abigail"] = true,
--     ["shadowminion"] = true,
    
--     -- 地形和建筑
--     ["cave_exit"] = true,
--     ["cave_entrance"] = true,
--     ["cave_entrance_open"] = true,
--     ["wormhole"] = true,
-- }

-- -- 检查实体是否在黑名单中
-- local function IsEntityBlacklisted(ent)
--     if not ent or not ent.prefab then
--         return true
--     end
    
--     return BLACKLISTED_ENTITIES[ent.prefab] == true
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "companion" }  -- 添加玩家、玩家鬼魂和同伴标签
    
--     -- 查找范围内的实体
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 获取玩家队伍信息（如果有）
--     local player_team = reader.team or nil
    
--     -- 进一步过滤，排除队友和黑名单中的实体
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         -- 改进的队友判断逻辑
--         local is_teammate = false
        
--         -- 如果实体在黑名单中，跳过当前循环
--         if IsEntityBlacklisted(v) then
--             -- 使用 continue 替代 goto
--             -- 注意：在 Lua 中，没有显式的 continue 关键字
--             -- 我们可以通过反转条件来实现相同的效果
--         else
--             -- 如果玩家有队伍信息，检查实体是否有相同队伍标签
--             if player_team then
--                 is_teammate = v:HasTag("team_"..player_team)
--             end
            
--             -- 如果实体是玩家（即使没有队伍标签），也排除
--             if v:HasTag("player") then
--                 is_teammate = true
--             end
            
--             -- 如果实体是同伴，排除
--             if v:HasTag("companion") then
--                 is_teammate = true
--             end
            
--             -- 如果不是队友，添加到有效实体列表
--             if not is_teammate then
--                 table.insert(valid_ents, v)
--             end
--         end
--     end

--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量（可选）
--             local max_devour = 100
--             local entities_to_devour = #valid_ents > max_devour and max_devour or #valid_ents
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 table.insert(inst._stored_entities, v.prefab)
--                 -- 添加吞噬特效
--                 if v.components.health and not v.components.health:IsDead() then
--                     v:PushEvent("death")
--                 end
--                 v:Remove()
--             end
            
--             -- 如果有超过最大数量的实体，显示警告
--             if #valid_ents > max_devour then
--                 if reader.components.talker then
--                     reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT"), max_devour))
--                 end
--             end
            
--             -- 播放吞噬成功的动画或特效
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
            
--             -- 显示吞噬数量提示
--             if reader.components.talker then
--                 reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR"), #inst._stored_entities))
--             end
--         else
--             -- 没有可吞噬的实体
--             if reader.components.talker then
--                 reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE"))
--             end
--         end
--         return true
--     else
--         -- 在释放前保存实体数量
--         local entities_count = #inst._stored_entities
        
--         for i, prefab in ipairs(inst._stored_entities) do
--             local theta = math.random() * TWOPI
--             local random_radius = math.random(0, range * 0.7)  -- 释放范围略小于吞噬范围
--             local pos_x = x + random_radius * math.cos(theta)
--             local pos_z = z + random_radius * math.sin(theta)
--             local entity = SpawnPrefab(prefab)
--             entity.Transform:SetPosition(pos_x, 0, pos_z)
            
--             -- 添加释放特效
--             if entity.components.health then
--                 entity.components.health:SetPercent(1.0)
--             end
--         end
        
--         -- 释放后再设为 nil
--         inst._stored_entities = nil
        
--         -- 播放释放成功的动画或特效
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
        
--         -- 使用之前保存的数量显示提示
--         if reader.components.talker then
--             reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE"), entities_count))
--         end
        
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     -----------------------------------

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_entities and #inst._stored_entities > 0 and "FILLED" or "EMPTY"
--     end

--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     -- 添加空值检查
--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 添加保存/加载逻辑
--     inst.OnSave = function(inst, data)
--         if inst._stored_entities then
--             data.stored_entities = inst._stored_entities
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stored_entities then
--             inst._stored_entities = data.stored_entities
--         end
--     end

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)






















-- 没有容器判断
-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 不可吞噬的实体清单（使用哈希表结构）
-- local BLACKLISTED_ENTITIES = {
--     -- 玩家相关
--     ["player"] = true,
--     ["playerghost"] = true,
--     ["abigail"] = true,
--     ["shadowminion"] = true,

--     -- 物品相关
--     ["sjy_book_devour"] = true,
--     -- 地形和建筑
--     ["cave_exit"] = true,
--     ["cave_entrance"] = true,
--     ["cave_entrance_open"] = true,
--     ["wormhole"] = true,
-- }

-- -- 检查实体是否在黑名单中
-- local function IsEntityBlacklisted(ent)
--     if not ent or not ent.prefab then
--         return true
--     end
    
--     return BLACKLISTED_ENTITIES[ent.prefab] == true
-- end

-- -- 保存实体状态
-- local function SaveEntityState(entity)
--     if not entity then
--         return nil  -- 如果实体为空，直接返回 nil
--     end
    
--     local state = {
--         prefab = entity.prefab,
--         health = entity.components.health and entity.components.health:GetPercent() or 1.0,
--         hunger = entity.components.hunger and entity.components.hunger:GetPercent() or nil,
--         sanity = entity.components.sanity and entity.components.sanity:GetPercent() or nil,
--         age = entity.components.age and entity.components.age:GetAge() or nil,
--         tags = {},
--         buffs = {},
--     }
    
--     -- 保存标签，添加对 tags 是否存在的检查
--     if entity.tags then
--         for tag in pairs(entity.tags) do
--             state.tags[tag] = true
--         end
--     end
    
--     -- 保存部分组件数据，添加组件存在检查
--     if entity.components.locomotor then
--         state.walkspeed = entity.components.locomotor.walkspeed
--         state.runspeed = entity.components.locomotor.runspeed
--     end
    
--     if entity.components.combat then
--         state.damage = entity.components.combat.defaultdamage
--     end
    
--     -- 保存buff，添加组件和方法存在检查
--     if entity.components.bufferedaction and entity.components.bufferedaction.GetBuffs then
--         for _, buff in ipairs(entity.components.bufferedaction:GetBuffs()) do
--             if buff.name then
--                 table.insert(state.buffs, buff.name)
--             end
--         end
--     end
    
--     return state
-- end

-- -- 恢复实体状态
-- local function RestoreEntityState(entity, state)
--     if not entity or not state then
--         return
--     end
    
--     -- 恢复健康值
--     if entity.components.health and state.health then
--         entity.components.health:SetPercent(state.health)
--     end
    
--     -- 恢复饥饿值
--     if entity.components.hunger and state.hunger then
--         entity.components.hunger:SetPercent(state.hunger)
--     end
    
--     -- 恢复理智值
--     if entity.components.sanity and state.sanity then
--         entity.components.sanity:SetPercent(state.sanity)
--     end
    
--     -- 恢复年龄
--     if entity.components.age and state.age then
--         entity.components.age:SetAge(state.age)
--     end
    
--     -- 恢复标签
--     for tag, _ in pairs(state.tags) do
--         if not entity:HasTag(tag) then
--             entity:AddTag(tag)
--         end
--     end
    
--     -- 恢复移动速度
--     if entity.components.locomotor and state.walkspeed then
--         entity.components.locomotor.walkspeed = state.walkspeed
--         entity.components.locomotor.runspeed = state.runspeed
--     end
    
--     -- 恢复攻击力
--     if entity.components.combat and state.damage then
--         entity.components.combat.defaultdamage = state.damage
--     end
    
--     -- 恢复buffs（简化版）
--     -- 注意：完整恢复buffs需要更复杂的处理，这里只是示例
--     if entity.components.bufferedaction and #state.buffs > 0 then
--         for _, buff_name in ipairs(state.buffs) do
--             -- 这里只是示例，实际恢复buffs需要更具体的实现
--             -- entity:AddBufferedAction(...)
--         end
--     end
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "companion" }  -- 添加玩家、玩家鬼魂和同伴标签
    
--     -- 查找范围内的实体
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 获取玩家队伍信息（如果有）
--     local player_team = reader.team or nil
    
--     -- 进一步过滤，排除队友和黑名单中的实体
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         -- 改进的队友判断逻辑
--         local is_teammate = false
        
--         -- 反转条件，只有不在黑名单中才继续处理
--         if not IsEntityBlacklisted(v) then
--             -- 如果玩家有队伍信息，检查实体是否有相同队伍标签
--             if player_team then
--                 is_teammate = v:HasTag("team_"..player_team)
--             end
            
--             -- 如果实体是玩家（即使没有队伍标签），也排除
--             if v:HasTag("player") then
--                 is_teammate = true
--             end
            
--             -- 如果实体是同伴，排除
--             if v:HasTag("companion") then
--                 is_teammate = true
--             end
            
--             -- 如果不是队友，添加到有效实体列表
--             if not is_teammate then
--                 table.insert(valid_ents, v)
--             end
--         end
--     end

--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量（可选）
--             local max_devour = 100
--             local entities_to_devour = #valid_ents > max_devour and max_devour or #valid_ents
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 -- 保存实体的完整状态
--                 local entity_state = SaveEntityState(v)
--                 if entity_state then  -- 确保状态已正确保存
--                     table.insert(inst._stored_entities, entity_state)
                    
--                     -- 添加吞噬特效
--                     if v.components.health and not v.components.health:IsDead() then
--                         v:PushEvent("death")
--                     end
--                     v:Remove()
--                 else
--                     -- 记录无法保存状态的实体
--                     print("警告: 无法保存实体状态:", v.prefab or "未知实体")
--                 end
--             end
            
--             -- 如果有超过最大数量的实体，显示警告
--             if #valid_ents > max_devour then
--                 if reader.components.talker then
--                     reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT"), max_devour))
--                 end
--             end
            
--             -- 播放吞噬成功的动画或特效
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
            
--             -- 显示吞噬数量提示
--             if reader.components.talker then
--                 reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR"), #inst._stored_entities))
--             end
--         else
--             -- 没有可吞噬的实体
--             if reader.components.talker then
--                 reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE"))
--             end
--         end
--         return true
--     else
--         -- 在释放前保存实体数量
--         local entities_count = #inst._stored_entities
        
--         for i, entity_state in ipairs(inst._stored_entities) do
--             local theta = math.random() * TWOPI
--             local random_radius = math.random(0, range * 0.7)  -- 释放范围略小于吞噬范围
--             local pos_x = x + random_radius * math.cos(theta)
--             local pos_z = z + random_radius * math.sin(theta)
--             local entity = SpawnPrefab(entity_state.prefab)
--             if entity then  -- 确保实体已成功生成
--                 entity.Transform:SetPosition(pos_x, 0, pos_z)
                
--                 -- 恢复实体状态
--                 RestoreEntityState(entity, entity_state)
--             else
--                 -- 记录无法生成的实体
--                 print("警告: 无法生成预制体:", entity_state.prefab)
--             end
--         end
        
--         -- 释放后再设为 nil
--         inst._stored_entities = nil
        
--         -- 播放释放成功的动画或特效
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
        
--         -- 使用之前保存的数量显示提示
--         if reader.components.talker then
--             reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE"), entities_count))
--         end
        
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_entities and #inst._stored_entities > 0 and "FILLED" or "EMPTY"
--     end

--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 修改保存/加载逻辑以支持新的数据结构
--     inst.OnSave = function(inst, data)
--         if inst._stored_entities then
--             data.stored_entities = inst._stored_entities
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stored_entities then
--             inst._stored_entities = data.stored_entities
--         end
--     end

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)















-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 不可吞噬的实体清单（使用哈希表结构）
-- local BLACKLISTED_ENTITIES = {
--     -- 玩家相关
--     ["player"] = true,
--     ["playerghost"] = true,
--     ["abigail"] = true,
--     ["shadowminion"] = true,
    
--     -- 物品相关
--     ["sjy_book_devour"] = true,
    
--     -- 地形和建筑
--     ["cave_exit"] = true,
--     ["cave_entrance"] = true,
--     ["cave_entrance_open"] = true,
--     ["wormhole"] = true,
-- }

-- -- 检查实体是否在黑名单中
-- local function IsEntityBlacklisted(ent)
--     if not ent or not ent.prefab then
--         return true
--     end
    
--     -- 检查实体是否在黑名单中
--     if BLACKLISTED_ENTITIES[ent.prefab] then
--         return true
--     end
    
--     -- 检查实体是否有 container 组件
--     return ent.components.container ~= nil
-- end

-- -- 保存实体状态
-- local function SaveEntityState(entity)
--     if not entity then
--         return nil  -- 如果实体为空，直接返回 nil
--     end
    
--     local state = {
--         prefab = entity.prefab,
--         health = entity.components.health and entity.components.health:GetPercent() or 1.0,
--         hunger = entity.components.hunger and entity.components.hunger:GetPercent() or nil,
--         sanity = entity.components.sanity and entity.components.sanity:GetPercent() or nil,
--         age = entity.components.age and entity.components.age:GetAge() or nil,
--         tags = {},
--         buffs = {},
--     }
    
--     -- 保存标签，添加对 tags 是否存在的检查
--     if entity.tags then
--         for tag in pairs(entity.tags) do
--             state.tags[tag] = true
--         end
--     end
    
--     -- 保存部分组件数据，添加组件存在检查
--     if entity.components.locomotor then
--         state.walkspeed = entity.components.locomotor.walkspeed
--         state.runspeed = entity.components.locomotor.runspeed
--     end
    
--     if entity.components.combat then
--         state.damage = entity.components.combat.defaultdamage
--     end
    
--     -- 保存buff，添加组件和方法存在检查
--     if entity.components.bufferedaction and entity.components.bufferedaction.GetBuffs then
--         for _, buff in ipairs(entity.components.bufferedaction:GetBuffs()) do
--             if buff.name then
--                 table.insert(state.buffs, buff.name)
--             end
--         end
--     end
    
--     return state
-- end

-- -- 恢复实体状态
-- local function RestoreEntityState(entity, state)
--     if not entity or not state then
--         return
--     end
    
--     -- 恢复健康值
--     if entity.components.health and state.health then
--         entity.components.health:SetPercent(state.health)
--     end
    
--     -- 恢复饥饿值
--     if entity.components.hunger and state.hunger then
--         entity.components.hunger:SetPercent(state.hunger)
--     end
    
--     -- 恢复理智值
--     if entity.components.sanity and state.sanity then
--         entity.components.sanity:SetPercent(state.sanity)
--     end
    
--     -- 恢复年龄
--     if entity.components.age and state.age then
--         entity.components.age:SetAge(state.age)
--     end
    
--     -- 恢复标签
--     for tag, _ in pairs(state.tags) do
--         if not entity:HasTag(tag) then
--             entity:AddTag(tag)
--         end
--     end
    
--     -- 恢复移动速度
--     if entity.components.locomotor and state.walkspeed then
--         entity.components.locomotor.walkspeed = state.walkspeed
--         entity.components.locomotor.runspeed = state.runspeed
--     end
    
--     -- 恢复攻击力
--     if entity.components.combat and state.damage then
--         entity.components.combat.defaultdamage = state.damage
--     end
    
--     -- 恢复buffs（简化版）
--     -- 注意：完整恢复buffs需要更复杂的处理，这里只是示例
--     if entity.components.bufferedaction and #state.buffs > 0 then
--         for _, buff_name in ipairs(state.buffs) do
--             -- 这里只是示例，实际恢复buffs需要更具体的实现
--             -- entity:AddBufferedAction(...)
--         end
--     end
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "companion" }  -- 添加玩家、玩家鬼魂和同伴标签
    
--     -- 查找范围内的实体
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 获取玩家队伍信息（如果有）
--     local player_team = reader.team or nil
    
--     -- 进一步过滤，排除队友和黑名单中的实体
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         -- 改进的队友判断逻辑
--         local is_teammate = false
        
--         -- 反转条件，只有不在黑名单中才继续处理
--         if not IsEntityBlacklisted(v) then
--             -- 如果玩家有队伍信息，检查实体是否有相同队伍标签
--             if player_team then
--                 is_teammate = v:HasTag("team_"..player_team)
--             end
            
--             -- 如果实体是玩家（即使没有队伍标签），也排除
--             if v:HasTag("player") then
--                 is_teammate = true
--             end
            
--             -- 如果实体是同伴，排除
--             if v:HasTag("companion") then
--                 is_teammate = true
--             end
            
--             -- 如果不是队友，添加到有效实体列表
--             if not is_teammate then
--                 table.insert(valid_ents, v)
--             end
--         end
--     end

--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量（可选）
--             local max_devour = 100
--             local entities_to_devour = #valid_ents > max_devour and max_devour or #valid_ents
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 -- 保存实体的完整状态
--                 local entity_state = SaveEntityState(v)
--                 if entity_state then  -- 确保状态已正确保存
--                     table.insert(inst._stored_entities, entity_state)
                    
--                     -- 添加吞噬特效
--                     if v.components.health and not v.components.health:IsDead() then
--                         v:PushEvent("death")
--                     end
--                     v:Remove()
--                 else
--                     -- 记录无法保存状态的实体
--                     print("警告: 无法保存实体状态:", v.prefab or "未知实体")
--                 end
--             end
            
--             -- 如果有超过最大数量的实体，显示警告
--             if #valid_ents > max_devour then
--                 if reader.components.talker then
--                     reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT"), max_devour))
--                 end
--             end
            
--             -- 播放吞噬成功的动画或特效
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
            
--             -- 显示吞噬数量提示
--             if reader.components.talker then
--                 reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR"), #inst._stored_entities))
--             end
--         else
--             -- 没有可吞噬的实体
--             if reader.components.talker then
--                 reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE"))
--             end
--         end
--         return true
--     else
--         -- 在释放前保存实体数量
--         local entities_count = #inst._stored_entities
        
--         for i, entity_state in ipairs(inst._stored_entities) do
--             local theta = math.random() * TWOPI
--             local random_radius = math.random(0, range * 0.7)  -- 释放范围略小于吞噬范围
--             local pos_x = x + random_radius * math.cos(theta)
--             local pos_z = z + random_radius * math.sin(theta)
--             local entity = SpawnPrefab(entity_state.prefab)
--             if entity then  -- 确保实体已成功生成
--                 entity.Transform:SetPosition(pos_x, 0, pos_z)
                
--                 -- 恢复实体状态
--                 RestoreEntityState(entity, entity_state)
--             else
--                 -- 记录无法生成的实体
--                 print("警告: 无法生成预制体:", entity_state.prefab)
--             end
--         end
        
--         -- 释放后再设为 nil
--         inst._stored_entities = nil
        
--         -- 播放释放成功的动画或特效
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
        
--         -- 使用之前保存的数量显示提示
--         if reader.components.talker then
--             reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE"), entities_count))
--         end
        
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_entities and #inst._stored_entities > 0 and "FILLED" or "EMPTY"
--     end

--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 修改保存/加载逻辑以支持新的数据结构
--     inst.OnSave = function(inst, data)
--         if inst._stored_entities then
--             data.stored_entities = inst._stored_entities
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stored_entities then
--             inst._stored_entities = data.stored_entities
--         end
--     end

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)















































-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 生物标签列表 - 添加了树精守卫相关标签
-- local CREATURE_TAGS = {
--     "character", "monster", "animal", "bird", "prey", "scarytoprey", 
--     "smallcreature", "hostile", "companion", "treestump", "guardian"
-- }

-- -- 检查实体是否是活的生物
-- local function IsLivingCreature(ent)
--     if not ent or ent:HasTag("player") or ent:HasTag("playerghost") then
--         return false
--     end
    
--     -- 检查是否有生物必须的组件且是活着的
--     return ent.components.health and not ent.components.health:IsDead() and
--            ent.components.combat and
--            -- 检查是否有生物标签
--            (function()
--                for _, tag in ipairs(CREATURE_TAGS) do
--                    if ent:HasTag(tag) then
--                        return true
--                    end
--                end
--                return false
--            end)()
-- end

-- -- 保存实体状态
-- local function SaveEntityState(entity, reader)
--     if not entity or not IsLivingCreature(entity) then
--         return nil  -- 如果实体不是活的生物，直接返回 nil
--     end
    
--     local state = {
--         prefab = entity.prefab,
--         health = entity.components.health:GetPercent(),  -- 保存当前血量百分比
--         hunger = entity.components.hunger and entity.components.hunger:GetPercent() or nil,
--         sanity = entity.components.sanity and entity.components.sanity:GetPercent() or nil,
--         age = entity.components.age and entity.components.age:GetAge() or nil,
--         tags = {},
--         buffs = {},
--     }
    
--     -- 保存标签
--     if entity.tags then
--         for tag in pairs(entity.tags) do
--             state.tags[tag] = true
--         end
--     end
    
--     -- 保存部分组件数据
--     if entity.components.locomotor then
--         state.walkspeed = entity.components.locomotor.walkspeed
--         state.runspeed = entity.components.locomotor.runspeed
--     end
    
--     if entity.components.combat then
--         state.damage = entity.components.combat.defaultdamage
--     end
    
--     -- 保存buff
--     if entity.components.bufferedaction and entity.components.bufferedaction.GetBuffs then
--         for _, buff in ipairs(entity.components.bufferedaction.GetBuffs()) do
--             if buff.name then
--                 table.insert(state.buffs, buff.name)
--             end
--         end
--     end
    
--     -- 记录实体的相对位置（使用传入的 reader 作为参考点）
--     local v_x, v_y, v_z = entity.Transform:GetWorldPosition()
--     local reader_x, reader_y, reader_z = reader.Transform:GetWorldPosition()
--     state.dx = v_x - reader_x
--     state.dz = v_z - reader_z
    
--     return state
-- end

-- -- 恢复实体状态
-- local function RestoreEntityState(entity, state)
--     if not entity or not state then
--         return
--     end
    
--     -- 恢复健康值 - 这行现在负责恢复正确的血量
--     if entity.components.health and state.health then
--         entity.components.health:SetPercent(state.health)
--         print("恢复实体血量:", state.health * 100, "%") -- 添加调试日志
--     end
    
--     -- 恢复饥饿值
--     if entity.components.hunger and state.hunger then
--         entity.components.hunger:SetPercent(state.hunger)
--     end
    
--     -- 恢复理智值
--     if entity.components.sanity and state.sanity then
--         entity.components.sanity:SetPercent(state.sanity)
--     end
    
--     -- 恢复年龄
--     if entity.components.age and state.age then
--         entity.components.age:SetAge(state.age)
--     end
    
--     -- 恢复标签
--     for tag, _ in pairs(state.tags) do
--         if not entity:HasTag(tag) then
--             entity:AddTag(tag)
--         end
--     end
    
--     -- 恢复移动速度
--     if entity.components.locomotor and state.walkspeed then
--         entity.components.locomotor.walkspeed = state.walkspeed
--         entity.components.locomotor.runspeed = state.runspeed
--     end
    
--     -- 恢复攻击力
--     if entity.components.combat and state.damage then
--         entity.components.combat.defaultdamage = state.damage
--     end
    
--     -- 恢复buffs（简化版）
--     if entity.components.bufferedaction and #state.buffs > 0 then
--         for _, buff_name in ipairs(state.buffs) do
--             -- 实际恢复buffs需要更具体的实现
--             -- 这里仅作示例
--         end
--     end
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
    
--     -- 查找范围内的实体，排除玩家、玩家鬼魂和其他不需要的标签
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "structure", "tree", "wall", "plant", "groundspike", "decor", "inanimate" }
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 进一步过滤，只保留活的生物
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if IsLivingCreature(v) then
--             table.insert(valid_ents, v)
--             print("找到可吞噬实体:", v.prefab) -- 添加调试日志
--         end
--     end

--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量
--             local max_devour = 100
--             local entities_to_devour = math.min(#valid_ents, max_devour)
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 -- 保存实体的完整状态（传入 reader）
--                 local entity_state = SaveEntityState(v, reader)
--                 if entity_state then  -- 确保状态已正确保存
--                     -- 添加调试日志，显示保存的血量
--                     if v.components.health then
--                         print("保存实体:", v.prefab, "血量:", v.components.health:GetPercent() * 100, "%")
--                     end
                    
--                     table.insert(inst._stored_entities, entity_state)
                    
--                     -- 添加吞噬特效
--                     v:PushEvent("death")
--                     v:Remove()
--                 else
--                     -- 记录无法保存状态的实体
--                     print("警告: 无法保存实体状态:", v.prefab or "未知实体")
--                 end
--             end
            
--             -- 如果有超过最大数量的实体，显示警告
--             if #valid_ents > max_devour then
--                 if reader.components.talker then
--                     reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT"), max_devour))
--                 end
--             end
            
--             -- 播放吞噬成功的动画或特效
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
            
--             -- 显示吞噬数量提示
--             if reader.components.talker then
--                 reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR"), #inst._stored_entities))
--             end
--         else
--             -- 没有可吞噬的实体
--             if reader.components.talker then
--                 reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE"))
--             end
--         end
--         return true
--     else
--         -- 在释放前保存实体数量
--         local entities_count = #inst._stored_entities
        
--         for i, entity_state in ipairs(inst._stored_entities) do
--             -- 检查相对位置是否存在
--             local pos_x, pos_z
--             if entity_state.dx and entity_state.dz then
--                 -- 使用保存的相对位置释放实体
--                 pos_x = x + entity_state.dx
--                 pos_z = z + entity_state.dz
--             else
--                 -- 如果相对位置不存在，使用随机位置
--                 print("警告: 实体相对位置不存在，使用随机位置释放:", entity_state.prefab)
--                 local theta = math.random() * TWOPI
--                 local random_radius = math.random(1, 3)
--                 pos_x = x + random_radius * math.cos(theta)
--                 pos_z = z + random_radius * math.sin(theta)
--             end
            
--             -- 检查释放位置是否有效（不在障碍物中）
--             local ground = TheWorld.Map
--             if ground:IsPassableAtPoint(pos_x, 0, pos_z) then
--                 local entity = SpawnPrefab(entity_state.prefab)
--                 if entity then  -- 确保实体已成功生成
--                     entity.Transform:SetPosition(pos_x, 0, pos_z)
                    
--                     -- 恢复实体状态
--                     RestoreEntityState(entity, entity_state)
                    
--                     -- 删除强制满血的代码，让 RestoreEntityState 处理血量
--                     -- if entity.components.health then
--                     --     entity.components.health:SetPercent(1.0)  -- 移除这行！
--                     -- end
                    
--                     -- 添加释放特效
--                     if entity.SoundEmitter then
--                         entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--                     end
                    
--                     print("成功释放实体:", entity_state.prefab)
--                 else
--                     -- 记录无法生成的实体
--                     print("警告: 无法生成预制体:", entity_state.prefab)
--                 end
--             else
--                 -- 如果位置不可用，尝试寻找附近的可用位置
--                 local offset_x, offset_z = FindValidPositionByFan(pos_x, 0, pos_z, 3, 8)
--                 if offset_x and offset_z then
--                     local entity = SpawnPrefab(entity_state.prefab)
--                     if entity then
--                         entity.Transform:SetPosition(offset_x, 0, offset_z)
--                         RestoreEntityState(entity, entity_state)
--                         -- 同样移除强制满血的代码
--                         -- if entity.components.health then
--                         --     entity.components.health:SetPercent(1.0)
--                         -- end
--                         if entity.SoundEmitter then
--                             entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--                         end
--                         print("成功释放实体(重新定位):", entity_state.prefab)
--                     else
--                         print("警告: 无法生成预制体:", entity_state.prefab)
--                     end
--                 else
--                     print("警告: 找不到合适的位置释放实体:", entity_state.prefab)
--                 end
--             end
--         end
        
--         -- 释放后再设为 nil
--         inst._stored_entities = nil
        
--         -- 播放释放成功的动画或特效
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
        
--         -- 使用之前保存的数量显示提示
--         if reader.components.talker then
--             reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE"), entities_count))
--         end
        
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_entities and #inst._stored_entities > 0 and "FILLED" or "EMPTY"
--     end

--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 修改保存/加载逻辑以支持新的数据结构
--     inst.OnSave = function(inst, data)
--         if inst._stored_entities then
--             data.stored_entities = inst._stored_entities
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stored_entities then
--             inst._stored_entities = data.stored_entities
            
--             -- 检查并修复缺少相对位置的实体
--             for i, entity_state in ipairs(inst._stored_entities) do
--                 if not entity_state.dx or not entity_state.dz then
--                     print("警告: 加载的实体状态缺少相对位置信息:", entity_state.prefab)
--                     -- 可以选择移除这个实体，或者设置默认值
--                     -- table.remove(inst._stored_entities, i)
--                 end
--             end
--         end
--     end

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)



























-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 可吞噬生物白名单 - 这里可以添加或移除任何你想支持的生物
-- local ALLOWED_CREATURES = {
--     ["leif"] = true,               -- 树精守卫
--     ["leif_sparse"] = true,        -- 粗壮的树精守卫
--     -- ["chester"] = true,            -- 切斯特示例
--     -- 可以在这里添加更多生物...
-- }

-- -- 生物标签列表
-- local CREATURE_TAGS = {
--     "character", "monster", "animal", "bird", "prey", "scarytoprey", 
--     "smallcreature", "hostile", "companion", "treestump", "guardian"
-- }

-- -- 检查实体是否是活的生物且在白名单中
-- local function IsLivingCreature(ent)
--     if not ent or ent:HasTag("player") or ent:HasTag("playerghost") then
--         return false
--     end
    
--     -- 检查是否有生物必须的组件且是活着的
--     local has_required_components = ent.components.health and not ent.components.health:IsDead() and
--                                    ent.components.combat
    
--     -- 检查是否有生物标签
--     local has_creature_tag = false
--     for _, tag in ipairs(CREATURE_TAGS) do
--         if ent:HasTag(tag) then
--             has_creature_tag = true
--             break
--         end
--     end
    
--     -- 检查是否在允许的生物白名单中
--     local is_allowed = ALLOWED_CREATURES[ent.prefab] == true
    
--     return has_required_components and (has_creature_tag or is_allowed)
-- end

-- -- 保存实体状态
-- local function SaveEntityState(entity, reader)
--     if not entity or not IsLivingCreature(entity) then
--         return nil  -- 如果实体不是活的生物，直接返回 nil
--     end
    
--     local state = {
--         prefab = entity.prefab,
--         health = entity.components.health:GetPercent(),  -- 保存当前血量百分比
--         hunger = entity.components.hunger and entity.components.hunger:GetPercent() or nil,
--         sanity = entity.components.sanity and entity.components.sanity:GetPercent() or nil,
--         age = entity.components.age and entity.components.age:GetAge() or nil,
--         tags = {},
--         buffs = {},
--     }
    
--     -- 保存标签
--     if entity.tags then
--         for tag in pairs(entity.tags) do
--             state.tags[tag] = true
--         end
--     end
    
--     -- 保存部分组件数据
--     if entity.components.locomotor then
--         state.walkspeed = entity.components.locomotor.walkspeed
--         state.runspeed = entity.components.locomotor.runspeed
--     end
    
--     if entity.components.combat then
--         state.damage = entity.components.combat.defaultdamage
--     end
    
--     -- 保存buff
--     if entity.components.bufferedaction and entity.components.bufferedaction.GetBuffs then
--         for _, buff in ipairs(entity.components.bufferedaction.GetBuffs()) do
--             if buff.name then
--                 table.insert(state.buffs, buff.name)
--             end
--         end
--     end
    
--     -- 记录实体的相对位置（使用传入的 reader 作为参考点）
--     local v_x, v_y, v_z = entity.Transform:GetWorldPosition()
--     local reader_x, reader_y, reader_z = reader.Transform:GetWorldPosition()
--     state.dx = v_x - reader_x
--     state.dz = v_z - reader_z
    
--     return state
-- end

-- -- 恢复实体状态
-- local function RestoreEntityState(entity, state)
--     if not entity or not state then
--         return
--     end
    
--     -- 恢复健康值 - 这行现在负责恢复正确的血量
--     if entity.components.health and state.health then
--         entity.components.health:SetPercent(state.health)
--         print("恢复实体血量:", state.health * 100, "%") -- 添加调试日志
--     end
    
--     -- 恢复饥饿值
--     if entity.components.hunger and state.hunger then
--         entity.components.hunger:SetPercent(state.hunger)
--     end
    
--     -- 恢复理智值
--     if entity.components.sanity and state.sanity then
--         entity.components.sanity:SetPercent(state.sanity)
--     end
    
--     -- 恢复年龄
--     if entity.components.age and state.age then
--         entity.components.age:SetAge(state.age)
--     end
    
--     -- 恢复标签
--     for tag, _ in pairs(state.tags) do
--         if not entity:HasTag(tag) then
--             entity:AddTag(tag)
--         end
--     end
    
--     -- 恢复移动速度
--     if entity.components.locomotor and state.walkspeed then
--         entity.components.locomotor.walkspeed = state.walkspeed
--         entity.components.locomotor.runspeed = state.runspeed
--     end
    
--     -- 恢复攻击力
--     if entity.components.combat and state.damage then
--         entity.components.combat.defaultdamage = state.damage
--     end
    
--     -- 恢复buffs（简化版）
--     if entity.components.bufferedaction and #state.buffs > 0 then
--         for _, buff_name in ipairs(state.buffs) do
--             -- 实际恢复buffs需要更具体的实现
--             -- 这里仅作示例
--         end
--     end
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
    
--     -- 查找范围内的实体，排除玩家、玩家鬼魂和其他不需要的标签
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "structure", "tree", "wall", "plant", "groundspike", "decor", "inanimate" }
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 进一步过滤，只保留活的生物且在白名单中
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if IsLivingCreature(v) then
--             table.insert(valid_ents, v)
--             print("找到可吞噬实体:", v.prefab) -- 添加调试日志
--         end
--     end

--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量
--             local max_devour = 100
--             local entities_to_devour = math.min(#valid_ents, max_devour)
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 -- 保存实体的完整状态（传入 reader）
--                 local entity_state = SaveEntityState(v, reader)
--                 if entity_state then  -- 确保状态已正确保存
--                     -- 添加调试日志，显示保存的血量
--                     if v.components.health then
--                         print("保存实体:", v.prefab, "血量:", v.components.health:GetPercent() * 100, "%")
--                     end
                    
--                     table.insert(inst._stored_entities, entity_state)
                    
--                     -- 添加吞噬特效
--                     v:PushEvent("death")
--                     v:Remove()
--                 else
--                     -- 记录无法保存状态的实体
--                     print("警告: 无法保存实体状态:", v.prefab or "未知实体")
--                 end
--             end
            
--             -- 如果有超过最大数量的实体，显示警告
--             if #valid_ents > max_devour then
--                 if reader.components.talker then
--                     reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT"), max_devour))
--                 end
--             end
            
--             -- 播放吞噬成功的动画或特效
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
            
--             -- 显示吞噬数量提示
--             if reader.components.talker then
--                 reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR"), #inst._stored_entities))
--             end
--         else
--             -- 没有可吞噬的实体
--             if reader.components.talker then
--                 reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE"))
--             end
--         end
--         return true
--     else
--         -- 在释放前保存实体数量
--         local entities_count = #inst._stored_entities
        
--         for i, entity_state in ipairs(inst._stored_entities) do
--             -- 检查相对位置是否存在
--             local pos_x, pos_z
--             if entity_state.dx and entity_state.dz then
--                 -- 使用保存的相对位置释放实体
--                 pos_x = x + entity_state.dx
--                 pos_z = z + entity_state.dz
--             else
--                 -- 如果相对位置不存在，使用随机位置
--                 print("警告: 实体相对位置不存在，使用随机位置释放:", entity_state.prefab)
--                 local theta = math.random() * TWOPI
--                 local random_radius = math.random(1, 3)
--                 pos_x = x + random_radius * math.cos(theta)
--                 pos_z = z + random_radius * math.sin(theta)
--             end
            
--             -- 检查释放位置是否有效（不在障碍物中）
--             local ground = TheWorld.Map
--             if ground:IsPassableAtPoint(pos_x, 0, pos_z) then
--                 local entity = SpawnPrefab(entity_state.prefab)
--                 if entity then  -- 确保实体已成功生成
--                     entity.Transform:SetPosition(pos_x, 0, pos_z)
                    
--                     -- 恢复实体状态
--                     RestoreEntityState(entity, entity_state)
                    
--                     -- 删除强制满血的代码，让 RestoreEntityState 处理血量
--                     -- if entity.components.health then
--                     --     entity.components.health:SetPercent(1.0)  -- 移除这行！
--                     -- end
                    
--                     -- 添加释放特效
--                     if entity.SoundEmitter then
--                         entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--                     end
                    
--                     print("成功释放实体:", entity_state.prefab)
--                 else
--                     -- 记录无法生成的实体
--                     print("警告: 无法生成预制体:", entity_state.prefab)
--                 end
--             else
--                 -- 如果位置不可用，尝试寻找附近的可用位置
--                 local offset_x, offset_z = FindValidPositionByFan(pos_x, 0, pos_z, 3, 8)
--                 if offset_x and offset_z then
--                     local entity = SpawnPrefab(entity_state.prefab)
--                     if entity then
--                         entity.Transform:SetPosition(offset_x, 0, offset_z)
--                         RestoreEntityState(entity, entity_state)
--                         -- 同样移除强制满血的代码
--                         -- if entity.components.health then
--                         --     entity.components.health:SetPercent(1.0)
--                         -- end
--                         if entity.SoundEmitter then
--                             entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--                         end
--                         print("成功释放实体(重新定位):", entity_state.prefab)
--                     else
--                         print("警告: 无法生成预制体:", entity_state.prefab)
--                     end
--                 else
--                     print("警告: 找不到合适的位置释放实体:", entity_state.prefab)
--                 end
--             end
--         end
        
--         -- 释放后再设为 nil
--         inst._stored_entities = nil
        
--         -- 播放释放成功的动画或特效
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
        
--         -- 使用之前保存的数量显示提示
--         if reader.components.talker then
--             reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE"), entities_count))
--         end
        
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_entities and #inst._stored_entities > 0 and "FILLED" or "EMPTY"
--     end

--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 修改保存/加载逻辑以支持新的数据结构
--     inst.OnSave = function(inst, data)
--         if inst._stored_entities then
--             data.stored_entities = inst._stored_entities
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stored_entities then
--             inst._stored_entities = data.stored_entities
            
--             -- 检查并修复缺少相对位置的实体
--             for i, entity_state in ipairs(inst._stored_entities) do
--                 if not entity_state.dx or not entity_state.dz then
--                     print("警告: 加载的实体状态缺少相对位置信息:", entity_state.prefab)
--                     -- 可以选择移除这个实体，或者设置默认值
--                     -- table.remove(inst._stored_entities, i)
--                 end
--             end
--         end
--     end

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)


































-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 可吞噬生物白名单 - 这里可以添加或移除任何你想支持的生物
-- local ALLOWED_CREATURES = {
--     ["leif"] = true,               -- 树精守卫
--     ["leif_sparse"] = true,        -- 粗壮的树精守卫
--     ["chester"] = true,            -- 切斯特示例
--     ["treeseedling"] = true,       -- 树苗
--     ["deciduoustree"] = true,      -- 落叶树
--     ["evergreen"] = true,          -- 常青树
--     -- 可以在这里添加更多生物...
-- }

-- -- 生物标签列表 - 用于识别可吞噬的生物类型
-- local CREATURE_TAGS = {
--     "character", "monster", "animal", "bird", "prey", "scarytoprey", 
--     "smallcreature", "hostile", "companion", "treestump", "guardian",
--     "treeguard"                      -- 添加树精守卫专用标签
-- }

-- -- 始终允许的生物 - 无论是否有其他排除标签
-- local ALWAYS_ALLOWED = {
--     ["leif"] = true,
--     ["leif_sparse"] = true,
-- }

-- -- 检查实体是否是活的生物且在白名单中
-- local function IsLivingCreature(ent)
--     if not ent or ent:HasTag("player") or ent:HasTag("playerghost") then
--         return false
--     end
    
--     -- 特殊检查：始终允许的生物（如树精守卫）
--     if ALWAYS_ALLOWED[ent.prefab] then
--         print("特殊允许实体:", ent.prefab)
--         return ent.components.health and not ent.components.health:IsDead()
--     end
    
--     -- 检查是否有生物必须的组件且是活着的
--     local has_required_components = ent.components.health and not ent.components.health:IsDead() and
--                                    ent.components.combat
    
--     -- 检查是否有生物标签
--     local has_creature_tag = false
--     for _, tag in ipairs(CREATURE_TAGS) do
--         if ent:HasTag(tag) then
--             has_creature_tag = true
--             break
--         end
--     end
    
--     -- 检查是否在允许的生物白名单中
--     local is_allowed = ALLOWED_CREATURES[ent.prefab] == true
    
--     -- 调试输出
--     print("检查实体:", ent.prefab)
--     print("  健康组件:", has_required_components and "有" or "无")
--     print("  生物标签:", has_creature_tag and "有" or "无")
--     print("  白名单中:", is_allowed and "是" or "否")
    
--     return has_required_components and (has_creature_tag or is_allowed)
-- end

-- -- 保存实体状态
-- local function SaveEntityState(entity, reader)
--     if not entity or not IsLivingCreature(entity) then
--         print("警告: 尝试保存无效实体状态:", entity and entity.prefab or "nil")
--         return nil
--     end
    
--     local state = {
--         prefab = entity.prefab,
--         health = entity.components.health:GetPercent(),  -- 保存当前血量百分比
--         hunger = entity.components.hunger and entity.components.hunger:GetPercent() or nil,
--         sanity = entity.components.sanity and entity.components.sanity:GetPercent() or nil,
--         age = entity.components.age and entity.components.age:GetAge() or nil,
--         tags = {},
--         buffs = {},
--     }
    
--     -- 保存标签
--     if entity.tags then
--         for tag in pairs(entity.tags) do
--             state.tags[tag] = true
--         end
--     end
    
--     -- 保存部分组件数据
--     if entity.components.locomotor then
--         state.walkspeed = entity.components.locomotor.walkspeed
--         state.runspeed = entity.components.locomotor.runspeed
--     end
    
--     if entity.components.combat then
--         state.damage = entity.components.combat.defaultdamage
--     end
    
--     -- 保存buff
--     if entity.components.bufferedaction and entity.components.bufferedaction.GetBuffs then
--         for _, buff in ipairs(entity.components.bufferedaction.GetBuffs()) do
--             if buff.name then
--                 table.insert(state.buffs, buff.name)
--             end
--         end
--     end
    
--     -- 记录实体的相对位置（使用传入的 reader 作为参考点）
--     local v_x, v_y, v_z = entity.Transform:GetWorldPosition()
--     local reader_x, reader_y, reader_z = reader.Transform:GetWorldPosition()
--     state.dx = v_x - reader_x
--     state.dz = v_z - reader_z
    
--     print("成功保存实体状态:", entity.prefab)
--     return state
-- end

-- -- 恢复实体状态
-- local function RestoreEntityState(entity, state)
--     if not entity or not state then
--         print("警告: 尝试恢复无效实体状态")
--         return
--     end
    
--     print("开始恢复实体状态:", entity.prefab)
    
--     -- 恢复健康值
--     if entity.components.health and state.health then
--         entity.components.health:SetPercent(state.health)
--         print("恢复实体血量:", state.health * 100, "%")
--     end
    
--     -- 恢复饥饿值
--     if entity.components.hunger and state.hunger then
--         entity.components.hunger:SetPercent(state.hunger)
--         print("恢复实体饥饿值:", state.hunger * 100, "%")
--     end
    
--     -- 恢复理智值
--     if entity.components.sanity and state.sanity then
--         entity.components.sanity:SetPercent(state.sanity)
--         print("恢复实体理智值:", state.sanity * 100, "%")
--     end
    
--     -- 恢复年龄
--     if entity.components.age and state.age then
--         entity.components.age:SetAge(state.age)
--         print("恢复实体年龄:", state.age)
--     end
    
--     -- 恢复标签
--     for tag, _ in pairs(state.tags) do
--         if not entity:HasTag(tag) then
--             entity:AddTag(tag)
--             print("添加标签:", tag)
--         end
--     end
    
--     -- 恢复移动速度
--     if entity.components.locomotor and state.walkspeed then
--         entity.components.locomotor.walkspeed = state.walkspeed
--         entity.components.locomotor.runspeed = state.runspeed
--         print("恢复移动速度: 行走", state.walkspeed, "奔跑", state.runspeed)
--     end
    
--     -- 恢复攻击力
--     if entity.components.combat and state.damage then
--         entity.components.combat.defaultdamage = state.damage
--         print("恢复攻击力:", state.damage)
--     end
    
--     -- 恢复buffs（简化版）
--     if entity.components.bufferedaction and #state.buffs > 0 then
--         for _, buff_name in ipairs(state.buffs) do
--             print("需要恢复buff:", buff_name, "(简化版未实现)")
--             -- 实际恢复buffs需要更具体的实现
--         end
--     end
    
--     print("实体状态恢复完成:", entity.prefab)
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
    
--     print("===== 开始执行吞噬法术 =====")
--     print("施法者:", reader.prefab)
--     print("位置:", x, y, z)
    
--     -- 查找范围内的实体，排除玩家、玩家鬼魂和其他不需要的标签
--     -- 移除"tree"和"plant"标签，避免排除树精守卫
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "structure", "wall", "groundspike", "decor", "inanimate" }
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     print("搜索范围内实体数量:", #ents)
    
--     -- 输出所有找到的实体及其标签
--     for _, v in ipairs(ents) do
--         local tags_str = table.concat(v.tags or {}, ", ")
--         print("发现实体:", v.prefab, "标签:", tags_str)
--     end
    
--     -- 进一步过滤，只保留活的生物且在白名单中
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if IsLivingCreature(v) then
--             table.insert(valid_ents, v)
--             print("可吞噬实体:", v.prefab)
--         end
--     end
    
--     print("可吞噬实体数量:", #valid_ents)
    
--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量
--             local max_devour = 2000
--             local entities_to_devour = math.min(#valid_ents, max_devour)
            
--             print("开始吞噬", entities_to_devour, "个实体")
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 -- 保存实体的完整状态（传入 reader）
--                 local entity_state = SaveEntityState(v, reader)
--                 if entity_state then  -- 确保状态已正确保存
--                     table.insert(inst._stored_entities, entity_state)
                    
--                     -- 添加吞噬特效
--                     v:PushEvent("death")
--                     v:Remove()
--                     print("成功吞噬实体:", v.prefab)
--                 else
--                     -- 记录无法保存状态的实体
--                     print("警告: 无法保存实体状态:", v.prefab or "未知实体")
--                 end
--             end
            
--             -- 如果有超过最大数量的实体，显示警告
--             if #valid_ents > max_devour then
--                 if reader.components.talker then
--                     reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT"), max_devour))
--                 end
--                 print("警告: 超过最大吞噬数量，仅吞噬了", entities_to_devour, "个实体")
--             end
            
--             -- 播放吞噬成功的动画或特效
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
            
--             -- 显示吞噬数量提示
--             if reader.components.talker then
--                 reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR"), #inst._stored_entities))
--             end
--             print("吞噬完成，共吞噬", #inst._stored_entities, "个实体")
--         else
--             -- 没有可吞噬的实体
--             if reader.components.talker then
--                 reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE"))
--             end
--             print("警告: 没有找到可吞噬的实体")
--         end
--         return true
--     else
--         -- 在释放前保存实体数量
--         local entities_count = #inst._stored_entities
        
--         print("开始释放", entities_count, "个实体")
        
--         for i, entity_state in ipairs(inst._stored_entities) do
--             -- 检查相对位置是否存在
--             local pos_x, pos_z
--             if entity_state.dx and entity_state.dz then
--                 -- 使用保存的相对位置释放实体
--                 pos_x = x + entity_state.dx
--                 pos_z = z + entity_state.dz
--             else
--                 -- 如果相对位置不存在，使用随机位置
--                 print("警告: 实体相对位置不存在，使用随机位置释放:", entity_state.prefab)
--                 local theta = math.random() * TWOPI
--                 local random_radius = math.random(1, 3)
--                 pos_x = x + random_radius * math.cos(theta)
--                 pos_z = z + random_radius * math.sin(theta)
--             end
            
--             -- 检查释放位置是否有效（不在障碍物中）
--             local ground = TheWorld.Map
--             if ground:IsPassableAtPoint(pos_x, 0, pos_z) then
--                 local entity = SpawnPrefab(entity_state.prefab)
--                 if entity then  -- 确保实体已成功生成
--                     entity.Transform:SetPosition(pos_x, 0, pos_z)
                    
--                     -- 恢复实体状态
--                     RestoreEntityState(entity, entity_state)
                    
--                     -- 添加释放特效
--                     if entity.SoundEmitter then
--                         entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--                     end
                    
--                     print("成功释放实体:", entity_state.prefab)
--                 else
--                     -- 记录无法生成的实体
--                     print("警告: 无法生成预制体:", entity_state.prefab)
--                 end
--             else
--                 -- 如果位置不可用，尝试寻找附近的可用位置
--                 local offset_x, offset_z = FindValidPositionByFan(pos_x, 0, pos_z, 3, 8)
--                 if offset_x and offset_z then
--                     local entity = SpawnPrefab(entity_state.prefab)
--                     if entity then
--                         entity.Transform:SetPosition(offset_x, 0, offset_z)
--                         RestoreEntityState(entity, entity_state)
--                         if entity.SoundEmitter then
--                             entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--                         end
--                         print("成功释放实体(重新定位):", entity_state.prefab)
--                     else
--                         print("警告: 无法生成预制体:", entity_state.prefab)
--                     end
--                 else
--                     print("警告: 找不到合适的位置释放实体:", entity_state.prefab)
--                 end
--             end
--         end
        
--         -- 释放后再设为 nil
--         inst._stored_entities = nil
        
--         -- 播放释放成功的动画或特效
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
        
--         -- 使用之前保存的数量显示提示
--         if reader.components.talker then
--             reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE"), entities_count))
--         end
        
--         print("释放完成，共释放", entities_count, "个实体")
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_entities and #inst._stored_entities > 0 and "FILLED" or "EMPTY"
--     end

--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 修改保存/加载逻辑以支持新的数据结构
--     inst.OnSave = function(inst, data)
--         if inst._stored_entities then
--             data.stored_entities = inst._stored_entities
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stored_entities then
--             inst._stored_entities = data.stored_entities
            
--             -- 检查并修复缺少相对位置的实体
--             for i, entity_state in ipairs(inst._stored_entities) do
--                 if not entity_state.dx or not entity_state.dz then
--                     print("警告: 加载的实体状态缺少相对位置信息:", entity_state.prefab)
--                     -- 可以选择移除这个实体，或者设置默认值
--                     -- table.remove(inst._stored_entities, i)
--                 end
--             end
--         end
--     end

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)















-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 可吞噬生物白名单 - 这里可以添加或移除任何你想支持的生物
-- local ALLOWED_CREATURES = {
--     ["leif"] = true,               -- 树精守卫
--     ["leif_sparse"] = true,        -- 粗壮的树精守卫
--     ["chester"] = true,            -- 切斯特示例
--     ["treeseedling"] = true,       -- 树苗
--     ["deciduoustree"] = true,      -- 落叶树
--     ["evergreen"] = true,          -- 常青树
--     -- 可以在这里添加更多生物...
-- }

-- -- 生物标签列表 - 用于识别可吞噬的生物类型
-- local CREATURE_TAGS = {
--     "character", "monster", "animal", "bird", "prey", "scarytoprey", 
--     "smallcreature", "hostile", "companion", "treestump", "guardian",
--     "treeguard"                      -- 添加树精守卫专用标签
-- }

-- -- 始终允许的生物 - 无论是否有其他排除标签
-- local ALWAYS_ALLOWED = {
--     ["leif"] = true,
--     ["leif_sparse"] = true,
-- }

-- -- 不可吞噬生物黑名单 - 优先级高于白名单和标签检查
-- local BLOCKED_CREATURES = {
--     -- ["deerclops"] = true,          -- 巨鹿
--     -- ["bearger"] = true,            -- 熊獾
--     -- ["dragonfly"] = true,          -- 蜻蜓龙
--     -- ["klaus"] = true,              -- 克劳斯
--     -- 可以在这里添加更多不可吞噬的生物...
--     -- ["sjy_book_ikea_guidebook"] = true,              -- 克劳斯
-- }

-- -- 检查实体是否是活的生物且在白名单中
-- local function IsLivingCreature(ent)
--     if not ent or ent:HasTag("player") or ent:HasTag("playerghost") then
--         return false
--     end
    
--     -- 检查是否在黑名单中
--     if BLOCKED_CREATURES[ent.prefab] then
--         print("实体在黑名单中，不可吞噬:", ent.prefab)
--         return false
--     end
    
--     -- 特殊检查：始终允许的生物（如树精守卫）
--     if ALWAYS_ALLOWED[ent.prefab] then
--         print("特殊允许实体:", ent.prefab)
--         return ent.components.health and not ent.components.health:IsDead()
--     end
    
--     -- 检查是否有生物必须的组件且是活着的
--     local has_required_components = ent.components.health and not ent.components.health:IsDead() and
--                                    ent.components.combat
    
--     -- 检查是否有生物标签
--     local has_creature_tag = false
--     for _, tag in ipairs(CREATURE_TAGS) do
--         if ent:HasTag(tag) then
--             has_creature_tag = true
--             break
--         end
--     end
    
--     -- 检查是否在允许的生物白名单中
--     local is_allowed = ALLOWED_CREATURES[ent.prefab] == true
    
--     -- 调试输出
--     print("检查实体:", ent.prefab)
--     print("  健康组件:", has_required_components and "有" or "无")
--     print("  生物标签:", has_creature_tag and "有" or "无")
--     print("  白名单中:", is_allowed and "是" or "否")
    
--     return has_required_components and (has_creature_tag or is_allowed)
-- end

-- -- 保存实体状态
-- local function SaveEntityState(entity, reader)
--     if not entity or not IsLivingCreature(entity) then
--         print("警告: 尝试保存无效实体状态:", entity and entity.prefab or "nil")
--         return nil
--     end
    
--     local state = {
--         prefab = entity.prefab,
--         health = entity.components.health:GetPercent(),  -- 保存当前血量百分比
--         hunger = entity.components.hunger and entity.components.hunger:GetPercent() or nil,
--         sanity = entity.components.sanity and entity.components.sanity:GetPercent() or nil,
--         age = entity.components.age and entity.components.age:GetAge() or nil,
--         tags = {},
--         buffs = {},
--     }
    
--     -- 保存标签
--     if entity.tags then
--         for tag in pairs(entity.tags) do
--             state.tags[tag] = true
--         end
--     end
    
--     -- 保存部分组件数据
--     if entity.components.locomotor then
--         state.walkspeed = entity.components.locomotor.walkspeed
--         state.runspeed = entity.components.locomotor.runspeed
--     end
    
--     if entity.components.combat then
--         state.damage = entity.components.combat.defaultdamage
--     end
    
--     -- 保存buff
--     if entity.components.bufferedaction and entity.components.bufferedaction.GetBuffs then
--         for _, buff in ipairs(entity.components.bufferedaction.GetBuffs()) do
--             if buff.name then
--                 table.insert(state.buffs, buff.name)
--             end
--         end
--     end
    
--     -- 记录实体的相对位置（使用传入的 reader 作为参考点）
--     local v_x, v_y, v_z = entity.Transform:GetWorldPosition()
--     local reader_x, reader_y, reader_z = reader.Transform:GetWorldPosition()
--     state.dx = v_x - reader_x
--     state.dz = v_z - reader_z
    
--     print("成功保存实体状态:", entity.prefab)
--     return state
-- end

-- -- 恢复实体状态
-- local function RestoreEntityState(entity, state)
--     if not entity or not state then
--         print("警告: 尝试恢复无效实体状态")
--         return
--     end
    
--     print("开始恢复实体状态:", entity.prefab)
    
--     -- 恢复健康值
--     if entity.components.health and state.health then
--         entity.components.health:SetPercent(state.health)
--         print("恢复实体血量:", state.health * 100, "%")
--     end
    
--     -- 恢复饥饿值
--     if entity.components.hunger and state.hunger then
--         entity.components.hunger:SetPercent(state.hunger)
--         print("恢复实体饥饿值:", state.hunger * 100, "%")
--     end
    
--     -- 恢复理智值
--     if entity.components.sanity and state.sanity then
--         entity.components.sanity:SetPercent(state.sanity)
--         print("恢复实体理智值:", state.sanity * 100, "%")
--     end
    
--     -- 恢复年龄
--     if entity.components.age and state.age then
--         entity.components.age:SetAge(state.age)
--         print("恢复实体年龄:", state.age)
--     end
    
--     -- 恢复标签
--     for tag, _ in pairs(state.tags) do
--         if not entity:HasTag(tag) then
--             entity:AddTag(tag)
--             print("添加标签:", tag)
--         end
--     end
    
--     -- 恢复移动速度
--     if entity.components.locomotor and state.walkspeed then
--         entity.components.locomotor.walkspeed = state.walkspeed
--         entity.components.locomotor.runspeed = state.runspeed
--         print("恢复移动速度: 行走", state.walkspeed, "奔跑", state.runspeed)
--     end
    
--     -- 恢复攻击力
--     if entity.components.combat and state.damage then
--         entity.components.combat.defaultdamage = state.damage
--         print("恢复攻击力:", state.damage)
--     end
    
--     -- 恢复buffs（简化版）
--     if entity.components.bufferedaction and #state.buffs > 0 then
--         for _, buff_name in ipairs(state.buffs) do
--             print("需要恢复buff:", buff_name, "(简化版未实现)")
--             -- 实际恢复buffs需要更具体的实现
--         end
--     end
    
--     print("实体状态恢复完成:", entity.prefab)
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
    
--     print("===== 开始执行吞噬法术 =====")
--     print("施法者:", reader.prefab)
--     print("位置:", x, y, z)
    
--     -- 查找范围内的实体，排除玩家、玩家鬼魂和其他不需要的标签
--     -- 移除"tree"和"plant"标签，避免排除树精守卫
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "structure", "wall", "groundspike", "decor", "inanimate" }
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     print("搜索范围内实体数量:", #ents)
    
--     -- 输出所有找到的实体及其标签
--     for _, v in ipairs(ents) do
--         local tags_str = table.concat(v.tags or {}, ", ")
--         print("发现实体:", v.prefab, "标签:", tags_str)
--     end
    
--     -- 进一步过滤，只保留活的生物且在白名单中
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if IsLivingCreature(v) then
--             table.insert(valid_ents, v)
--             print("可吞噬实体:", v.prefab)
--         end
--     end
    
--     print("可吞噬实体数量:", #valid_ents)
    
--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量
--             local max_devour = 2000
--             local entities_to_devour = math.min(#valid_ents, max_devour)
            
--             print("开始吞噬", entities_to_devour, "个实体")
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 -- 保存实体的完整状态（传入 reader）
--                 local entity_state = SaveEntityState(v, reader)
--                 if entity_state then  -- 确保状态已正确保存
--                     table.insert(inst._stored_entities, entity_state)
                    
--                     -- 添加吞噬特效
--                     v:PushEvent("death")
--                     v:Remove()
--                     print("成功吞噬实体:", v.prefab)
--                 else
--                     -- 记录无法保存状态的实体
--                     print("警告: 无法保存实体状态:", v.prefab or "未知实体")
--                 end
--             end
            
--             -- 如果有超过最大数量的实体，显示警告
--             if #valid_ents > max_devour then
--                 if reader.components.talker then
--                     reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT"), max_devour))
--                 end
--                 print("警告: 超过最大吞噬数量，仅吞噬了", entities_to_devour, "个实体")
--             end
            
--             -- 播放吞噬成功的动画或特效
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
            
--             -- 显示吞噬数量提示
--             if reader.components.talker then
--                 reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR"), #inst._stored_entities))
--             end
--             print("吞噬完成，共吞噬", #inst._stored_entities, "个实体")
--         else
--             -- 没有可吞噬的实体
--             if reader.components.talker then
--                 reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE"))
--             end
--             print("警告: 没有找到可吞噬的实体")
--         end
--         return true
--     else
--         -- 在释放前保存实体数量
--         local entities_count = #inst._stored_entities
        
--         print("开始释放", entities_count, "个实体")
        
--         for i, entity_state in ipairs(inst._stored_entities) do
--             -- 检查相对位置是否存在
--             local pos_x, pos_z
--             if entity_state.dx and entity_state.dz then
--                 -- 使用保存的相对位置释放实体
--                 pos_x = x + entity_state.dx
--                 pos_z = z + entity_state.dz
--             else
--                 -- 如果相对位置不存在，使用随机位置
--                 print("警告: 实体相对位置不存在，使用随机位置释放:", entity_state.prefab)
--                 local theta = math.random() * TWOPI
--                 local random_radius = math.random(1, 3)
--                 pos_x = x + random_radius * math.cos(theta)
--                 pos_z = z + random_radius * math.sin(theta)
--             end
            
--             -- 检查释放位置是否有效（不在障碍物中）
--             local ground = TheWorld.Map
--             if ground:IsPassableAtPoint(pos_x, 0, pos_z) then
--                 local entity = SpawnPrefab(entity_state.prefab)
--                 if entity then  -- 确保实体已成功生成
--                     entity.Transform:SetPosition(pos_x, 0, pos_z)
                    
--                     -- 恢复实体状态
--                     RestoreEntityState(entity, entity_state)
                    
--                     -- 添加释放特效
--                     if entity.SoundEmitter then
--                         entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--                     end
                    
--                     print("成功释放实体:", entity_state.prefab)
--                 else
--                     -- 记录无法生成的实体
--                     print("警告: 无法生成预制体:", entity_state.prefab)
--                 end
--             else
--                 -- 如果位置不可用，尝试寻找附近的可用位置
--                 local offset_x, offset_z = FindValidPositionByFan(pos_x, 0, pos_z, 3, 8)
--                 if offset_x and offset_z then
--                     local entity = SpawnPrefab(entity_state.prefab)
--                     if entity then
--                         entity.Transform:SetPosition(offset_x, 0, offset_z)
--                         RestoreEntityState(entity, entity_state)
--                         if entity.SoundEmitter then
--                             entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--                         end
--                         print("成功释放实体(重新定位):", entity_state.prefab)
--                     else
--                         print("警告: 无法生成预制体:", entity_state.prefab)
--                     end
--                 else
--                     print("警告: 找不到合适的位置释放实体:", entity_state.prefab)
--                 end
--             end
--         end
        
--         -- 释放后再设为 nil
--         inst._stored_entities = nil
        
--         -- 播放释放成功的动画或特效
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
        
--         -- 使用之前保存的数量显示提示
--         if reader.components.talker then
--             reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE"), entities_count))
--         end
        
--         print("释放完成，共释放", entities_count, "个实体")
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_entities and #inst._stored_entities > 0 and "FILLED" or "EMPTY"
--     end

--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 修改保存/加载逻辑以支持新的数据结构
--     inst.OnSave = function(inst, data)
--         if inst._stored_entities then
--             data.stored_entities = inst._stored_entities
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stored_entities then
--             inst._stored_entities = data.stored_entities
            
--             -- 检查并修复缺少相对位置的实体
--             for i, entity_state in ipairs(inst._stored_entities) do
--                 if not entity_state.dx or not entity_state.dz then
--                     print("警告: 加载的实体状态缺少相对位置信息:", entity_state.prefab)
--                     -- 可以选择移除这个实体，或者设置默认值
--                     -- table.remove(inst._stored_entities, i)
--                 end
--             end
--         end
--     end

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)




















-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_devour.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 可吞噬生物白名单 - 这里可以添加或移除任何你想支持的生物
-- local ALLOWED_CREATURES = {
--     ["leif"] = true,               -- 树精守卫
--     ["leif_sparse"] = true,        -- 粗壮的树精守卫
--     ["chester"] = true,            -- 切斯特示例
--     ["treeseedling"] = true,       -- 树苗
--     ["deciduoustree"] = true,      -- 落叶树
--     ["evergreen"] = true,          -- 常青树
--     -- 可以在这里添加更多生物...
-- }

-- -- 生物标签列表 - 用于识别可吞噬的生物类型
-- local CREATURE_TAGS = {
--     "character", "monster", "animal", "bird", "prey", "scarytoprey", 
--     "smallcreature", "hostile", "companion", "treestump", "guardian",
--     "treeguard"                      -- 添加树精守卫专用标签
-- }

-- -- 始终允许的生物 - 无论是否有其他排除标签
-- local ALWAYS_ALLOWED = {
--     ["leif"] = true,
--     ["leif_sparse"] = true,
-- }

-- -- 检查实体是否是活的生物且在白名单中
-- local function IsLivingCreature(ent)
--     if not ent or ent:HasTag("player") or ent:HasTag("playerghost") then
--         return false
--     end
    
--     -- 特殊检查：始终允许的生物（如树精守卫）
--     if ALWAYS_ALLOWED[ent.prefab] then
--         print("特殊允许实体:", ent.prefab)
--         return ent.components.health and not ent.components.health:IsDead()
--     end
    
--     -- 检查是否有生物必须的组件且是活着的
--     local has_required_components = ent.components.health and not ent.components.health:IsDead() and
--                                    ent.components.combat
    
--     -- 检查是否有生物标签
--     local has_creature_tag = false
--     for _, tag in ipairs(CREATURE_TAGS) do
--         if ent:HasTag(tag) then
--             has_creature_tag = true
--             break
--         end
--     end
    
--     -- 检查是否在允许的生物白名单中
--     local is_allowed = ALLOWED_CREATURES[ent.prefab] == true
    
--     -- 调试输出
--     print("检查实体:", ent.prefab)
--     print("  健康组件:", has_required_components and "有" or "无")
--     print("  生物标签:", has_creature_tag and "有" or "无")
--     print("  白名单中:", is_allowed and "是" or "否")
    
--     return has_required_components and (has_creature_tag or is_allowed)
-- end

-- -- 保存实体状态
-- local function SaveEntityState(entity, reader)
--     if not entity or not IsLivingCreature(entity) then
--         print("警告: 尝试保存无效实体状态:", entity and entity.prefab or "nil")
--         return nil
--     end
    
--     local state = {
--         prefab = entity.prefab,
--         health = entity.components.health:GetPercent(),  -- 保存当前血量百分比
--         hunger = entity.components.hunger and entity.components.hunger:GetPercent() or nil,
--         sanity = entity.components.sanity and entity.components.sanity:GetPercent() or nil,
--         age = entity.components.age and entity.components.age:GetAge() or nil,
--         tags = {},
--         buffs = {},
--     }
    
--     -- 保存标签
--     if entity.tags then
--         for tag in pairs(entity.tags) do
--             state.tags[tag] = true
--         end
--     end
    
--     -- 保存部分组件数据
--     if entity.components.locomotor then
--         state.walkspeed = entity.components.locomotor.walkspeed
--         state.runspeed = entity.components.locomotor.runspeed
--     end
    
--     if entity.components.combat then
--         state.damage = entity.components.combat.defaultdamage
--     end
    
--     -- 保存buff
--     if entity.components.bufferedaction and entity.components.bufferedaction.GetBuffs then
--         for _, buff in ipairs(entity.components.bufferedaction.GetBuffs()) do
--             if buff.name then
--                 table.insert(state.buffs, buff.name)
--             end
--         end
--     end
    
--     -- 记录实体的相对位置（使用传入的 reader 作为参考点）
--     local v_x, v_y, v_z = entity.Transform:GetWorldPosition()
--     local reader_x, reader_y, reader_z = reader.Transform:GetWorldPosition()
--     state.dx = v_x - reader_x
--     state.dz = v_z - reader_z
    
--     print("成功保存实体状态:", entity.prefab)
--     return state
-- end

-- -- 恢复实体状态
-- local function RestoreEntityState(entity, state)
--     if not entity or not state then
--         print("警告: 尝试恢复无效实体状态")
--         return
--     end
    
--     print("开始恢复实体状态:", entity.prefab)
    
--     -- 恢复健康值
--     if entity.components.health and state.health then
--         entity.components.health:SetPercent(state.health)
--         print("恢复实体血量:", state.health * 100, "%")
--     end
    
--     -- 恢复饥饿值
--     if entity.components.hunger and state.hunger then
--         entity.components.hunger:SetPercent(state.hunger)
--         print("恢复实体饥饿值:", state.hunger * 100, "%")
--     end
    
--     -- 恢复理智值
--     if entity.components.sanity and state.sanity then
--         entity.components.sanity:SetPercent(state.sanity)
--         print("恢复实体理智值:", state.sanity * 100, "%")
--     end
    
--     -- 恢复年龄
--     if entity.components.age and state.age then
--         entity.components.age:SetAge(state.age)
--         print("恢复实体年龄:", state.age)
--     end
    
--     -- 恢复标签
--     for tag, _ in pairs(state.tags) do
--         if not entity:HasTag(tag) then
--             entity:AddTag(tag)
--             print("添加标签:", tag)
--         end
--     end
    
--     -- 恢复移动速度
--     if entity.components.locomotor and state.walkspeed then
--         entity.components.locomotor.walkspeed = state.walkspeed
--         entity.components.locomotor.runspeed = state.runspeed
--         print("恢复移动速度: 行走", state.walkspeed, "奔跑", state.runspeed)
--     end
    
--     -- 恢复攻击力
--     if entity.components.combat and state.damage then
--         entity.components.combat.defaultdamage = state.damage
--         print("恢复攻击力:", state.damage)
--     end
    
--     -- 恢复buffs（简化版）
--     if entity.components.bufferedaction and #state.buffs > 0 then
--         for _, buff_name in ipairs(state.buffs) do
--             print("需要恢复buff:", buff_name, "(简化版未实现)")
--             -- 实际恢复buffs需要更具体的实现
--         end
--     end
    
--     print("实体状态恢复完成:", entity.prefab)
-- end

-- -- 检查位置是否在海洋中
-- local function IsPointInOcean(x, z)
--     local ground = TheWorld.Map
--     if not ground then return false end
    
--     local tile = ground:GetTileAtPoint(x, 0, z)
--     -- 检查是否为海洋地形
--     return tile == GROUND.OCEAN_SHALLOW or 
--            tile == GROUND.OCEAN_MEDIUM or 
--            tile == GROUND.OCEAN_DEEP or 
--            tile == GROUND.OCEAN_ABYSS or
--            tile == GROUND.OCEAN_COASTAL or
--            tile == GROUND.OCEAN_SWELL or
--            tile == GROUND.OCEAN_ROUGH
-- end

-- -- 尝试寻找替代位置并释放实体
-- local function TryFindAlternativePositionAndRelease(inst, entity_state, pos_x, pos_z, reader)
--     -- 安全位置测试函数
--     local test_fn = function(offset)
--         local check_x = pos_x + offset.x
--         local check_z = pos_z + offset.z
        
--         -- 检查地面是否可通行
--         local is_passable = TheWorld.Map:IsPassableAtPoint(check_x, 0, check_z)
        
--         -- 检查是否在洞穴边缘或悬崖附近
--         local is_safe = true
--         if TheWorld:HasTag("cave") then
--             -- 在洞穴中，检查是否在深渊附近
--             local tile = TheWorld.Map:GetTileAtPoint(check_x, 0, check_z)
--             is_safe = tile ~= GROUND.IMPASSABLE and tile ~= GROUND.ROCKY
--         else
--             -- 在地面世界，检查是否在海洋附近
--             -- 使用更安全的海洋检测方法
--             if TheWorld.Map and TheWorld.Map.IsPointNearOcean then
--                 -- 如果有 IsPointNearOcean 方法则使用
--                 local is_ocean = TheWorld.Map:IsPointNearOcean(Vector3(check_x, 0, check_z), 0.5)
--                 is_safe = not is_ocean
--             else
--                 -- 没有则直接检查是否是海洋地形
--                 is_safe = not IsPointInOcean(check_x, check_z)
--             end
--         end
        
--         return is_passable and is_safe
--     end
    
--     -- 使用正确的参数顺序调用 FindValidPositionByFan
--     local start_angle = math.random() * TWOPI
--     local radius = 3
--     local attempts = 12
    
--     local offset = FindValidPositionByFan(start_angle, radius, attempts, test_fn)
    
--     if offset then
--         local offset_x = pos_x + offset.x
--         local offset_z = pos_z + offset.z
        
--         -- 再次检查是否在海洋中
--         if IsPointInOcean(offset_x, offset_z) then
--             print("警告: 找到的替代位置仍在海洋中，跳过:", entity_state.prefab)
--             return false
--         end
        
--         local entity = SpawnPrefab(entity_state.prefab)
--         if entity then
--             entity.Transform:SetPosition(offset_x, 0, offset_z)
--             RestoreEntityState(entity, entity_state)
--             if entity.SoundEmitter then
--                 entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--             end
--             print("成功释放实体(重新定位):", entity_state.prefab)
--             return true
--         else
--             print("警告: 无法生成预制体:", entity_state.prefab)
--         end
--     else
--         print("警告: 找不到合适的位置释放实体:", entity_state.prefab)
--     end
--     return false
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
    
--     print("===== 开始执行吞噬法术 =====")
--     print("施法者:", reader.prefab)
--     print("位置:", x, y, z)
    
--     -- 检查是否在海洋中
--     if IsPointInOcean(x, z) then
--         if reader.components.talker then
--             reader.components.talker:Say(GetString(reader, "ANNOUNCE_CANT_RELEASE_IN_OCEAN"))
--         end
--         print("警告: 无法在海洋中释放生物")
--         return false
--     end
    
--     -- 查找范围内的实体，排除玩家、玩家鬼魂和其他不需要的标签
--     -- 移除"tree"和"plant"标签，避免排除树精守卫
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "structure", "wall", "groundspike", "decor", "inanimate" }
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     print("搜索范围内实体数量:", #ents)
    
--     -- 输出所有找到的实体及其标签
--     for _, v in ipairs(ents) do
--         local tags_str = table.concat(v.tags or {}, ", ")
--         print("发现实体:", v.prefab, "标签:", tags_str)
--     end
    
--     -- 进一步过滤，只保留活的生物且在白名单中
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if IsLivingCreature(v) then
--             table.insert(valid_ents, v)
--             print("可吞噬实体:", v.prefab)
--         end
--     end
    
--     print("可吞噬实体数量:", #valid_ents)
    
--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量
--             local max_devour = 2000
--             local entities_to_devour = math.min(#valid_ents, max_devour)
            
--             print("开始吞噬", entities_to_devour, "个实体")
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 -- 保存实体的完整状态（传入 reader）
--                 local entity_state = SaveEntityState(v, reader)
--                 if entity_state then  -- 确保状态已正确保存
--                     table.insert(inst._stored_entities, entity_state)
                    
--                     -- 添加吞噬特效
--                     v:PushEvent("death")
--                     v:Remove()
--                     print("成功吞噬实体:", v.prefab)
--                 else
--                     -- 记录无法保存状态的实体
--                     print("警告: 无法保存实体状态:", v.prefab or "未知实体")
--                 end
--             end
            
--             -- 如果有超过最大数量的实体，显示警告
--             if #valid_ents > max_devour then
--                 if reader.components.talker then
--                     reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT"), max_devour))
--                 end
--                 print("警告: 超过最大吞噬数量，仅吞噬了", entities_to_devour, "个实体")
--             end
            
--             -- 播放吞噬成功的动画或特效
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
            
--             -- 显示吞噬数量提示
--             if reader.components.talker then
--                 reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR"), #inst._stored_entities))
--             end
--             print("吞噬完成，共吞噬", #inst._stored_entities, "个实体")
--         else
--             -- 没有可吞噬的实体
--             if reader.components.talker then
--                 reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE"))
--             end
--             print("警告: 没有找到可吞噬的实体")
--         end
--         return true
--     else
--         -- 在释放前保存实体数量
--         local entities_count = #inst._stored_entities
        
--         print("开始释放", entities_count, "个实体")
        
--         for i, entity_state in ipairs(inst._stored_entities) do
--             -- 检查相对位置是否存在
--             local pos_x, pos_z
--             if entity_state.dx and entity_state.dz then
--                 -- 使用保存的相对位置释放实体
--                 pos_x = x + entity_state.dx
--                 pos_z = z + entity_state.dz
--             else
--                 -- 如果相对位置不存在，使用随机位置
--                 print("警告: 实体相对位置不存在，使用随机位置释放:", entity_state.prefab)
--                 local theta = math.random() * TWOPI
--                 local random_radius = math.random(1, 3)
--                 pos_x = x + random_radius * math.cos(theta)
--                 pos_z = z + random_radius * math.sin(theta)
--             end
            
--             -- 检查释放位置是否有效（不在障碍物中）
--             local ground = TheWorld.Map
--             local released = false
            
--             if ground:IsPassableAtPoint(pos_x, 0, pos_z) then
--                 -- 检查是否在海洋中
--                 if IsPointInOcean(pos_x, pos_z) then
--                     print("警告: 释放位置在海洋中，尝试寻找替代位置:", entity_state.prefab)
--                     released = TryFindAlternativePositionAndRelease(inst, entity_state, pos_x, pos_z, reader)
--                 else
--                     -- 尝试在原位置释放
--                     local entity = SpawnPrefab(entity_state.prefab)
--                     if entity then  -- 确保实体已成功生成
--                         entity.Transform:SetPosition(pos_x, 0, pos_z)
                        
--                         -- 恢复实体状态
--                         RestoreEntityState(entity, entity_state)
                        
--                         -- 添加释放特效
--                         if entity.SoundEmitter then
--                             entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
--                         end
                        
--                         print("成功释放实体:", entity_state.prefab)
--                         released = true
--                     else
--                         print("警告: 无法生成预制体:", entity_state.prefab)
--                     end
--                 end
--             else
--                 -- 如果位置不可用，尝试寻找附近的可用位置
--                 print("警告: 释放位置不可通行，尝试寻找替代位置:", entity_state.prefab)
--                 released = TryFindAlternativePositionAndRelease(inst, entity_state, pos_x, pos_z, reader)
--             end
            
--             -- 如果没有成功释放，可以在这里添加额外的错误处理逻辑
--             if not released then
--                 print("最终无法释放实体:", entity_state.prefab)
--             end
--         end
        
--         -- 释放后再设为 nil
--         inst._stored_entities = nil
        
--         -- 播放释放成功的动画或特效
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
        
--         -- 使用之前保存的数量显示提示
--         if reader.components.talker then
--             reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE"), entities_count))
--         end
        
--         print("释放完成，共释放", entities_count, "个实体")
--         return true
--     end
-- end

-- -- 吞噬生物书翻阅函数
-- local function peruse_sjy_book_devour(inst, reader)
--     if reader.peruse_devour then
--         reader.peruse_devour(reader)
--     end
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_devour",
--     fn = do_sjy_book_devour_spell,
--     perusefn = peruse_sjy_book_devour,
--     read_sanity = -TUNING.SANITY_LARGE,
--     peruse_sanity = TUNING.SANITY_HUGE,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 定义一个内部函数，用于创建书的实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_devour")
--     inst.AnimState:SetBuild("sjy_book_devour")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("bookcabinet_item")

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_entities and #inst._stored_entities > 0 and "FILLED" or "EMPTY"
--     end

--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     -- 修正：使用正确的参数名
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     MakeHauntableLaunch(inst)

--     -- 修改保存/加载逻辑以支持新的数据结构
--     inst.OnSave = function(inst, data)
--         if inst._stored_entities then
--             data.stored_entities = inst._stored_entities
--         end
--     end

--     inst.OnLoad = function(inst, data)
--         if data and data.stored_entities then
--             inst._stored_entities = data.stored_entities
            
--             -- 检查并修复缺少相对位置的实体
--             for i, entity_state in ipairs(inst._stored_entities) do
--                 if not entity_state.dx or not entity_state.dz then
--                     print("警告: 加载的实体状态缺少相对位置信息:", entity_state.prefab)
--                     -- 可以选择移除这个实体，或者设置默认值
--                     -- table.remove(inst._stored_entities, i)
--                 end
--             end
--         end
--     end

--     return inst
-- end

-- -- 返回根据书的定义信息创建的预制体
-- return Prefab(def.name, fn, assets)





















-- 资源定义
local assets =
{
    Asset("ANIM", "anim/sjy_book_devour.zip"),
    Asset("IMAGE", "images/inventoryimages/sjy_book_devour.tex"),
    Asset("ATLAS", "images/inventoryimages/sjy_book_devour.xml"),
    Asset("ANIM", "anim/fx_books.zip"), 
}

-- 可吞噬生物白名单 - 这里可以添加或移除任何你想支持的生物
local ALLOWED_CREATURES = {
    ["leif"] = true,               -- 树精守卫
    ["leif_sparse"] = true,        -- 粗壮的树精守卫
    ["chester"] = true,            -- 切斯特示例
    ["treeseedling"] = true,       -- 树苗
    ["deciduoustree"] = true,      -- 落叶树
    ["evergreen"] = true,          -- 常青树
    -- 可以在这里添加更多生物...
}

-- 不可吞噬生物黑名单 - 会导致崩溃或不希望被吞噬的生物
local BLOCKED_CREATURES = {
    ["world"] = true,              -- 世界实体
    ["camera"] = true,             -- 相机实体
    ["player"] = true,             -- 玩家实体
    ["statue"] = true,             -- 雕像类实体
    ["chester_eyebone"] = true,    -- 切斯特骨眼
    ["beefalo"] = true,       -- 坎普斯背包
    ["shipwrecked"] = true,        -- 船只残骸类
    ["oceanfish"] = true,          -- 海洋鱼类（可能导致崩溃）
    ["wave"] = true,               -- 波浪特效
    ["lightning"] = true,          -- 闪电特效
    ["earthquake"] = true,         -- 地震特效
    ["crabking"] = true,           -- 帝王蟹
    

    -- 添加更多已知会导致崩溃的实体
}

-- 生物标签列表 - 用于识别可吞噬的生物类型
local CREATURE_TAGS = {
    "character", "monster", "animal", "bird", "prey", "scarytoprey", 
    "smallcreature", "hostile", "companion", "treestump", "guardian",
    "treeguard"                      -- 添加树精守卫专用标签
}

-- 始终允许的生物 - 无论是否有其他排除标签
local ALWAYS_ALLOWED = {
    ["leif"] = true,
    ["leif_sparse"] = true,
}

-- 检查实体是否有主人
local function HasOwner(ent)
    -- 检查是否有所有者组件
    if ent.components and ent.components.inventoryitem and ent.components.inventoryitem.owner then
        return true
    end
    
    -- 检查是否有归属性标签
    if ent:HasTag("owned") or ent:HasTag("pet") or ent:HasTag("follower") then
        return true
    end
    
    -- 检查是否为特定生物的跟随者
    if ent.components and ent.components.follower and ent.components.follower.leader then
        return true
    end
    
    return false
end

-- 检查实体是否是活的生物且在白名单中，不在黑名单中，且没有主人
local function IsLivingCreature(ent)
    if not ent or not ent:IsValid() then
        return false
    end
    
    -- 检查是否在黑名单中
    if BLOCKED_CREATURES[ent.prefab] then
        print("实体在黑名单中，不可吞噬:", ent.prefab)
        return false
    end
    
    -- 检查是否有主人
    if HasOwner(ent) then
        print("实体有主人，不可吞噬:", ent.prefab)
        return false
    end
    
    -- 排除玩家和玩家鬼魂
    if ent:HasTag("player") or ent:HasTag("playerghost") then
        return false
    end
    
    -- 特殊检查：始终允许的生物（如树精守卫）
    if ALWAYS_ALLOWED[ent.prefab] then
        print("特殊允许实体:", ent.prefab)
        return ent.components.health and not ent.components.health:IsDead()
    end
    
    -- 检查是否有生物必须的组件且是活着的
    local has_required_components = ent.components.health and not ent.components.health:IsDead() and
                                   ent.components.combat
    
    -- 检查是否有生物标签
    local has_creature_tag = false
    for _, tag in ipairs(CREATURE_TAGS) do
        if ent:HasTag(tag) then
            has_creature_tag = true
            break
        end
    end
    
    -- 检查是否在允许的生物白名单中
    local is_allowed = ALLOWED_CREATURES[ent.prefab] == true
    
    -- 调试输出
    print("检查实体:", ent.prefab)
    print("  健康组件:", has_required_components and "有" or "无")
    print("  生物标签:", has_creature_tag and "有" or "无")
    print("  白名单中:", is_allowed and "是" or "否")
    
    return has_required_components and (has_creature_tag or is_allowed)
end

-- 保存实体状态
local function SaveEntityState(entity, reader)
    -- 额外的安全检查
    if not entity or not entity:IsValid() or not IsLivingCreature(entity) then
        print("警告: 尝试保存无效实体状态:", entity and entity.prefab or "nil")
        return nil
    end
    
    local state = {
        prefab = entity.prefab,
        health = entity.components.health:GetPercent(),  -- 保存当前血量百分比
        hunger = entity.components.hunger and entity.components.hunger:GetPercent() or nil,
        sanity = entity.components.sanity and entity.components.sanity:GetPercent() or nil,
        age = entity.components.age and entity.components.age:GetAge() or nil,
        tags = {},
        buffs = {},
    }
    
    -- 保存标签（只保存安全的标签）
    if entity.tags then
        for tag in pairs(entity.tags) do
            -- 过滤掉可能导致问题的标签
            if tag ~= "INLIMBO" and tag ~= "NOCLICK" and tag ~= "FX" then
                state.tags[tag] = true
            end
        end
    end
    
    -- 保存部分组件数据
    if entity.components.locomotor then
        state.walkspeed = entity.components.locomotor.walkspeed
        state.runspeed = entity.components.locomotor.runspeed
    end
    
    if entity.components.combat then
        state.damage = entity.components.combat.defaultdamage
    end
    
    -- 保存buff（只保存安全的buff）
    if entity.components.debuffable then
        local buffs = entity.components.debuffable:GetAllBuffs()
        for _, buff in ipairs(buffs) do
            if buff and buff.prefab and not BLOCKED_CREATURES[buff.prefab] then
                table.insert(state.buffs, buff.prefab)
            end
        end
    end
    
    -- 记录实体的相对位置（使用传入的 reader 作为参考点）
    local v_x, v_y, v_z = entity.Transform:GetWorldPosition()
    local reader_x, reader_y, reader_z = reader.Transform:GetWorldPosition()
    state.dx = v_x - reader_x
    state.dz = v_z - reader_z
    
    print("成功保存实体状态:", entity.prefab)
    return state
end

-- 恢复实体状态
local function RestoreEntityState(entity, state)
    if not entity or not entity:IsValid() or not state then
        print("警告: 尝试恢复无效实体状态")
        return
    end
    
    print("开始恢复实体状态:", entity.prefab)
    
    -- 恢复健康值
    if entity.components.health and state.health then
        entity.components.health:SetPercent(state.health)
        print("恢复实体血量:", state.health * 100, "%")
    end
    
    -- 恢复饥饿值
    if entity.components.hunger and state.hunger then
        entity.components.hunger:SetPercent(state.hunger)
        print("恢复实体饥饿值:", state.hunger * 100, "%")
    end
    
    -- 恢复理智值
    if entity.components.sanity and state.sanity then
        entity.components.sanity:SetPercent(state.sanity)
        print("恢复实体理智值:", state.sanity * 100, "%")
    end
    
    -- 恢复年龄
    if entity.components.age and state.age then
        entity.components.age:SetAge(state.age)
        print("恢复实体年龄:", state.age)
    end
    
    -- 恢复标签
    for tag, _ in pairs(state.tags) do
        if not entity:HasTag(tag) then
            entity:AddTag(tag)
            print("添加标签:", tag)
        end
    end
    
    -- 恢复移动速度
    if entity.components.locomotor and state.walkspeed then
        entity.components.locomotor.walkspeed = state.walkspeed
        entity.components.locomotor.runspeed = state.runspeed
        print("恢复移动速度: 行走", state.walkspeed, "奔跑", state.runspeed)
    end
    
    -- 恢复攻击力
    if entity.components.combat and state.damage then
        entity.components.combat.defaultdamage = state.damage
        print("恢复攻击力:", state.damage)
    end
    
    -- 恢复buffs（安全版）
    if entity.components.debuffable and #state.buffs > 0 then
        for _, buff_name in ipairs(state.buffs) do
            -- 只恢复不在黑名单中的buff
            if not BLOCKED_CREATURES[buff_name] then
                entity:AddDebuff(buff_name, buff_name)
                print("恢复buff:", buff_name)
            else
                print("跳过黑名单中的buff:", buff_name)
            end
        end
    end
    
    print("实体状态恢复完成:", entity.prefab)
end

-- 检查位置是否在海洋中
local function IsPointInOcean(x, z)
    local ground = TheWorld.Map
    if not ground then return false end
    
    local tile = ground:GetTileAtPoint(x, 0, z)
    -- 检查是否为海洋地形
    return tile == GROUND.OCEAN_SHALLOW or 
           tile == GROUND.OCEAN_MEDIUM or 
           tile == GROUND.OCEAN_DEEP or 
           tile == GROUND.OCEAN_ABYSS or
           tile == GROUND.OCEAN_COASTAL or
           tile == GROUND.OCEAN_SWELL or
           tile == GROUND.OCEAN_ROUGH
end

-- 尝试寻找替代位置并释放实体
local function TryFindAlternativePositionAndRelease(inst, entity_state, pos_x, pos_z, reader)
    -- 安全位置测试函数
    local test_fn = function(offset)
        local check_x = pos_x + offset.x
        local check_z = pos_z + offset.z
        
        -- 检查地面是否可通行
        local is_passable = TheWorld.Map:IsPassableAtPoint(check_x, 0, check_z)
        
        -- 检查是否在洞穴边缘或悬崖附近
        local is_safe = true
        if TheWorld:HasTag("cave") then
            -- 在洞穴中，检查是否在深渊附近
            local tile = TheWorld.Map:GetTileAtPoint(check_x, 0, check_z)
            is_safe = tile ~= GROUND.IMPASSABLE and tile ~= GROUND.ROCKY
        else
            -- 在地面世界，检查是否在海洋附近
            -- 使用更安全的海洋检测方法
            if TheWorld.Map and TheWorld.Map.IsPointNearOcean then
                -- 如果有 IsPointNearOcean 方法则使用
                local is_ocean = TheWorld.Map:IsPointNearOcean(Vector3(check_x, 0, check_z), 0.5)
                is_safe = not is_ocean
            else
                -- 没有则直接检查是否是海洋地形
                is_safe = not IsPointInOcean(check_x, check_z)
            end
        end
        
        return is_passable and is_safe
    end
    
    -- 使用正确的参数顺序调用 FindValidPositionByFan
    local start_angle = math.random() * TWOPI
    local radius = 3
    local attempts = 12
    
    local offset = FindValidPositionByFan(start_angle, radius, attempts, test_fn)
    
    if offset then
        local offset_x = pos_x + offset.x
        local offset_z = pos_z + offset.z
        
        -- 再次检查是否在海洋中
        if IsPointInOcean(offset_x, offset_z) then
            print("警告: 找到的替代位置仍在海洋中，跳过:", entity_state.prefab)
            return false
        end
        
        -- 检查实体是否在黑名单中
        if BLOCKED_CREATURES[entity_state.prefab] then
            print("警告: 尝试释放黑名单中的实体，跳过:", entity_state.prefab)
            return false
        end
        
        local entity = SpawnPrefab(entity_state.prefab)
        if entity and entity:IsValid() then
            entity.Transform:SetPosition(offset_x, 0, offset_z)
            RestoreEntityState(entity, entity_state)
            if entity.SoundEmitter then
                entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
            end
            print("成功释放实体(重新定位):", entity_state.prefab)
            return true
        else
            print("警告: 无法生成预制体:", entity_state.prefab)
        end
    else
        print("警告: 找不到合适的位置释放实体:", entity_state.prefab)
    end
    return false
end

-- 吞噬生物法术执行函数
local function do_sjy_book_devour_spell(inst, reader)
    -- 安全检查：确保施法者有效
    if not reader or not reader:IsValid() then
        print("错误: 施法者无效")
        return false
    end
    
    local x, y, z = reader.Transform:GetWorldPosition()
    local range = 15  -- 增大吞噬范围
    
    print("===== 开始执行吞噬法术 =====")
    print("施法者:", reader.prefab)
    print("位置:", x, y, z)
    
    -- 检查是否在海洋中
    if IsPointInOcean(x, z) then
        if reader.components.talker then
            reader.components.talker:Say(GetString(reader, "ANNOUNCE_CANT_RELEASE_IN_OCEAN") or "不能在海洋中使用这本书!")
        end
        print("警告: 无法在海洋中释放生物")
        return false
    end
    
    -- 查找范围内的实体，排除玩家、玩家鬼魂和其他不需要的标签
    -- 移除"tree"和"plant"标签，避免排除树精守卫
    local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "structure", "wall", "groundspike", "decor", "inanimate" }
    local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
    print("搜索范围内实体数量:", #ents)
    
    -- 输出所有找到的实体及其标签
    for _, v in ipairs(ents) do
        if v and v:IsValid() then
            local tags_str = table.concat(v.tags or {}, ", ")
            print("发现实体:", v.prefab, "标签:", tags_str)
        end
    end
    
    -- 进一步过滤，只保留活的生物且在白名单中
    local valid_ents = {}
    for _, v in ipairs(ents) do
        if v and v:IsValid() and IsLivingCreature(v) then
            table.insert(valid_ents, v)
            print("可吞噬实体:", v.prefab)
        end
    end
    
    print("可吞噬实体数量:", #valid_ents)
    
    if inst._stored_entities == nil then
        inst._stored_entities = {}
        if #valid_ents > 0 then
            -- 限制最大吞噬数量
            local max_devour = 2000
            local entities_to_devour = math.min(#valid_ents, max_devour)
            
            print("开始吞噬", entities_to_devour, "个实体")
            
            for i = 1, entities_to_devour do
                local v = valid_ents[i]
                -- 再次检查实体有效性（防止在循环中实体已被移除）
                if v and v:IsValid() then
                    -- 保存实体的完整状态（传入 reader）
                    local entity_state = SaveEntityState(v, reader)
                    if entity_state then  -- 确保状态已正确保存
                        table.insert(inst._stored_entities, entity_state)
                        
                        -- 添加吞噬特效
                        v:PushEvent("death")
                        v:Remove()
                        print("成功吞噬实体:", v.prefab)
                    else
                        -- 记录无法保存状态的实体
                        print("警告: 无法保存实体状态:", v.prefab or "未知实体")
                    end
                else
                    print("警告: 实体已失效，跳过吞噬:", v and v.prefab or "未知实体")
                end
            end
            
            -- 如果有超过最大数量的实体，显示警告
            if #valid_ents > max_devour then
                if reader.components.talker then
                    reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT") or "只能吞噬最多 %d 个实体", max_devour))
                end
                print("警告: 超过最大吞噬数量，仅吞噬了", entities_to_devour, "个实体")
            end
            
            -- 播放吞噬成功的动画或特效
            inst.AnimState:PlayAnimation("active")
            inst.AnimState:PushAnimation("idle")
            
            -- 显示吞噬数量提示
            if reader.components.talker then
                reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR") or "吞噬了 %d 个实体", #inst._stored_entities))
            end
            print("吞噬完成，共吞噬", #inst._stored_entities, "个实体")
        else
            -- 没有可吞噬的实体
            if reader.components.talker then
                reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE") or "没有找到可吞噬的实体")
            end
            print("警告: 没有找到可吞噬的实体")
        end
        return true
    else
        -- 在释放前保存实体数量
        local entities_count = #inst._stored_entities
        
        print("开始释放", entities_count, "个实体")
        
        -- 创建临时表来存储无法释放的实体
        local failed_entities = {}
        
        for i, entity_state in ipairs(inst._stored_entities) do
            -- 检查实体是否在黑名单中
            if BLOCKED_CREATURES[entity_state.prefab] then
                print("警告: 尝试释放黑名单中的实体，跳过:", entity_state.prefab)
                table.insert(failed_entities, entity_state)
            else
                -- 检查相对位置是否存在
                local pos_x, pos_z
                if entity_state.dx and entity_state.dz then
                    -- 使用保存的相对位置释放实体
                    pos_x = x + entity_state.dx
                    pos_z = z + entity_state.dz
                else
                    -- 如果相对位置不存在，使用随机位置
                    print("警告: 实体相对位置不存在，使用随机位置释放:", entity_state.prefab)
                    local theta = math.random() * TWOPI
                    local random_radius = math.random(1, 3)
                    pos_x = x + random_radius * math.cos(theta)
                    pos_z = z + random_radius * math.sin(theta)
                end
                
                -- 检查释放位置是否有效（不在障碍物中）
                local ground = TheWorld.Map
                local released = false
                
                if ground and ground:IsPassableAtPoint(pos_x, 0, pos_z) then
                    -- 检查是否在海洋中
                    if IsPointInOcean(pos_x, pos_z) then
                        print("警告: 释放位置在海洋中，尝试寻找替代位置:", entity_state.prefab)
                        released = TryFindAlternativePositionAndRelease(inst, entity_state, pos_x, pos_z, reader)
                    else
                        -- 尝试在原位置释放
                        local entity = SpawnPrefab(entity_state.prefab)
                        if entity and entity:IsValid() then  -- 确保实体已成功生成
                            entity.Transform:SetPosition(pos_x, 0, pos_z)
                            
                            -- 恢复实体状态
                            RestoreEntityState(entity, entity_state)
                            
                            -- 添加释放特效
                            if entity.SoundEmitter then
                                entity.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
                            end
                            
                            print("成功释放实体:", entity_state.prefab)
                            released = true
                        else
                            print("警告: 无法生成预制体:", entity_state.prefab)
                        end
                    end
                else
                    -- 如果位置不可用，尝试寻找附近的可用位置
                    print("警告: 释放位置不可通行，尝试寻找替代位置:", entity_state.prefab)
                    released = TryFindAlternativePositionAndRelease(inst, entity_state, pos_x, pos_z, reader)
                end
                
                -- 如果没有成功释放，保存到失败列表
                if not released then
                    print("最终无法释放实体:", entity_state.prefab)
                    table.insert(failed_entities, entity_state)
                end
            end
        end
        
        -- 保留无法释放的实体
        inst._stored_entities = #failed_entities > 0 and failed_entities or nil
        
        -- 播放释放成功的动画或特效
        inst.AnimState:PlayAnimation("release")
        inst.AnimState:PushAnimation("idle")
        
        -- 使用之前保存的数量显示提示
        if reader.components.talker then
            local released_count = entities_count - #failed_entities
            reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE") or "释放了 %d 个实体", released_count))
            
            -- 提示无法释放的实体
            if #failed_entities > 0 then
                reader.components.talker:Say(string.format("有 %d 个实体无法释放", #failed_entities))
            end
        end
        
        print("释放完成，共释放", entities_count - #failed_entities, "个实体，", #failed_entities, "个实体无法释放")
        return true
    end
end

-- 吞噬生物书翻阅函数
local function peruse_sjy_book_devour(inst, reader)
    if not reader or not reader:IsValid() then
        return false
    end
    
    if reader.peruse_devour then
        reader.peruse_devour(reader)
    end
    reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR") or "这本书充满了吞噬的力量...")
    return true
end

-- 定义书的定义信息
local def = {
    name = "sjy_book_devour",
    fn = do_sjy_book_devour_spell,
    perusefn = peruse_sjy_book_devour,
    read_sanity = -TUNING.SANITY_LARGE,
    peruse_sanity = TUNING.SANITY_HUGE,
    fx = nil,
    fxmount = nil,
}

-- 定义一个内部函数，用于创建书的实体
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sjy_book_devour")
    inst.AnimState:SetBuild("sjy_book_devour")
    inst.AnimState:PlayAnimation("idle")
    inst.scrapbook_anim = def.name

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst:AddTag("book")
    inst:AddTag("bookcabinet_item")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.def = def
    inst.swap_build = "swap_books"
    inst.swap_prefix = def.name

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        return inst._stored_entities and #inst._stored_entities > 0 and "FILLED" or "EMPTY"
    end

    inst:AddComponent("book")
    inst.components.book:SetOnRead(def.fn)
    inst.components.book:SetOnPeruse(def.perusefn)
    inst.components.book:SetReadSanity(def.read_sanity)
    -- 修正：使用正确的参数名
    inst.components.book:SetPeruseSanity(def.peruse_sanity)

    if def.fx and def.fxmount then
        inst.components.book:SetFx(def.fx, def.fxmount)
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_devour.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    MakeHauntableLaunch(inst)

    -- 修改保存/加载逻辑以支持新的数据结构
    inst.OnSave = function(inst, data)
        if inst._stored_entities and #inst._stored_entities > 0 then
            -- 过滤掉黑名单中的实体
            local filtered_entities = {}
            for _, entity_state in ipairs(inst._stored_entities) do
                if not BLOCKED_CREATURES[entity_state.prefab] then
                    table.insert(filtered_entities, entity_state)
                else
                    print("保存时过滤掉黑名单中的实体:", entity_state.prefab)
                end
            end
            if #filtered_entities > 0 then
                data.stored_entities = filtered_entities
            end
        end
    end

    inst.OnLoad = function(inst, data)
        if data and data.stored_entities then
            -- 过滤掉黑名单中的实体
            local filtered_entities = {}
            for _, entity_state in ipairs(data.stored_entities) do
                if not BLOCKED_CREATURES[entity_state.prefab] then
                    table.insert(filtered_entities, entity_state)
                else
                    print("加载时过滤掉黑名单中的实体:", entity_state.prefab)
                end
            end
            
            inst._stored_entities = #filtered_entities > 0 and filtered_entities or nil
            
            -- 检查并修复缺少相对位置的实体
            if inst._stored_entities then
                for i, entity_state in ipairs(inst._stored_entities) do
                    if not entity_state.dx or not entity_state.dz then
                        print("警告: 加载的实体状态缺少相对位置信息:", entity_state.prefab)
                        -- 设置默认相对位置
                        entity_state.dx = math.random(-2, 2)
                        entity_state.dz = math.random(-2, 2)
                    end
                end
            end
        end
    end

    return inst
end

-- 返回根据书的定义信息创建的预制体
return Prefab(def.name, fn, assets)
