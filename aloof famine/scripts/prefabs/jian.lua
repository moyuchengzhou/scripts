-- -- local assets =
-- -- {
-- --    Asset("ATLAS","images/jian.xml"),
-- --    Asset("ATLAS","anim/jian.zip"),
-- -- }

-- local assets = {Asset("ANIM", "anim/jian.zip"), 
--                 Asset("IMAGE", "images/inventoryimages/jian.tex"),
--                 Asset("ATLAS", "images/inventoryimages/jian.xml"),
--                 Asset("ANIM","anim/swap_jian.zip"),
--             }

-- local function onfinished(inst)
--     inst:Remove()--耐久用完后，移除这个物体
--     end


-- local function onequip(inst,owner)
--     local skin_build = inst:GetSkinBuild()
--     if skin_build ~= nil then
--         owner:PushEvent("equipskinneditem", inst:GetSkinName())
--         owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_jian", inst.GUID, "swap_jian")
--     else
--         owner.AnimState:OverrideSymbol("swap_object", "swap_jian", "swap_jian")
--     end
-- 	owner.AnimState:Hide("ARM_normal")
-- 	owner.AnimState:Show("ARM_carry")
-- end

-- local function onunequip(inst, owner)
--     owner.AnimState:Hide("ARM_carry")
--     owner.AnimState:Show("ARM_normal")
--     local skin_build = inst:GetSkinBuild()
--     if skin_build ~= nil then
--         owner:PushEvent("unequipskinneditem", inst:GetSkinName())
--     end	
-- end


-- local prefabs={}
-- STRINGS.NAMES.JIAN="大宝剑"--名称
-- STRINGS.CHARACTERS.GENERIC.DESCRIBE.JIAN="一起来击剑"--描述
-- local function fn()
--     local assetname = "jian"

--     local inst = CreateEntity() -- 创建实体
--     inst.entity:AddTransform() -- 添加xyz形变对象
--     inst.entity:AddAnimState() -- 添加动画状态
--     inst.entity:AddNetwork() -- 添加这一行才能让所有客户端都能看到这个实体
--     MakeInventoryPhysics(inst)
--     ---------------------------------------------
--     --动画加载
--     inst.AnimState:SetBank(assetname) -- 地上动画
--     inst.AnimState:SetBuild(assetname) -- 材质包，就是anim里的zip包
--     inst.AnimState:PlayAnimation("idle") -- 默认播放哪个动画
--     -- MakeInventoryFloatable(inst)
    

--     MakeInventoryFloatable(inst, "med", nil, 0.68) -- 设置浮动属性
--     inst.pickupsound = "wood" -- 拾取声音为"wood"

--     if not TheWorld.ismastersim then -- 如果不是主机模式，则返回实体
--         return inst
--     end
--     --------------------------------------------------------------------------
--     inst:AddComponent("inspectable") -- 可检查组件
--     inst:AddComponent("inventoryitem") -- 物品组件
    

--     inst.components.inventoryitem.atlasname = "images/inventoryimages/jian.xml" -- 在背包里的贴图
--     inst.components.inventoryitem.imagename = "jian"--图片名称
--     inst:AddComponent("stackable")--可堆叠组件
--     inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM--最大堆叠数量40

--     inst:AddComponent("finiteuses")
--     inst.components.finiteuses:SetMaxUses(5000)       --耐久度
--     inst.components.finiteuses:SetUses(5000)--当前耐久度
--     if inst.components.finiteuses.current < 0 then
--        inst.components.finiteuses.current = 0
--     end

--     inst.components.finiteuses:SetOnFinished( onfinished )  

--     inst:AddTag("shadow")--属于暗影武器
-- 	inst:AddComponent("weapon")
--     inst.components.weapon:SetDamage(20)--基础攻击伤害
-- 	inst.components.weapon:SetRange(10, 15)--攻击距离

--     inst:AddComponent("equippable")
--     inst.components.equippable:SetOnEquip( onequip )
--     inst.components.equippable:SetOnUnequip( onunequip )

--     MakeHauntableLaunch(inst)
   
--     return inst
-- end


-- return Prefab("jian", fn, assets, prefabs)
















-- -- 武器相关资源定义
-- local assets = {
--     Asset("ANIM", "anim/jian.zip"), 
--     Asset("IMAGE", "images/inventoryimages/jian.tex"),
--     Asset("ATLAS", "images/inventoryimages/jian.xml"),
--     Asset("ANIM", "anim/swap_jian.zip"),
-- }

-- -- 耐久耗尽时移除物品
-- local function onfinished(inst)
--     inst:Remove()
-- end

-- -- 装备时的回调函数
-- local function onequip(inst, owner)
--     local skin_build = inst:GetSkinBuild()
--     if skin_build ~= nil then
--         owner:PushEvent("equipskinneditem", inst:GetSkinName())
--         owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_jian", inst.GUID, "swap_jian")
--     else
--         owner.AnimState:OverrideSymbol("swap_object", "swap_jian", "swap_jian")
--     end
--     owner.AnimState:Hide("ARM_normal")
--     owner.AnimState:Show("ARM_carry")
-- end

-- -- 卸下时的回调函数
-- local function onunequip(inst, owner)
--     owner.AnimState:Hide("ARM_carry")
--     owner.AnimState:Show("ARM_normal")
--     local skin_build = inst:GetSkinBuild()
--     if skin_build ~= nil then
--         owner:PushEvent("unequipskinneditem", inst:GetSkinName())
--     end	
-- end

-- -- 攻击时的额外效果：对附近仇恨目标造成伤害
-- local function onattack(inst, attacker, target)
--     -- 确保攻击者存在且是实体
--     if not attacker or not attacker:IsValid() then
--         return
--     end

--     -- 获取武器基础伤害
--     local base_damage = inst.components.weapon.damage or 20

--     -- 查找攻击者周围有仇恨的生物（范围15）
--     local x, y, z = attacker.Transform:GetWorldPosition()
--     local nearby_enemies = TheSim:FindEntities(x, y, z, 15, nil, {"INLIMBO", "notarget", "noattack", "flight", "invisible"}, {"hostile", "monster"})

--     for _, enemy in ipairs(nearby_enemies) do
--         -- 过滤掉攻击目标本身和无效实体
--         if enemy ~= target and enemy:IsValid() and enemy.components.health and not enemy.components.health:IsDead() then
--             -- 检查是否对攻击者有仇恨
--             if enemy.components.combat and enemy.components.combat.target == attacker then
--                 -- 计算伤害：(目标最大血量/100 + 2) * 武器基础伤害
--                 local max_health = enemy.components.health.maxhealth or 100
--                 local damage = (max_health / 100 + 2) * base_damage
--                 enemy.components.health:DoDelta(-damage, inst, attacker)
--             end
--         end
--     end
-- end

-- -- 物品名称和描述
-- local prefabs = {}
-- STRINGS.NAMES.JIAN = "大宝剑"
-- STRINGS.CHARACTERS.GENERIC.DESCRIBE.JIAN = "一起来击剑"

-- -- 创建实体的主函数
-- local function fn()
--     local assetname = "jian"
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     -- 动画设置
--     inst.AnimState:SetBank(assetname)
--     inst.AnimState:SetBuild(assetname)
--     inst.AnimState:PlayAnimation("idle")

--     -- 浮动属性设置
--     MakeInventoryFloatable(inst, "med", nil, 0.68)
--     inst.pickupsound = "wood"

--     -- 客户端处理
--     if not TheWorld.ismastersim then
--         return inst
--     end

--     -- 组件添加
--     inst:AddComponent("inspectable")
--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/jian.xml"
--     inst.components.inventoryitem.imagename = "jian"

--     inst:AddComponent("stackable")
--     inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

--     inst:AddComponent("finiteuses")
--     inst.components.finiteuses:SetMaxUses(5000)
--     inst.components.finiteuses:SetUses(5000)
--     inst.components.finiteuses:SetOnFinished(onfinished)

--     inst:AddTag("shadow")

--     inst:AddComponent("weapon")
--     inst.components.weapon:SetDamage(20)
--     inst.components.weapon:SetRange(10, 15)
--     inst.components.weapon:SetOnAttack(onattack)  -- 添加攻击回调

--     inst:AddComponent("equippable")
--     inst.components.equippable:SetOnEquip(onequip)
--     inst.components.equippable:SetOnUnequip(onunequip)

--     MakeHauntableLaunch(inst)

--     return inst
-- end

-- return Prefab("jian", fn, assets, prefabs)















-- -- 武器相关资源定义
-- local assets = {
--     Asset("ANIM", "anim/jian.zip"), 
--     Asset("IMAGE", "images/inventoryimages/jian.tex"),
--     Asset("ATLAS", "images/inventoryimages/jian.xml"),
--     Asset("ANIM", "anim/swap_jian.zip"),
-- }

-- -- 耐久耗尽时移除物品
-- local function onfinished(inst)
--     inst:Remove()
-- end

-- -- 装备时的回调函数
-- local function onequip(inst, owner)
--     local skin_build = inst:GetSkinBuild()
--     if skin_build ~= nil then
--         owner:PushEvent("equipskinneditem", inst:GetSkinName())
--         owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_jian", inst.GUID, "swap_jian")
--     else
--         owner.AnimState:OverrideSymbol("swap_object", "swap_jian", "swap_jian")
--     end
--     owner.AnimState:Hide("ARM_normal")
--     owner.AnimState:Show("ARM_carry")
-- end

-- -- 卸下时的回调函数
-- local function onunequip(inst, owner)
--     owner.AnimState:Hide("ARM_carry")
--     owner.AnimState:Show("ARM_normal")
--     local skin_build = inst:GetSkinBuild()
--     if skin_build ~= nil then
--         owner:PushEvent("unequipskinneditem", inst:GetSkinName())
--     end	
-- end

-- -- 排除列表（这里示例添加了一些常见BOSS预制体名，可根据实际需求修改）
-- local EXCLUDE_LIST = {
--     "dragonfly",       -- 龙蝇
--     "deerclops",       -- 巨鹿
--     "bearger",         -- 熊獾
--     "stalker_atrium",           -- 织影者
--     "klaus",           -- 克劳斯
--     "shadow_bishop",-- 暗影主教
--     "shadow_knight",-- 暗影骑士
--     "shadow_rook" , -- 暗影战车
--     "sharkboi",       -- 大双鲨鱼
--     "alterguardian_phase1",       -- 天体1
--     "alterguardian_phase2",         -- 天体2
--     "alterguardian_phase3",           -- 天体3
--     "worm_boss",           -- 巨型蠕虫
--     "crabking",-- 帝王蟹
--     "eyeofterror",-- 克苏鲁之眼
--     "twinofterror1",  -- 激光眼
--     "twinofterror2",       -- 魔焰眼
--     "wagboss_robot",       -- 战争瓦器人
--     "daywalker2",         -- 垃圾猪
--     "mutateddeerclops",           -- 变异巨鹿
--     "lordfruitfly",           -- 果蝇王
--     "daywalker",-- 梦魇疯猪
--     "toadstool",-- 毒菌蟾蜍
--     "toadstool_dark" , -- 悲惨毒菌蟾蜍

--     "antlion",       -- 蚁狮
--     "beequeen",       -- 蜂后
--     "spiderqueen",         -- 猪猪女王
--     "mutatedbearger",           -- 变异熊
--     "minotaur",           -- 远古犀牛
--     "malbatross",-- 邪天翁
--     "moose",-- 麋鹿鹅
--     "alterguardian_phase4_lunarrift"  -- 天体后羿
-- }

-- -- 检查是否为排除列表中的生物
-- local function is_in_exclude_list(enemy)
--     if not enemy or not enemy.prefab then return false end
--     for _, prefab in ipairs(EXCLUDE_LIST) do
--         if enemy.prefab == prefab then
--             return true
--         end
--     end
--     return false
-- end

-- -- 攻击时的额外效果：对附近仇恨目标造成伤害
-- local function onattack(inst, attacker, target)
--     -- 确保攻击者存在且是实体
--     if not attacker or not attacker:IsValid() then
--         return
--     end

--     -- 获取武器基础伤害（固定20点）
--     local base_damage = 20

--     -- 查找攻击者周围有仇恨的生物（范围15）
--     local x, y, z = attacker.Transform:GetWorldPosition()
--     local nearby_enemies = TheSim:FindEntities(x, y, z, 15, nil, 
--         {"INLIMBO", "notarget", "noattack", "flight", "invisible"}, 
--         {"hostile", "monster"}
--     )

--     for _, enemy in ipairs(nearby_enemies) do
--         -- 过滤条件：不是攻击目标、实体有效、有生命值组件、未死亡
--         if enemy ~= target 
--             and enemy:IsValid() 
--             and enemy.components.health 
--             and not enemy.components.health:IsDead() 
--             and enemy.components.combat 
--             and enemy.components.combat.target == attacker then

--             local damage = 0
--             -- 检查是否为排除列表中的生物（BOSS类）
--             if is_in_exclude_list(enemy) then
--                 -- 排除列表生物：固定武器伤害×5
--                 damage = base_damage * 5
--             else
--                 -- 普通仇恨生物：(最大血量/100 + 2) × 武器基础伤害
--                 local max_health = enemy.components.health.maxhealth or 100
--                 damage = (max_health / 100 + 2) * base_damage
--             end

--             -- 应用伤害
--             enemy.components.health:DoDelta(-damage, inst, attacker)
--         end
--     end
-- end

-- -- 物品名称和描述
-- local prefabs = {}
-- STRINGS.NAMES.JIAN = "大宝剑"
-- STRINGS.CHARACTERS.GENERIC.DESCRIBE.JIAN = "一起来击剑"

-- -- 创建实体的主函数
-- local function fn()
--     local assetname = "jian"
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     -- 动画设置
--     inst.AnimState:SetBank(assetname)
--     inst.AnimState:SetBuild(assetname)
--     inst.AnimState:PlayAnimation("idle")

--     -- 浮动属性设置
--     MakeInventoryFloatable(inst, "med", nil, 0.68)
--     inst.pickupsound = "wood"

--     -- 客户端处理
--     if not TheWorld.ismastersim then
--         return inst
--     end

--     -- 组件添加
--     inst:AddComponent("inspectable")
--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/jian.xml"
--     inst.components.inventoryitem.imagename = "jian"

--     inst:AddComponent("stackable")
--     inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

--     inst:AddComponent("finiteuses")
--     inst.components.finiteuses:SetMaxUses(5000)
--     inst.components.finiteuses:SetUses(5000)
--     inst.components.finiteuses:SetOnFinished(onfinished)

--     inst:AddTag("shadow")

--     inst:AddComponent("weapon")
--     inst.components.weapon:SetDamage(20)  -- 基础伤害20点
--     inst.components.weapon:SetRange(10, 15)
--     inst.components.weapon:SetOnAttack(onattack)  -- 绑定攻击回调

--     inst:AddComponent("equippable")
--     inst.components.equippable:SetOnEquip(onequip)
--     inst.components.equippable:SetOnUnequip(onunequip)

--     MakeHauntableLaunch(inst)

--     return inst
-- end

-- return Prefab("jian", fn, assets, prefabs)















-- -- 武器相关资源定义
-- local assets = {
--     Asset("ANIM", "anim/jian.zip"), 
--     Asset("IMAGE", "images/inventoryimages/jian.tex"),
--     Asset("ATLAS", "images/inventoryimages/jian.xml"),
--     Asset("ANIM", "anim/swap_jian.zip"),
--     -- Asset("ANIM", "anim/statue_transition.zip"), -- 添加特效资源
-- }

-- -- 耐久耗尽时移除物品
-- local function onfinished(inst)
--     inst:Remove()
-- end

-- -- 装备时的回调函数
-- local function onequip(inst, owner)
--     local skin_build = inst:GetSkinBuild()
--     if skin_build ~= nil then
--         owner:PushEvent("equipskinneditem", inst:GetSkinName())
--         owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_jian", inst.GUID, "swap_jian")
--     else
--         owner.AnimState:OverrideSymbol("swap_object", "swap_jian", "swap_jian")
--     end
--     owner.AnimState:Hide("ARM_normal")
--     owner.AnimState:Show("ARM_carry")
-- end

-- -- 卸下时的回调函数
-- local function onunequip(inst, owner)
--     owner.AnimState:Hide("ARM_carry")
--     owner.AnimState:Show("ARM_normal")
--     local skin_build = inst:GetSkinBuild()
--     if skin_build ~= nil then
--         owner:PushEvent("unequipskinneditem", inst:GetSkinName())
--     end	
-- end

-- -- 排除列表（这里示例添加了一些常见BOSS预制体名，可根据实际需求修改）
-- local EXCLUDE_LIST = {
--     "dragonfly",       -- 龙蝇
--     "deerclops",       -- 巨鹿
--     "bearger",         -- 熊獾
--     "stalker_atrium",  -- 织影者
--     "klaus",           -- 克劳斯
--     "shadow_bishop",   -- 暗影主教
--     "shadow_knight",   -- 暗影骑士
--     "shadow_rook" ,    -- 暗影战车
--     "sharkboi",        -- 大双鲨鱼
--     "alterguardian_phase1",       -- 天体1
--     "alterguardian_phase2",       -- 天体2
--     "alterguardian_phase3",       -- 天体3
--     "worm_boss",       -- 巨型蠕虫
--     "crabking",        -- 帝王蟹
--     "eyeofterror",     -- 克苏鲁之眼
--     "twinofterror1",   -- 激光眼
--     "twinofterror2",   -- 魔焰眼
--     "wagboss_robot",   -- 战争瓦器人
--     "daywalker2",      -- 垃圾猪
--     "mutateddeerclops",-- 变异巨鹿
--     "lordfruitfly",    -- 果蝇王
--     "daywalker",       -- 梦魇疯猪
--     "toadstool",       -- 毒菌蟾蜍
--     "toadstool_dark" , -- 悲惨毒菌蟾蜍

--     "antlion",         -- 蚁狮
--     "beequeen",        -- 蜂后
--     "spiderqueen",     -- 猪猪女王
--     "mutatedbearger",  -- 变异熊
--     "minotaur",        -- 远古犀牛
--     "malbatross",      -- 邪天翁
--     "moose",           -- 麋鹿鹅
--     "alterguardian_phase4_lunarrift"  -- 天体后羿
-- }

-- -- 检查是否为排除列表中的生物
-- local function is_in_exclude_list(enemy)
--     if not enemy or not enemy.prefab then return false end
--     for _, prefab in ipairs(EXCLUDE_LIST) do
--         if enemy.prefab == prefab then
--             return true
--         end
--     end
--     return false
-- end

-- -- 创建伤害特效（每次掉血都播放）
-- local function spawn_damage_fx(x, y, z)
--     -- 直接按照要求的方式触发特效
--     local fx = SpawnPrefab("statue_transition")
--     fx.Transform:SetPosition(x, y, z)
-- end

-- -- 攻击时的额外效果：对附近仇恨目标造成伤害
-- local function onattack(inst, attacker, target)
--     -- 确保攻击者存在且是实体
--     if not attacker or not attacker:IsValid() then
--         return
--     end

--     -- 获取武器基础伤害（固定20点）
--     local base_damage = 20

--     -- 查找攻击者周围有仇恨的生物（范围15）
--     local x, y, z = attacker.Transform:GetWorldPosition()
--     local nearby_enemies = TheSim:FindEntities(x, y, z, 15, nil, 
--         {"INLIMBO", "notarget", "noattack", "flight", "invisible"}, 
--         {"hostile", "monster"}
--     )

--     for _, enemy in ipairs(nearby_enemies) do
--         -- 过滤条件：不是攻击目标、实体有效、有生命值组件、未死亡
--         if enemy ~= target 
--             and enemy:IsValid() 
--             and enemy.components.health 
--             and not enemy.components.health:IsDead() 
--             and enemy.components.combat 
--             and enemy.components.combat.target == attacker then

--             local damage = 0
--             -- 检查是否为排除列表中的生物（BOSS类）
--             if is_in_exclude_list(enemy) then
--                 -- 排除列表生物：固定武器伤害×5
--                 damage = base_damage * 5
--             else
--                 -- 普通仇恨生物：(最大血量/100 + 2) × 武器基础伤害
--                 local max_health = enemy.components.health.maxhealth or 100
--                 damage = (max_health / 100 + 2) * base_damage
--             end

--             -- 记录伤害前血量
--             local prev_health = enemy.components.health.currenthealth
            
--             -- 应用伤害
--             enemy.components.health:DoDelta(-damage, inst, attacker)
            
--             -- 只有实际造成了伤害才播放特效（确保每次掉血都触发）
--             if enemy.components.health.currenthealth < prev_health then
--                 local ex, ey, ez = enemy.Transform:GetWorldPosition()
--                 spawn_damage_fx(ex, ey, ez)
--             end
--         end
--     end
-- end

-- -- 物品名称和描述
-- local prefabs = {"statue_transition"} -- 添加特效预制体引用
-- STRINGS.NAMES.JIAN = "大宝剑"
-- STRINGS.CHARACTERS.GENERIC.DESCRIBE.JIAN = "一起来击剑"

-- -- 创建实体的主函数
-- local function fn()
--     local assetname = "jian"
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddNetwork()

--     MakeInventoryPhysics(inst)

--     -- 动画设置
--     inst.AnimState:SetBank(assetname)
--     inst.AnimState:SetBuild(assetname)
--     inst.AnimState:PlayAnimation("idle")

--     -- 浮动属性设置
--     MakeInventoryFloatable(inst, "med", nil, 0.68)
--     inst.pickupsound = "wood"

--     -- 客户端处理
--     if not TheWorld.ismastersim then
--         return inst
--     end

--     -- 组件添加
--     inst:AddComponent("inspectable")
--     inst:AddComponent("inventoryitem")
--     inst.components.inventoryitem.atlasname = "images/inventoryimages/jian.xml"
--     inst.components.inventoryitem.imagename = "jian"

--     inst:AddComponent("stackable")
--     inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

--     inst:AddComponent("finiteuses")
--     inst.components.finiteuses:SetMaxUses(5000)
--     inst.components.finiteuses:SetUses(5000)
--     inst.components.finiteuses:SetOnFinished(onfinished)

--     inst:AddTag("shadow")

--     inst:AddComponent("weapon")
--     inst.components.weapon:SetDamage(20)  -- 基础伤害20点
--     inst.components.weapon:SetRange(10, 15)
--     inst.components.weapon:SetOnAttack(onattack)  -- 绑定攻击回调

--     inst:AddComponent("equippable")
--     inst.components.equippable:SetOnEquip(onequip)
--     inst.components.equippable:SetOnUnequip(onunequip)

--     MakeHauntableLaunch(inst)

--     return inst
-- end

-- return Prefab("jian", fn, assets, prefabs)





















-- 武器相关资源定义
local assets = {
    Asset("ANIM", "anim/jian.zip"), 
    Asset("IMAGE", "images/inventoryimages/jian.tex"),
    Asset("ATLAS", "images/inventoryimages/jian.xml"),
    Asset("ANIM", "anim/swap_jian.zip"),
    -- Asset("ANIM", "anim/statue_transition.zip"), -- 添加特效资源
}

-- 耐久耗尽时移除物品
local function onfinished(inst)
    inst:Remove()
end

-- 装备时的回调函数
local function onequip(inst, owner)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_jian", inst.GUID, "swap_jian")
    else
        owner.AnimState:OverrideSymbol("swap_object", "swap_jian", "swap_jian")
    end
    owner.AnimState:Hide("ARM_normal")
    owner.AnimState:Show("ARM_carry")
end

-- 卸下时的回调函数
local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end	
end

-- 排除列表（这里示例添加了一些常见BOSS预制体名，可根据实际需求修改）
local EXCLUDE_LIST = {
    "dragonfly",       -- 龙蝇
    "deerclops",       -- 巨鹿
    "bearger",         -- 熊獾
    "stalker_atrium",  -- 织影者
    "klaus",           -- 克劳斯
    "shadow_bishop",   -- 暗影主教
    "shadow_knight",   -- 暗影骑士
    "shadow_rook" ,    -- 暗影战车
    "sharkboi",        -- 大双鲨鱼
    "alterguardian_phase1",       -- 天体1
    "alterguardian_phase2",       -- 天体2
    "alterguardian_phase3",       -- 天体3
    "worm_boss",       -- 巨型蠕虫
    "crabking",        -- 帝王蟹
    "eyeofterror",     -- 克苏鲁之眼
    "twinofterror1",   -- 激光眼
    "twinofterror2",   -- 魔焰眼
    "wagboss_robot",   -- 战争瓦器人
    "daywalker2",      -- 垃圾猪
    "mutateddeerclops",-- 变异巨鹿
    "lordfruitfly",    -- 果蝇王
    "daywalker",       -- 梦魇疯猪
    "toadstool",       -- 毒菌蟾蜍
    "toadstool_dark" , -- 悲惨毒菌蟾蜍

    "antlion",         -- 蚁狮
    "beequeen",        -- 蜂后
    "spiderqueen",     -- 猪猪女王
    "mutatedbearger",  -- 变异熊
    "minotaur",        -- 远古犀牛
    "malbatross",      -- 邪天翁
    "moose",           -- 麋鹿鹅
    "alterguardian_phase4_lunarrift"  -- 天体后羿
}

-- 检查是否为排除列表中的生物
local function is_in_exclude_list(enemy)
    if not enemy or not enemy.prefab then return false end
    for _, prefab in ipairs(EXCLUDE_LIST) do
        if enemy.prefab == prefab then
            return true
        end
    end
    return false
end

-- 检查是否为玩家的队友
local function is_teammate(enemy, attacker)
    -- 检查是否为玩家或玩家的同伴
    if enemy:HasTag("player") then
        -- 如果攻击者是玩家，检查是否为队友
        if attacker:HasTag("player") then
            -- 这里假设使用了团队系统，可根据实际情况修改
            return attacker.components.teammate and attacker.components.teammate:IsTeammate(enemy)
        end
        return true
    end
    return false
end

-- 创建伤害特效（每次掉血都播放）
local function spawn_damage_fx(x, y, z)
    -- 直接按照要求的方式触发特效
    local fx = SpawnPrefab("statue_transition")
    fx.Transform:SetPosition(x, y, z)
end

-- 攻击时的额外效果：对附近仇恨目标造成伤害
local function onattack(inst, attacker, target)
    -- 确保攻击者存在且是实体
    if not attacker or not attacker:IsValid() then
        return
    end

    -- 获取武器基础伤害（固定20点）
    local base_damage = 20

    -- 查找攻击者周围所有生物（范围15）
    local x, y, z = attacker.Transform:GetWorldPosition()
    local nearby_creatures = TheSim:FindEntities(x, y, z, 15, nil, 
        {"INLIMBO", "notarget", "noattack", "flight", "invisible"}
    )

    for _, creature in ipairs(nearby_creatures) do
        -- 过滤条件：不是攻击目标、实体有效、有生命值组件、未死亡
        if creature ~= target 
            and creature:IsValid() 
            and creature.components.health 
            and not creature.components.health:IsDead() 
            and creature.components.combat then

            -- 检查是否对玩家有仇恨
            local has_hatred = creature.components.combat.target and 
                              (creature.components.combat.target:HasTag("player") or
                               (creature.components.combat.target.components.follower and 
                                creature.components.combat.target.components.follower.leader and 
                                creature.components.combat.target.components.follower.leader:HasTag("player")))

            -- 排除列表中的生物和队友不受影响
            if has_hatred 
                and not is_in_exclude_list(creature) 
                and not is_teammate(creature, attacker) then

                -- 计算伤害
                local damage = (creature.components.health.maxhealth or 100) / 100 + 2
                damage = damage * base_damage

                -- 记录伤害前血量
                local prev_health = creature.components.health.currenthealth
                
                -- 应用伤害
                creature.components.health:DoDelta(-damage, inst, attacker)
                
                -- 只有实际造成了伤害才播放特效（确保每次掉血都触发）
                if creature.components.health.currenthealth < prev_health then
                    local ex, ey, ez = creature.Transform:GetWorldPosition()
                    spawn_damage_fx(ex, ey, ez)
                end
            end
        end
    end
end

-- 物品名称和描述
local prefabs = {"statue_transition"} -- 添加特效预制体引用
STRINGS.NAMES.JIAN = "大宝剑"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.JIAN = "一起来击剑"

-- 创建实体的主函数
local function fn()
    local assetname = "jian"
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    -- 动画设置
    inst.AnimState:SetBank(assetname)
    inst.AnimState:SetBuild(assetname)
    inst.AnimState:PlayAnimation("idle")

    -- 浮动属性设置
    MakeInventoryFloatable(inst, "med", nil, 0.68)
    inst.pickupsound = "wood"

    -- 客户端处理
    if not TheWorld.ismastersim then
        return inst
    end

    -- 组件添加
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/jian.xml"
    inst.components.inventoryitem.imagename = "jian"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(5000)
    inst.components.finiteuses:SetUses(5000)
    inst.components.finiteuses:SetOnFinished(onfinished)

    inst:AddTag("shadow")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(20)  -- 基础伤害20点
    inst.components.weapon:SetRange(10, 15)
    inst.components.weapon:SetOnAttack(onattack)  -- 绑定攻击回调

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("jian", fn, assets, prefabs)
    