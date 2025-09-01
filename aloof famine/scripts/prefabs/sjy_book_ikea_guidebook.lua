-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_ikea_guidebook.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_ikea_guidebook.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_ikea_guidebook.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 不可吞噬的实体清单
-- local BLACKLISTED_ENTITIES = {
--     -- 玩家和生物相关
--     ["player"] = true,
--     ["playerghost"] = true,
--     ["abigail"] = true,
--     ["shadowminion"] = true,
    
--     -- 地形和特殊结构
--     ["cave_exit"] = true,
--     ["cave_entrance"] = true,
--     ["cave_entrance_open"] = true,
--     ["wormhole"] = true,
    
--     -- 自身排除
--     ["sjy_book_ikea_guidebook"] = true,
-- }

-- -- 检查实体是否可被吞噬（排除黑名单、非建筑实体）
-- local function IsEntityDevourable(ent)
--     if not ent or not ent.prefab then
--         return false
--     end
    
--     -- 黑名单实体不可吞噬
--     if BLACKLISTED_ENTITIES[ent.prefab] then
--         return false
--     end
    
--     -- 仅允许建筑类实体（带structure标签）
--     return ent:HasTag("structure")
-- end

-- -- 保存实体状态（包括容器内容和相对位置）
-- local function SaveEntityState(entity, player_pos)
--     if not entity then
--         return nil
--     end
    
--     -- 计算与玩家的相对位置
--     local ent_x, ent_y, ent_z = entity.Transform:GetWorldPosition()
--     local relative_pos = {
--         x = ent_x - player_pos.x,
--         z = ent_z - player_pos.z
--     }
    
--     local state = {
--         prefab = entity.prefab,
--         health = entity.components.health and entity.components.health:GetPercent() or 1.0,
--         relative_pos = relative_pos,
--         container_items = {},  -- 容器内物品
--         orientation = entity.Transform:GetRotation(),  -- 旋转角度
--         tags = {},
--     }
    
--     -- 保存标签
--     if entity.tags then
--         for tag in pairs(entity.tags) do
--             state.tags[tag] = true
--         end
--     end
    
--     -- 保存容器内容（仅记录必要信息，避免依赖Load方法）
--     if entity.components.container then
--         for slot = 1, entity.components.container:GetNumSlots() do
--             local item = entity.components.container:GetItemInSlot(slot)
--             if item then
--                 -- 只保存预制体和堆叠数量（通用且安全）
--                 local item_data = {
--                     prefab = item.prefab,
--                     stacksize = item.components.stackable and item.components.stackable.stacksize or 1
--                 }
--                 table.insert(state.container_items, item_data)
--             end
--         end
--     end
    
--     return state
-- end

-- -- 恢复实体状态（兼容无Load方法的物品）
-- local function RestoreEntityState(entity, state, player_pos)
--     if not entity or not state then
--         return
--     end
    
--     -- 恢复相对位置
--     local pos_x = player_pos.x + state.relative_pos.x
--     local pos_z = player_pos.z + state.relative_pos.z
--     entity.Transform:SetPosition(pos_x, 0, pos_z)
--     entity.Transform:SetRotation(state.orientation)
    
--     -- 恢复健康值
--     if entity.components.health and state.health then
--         entity.components.health:SetPercent(state.health)
--     end
    
--     -- 恢复标签
--     for tag, _ in pairs(state.tags) do
--         if not entity:HasTag(tag) then
--             entity:AddTag(tag)
--         end
--     end
    
--     -- 恢复容器内容（不依赖Load方法，通用兼容）
--     if entity.components.container and #state.container_items > 0 then
--         entity.components.container:Close()  -- 先关闭容器
        
--         for slot, item_data in ipairs(state.container_items) do
--             local item = SpawnPrefab(item_data.prefab)
--             if item then
--                 -- 处理堆叠数量（兼容堆叠物品）
--                 if item.components.stackable and item_data.stacksize and item_data.stacksize > 1 then
--                     item.components.stackable:SetStackSize(item_data.stacksize)
--                 end
                
--                 -- 放入对应槽位
--                 if slot <= entity.components.container:GetNumSlots() then
--                     entity.components.container:GiveItem(item, slot)
--                 else
--                     entity.components.container:GiveItem(item)  -- 超出槽位则自动适配
--                 end
--             end
--         end
--     end
-- end

-- -- 吞噬/释放建筑核心逻辑
-- local function do_ikea_guide_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local player_pos = {x = x, z = z}  -- 玩家当前位置（仅x/z）
--     local range = 25  -- 吞噬范围
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "companion", "character" }
    
--     -- 查找范围内实体
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 过滤可吞噬的建筑
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if IsEntityDevourable(v) then
--             table.insert(valid_ents, v)
--         end
--     end

--     -- 状态1：吞噬建筑
--     if inst._stored_buildings == nil then
--         inst._stored_buildings = {}
        
--         if #valid_ents > 0 then
--             local max_devour = 200  -- 最大吞噬数量
--             local entities_to_devour = math.min(#valid_ents, max_devour)
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 local entity_state = SaveEntityState(v, player_pos)
--                 if entity_state then
--                     table.insert(inst._stored_buildings, entity_state)
                    
--                     -- 吞噬特效
--                     if v.components.health and not v.components.health:IsDead() then
--                         v:PushEvent("death")
--                     end
--                     v:Remove()
--                 else
--                     print("警告: 无法保存建筑状态:", v.prefab or "未知")
--                 end
--             end
            
--             -- 提示信息
--             if reader.components.talker then
--                 reader.components.talker:Say("收纳了 " .. #inst._stored_buildings .. " 个建筑!")
--             end
--             inst.AnimState:PlayAnimation("active")
--             inst.AnimState:PushAnimation("idle")
--         else
--             if reader.components.talker then
--                 reader.components.talker:Say("附近没有可收纳的建筑!")
--             end
--         end
--         return true
    
--     -- 状态2：释放建筑
--     else
--         local buildings_count = #inst._stored_buildings
        
--         for i, building_state in ipairs(inst._stored_buildings) do
--             local building = SpawnPrefab(building_state.prefab)
--             if building then
--                 RestoreEntityState(building, building_state, player_pos)
                
--                 -- 生成特效
--                 if building.AnimState then
--                     building.AnimState:PlayAnimation("place")
--                     building.AnimState:PushAnimation("idle", true)
--                 end
--             else
--                 print("警告: 无法生成建筑:", building_state.prefab)
--             end
--         end
        
--         -- 清空存储
--         inst._stored_buildings = nil
        
--         -- 提示信息
--         if reader.components.talker then
--             reader.components.talker:Say("释放了 " .. buildings_count .. " 个建筑!")
--         end
--         inst.AnimState:PlayAnimation("release")
--         inst.AnimState:PushAnimation("idle")
--         return true
--     end
-- end

-- -- 翻阅函数
-- local function peruse_ikea_guide(inst, reader)
--     if reader.components.talker then
--         reader.components.talker:Say("右键点击收纳/释放建筑")
--     end
--     return true
-- end

-- -- 书籍定义
-- local def = {
--     name = "sjy_book_ikea_guidebook",
--     fn = do_ikea_guide_spell,
--     perusefn = peruse_ikea_guide,
--     read_sanity = -TUNING.SANITY_MED,
--     peruse_sanity = -TUNING.SANITY_SMALL,
--     fx = nil,
--     fxmount = nil,
-- }

-- -- 创建实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     inst.AnimState:SetBank("sjy_book_ikea_guidebook")
--     inst.AnimState:SetBuild("sjy_book_ikea_guidebook")
--     inst.AnimState:PlayAnimation("idle")
--     inst.scrapbook_anim = def.name

--     MakeInventoryFloatable(inst, "med", nil, 0.75)

--     inst:AddTag("book")
--     inst:AddTag("ikea_item")

--     inst.entity:SetPristine()
--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     -- 检查状态
--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_buildings and #inst._stored_buildings > 0 
--             and "收纳了 " .. #inst._stored_buildings .. " 个建筑" 
--             or "空的"
--     end

--     -- 书籍组件
--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     -- 物品栏
--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_ikea_guidebook.xml"

--     -- 燃料
--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL

--     -- 燃烧特性
--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)

--     -- 作祟
--     MakeHauntableLaunch(inst)

--     -- 存档/读档
--     inst.OnSave = function(inst, data)
--         if inst._stored_buildings then
--             data.stored_buildings = inst._stored_buildings
--         end
--     end
--     inst.OnLoad = function(inst, data)
--         if data and data.stored_buildings then
--             inst._stored_buildings = data.stored_buildings
--         end
--     end

--     return inst
-- end

-- return Prefab(def.name, fn, assets)


































-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_ikea_guidebook.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_ikea_guidebook.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_ikea_guidebook.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 不可吞噬的实体清单
-- local BLACKLISTED_ENTITIES = {
--     ["player"] = true,
--     ["playerghost"] = true,
--     ["abigail"] = true,
--     ["shadowminion"] = true,
--     ["sjy_book_ikea_guidebook"] = true, -- 自身排除
-- }

-- -- 生物标签（排除非建筑实体）
-- local CREATURE_TAGS = { "character", "monster", "animal", "companion" }

-- -- 特殊建筑列表（需要额外处理的实体）
-- local SPECIAL_BUILDINGS = {
--     -- 基础建筑
--     ["cookpot"] = true,
--     ["treasurechest"] = true,
--     ["dragonflychest"] = true,
--     ["icebox"] = true,
--     ["pandoraschest"] = true,
    
--     -- 科技建筑
--     ["researchlab"] = true,
--     ["researchlab2"] = true,
--     ["researchlab3"] = true,
--     ["researchlab4"] = true,
--     ["alchemyengine"] = true,
    
--     -- 其他功能性建筑
--     ["birdcage"] = true,
--     ["beebox"] = true,
--     ["rabbit_hutch"] = true,
--     ["nightlight"] = true,
--     ["lightning_rod"] = true,
-- }

-- -- 特殊建筑的默认材质映射
-- local BUILDING_DEFAULT_BUILDS = {
--     ["cookpot"] = "cookpot",
--     ["treasurechest"] = "treasurechest",
--     ["dragonflychest"] = "dragonflychest",
--     ["icebox"] = "icebox",
--     ["pandoraschest"] = "pandoraschest",
--     ["researchlab"] = "researchlab",
--     ["researchlab2"] = "researchlab2",
--     ["researchlab3"] = "researchlab3",
--     ["researchlab4"] = "researchlab4",
--     ["alchemyengine"] = "alchemyengine",
--     ["birdcage"] = "birdcage",
--     ["beebox"] = "beebox",
--     ["rabbit_hutch"] = "rabbit_hutch",
--     ["nightlight"] = "nightlight",
--     ["lightning_rod"] = "lightning_rod",
-- }

-- -- 特殊实体处理函数
-- local function GetEntityAnimationInfo(entity)
--     if not entity.AnimState then
--         return {
--             current_anim = "idle",
--             loop = true,
--             time = 0
--         }
--     end
    
--     -- 特殊处理：某些实体虽然有AnimState组件，但没有动画
--     local prefab = entity.prefab
--     if prefab == "dragonflychest" then
--         return {
--             current_anim = entity.AnimState:IsCurrentAnimation("open") and "open" or "closed",
--             loop = true,
--             time = 0
--         }
--     end
    
--     -- 通用处理：检查AnimState组件及其方法是否存在
--     if type(entity.AnimState.GetCurrentAnimation) == "function" then
--         return {
--             current_anim = entity.AnimState:GetCurrentAnimation(),
--             loop = entity.AnimState:IsCurrentAnimationLooping(),
--             time = entity.AnimState:GetCurrentAnimationTime()
--         }
--     end
    
--     -- 默认值
--     return {
--         current_anim = "idle",
--         loop = true,
--         time = 0
--     }
-- end

-- -- 检查实体是否可被吞噬
-- local function IsEntityDevourable(ent)
--     if not ent or not ent.prefab then
--         return false
--     end
--     if BLACKLISTED_ENTITIES[ent.prefab] then
--         return false
--     end
--     for _, tag in ipairs(CREATURE_TAGS) do
--         if ent:HasTag(tag) then
--             return false
--         end
--     end
--     return true
-- end

-- -- 保存实体状态（增强版，保存更多信息）
-- local function SaveEntityState(entity, player_pos)
--     if not entity then
--         return nil
--     end
    
--     -- 调试日志
--     if entity.prefab == "cookpot" or entity.prefab == "treasurechest" then
--         print("保存实体状态:", entity.prefab, entity.AnimState)
--     end
    
--     -- 相对位置
--     local ent_x, _, ent_z = entity.Transform:GetWorldPosition()
--     local rel_pos = {
--         x = ent_x - player_pos.x,
--         z = ent_z - player_pos.z
--     }
    
--     local state = {
--         prefab = entity.prefab,
--         health = entity.components.health and entity.components.health:GetPercent() or 1.0,
--         rel_pos = rel_pos,
--         rotation = entity.Transform:GetRotation(),
--         tags = {},
--         container = {},
--         skinname = entity.skinname or entity:GetSkinName(),
--         anim = GetEntityAnimationInfo(entity),
--         special_data = {},
--     }
    
--     -- 保存标签
--     if entity.tags then
--         for tag in pairs(entity.tags) do
--             state.tags[tag] = true
--         end
--     end
    
--     -- 保存容器内容
--     if entity.components.container then
--         for slot = 1, entity.components.container:GetNumSlots() do
--             local item = entity.components.container:GetItemInSlot(slot)
--             if item then
--                 table.insert(state.container, {
--                     prefab = item.prefab,
--                     stacksize = item.components.stackable and item.components.stackable.stacksize or 1,
--                     skinname = item.skinname or item:GetSkinName(),
--                     anim = GetEntityAnimationInfo(item),
--                 })
--             end
--         end
--     end
    
--     -- 特殊建筑保存额外数据
--     if SPECIAL_BUILDINGS[entity.prefab] then
--         -- 针对烹饪锅保存烹饪状态
--         if entity.prefab == "cookpot" and entity.components.cooker then
--             state.special_data.cooking = entity.components.cooker.cooking
--             state.special_data.product = entity.components.cooker.product
--             state.special_data.cooktime = entity.components.cooker:GetCookTime()
--             state.special_data.cookleft = entity.components.cooker:GetTimeToCook()
--             state.special_data.ingredients = {}
            
--             -- 保存食材信息
--             if entity.components.cooker.ingredients then
--                 for k, v in pairs(entity.components.cooker.ingredients) do
--                     state.special_data.ingredients[k] = v
--                 end
--             end
--         end
        
--         -- 针对箱子保存开启状态
--         if entity.components.container then
--             state.special_data.open = entity.components.container:IsOpen()
--         end
        
--         -- 针对光源保存亮度
--         if entity.components.lightfx then
--             state.special_data.light = {
--                 radius = entity.components.lightfx:GetRadius(),
--                 intensity = entity.components.lightfx:GetIntensity(),
--                 falloff = entity.components.lightfx:GetFalloff(),
--                 colour = {entity.components.lightfx:GetColour()},
--             }
--         end
        
--         -- 针对科技建筑保存研究状态
--         if entity.prefab:find("researchlab") or entity.prefab == "alchemyengine" then
--             state.special_data.techtree = entity.components.techtree and entity.components.techtree.techtree or nil
--         end
--     end
    
--     -- 保存装饰物品
--     if entity.components.decoratable then
--         state.special_data.decor_item = entity.components.decoratable.item and entity.components.decoratable.item.prefab or nil
--     end
    
--     return state
-- end

-- -- 创建新实体（增强版，确保所有预制体都能正确创建和初始化）
-- local function CreateNewEntity(state, player_pos)
--     if not state or not state.prefab then
--         return nil
--     end
    
--     -- 计算绝对位置
--     local pos_x = player_pos.x + state.rel_pos.x
--     local pos_z = player_pos.z + state.rel_pos.z
    
--     -- 创建新的prefab实例
--     local ent = SpawnPrefab(state.prefab)
--     if not ent then
--         print("无法生成prefab:", state.prefab)
--         return nil
--     end
    
--     -- 设置位置和旋转
--     ent.Transform:SetPosition(pos_x, 0, pos_z)
--     ent.Transform:SetRotation(state.rotation)
    
--     -- 设置健康值
--     if ent.components.health and state.health then
--         ent.components.health:SetPercent(state.health)
--     end
    
--     -- 添加标签
--     for tag in pairs(state.tags) do
--         if not ent:HasTag(tag) then
--             ent:AddTag(tag)
--         end
--     end
    
--     -- 设置皮肤
--     if state.skinname and ent.SetSkin then
--         ent:SetSkin(state.skinname)
--     end
    
--     -- 特殊建筑处理
--     if SPECIAL_BUILDINGS[state.prefab] then
--         -- 烹饪锅状态恢复
--         if state.prefab == "cookpot" and ent.components.cooker and state.special_data.cooking then
--             if state.special_data.product then
--                 -- 重新添加食材
--                 if state.special_data.ingredients then
--                     for ingredient, count in pairs(state.special_data.ingredients) do
--                         for i = 1, count do
--                             local item = SpawnPrefab(ingredient)
--                             if item then
--                                 ent.components.cooker:AddIngredient(item)
--                             end
--                         end
--                     end
--                 end
                
--                 -- 开始烹饪
--                 ent.components.cooker:StartCooking(state.special_data.product, state.special_data.cooktime)
                
--                 -- 恢复剩余烹饪时间
--                 if state.special_data.cookleft and state.special_data.cookleft < state.special_data.cooktime then
--                     ent.components.cooker:SetTimeToCook(state.special_data.cookleft)
--                 end
--             end
--         end
        
--         -- 箱子开启状态
--         if ent.components.container and state.special_data.open ~= nil then
--             -- 先确保容器关闭，再设置开启状态
--             ent.components.container:Close()
            
--             ent:DoTaskInTime(0, function()
--                 if state.special_data.open then
--                     ent.components.container:Open()
--                 end
--             end)
--         end
        
--         -- 光源状态
--         if ent.components.lightfx and state.special_data.light then
--             ent.components.lightfx:SetRadius(state.special_data.light.radius)
--             ent.components.lightfx:SetIntensity(state.special_data.light.intensity)
--             ent.components.lightfx:SetFalloff(state.special_data.light.falloff)
--             ent.components.lightfx:SetColour(unpack(state.special_data.light.colour))
--         end
        
--         -- 科技建筑研究状态
--         if (state.prefab:find("researchlab") or state.prefab == "alchemyengine") and 
--            ent.components.techtree and state.special_data.techtree then
--             ent.components.techtree.techtree = state.special_data.techtree
--         end
        
--         -- 恢复装饰物品
--         if ent.components.decoratable and state.special_data.decor_item then
--             local decor_item = SpawnPrefab(state.special_data.decor_item)
--             if decor_item then
--                 ent.components.decoratable:AddItem(decor_item)
--             end
--         end
--     end
    
--     -- 设置动画状态
--     if ent.AnimState and state.anim.current_anim then
--         -- 确保动画正确设置
--         ent.AnimState:PlayAnimation(state.anim.current_anim, state.anim.loop)
        
--         -- 设置动画时间
--         if state.anim.time and type(state.anim.time) == "number" then
--             ent.AnimState:SetTime(state.anim.time)
--         end
--     end
    
--     -- 设置容器内容（增强版）
--     if ent.components.container and #state.container > 0 then
--         ent.components.container:Close()
        
--         -- 等待一帧，确保容器完全关闭
--         ent:DoTaskInTime(0, function()
--             for slot, item_data in ipairs(state.container) do
--                 local item = SpawnPrefab(item_data.prefab)
--                 if item then
--                     -- 设置物品皮肤
--                     if item_data.skinname and item.SetSkin then
--                         item:SetSkin(item_data.skinname)
--                     end
                    
--                     -- 设置堆叠数量
--                     if item.components.stackable and item_data.stacksize and item_data.stacksize > 1 then
--                         item.components.stackable:SetStackSize(item_data.stacksize)
--                     end
                    
--                     -- 设置物品动画状态
--                     if item.AnimState and item_data.anim and item_data.anim.current_anim then
--                         item.AnimState:PlayAnimation(item_data.anim.current_anim, item_data.anim.loop)
--                         if item_data.anim.time and type(item_data.anim.time) == "number" then
--                             item.AnimState:SetTime(item_data.anim.time)
--                         end
--                     end
                    
--                     -- 放入容器
--                     if slot <= ent.components.container:GetNumSlots() then
--                         ent.components.container:GiveItem(item, slot)
--                     else
--                         ent.components.container:GiveItem(item)
--                     end
--                 end
--             end
            
--             -- 恢复容器开启状态
--             if ent.components.container and state.special_data.open then
--                 ent:DoTaskInTime(0.1, function()
--                     ent.components.container:Open()
--                 end)
--             end
--         end)
--     end
    
--     -- 特殊预制体的额外初始化
--     if state.prefab == "nightlight" then
--         -- 确保夜灯正确初始化
--         if ent.components.fueled then
--             ent.components.fueled:InitializeFuelLevel(ent.components.fueled.maxfuel * state.health)
--         end
--     elseif state.prefab == "lightning_rod" then
--         -- 确保避雷针正确初始化
--         if ent.components.aoetargeting then
--             ent.components.aoetargeting:Activate()
--         end
--     end
    
--     -- 播放放置动画
--     if ent.AnimState and not ent.AnimState:IsCurrentAnimation("place") then
--         ent.AnimState:PlayAnimation("place")
--         ent.AnimState:PushAnimation(state.anim.current_anim or "idle", state.anim.loop or true)
--     end
    
--     -- 特殊效果
--     if ent.SoundEmitter then
--         ent.SoundEmitter:PlaySound("dontstarve/common/place_structure_stone")
--     end
    
--     return ent
-- end

-- -- 吞噬/释放核心逻辑
-- local function do_ikea_guide_spell(inst, reader)
--     local px, py, pz = reader.Transform:GetWorldPosition()
--     local player_pos = { x = px, z = pz }
--     local range = 25
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX" }
    
--     -- 合并生物标签
--     for _, tag in ipairs(CREATURE_TAGS) do
--         table.insert(CANT_TAGS, tag)
--     end
    
--     -- 查找并过滤实体
--     local ents = TheSim:FindEntities(px, py, pz, range, nil, CANT_TAGS)
--     local devourable_ents = {}
--     for _, ent in ipairs(ents) do
--         if IsEntityDevourable(ent) then
--             table.insert(devourable_ents, ent)
--         end
--     end

--     -- 吞噬实体
--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #devourable_ents > 0 then
--             local max_devour = 200
--             local num_to_devour = math.min(#devourable_ents, max_devour)
            
--             -- 分批处理，避免卡顿
--             local batch_size = 10
--             local batches = math.ceil(num_to_devour / batch_size)
            
--             for batch = 1, batches do
--                 inst:DoTaskInTime((batch-1) * 0.1, function()
--                     local start_idx = (batch-1) * batch_size + 1
--                     local end_idx = math.min(batch * batch_size, num_to_devour)
                    
--                     for i = start_idx, end_idx do
--                         local ent = devourable_ents[i]
--                         local ent_state = SaveEntityState(ent, player_pos)
--                         if ent_state then
--                             table.insert(inst._stored_entities, ent_state)
                            
--                             -- 播放消失效果
--                             if ent.AnimState then
--                                 ent.AnimState:PlayAnimation("disappear")
--                             end
                            
--                             -- 添加消失音效
--                             if ent.SoundEmitter then
--                                 ent.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
--                             end
                            
--                             -- 延迟删除实体，确保动画播放完成
--                             ent:DoTaskInTime(0.5, function()
--                                 if ent.components.health and not ent.components.health:IsDead() then
--                                     ent:PushEvent("death")
--                                 end
--                                 ent:Remove()
--                             end)
--                         end
--                     end
                    
--                     -- 最后一批处理完成后更新UI
--                     if batch == batches then
--                         if reader.components.talker then
--                             reader.components.talker:Say(string.format("收纳了 %d 个物品!", #inst._stored_entities))
--                         end
--                         inst.AnimState:PlayAnimation("active")
--                         inst.AnimState:PushAnimation("idle")
--                     end
--                 end)
--             end
--         else
--             if reader.components.talker then
--                 reader.components.talker:Say("附近没有可收纳的物品!")
--             end
--         end
--         return true
    
--     -- 释放实体
--     else
--         local release_count = #inst._stored_entities
        
--         -- 分批释放实体，避免性能问题
--         local batch_size = 10
--         local batches = math.ceil(release_count / batch_size)
        
--         for batch = 1, batches do
--             inst:DoTaskInTime((batch-1) * 0.1, function()
--                 local start_idx = (batch-1) * batch_size + 1
--                 local end_idx = math.min(batch * batch_size, release_count)
                
--                 for i = start_idx, end_idx do
--                     local ent_state = inst._stored_entities[i]
--                     if ent_state then
--                         -- 创建新实体
--                         local ent = CreateNewEntity(ent_state, player_pos)
--                     end
--                 end
                
--                 -- 最后一批释放后清理存储
--                 if batch == batches then
--                     inst._stored_entities = nil
--                     if reader.components.talker then
--                         reader.components.talker:Say(string.format("释放了 %d 个物品!", release_count))
--                     end
--                     inst.AnimState:PlayAnimation("release")
--                     inst.AnimState:PushAnimation("idle")
--                 end
--             end)
--         end
        
--         return true
--     end
-- end

-- -- 翻阅函数
-- local function peruse_ikea_guide(inst, reader)
--     if reader.components.talker then
--         reader.components.talker:Say("右键点击收纳/释放物品")
--     end
--     return true
-- end

-- -- 书籍定义
-- local def = {
--     name = "sjy_book_ikea_guidebook",
--     fn = do_ikea_guide_spell,
--     perusefn = peruse_ikea_guide,
--     read_sanity = -TUNING.SANITY_MED,
--     peruse_sanity = -TUNING.SANITY_SMALL,
-- }

-- -- 创建实体
-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)
--     inst.AnimState:SetBank("sjy_book_ikea_guidebook")
--     inst.AnimState:SetBuild("sjy_book_ikea_guidebook")
--     inst.AnimState:PlayAnimation("idle")

--     MakeInventoryFloatable(inst, "med", nil, 0.75)
--     inst:AddTag("book")
--     inst:AddTag("ikea_item")

--     inst.entity:SetPristine()
--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst.def = def
--     inst.swap_build = "swap_books"
--     inst.swap_prefix = def.name

--     inst:AddComponent("inspectable")
--     inst.components.inspectable.getstatus = function(inst)
--         return inst._stored_entities 
--             and string.format("收纳了 %d 个物品", #inst._stored_entities) 
--             or "空的"
--     end

--     inst:AddComponent("book")
--     inst.components.book:SetOnRead(def.fn)
--     inst.components.book:SetOnPeruse(def.perusefn)
--     inst.components.book:SetReadSanity(def.read_sanity)
--     inst.components.book:SetPeruseSanity(def.peruse_sanity)

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_ikea_guidebook.xml"

--     inst:AddComponent("fuel")
--     inst.components.fuel.fuelvalue = TUNING.MED_FUEL
--     MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
--     MakeSmallPropagator(inst)
--     MakeHauntableLaunch(inst)

--     -- 存档/读档
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

-- return Prefab(def.name, fn, assets)












































-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_ikea_guidebook.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_ikea_guidebook.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_ikea_guidebook.xml"),
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
--     local range = 25  -- 增大吞噬范围
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "companion", "character" }  -- 添加玩家、玩家鬼魂和同伴标签
    
--     -- 查找范围内的实体
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 进一步过滤，排除黑名单中的实体
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if not IsEntityBlacklisted(v) then
--             table.insert(valid_ents, v)
--         end
--     end

--     if inst._stored_entities == nil then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量（可选）
--             local max_devour = 200
--             local entities_to_devour = #valid_ents > max_devour and max_devour or #valid_ents
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 local v_x, v_y, v_z = v.Transform:GetWorldPosition()
--                 local dx = v_x - x
--                 local dz = v_z - z
--                 local container_data = nil
--                 if v.components.container then
--                     container_data = {}
--                     for j = 1, v.components.container.numslots do
--                         local item = v.components.container:GetItemInSlot(j)
--                         if item then
--                             container_data[j] = item.prefab
--                             item:Remove()
--                         end
--                     end
--                 end
--                 table.insert(inst._stored_entities, {
--                     prefab = v.prefab,
--                     dx = dx,
--                     dz = dz,
--                     container_data = container_data
--                 })
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
        
--         for i, data in ipairs(inst._stored_entities) do
--             local pos_x = x + data.dx
--             local pos_z = z + data.dz
--             local entity = SpawnPrefab(data.prefab)
--             entity.Transform:SetPosition(pos_x, 0, pos_z)
            
--             -- 恢复容器内容
--             if entity.components.container and data.container_data then
--                 for j = 1, entity.components.container.numslots do
--                     local prefab = data.container_data[j]
--                     if prefab then
--                         local item = SpawnPrefab(prefab)
--                         entity.components.container:GiveItem(item, j)
--                     end
--                 end
--             end
            
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
--     reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_IKEA_GUIDEBOOK"))
--     return true
-- end

-- -- 定义书的定义信息
-- local def = {
--     name = "sjy_book_ikea_guidebook",
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

--     inst.AnimState:SetBank("sjy_book_ikea_guidebook")
--     inst.AnimState:SetBuild("sjy_book_ikea_guidebook")
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
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_ikea_guidebook.xml"

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





















-- 很完整版本 就是能吞生物
-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_ikea_guidebook.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_ikea_guidebook.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_ikea_guidebook.xml"),
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
--     return not ent or not ent.prefab or BLACKLISTED_ENTITIES[ent.prefab]
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX", "companion", "character" }  -- 添加玩家、玩家鬼魂和同伴标签
    
--     -- 查找范围内的实体
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 进一步过滤，排除黑名单中的实体
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if not IsEntityBlacklisted(v) then
--             table.insert(valid_ents, v)
--         end
--     end

--     if not inst._stored_entities then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量（可选）
--             local max_devour = 100
--             local entities_to_devour = math.min(#valid_ents, max_devour)
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 local v_x, v_y, v_z = v.Transform:GetWorldPosition()
--                 local dx = v_x - x
--                 local dz = v_z - z
--                 local container_data = nil
--                 if v.components.container then
--                     container_data = {}
--                     for j = 1, v.components.container.numslots do
--                         local item = v.components.container:GetItemInSlot(j)
--                         if item then
--                             container_data[j] = item.prefab
--                             item:Remove()
--                         end
--                     end
--                 end
--                 table.insert(inst._stored_entities, {
--                     prefab = v.prefab,
--                     dx = dx,
--                     dz = dz,
--                     container_data = container_data
--                 })
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
        
--         for i, data in ipairs(inst._stored_entities) do
--             local pos_x = x + data.dx
--             local pos_z = z + data.dz
--             local entity = SpawnPrefab(data.prefab)
--             entity.Transform:SetPosition(pos_x, 0, pos_z)
            
--             -- 恢复容器内容
--             if entity.components.container and data.container_data then
--                 for j = 1, entity.components.container.numslots do
--                     local prefab = data.container_data[j]
--                     if prefab then
--                         local item = SpawnPrefab(prefab)
--                         entity.components.container:GiveItem(item, j)
--                     end
--                 end
--             end
            
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
--     name = "sjy_book_ikea_guidebook",
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

--     inst.AnimState:SetBank("sjy_book_ikea_guidebook")
--     inst.AnimState:SetBuild("sjy_book_ikea_guidebook")
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

--     -- 添加空值检查
--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_ikea_guidebook.xml"

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





















-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_ikea_guidebook.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_ikea_guidebook.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_ikea_guidebook.xml"),
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
--     ["sjy_book_ikea_guidebook"] = true,
--     ["sjy_book_devour"] = true,
-- }

-- -- 生物标签列表
-- local CREATURE_TAGS = {
--     "character", "monster", "animal", "companion", "hostile", "bird", "prey", "scarytoprey", "smallcreature"
-- }

-- -- 检查实体是否在黑名单中
-- local function IsEntityBlacklisted(ent)
--     return not ent or not ent.prefab or BLACKLISTED_ENTITIES[ent.prefab]
-- end

-- -- 检查实体是否是生物
-- local function IsEntityCreature(ent)
--     if not ent then return true end
    
--     for _, tag in ipairs(CREATURE_TAGS) do
--         if ent:HasTag(tag) then
--             return true
--         end
--     end
    
--     return false
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX" }  -- 减少初始标签列表，主要依赖后续过滤
    
--     -- 查找范围内的实体
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 进一步过滤，排除黑名单中的实体和生物
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if not IsEntityBlacklisted(v) and not IsEntityCreature(v) then
--             table.insert(valid_ents, v)
--         end
--     end

--     if not inst._stored_entities then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量（可选）
--             local max_devour = 2000
--             local entities_to_devour = math.min(#valid_ents, max_devour)
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 local v_x, v_y, v_z = v.Transform:GetWorldPosition()
--                 local dx = v_x - x
--                 local dz = v_z - z
--                 local container_data = nil
--                 if v.components.container then
--                     container_data = {}
--                     for j = 1, v.components.container.numslots do
--                         local item = v.components.container:GetItemInSlot(j)
--                         if item then
--                             container_data[j] = item.prefab
--                             item:Remove()
--                         end
--                     end
--                 end
--                 table.insert(inst._stored_entities, {
--                     prefab = v.prefab,
--                     dx = dx,
--                     dz = dz,
--                     container_data = container_data
--                 })
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
        
--         for i, data in ipairs(inst._stored_entities) do
--             local pos_x = x + data.dx
--             local pos_z = z + data.dz
--             local entity = SpawnPrefab(data.prefab)
--             entity.Transform:SetPosition(pos_x, 0, pos_z)
            
--             -- 恢复容器内容
--             if entity.components.container and data.container_data then
--                 for j = 1, entity.components.container.numslots do
--                     local prefab = data.container_data[j]
--                     if prefab then
--                         local item = SpawnPrefab(prefab)
--                         entity.components.container:GiveItem(item, j)
--                     end
--                 end
--             end
            
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
--     name = "sjy_book_ikea_guidebook",
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

--     inst.AnimState:SetBank("sjy_book_ikea_guidebook")
--     inst.AnimState:SetBuild("sjy_book_ikea_guidebook")
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

--     -- 添加空值检查
--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_ikea_guidebook.xml"

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









-- 很好了
-- -- 资源定义
-- local assets =
-- {
--     Asset("ANIM", "anim/sjy_book_ikea_guidebook.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_book_ikea_guidebook.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_book_ikea_guidebook.xml"),
--     Asset("ANIM", "anim/fx_books.zip"), 
-- }

-- -- 创建官方特效的辅助函数
-- local function SpawnOfficialEffectAtEntity(ent)
--     if ent and ent:IsValid() then
--         local x, y, z = ent.Transform:GetWorldPosition()
--         -- 使用官方特效，按要求直接设置位置
--         local fx = SpawnPrefab("hermitcrab_fx_med")
--         if fx then
--             fx.Transform:SetPosition(x, y, z)
--             -- 确保特效播放完成后自动移除
--             fx:ListenForEvent("animover", function() fx:Remove() end)
--         end
--     end
-- end

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
--     ["sjy_book_ikea_guidebook"] = true,
--     ["sjy_book_devour"] = true,
-- }

-- -- 生物标签列表
-- local CREATURE_TAGS = {
--     "character", "monster", "animal", "companion", "hostile", "bird", "prey", "scarytoprey", "smallcreature"
-- }

-- -- 检查实体是否在黑名单中
-- local function IsEntityBlacklisted(ent)
--     return not ent or not ent.prefab or BLACKLISTED_ENTITIES[ent.prefab]
-- end

-- -- 检查实体是否是生物
-- local function IsEntityCreature(ent)
--     if not ent then return true end
    
--     for _, tag in ipairs(CREATURE_TAGS) do
--         if ent:HasTag(tag) then
--             return true
--         end
--     end
    
--     return false
-- end

-- -- 吞噬生物法术执行函数
-- local function do_sjy_book_devour_spell(inst, reader)
--     local x, y, z = reader.Transform:GetWorldPosition()
--     local range = 15  -- 增大吞噬范围
--     local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX" }  -- 减少初始标签列表，主要依赖后续过滤
    
--     -- 查找范围内的实体
--     local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
--     -- 进一步过滤，排除黑名单中的实体和生物
--     local valid_ents = {}
--     for _, v in ipairs(ents) do
--         if not IsEntityBlacklisted(v) and not IsEntityCreature(v) then
--             table.insert(valid_ents, v)
--         end
--     end

--     if not inst._stored_entities then
--         inst._stored_entities = {}
--         if #valid_ents > 0 then
--             -- 限制最大吞噬数量（可选）
--             local max_devour = 2000
--             local entities_to_devour = math.min(#valid_ents, max_devour)
            
--             for i = 1, entities_to_devour do
--                 local v = valid_ents[i]
--                 -- 在吞噬的物品上生成官方特效
--                 SpawnOfficialEffectAtEntity(v)
                
--                 local v_x, v_y, v_z = v.Transform:GetWorldPosition()
--                 local dx = v_x - x
--                 local dz = v_z - z
--                 local container_data = nil
--                 if v.components.container then
--                     container_data = {}
--                     for j = 1, v.components.container.numslots do
--                         local item = v.components.container:GetItemInSlot(j)
--                         if item then
--                             container_data[j] = item.prefab
--                             item:Remove()
--                         end
--                     end
--                 end
--                 table.insert(inst._stored_entities, {
--                     prefab = v.prefab,
--                     dx = dx,
--                     dz = dz,
--                     container_data = container_data
--                 })
--                 -- 添加吞噬特效后再移除实体
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
        
--         for i, data in ipairs(inst._stored_entities) do
--             local pos_x = x + data.dx
--             local pos_z = z + data.dz
--             local entity = SpawnPrefab(data.prefab)
--             entity.Transform:SetPosition(pos_x, 0, pos_z)
            
--             -- 在释放的物品上生成官方特效
--             SpawnOfficialEffectAtEntity(entity)
            
--             -- 恢复容器内容
--             if entity.components.container and data.container_data then
--                 for j = 1, entity.components.container.numslots do
--                     local prefab = data.container_data[j]
--                     if prefab then
--                         local item = SpawnPrefab(prefab)
--                         entity.components.container:GiveItem(item, j)
--                     end
--                 end
--             end
            
--             -- 恢复生命值
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
--     name = "sjy_book_ikea_guidebook",
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

--     inst.AnimState:SetBank("sjy_book_ikea_guidebook")
--     inst.AnimState:SetBuild("sjy_book_ikea_guidebook")
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

--     -- 添加空值检查
--     if def.fx and def.fxmount then
--         inst.components.book:SetFx(def.fx, def.fxmount)
--     end

--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_ikea_guidebook.xml"

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














-- 资源定义
local assets =
{
    Asset("ANIM", "anim/sjy_book_ikea_guidebook.zip"),
    Asset("IMAGE", "images/inventoryimages/sjy_book_ikea_guidebook.tex"),
    Asset("ATLAS", "images/inventoryimages/sjy_book_ikea_guidebook.xml"),
    Asset("ANIM", "anim/fx_books.zip"), 
}

-- 创建官方特效的辅助函数
local function SpawnOfficialEffectAtEntity(ent)
    if ent and ent:IsValid() then
        local x, y, z = ent.Transform:GetWorldPosition()
        -- 使用官方特效，按要求直接设置位置
        local fx = SpawnPrefab("hermitcrab_fx_med")
        if fx then
            fx.Transform:SetPosition(x, y, z)
            -- 确保特效播放完成后自动移除
            fx:ListenForEvent("animover", function() fx:Remove() end)
        end
    end
end

-- 不可吞噬的实体清单（使用哈希表结构）
local BLACKLISTED_ENTITIES = {
    -- 玩家相关
    ["player"] = true,
    ["playerghost"] = true,
    ["abigail"] = true,
    ["shadowminion"] = true,
    
    -- 地形和建筑
    ["cave_exit"] = true,
    ["cave_entrance"] = true,
    ["cave_entrance_open"] = true,
    ["wormhole"] = true,
    ["sjy_book_ikea_guidebook"] = true,
    ["sjy_book_devour"] = true,
}

-- 生物标签列表
local CREATURE_TAGS = {
    "character", "monster", "animal", "companion", "hostile", "bird", "prey", "scarytoprey", "smallcreature"
}

-- 检查实体是否在黑名单中
local function IsEntityBlacklisted(ent)
    return not ent or not ent.prefab or BLACKLISTED_ENTITIES[ent.prefab]
end

-- 检查实体是否是生物
local function IsEntityCreature(ent)
    if not ent then return true end
    
    for _, tag in ipairs(CREATURE_TAGS) do
        if ent:HasTag(tag) then
            return true
        end
    end
    
    return false
end

-- 保存物品的关键属性
local function SaveItemData(item)
    local data = {
        prefab = item.prefab,
        -- 保存堆叠数量
        stacksize = item.components.stackable and item.components.stackable:StackSize() or 1,
        -- 保存耐久度
        durability = nil,
        max_durability = nil,
        -- 保存燃料值（如果有）
        fuelamount = nil,
        -- 保存新鲜度（如果有）
        freshness = nil,
        -- 保存其他关键属性
        charged = nil,
        usesleft = nil
    }
    
    -- 处理耐久度物品
    if item.components.finiteuses then
        data.usesleft = item.components.finiteuses:GetUses()
        data.maxuses = item.components.finiteuses.total
    end
    
    -- 处理武器/工具耐久
    if item.components.weapon and item.components.weapon.remaininguses then
        data.durability = item.components.weapon.remaininguses
        data.maxdurability = item.components.weapon.maxuses
    end
    
    -- 处理燃料物品
    if item.components.fueled and not item.components.fueled:IsEmpty() then
        data.fuelamount = item.components.fueled:GetPercent()
    end
    
    -- 处理新鲜度物品
    if item.components.perishable then
        data.freshness = item.components.perishable:GetPercent()
    end
    
    -- 处理可充电物品
    if item.components.chargable then
        data.charged = item.components.chargable:IsCharged()
    end
    
    return data
end

-- 恢复物品的关键属性
local function RestoreItemData(item, data)
    -- 恢复堆叠数量
    if item.components.stackable and data.stacksize then
        item.components.stackable:SetStackSize(data.stacksize)
    end
    
    -- 恢复耐久度
    if item.components.finiteuses and data.usesleft then
        item.components.finiteuses:SetUses(data.usesleft)
    end
    
    -- 恢复武器耐久
    if item.components.weapon and data.durability and data.maxdurability then
        item.components.weapon.remaininguses = data.durability
        item.components.weapon.maxuses = data.maxdurability
    end
    
    -- 恢复燃料量
    if item.components.fueled and data.fuelamount then
        item.components.fueled:SetPercent(data.fuelamount)
    end
    
    -- 恢复新鲜度
    if item.components.perishable and data.freshness then
        item.components.perishable:SetPercent(data.freshness)
    end
    
    -- 恢复充电状态
    if item.components.chargable and data.charged ~= nil then
        if data.charged then
            item.components.chargable:Charge()
        else
            item.components.chargable:Discharge()
        end
    end
end

-- 吞噬生物法术执行函数
local function do_sjy_book_devour_spell(inst, reader)
    local x, y, z = reader.Transform:GetWorldPosition()
    local range = 15  -- 增大吞噬范围
    local CANT_TAGS = { "player", "playerghost", "INLIMBO", "FX" }  -- 减少初始标签列表，主要依赖后续过滤
    
    -- 查找范围内的实体
    local ents = TheSim:FindEntities(x, y, z, range, nil, CANT_TAGS)
    
    -- 进一步过滤，排除黑名单中的实体和生物
    local valid_ents = {}
    for _, v in ipairs(ents) do
        if not IsEntityBlacklisted(v) and not IsEntityCreature(v) then
            table.insert(valid_ents, v)
        end
    end

    if not inst._stored_entities then
        inst._stored_entities = {}
        if #valid_ents > 0 then
            -- 限制最大吞噬数量（可选）
            local max_devour = 2000
            local entities_to_devour = math.min(#valid_ents, max_devour)
            
            for i = 1, entities_to_devour do
                local v = valid_ents[i]
                -- 在吞噬的物品上生成官方特效
                SpawnOfficialEffectAtEntity(v)
                
                local v_x, v_y, v_z = v.Transform:GetWorldPosition()
                local dx = v_x - x
                local dz = v_z - z
                local container_data = nil
                
                -- 保存容器数据，包括物品数量和耐久
                if v.components.container then
                    container_data = {}
                    for j = 1, v.components.container.numslots do
                        local item = v.components.container:GetItemInSlot(j)
                        if item then
                            -- 保存物品详细数据而非仅仅prefab
                            container_data[j] = SaveItemData(item)
                            item:Remove()
                        end
                    end
                end
                
                -- 保存容器自身的状态数据
                local entity_data = {
                    prefab = v.prefab,
                    dx = dx,
                    dz = dz,
                    container_data = container_data,
                    -- 保存容器自身的耐久度（如果有）
                    usesleft = v.components.finiteuses and v.components.finiteuses:GetUses() or nil,
                    maxuses = v.components.finiteuses and v.components.finiteuses.total or nil
                }
                
                table.insert(inst._stored_entities, entity_data)
                
                -- 添加吞噬特效后再移除实体
                if v.components.health and not v.components.health:IsDead() then
                    v:PushEvent("death")
                end
                v:Remove()
            end
            
            -- 如果有超过最大数量的实体，显示警告
            if #valid_ents > max_devour then
                if reader.components.talker then
                    reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR_LIMIT"), max_devour))
                end
            end
            
            -- 播放吞噬成功的动画或特效
            inst.AnimState:PlayAnimation("active")
            inst.AnimState:PushAnimation("idle")
            
            -- 显示吞噬数量提示
            if reader.components.talker then
                reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_DEVOUR"), #inst._stored_entities))
            end
        else
            -- 没有可吞噬的实体
            if reader.components.talker then
                reader.components.talker:Say(GetString(reader, "ANNOUNCE_DEVOUR_NONE"))
            end
        end
        return true
    else
        -- 在释放前保存实体数量
        local entities_count = #inst._stored_entities
        
        for i, data in ipairs(inst._stored_entities) do
            local pos_x = x + data.dx
            local pos_z = z + data.dz
            local entity = SpawnPrefab(data.prefab)
            entity.Transform:SetPosition(pos_x, 0, pos_z)
            
            -- 恢复容器自身的耐久度
            if entity.components.finiteuses and data.usesleft and data.maxuses then
                entity.components.finiteuses.total = data.maxuses
                entity.components.finiteuses:SetUses(data.usesleft)
            end
            
            -- 在释放的物品上生成官方特效
            SpawnOfficialEffectAtEntity(entity)
            
            -- 恢复容器内容，包括物品数量和耐久
            if entity.components.container and data.container_data then
                for j = 1, entity.components.container.numslots do
                    local item_data = data.container_data[j]
                    if item_data then
                        local item = SpawnPrefab(item_data.prefab)
                        -- 恢复物品的数量和耐久等属性
                        RestoreItemData(item, item_data)
                        entity.components.container:GiveItem(item, j)
                    end
                end
            end
            
            -- 恢复生命值
            if entity.components.health then
                entity.components.health:SetPercent(1.0)
            end
        end
        
        -- 释放后再设为 nil
        inst._stored_entities = nil
        
        -- 播放释放成功的动画或特效
        inst.AnimState:PlayAnimation("release")
        inst.AnimState:PushAnimation("idle")
        
        -- 使用之前保存的数量显示提示
        if reader.components.talker then
            reader.components.talker:Say(string.format(GetString(reader, "ANNOUNCE_RELEASE"), entities_count))
        end
        
        return true
    end
end

-- 吞噬生物书翻阅函数
local function peruse_sjy_book_devour(inst, reader)
    if reader.peruse_devour then
        reader.peruse_devour(reader)
    end
    reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK", "SJY_BOOK_DEVOUR"))
    return true
end

-- 定义书的定义信息
local def = {
    name = "sjy_book_ikea_guidebook",
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

    inst.AnimState:SetBank("sjy_book_ikea_guidebook")
    inst.AnimState:SetBuild("sjy_book_ikea_guidebook")
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
    inst.components.book:SetPeruseSanity(def.peruse_sanity)

    -- 添加空值检查
    if def.fx and def.fxmount then
        inst.components.book:SetFx(def.fx, def.fxmount)
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_book_ikea_guidebook.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    MakeHauntableLaunch(inst)

    -- 添加保存/加载逻辑
    inst.OnSave = function(inst, data)
        if inst._stored_entities then
            data.stored_entities = inst._stored_entities
        end
    end

    inst.OnLoad = function(inst, data)
        if data and data.stored_entities then
            inst._stored_entities = data.stored_entities
        end
    end

    return inst
end

-- 返回根据书的定义信息创建的预制体
return Prefab(def.name, fn, assets)