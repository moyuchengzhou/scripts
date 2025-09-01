require "prefabutil"

local cooking = require("cooking")

local assets =
{
    Asset("ANIM", "anim/sjy_zhuozi_table.zip"),
    Asset("IMAGE", "images/inventoryimages/sjy_zhuozi_table.tex"),
   Asset("ATLAS", "images/inventoryimages/sjy_zhuozi_table.xml"),
   
}

local prefabs =
{
    "collapse_small",
}

local function onopen(inst)
    --inst.AnimState:PlayAnimation("open")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function onclose(inst)
    --inst.AnimState:PlayAnimation("close")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    inst.components.container:DropEverything()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.components.container:DropEverything()
    inst.components.container:Close()
end

local function onbuilt(inst)

end

local function RemoveDecor(inst, data)
    local str1 = "food"
    local str2 = "s"
    inst.AnimState:ClearOverrideSymbol(str1..data.slot..str2)
   
end



local function IsModCook(prefab)
    for cooker,recipes in pairs(cooking.recipes) do
        if IsModCookingProduct(cooker,prefab) then return true end
    end
    return false 
end

local function GetRecipe(prefab)
    for cooker,recipes in pairs(cooking.recipes) do
        if recipes[prefab] then return recipes[prefab] end
    end
    return nil
end

local function getbuild(item)
    if item.Get_Myth_Food_Table then --兼容接口
        return item:Get_Myth_Food_Table()
    elseif item:HasTag("spicedfood") then 
        local recipe = GetRecipe(item.prefab) 
        local truename = item.prefab
        local start = string.find (truename, "_spice")
        if start ~= nil then
            truename = string.sub(truename, 1,start-1)
        end
        if IsModCook(item.prefab) then
            return truename,truename,recipe.spice
        else
            local symbol_override_build = (recipe ~= nil and recipe.overridebuild) or "cook_pot_food" or "idle"
            return symbol_override_build,truename,recipe.spice
        end
    else
        local overridebuild = IsModCook(item.prefab) and item.prefab or nil
        local recipe = GetRecipe(item.prefab) 
        local build = (recipe ~= nil and recipe.overridebuild) or overridebuild or "cook_pot_food" or "idle" 
        local overridesymbol = (recipe ~= nil and recipe.overridesymbolname) or item.prefab
        return build,overridesymbol,nil
    end
end
local function AddDecor(inst, data)
    if inst:HasTag("burnt") or data == nil or data.slot == nil or data.item == nil then
        return
    end
    local build, symbol,spice = getbuild(data.item)
    local str1 = "food"
    local str2 = "s"
    inst.AnimState:OverrideSymbol(str1..data.slot..str2, build, symbol)
end

local function OnBuiltFn(inst,builder)
	if builder and builder.components.myth_playernwd then
		builder.components.myth_playernwd:DoDelta("foodtable_nwd",4)
	end
end

local function OnUse(inst,data)
    if data and data.doer then
        OnBuiltFn(inst,data.doer)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("sjy_zhuozi_table.tex")

    inst:AddTag("structure")

    --inst:AddTag("myth_nianweidu")

    inst.AnimState:SetBank("sjy_zhuozi_table")
    inst.AnimState:SetBuild("sjy_zhuozi_table")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetScale(.5,.5,.5)

    MakeObstaclePhysics(inst, 1.5)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("sjy_zhuozi_table")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true


    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit) 

    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(-1000000)

    inst:ListenForEvent("itemget", AddDecor)
    inst:ListenForEvent("itemlose", RemoveDecor)
  
    inst:ListenForEvent("onopen", OnUse)
    inst:ListenForEvent("onclose", OnUse)

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    AddHauntableDropItemOrWork(inst)

    inst.OnBuiltFn = OnBuiltFn

    return inst
end

return Prefab("sjy_zhuozi_table", fn, assets, prefabs),
    MakePlacer("sjy_zhuozi_table_placer", "sjy_zhuozi_table", "sjy_zhuozi_table", "idle")



-- require "prefabutil"
-- local cooking = require("cooking")

-- local assets = {
--     Asset("ANIM", "anim/sjy_zhuozi_table.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_zhuozi_table.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_zhuozi_table.xml"),
-- }

-- local prefabs = {
--     "collapse_small",
-- }

-- local function onopen(inst)
--     inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
-- end

-- local function onclose(inst)
--     inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
-- end

-- local function onhammered(inst, worker)
--     if inst.components.lootdropper then
--         inst.components.lootdropper:DropLoot()
--     end
--     if inst.components.container then
--         inst.components.container:DropEverything()
--         inst.components.container:Close()
--     end
--     local fx = SpawnPrefab("collapse_small")
--     if fx then
--         fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
--         fx:SetMaterial("metal")
--     end
--     inst:Remove()
-- end

-- local function onhit(inst, worker)
--     if inst.components.container then
--         inst.components.container:DropEverything()
--         inst.components.container:Close()
--     end
--     inst.AnimState:PlayAnimation("hit")
--     inst.AnimState:PushAnimation("idle", true)
-- end

-- local function RemoveDecor(inst, data)
--     -- 增加完整的参数验证
--     if not inst or not inst:IsValid() then return end
--     if not data or not data.slot then return end
    
--     local str1 = "food"
--     local str2 = "s"
--     local symbol = str1 .. tostring(data.slot) .. str2
    
--     -- 验证符号字符串有效且不为空
--     if symbol and symbol ~= "" and inst.AnimState then
--         inst.AnimState:ClearOverrideSymbol(symbol)
--     end
-- end

-- -- 修复进食物动画资源获取逻辑，支持更多类型食物
-- local function getbuild(item)
--     -- 增强的有效性检查
--     if not item or not item:IsValid() then
--         print("[getbuild] 无效物品实例")
--         return "cook_pot_food", "idle"
--     end
    
--     if not item.prefab or item.prefab == "" then
--         print("[getbuild] 物品缺少prefab属性")
--         return "cook_pot_food", "idle"
--     end

--     -- 处理调味食物
--     if item:HasTag("spicedfood") then 
--         local recipe = GetRecipe(item.prefab) 
--         local truename = item.prefab
        
--         -- 提取原始食物名称（去掉_spice后缀）
--         local start_idx = string.find(truename, "_spice")
--         if start_idx then
--             truename = string.sub(truename, 1, start_idx - 1)
--         end
        
--         -- 模组食物特殊处理
--         if IsModCook(item.prefab) then
--             print("[getbuild] 调味模组食物:", truename)
--             return truename, truename
--         else
--             local build = (recipe and recipe.overridebuild) or "cook_pot_food"
--             print("[getbuild] 调味普通食物:", build, truename)
--             return build, truename
--         end
--     end

--     -- 兼容模组自定义食物接口
--     if type(item.Get_Myth_Food_Table) == "function" then
--         local build = item:Get_Myth_Food_Table()
--         local symbol = item.prefab or "idle"
--         print("[getbuild] 模组自定义食物:", build or symbol, symbol)
--         return build or symbol, symbol
--     end

--     -- 处理有动画组件的物品（增强版）
--     if item.AnimState then
--         -- 安全获取build
--         local build = nil
--         if type(item.AnimState.GetBuild) == "function" then
--             build = item.AnimState:GetBuild()
--         end
        
--         -- 安全获取动画
--         local anim = "idle"
--         if type(item.AnimState.GetCurrentAnimation) == "function" then
--             anim = item.AnimState:GetCurrentAnimation() or "idle"
--         end
        
--         -- 验证build有效性
--         if build and build ~= "" then
--             print("[getbuild] 动画组件物品:", build, anim)
--             return build, anim
--         end
--     end

--     -- 处理肉类物品（扩展支持）
--     if item:HasTag("meat") then
--         print("[getbuild] 肉类物品:", "meat", "idle")
--         return "meat", "idle"
--     end

--     -- 处理怪物肉类（扩展支持）
--     if item:HasTag("monstermeat") then
--         print("[getbuild] 怪物肉类物品:", "meat_monster", "idle")
--         return "meat_monster", "idle"
--     end

--     -- 通用烹饪食物处理
--     local recipe = GetRecipe(item.prefab)
--     if recipe then
--         local build = recipe.overridebuild or "cook_pot_food"
--         local symbol = recipe.overridesymbolname or item.prefab or "idle"
--         print("[getbuild] 普通烹饪食物:", build, symbol)
--         return build, symbol
--     end

--     -- 处理其他物品类型（作为最后的备选）
--     print("[getbuild] 通用物品 fallback:", item.prefab, "idle")
--     return item.prefab, "idle"
-- end

-- local function IsModCook(prefab)
--     if not prefab or prefab == "" then return false end
--     for cooker, recipes in pairs(cooking.recipes) do
--         if IsModCookingProduct(cooker, prefab) then
--             return true
--         end
--     end
--     return false
-- end

-- local function GetRecipe(prefab)
--     if not prefab or prefab == "" then return nil end
--     for cooker, recipes in pairs(cooking.recipes) do
--         if recipes[prefab] then
--             return recipes[prefab]
--         end
--     end
--     return nil
-- end

-- local function AddDecor(inst, data)
--     -- 增强的基础有效性检查
--     if not inst or not inst:IsValid() then
--         print("[AddDecor] 桌子实例无效")
--         return 
--     end
    
--     if inst:HasTag("burnt") then
--         print("[AddDecor] 桌子已烧毁，无法添加装饰")
--         return 
--     end
    
--     if not data or not data.slot or not data.item then
--         print("[AddDecor] 物品数据不完整")
--         return 
--     end
    
--     if not data.item:IsValid() then
--         print("[AddDecor] 物品实例无效")
--         return 
--     end

--     -- 生成符号名称（严格按照动画文件中的命名规则）
--     local str1 = "food"
--     local str2 = "s"
--     local slotStr = tostring(data.slot)
    
--     -- 验证字符串拼接结果
--     if not slotStr or slotStr == "" then
--         print("[AddDecor] 格子编号无效")
--         return
--     end
    
--     local targetSymbol = str1 .. slotStr .. str2
--     print("[AddDecor] 处理格子:", slotStr, "目标符号:", targetSymbol)

--     -- 获取物品显示资源
--     local build, symbol = getbuild(data.item)
--     if not build or build == "" or not symbol or symbol == "" then
--         print("[AddDecor] 无法获取有效的物品资源")
--         return
--     end

--     -- 应用符号覆盖（确保AnimState有效）
--     if inst.AnimState then
--         -- 额外检查是否能执行OverrideSymbol方法
--         if type(inst.AnimState.OverrideSymbol) == "function" then
--             print("[AddDecor] 应用覆盖: 符号=", targetSymbol, "build=", build, "symbol=", symbol)
--             inst.AnimState:OverrideSymbol(targetSymbol, build, symbol)
--         else
--             print("[AddDecor] AnimState缺少OverrideSymbol方法")
--         end
--     else
--         print("[AddDecor] 桌子缺少AnimState组件")
--     end
-- end

-- -- 修复OnBuiltFn函数，增加完整的安全检查
-- local function OnBuiltFn(inst, builder)
--     -- 检查builder是否存在且有效
--     if not builder then
--         print("[OnBuiltFn] builder不存在")
--         return
--     end
    
--     -- 检查builder是否有IsValid方法并调用
--     if type(builder.IsValid) ~= "function" then
--         print("[OnBuiltFn] builder缺少IsValid方法")
--         return
--     end
    
--     if not builder:IsValid() then
--         print("[OnBuiltFn] builder实例无效")
--         return
--     end
    
--     -- 检查必要的组件和方法是否存在
--     if builder.components 
--         and builder.components.myth_playernwd 
--         and type(builder.components.myth_playernwd.DoDelta) == "function" then
--         builder.components.myth_playernwd:DoDelta("foodtable_nwd", 4)
--     else
--         print("[OnBuiltFn] builder缺少必要的组件或方法")
--     end
-- end

-- local function OnUse(inst, data)
--     if not data or not data.doer then
--         print("[OnUse] 数据或执行者不存在")
--         return
--     end
    
--     OnBuiltFn(inst, data.doer)
-- end

-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddSoundEmitter()
--     inst.entity:AddMiniMapEntity()
--     inst.entity:AddNetwork()

--     inst.MiniMapEntity:SetIcon("sjy_zhuozi_table.tex")

--     inst:AddTag("structure")

--     inst.AnimState:SetBank("sjy_zhuozi_table")
--     inst.AnimState:SetBuild("sjy_zhuozi_table")
--     inst.AnimState:PlayAnimation("idle")
--     inst.AnimState:SetScale(.5, .5, .5)

--     MakeObstaclePhysics(inst, 1.5)

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst:AddComponent("inspectable")

--     inst:AddComponent("container")
--     inst.components.container:WidgetSetup("sjy_zhuozi_table")
--     inst.components.container.onopenfn = onopen
--     inst.components.container.onclosefn = onclose
--     inst.components.container.skipclosesnd = true
--     inst.components.container.skipopensnd = true

--     inst:AddComponent("lootdropper")

--     inst:AddComponent("workable")
--     inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
--     inst.components.workable:SetWorkLeft(3)
--     inst.components.workable:SetOnFinishCallback(onhammered)
--     inst.components.workable:SetOnWorkCallback(onhit)

--     inst:AddComponent("preserver")
--     inst.components.preserver:SetPerishRateMultiplier(-1000000)

--     -- 注册事件监听时增加有效性检查
--     inst:ListenForEvent("itemget", function(...) AddDecor(inst, ...) end)
--     inst:ListenForEvent("itemlose", function(...) RemoveDecor(inst, ...) end)
--     inst:ListenForEvent("onopen", function(...) OnUse(inst, ...) end)
--     inst:ListenForEvent("onclose", function(...) OnUse(inst, ...) end)

--     MakeLargeBurnable(inst)
--     MakeLargePropagator(inst)

--     AddHauntableDropItemOrWork(inst)

--     inst.OnBuiltFn = OnBuiltFn

--     return inst
-- end

-- return Prefab("sjy_zhuozi_table", fn, assets, prefabs),
--     MakePlacer("sjy_zhuozi_table_placer", "sjy_zhuozi_table", "sjy_zhuozi_table", "idle")









-- require "prefabutil"
-- local cooking = require("cooking")

-- local assets = {
--     Asset("ANIM", "anim/sjy_zhuozi_table.zip"),
--     Asset("IMAGE", "images/inventoryimages/sjy_zhuozi_table.tex"),
--     Asset("ATLAS", "images/inventoryimages/sjy_zhuozi_table.xml"),
-- }

-- local prefabs = {
--     "collapse_small",
-- }

-- local function onopen(inst)
--     inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
-- end

-- local function onclose(inst)
--     inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
-- end

-- local function onhammered(inst, worker)
--     if inst.components.lootdropper then
--         inst.components.lootdropper:DropLoot()
--     end
--     if inst.components.container then
--         inst.components.container:DropEverything()
--         inst.components.container:Close()
--     end
--     local fx = SpawnPrefab("collapse_small")
--     if fx then
--         fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
--         fx:SetMaterial("metal")
--     end
--     inst:Remove()
-- end

-- local function onhit(inst, worker)
--     if inst.components.container then
--         inst.components.container:DropEverything()
--         inst.components.container:Close()
--     end
--     inst.AnimState:PlayAnimation("hit")
--     inst.AnimState:PushAnimation("idle", true)
-- end

-- local function RemoveDecor(inst, data)
--     -- 严格参数检查
--     if not inst or not inst:IsValid() then
--         print("[RemoveDecor] 桌子实例无效")
--         return
--     end
--     if not data or not data.slot then
--         print("[RemoveDecor] 缺少格子数据")
--         return
--     end
    
--     local str1 = "food"
--     local str2 = "s"
--     local symbol = str1 .. tostring(data.slot) .. str2
    
--     if inst.AnimState then
--         inst.AnimState:ClearOverrideSymbol(symbol)
--     end
-- end

-- -- 增强物品动画资源获取逻辑，支持更多类型物品
-- local function getbuild(item)
--     -- 基础有效性检查链
--     if not item then
--         print("[getbuild] 物品为nil")
--         return "cook_pot_food", "idle"
--     end
--     if not item:IsValid() then
--         print("[getbuild] 物品已失效")
--         return "cook_pot_food", "idle"
--     end
--     if not item.prefab then
--         print("[getbuild] 物品缺少prefab属性")
--         return "cook_pot_food", "idle"
--     end

--     -- 处理调味食物
--     if item:HasTag("spicedfood") then 
--         local truename = item.prefab
--         -- 提取原始食物名称（去掉_spice后缀）
--         local start_idx = string.find(truename, "_spice")
--         if start_idx then
--             truename = string.sub(truename, 1, start_idx - 1)
--         end
--         -- 模组食物处理
--         if IsModCook(truename) then
--             print("[getbuild] 调味模组食物:", truename)
--             return truename, truename
--         else
--             local recipe = GetRecipe(truename)
--             local build = (recipe and recipe.overridebuild) or "cook_pot_food"
--             print("[getbuild] 调味普通食物:", build, truename)
--             return build, truename
--         end
--     end

--     -- 兼容模组自定义食物接口
--     if type(item.Get_Myth_Food_Table) == "function" then
--         local build = item:Get_Myth_Food_Table()
--         local symbol = item.prefab or "idle"
--         print("[getbuild] 模组自定义食物:", build or symbol, symbol)
--         return build or symbol, symbol
--     end

--     -- 处理有动画组件的物品（完善方法检查）
--     if item.AnimState then
--         local get_build_fn = item.AnimState.GetBuild
--         local build = get_build_fn and get_build_fn(item.AnimState) or nil
--         local get_anim_fn = item.AnimState.GetCurrentAnimation
--         local anim = get_anim_fn and get_anim_fn(item.AnimState) or "idle"
        
--         -- 处理可能的空build
--         if build and build ~= "" then
--             print("[getbuild] 动画组件物品:", build, anim)
--             return build, anim
--         end
--     end

--     -- 处理肉类等特殊物品（扩展支持非烹饪锅食物）
--     local special_builds = {
--         meat = "meat",
--         meat_monster = "meat_monster",
--         meat_rack_food = "meat_rack_food"
--     }
--     if special_builds[item.prefab] then
--         print("[getbuild] 特殊物品:", item.prefab, "idle")
--         return item.prefab, "idle"
--     end

--     -- 通用烹饪食物处理
--     local recipe = GetRecipe(item.prefab)
--     if recipe then
--         local build = recipe.overridebuild or "cook_pot_food"
--         local symbol = recipe.overridesymbolname or item.prefab or "idle"
--         print("[getbuild] 普通烹饪食物:", build, symbol)
--         return build, symbol
--     end

--     -- 最终fallback，确保不会返回nil
--     print("[getbuild] 默认 fallback:", item.prefab, "idle")
--     return item.prefab, "idle"
-- end

-- local function IsModCook(prefab)
--     if not prefab then return false end
--     for cooker, recipes in pairs(cooking.recipes) do
--         if IsModCookingProduct(cooker, prefab) then
--             return true
--         end
--     end
--     return false
-- end

-- local function GetRecipe(prefab)
--     if not prefab then return nil end
--     for cooker, recipes in pairs(cooking.recipes) do
--         if recipes[prefab] then
--             return recipes[prefab]
--         end
--     end
--     return nil
-- end

-- local function AddDecor(inst, data)
--     -- 多层级参数验证，解决"物品数据不完整"问题
--     if not inst or not inst:IsValid() then
--         print("[AddDecor] 桌子实例无效")
--         return 
--     end
--     if inst:HasTag("burnt") then
--         print("[AddDecor] 桌子已烧毁")
--         return 
--     end
--     if not data then
--         print("[AddDecor] 缺少数据参数")
--         return 
--     end
--     if not data.slot then
--         print("[AddDecor] 缺少格子编号")
--         return 
--     end
--     if not data.item or not data.item:IsValid() then
--         print("[AddDecor] 物品无效或已消失")
--         return 
--     end

--     -- 符号名称生成（严格遵循动画文件命名规则）
--     local str1 = "food"
--     local str2 = "s"
--     local slot_str = tostring(data.slot)  -- 确保slot转为字符串，避免拼接问题
--     local targetSymbol = str1 .. slot_str .. str2
--     print("[AddDecor] 处理格子:", slot_str, "目标符号:", targetSymbol)

--     -- 获取物品显示资源
--     local build, symbol = getbuild(data.item)
--     if not build or not symbol then
--         print("[AddDecor] 无法获取有效的物品资源")
--         return
--     end

--     -- 应用符号覆盖（确保AnimState有效）
--     if inst.AnimState then
--         -- 防止空字符串导致的动画丢失
--         if build ~= "" and symbol ~= "" then
--             print("[AddDecor] 应用覆盖: 符号=", targetSymbol, "build=", build, "symbol=", symbol)
--             inst.AnimState:OverrideSymbol(targetSymbol, build, symbol)
--         else
--             print("[AddDecor] 无效的资源名称: build=", build, "symbol=", symbol)
--         end
--     else
--         print("[AddDecor] 桌子缺少AnimState组件")
--     end
-- end

-- -- 修复builder空值和方法检查问题
-- local function OnBuiltFn(inst, builder)
--     -- 安全检查链，防止nil引用和方法不存在错误
--     if not builder then
--         print("[OnBuiltFn] builder为nil")
--         return
--     end
--     -- 检查IsValid方法是否存在
--     if type(builder.IsValid) ~= "function" then
--         print("[OnBuiltFn] builder缺少IsValid方法")
--         return
--     end
--     if not builder:IsValid() then
--         print("[OnBuiltFn] builder实例无效")
--         return
--     end
--     -- 检查组件和方法是否存在
--     if builder.components 
--         and builder.components.myth_playernwd 
--         and type(builder.components.myth_playernwd.DoDelta) == "function" then
--         builder.components.myth_playernwd:DoDelta("foodtable_nwd", 4)
--     else
--         print("[OnBuiltFn] builder缺少必要的组件或方法")
--     end
-- end

-- local function OnUse(inst, data)
--     if not data or not data.doer then
--         print("[OnUse] 缺少使用者数据")
--         return
--     end
--     OnBuiltFn(inst, data.doer)
-- end

-- local function fn()
--     local inst = CreateEntity()

--     inst.entity:AddTransform()
--     inst.entity:AddAnimState()
--     inst.entity:AddSoundEmitter()
--     inst.entity:AddMiniMapEntity()
--     inst.entity:AddNetwork()

--     inst.MiniMapEntity:SetIcon("sjy_zhuozi_table.tex")

--     inst:AddTag("structure")

--     inst.AnimState:SetBank("sjy_zhuozi_table")
--     inst.AnimState:SetBuild("sjy_zhuozi_table")
--     inst.AnimState:PlayAnimation("idle")
--     inst.AnimState:SetScale(.5, .5, .5)

--     MakeObstaclePhysics(inst, 1.5)

--     inst.entity:SetPristine()

--     if not TheWorld.ismastersim then
--         return inst
--     end

--     inst:AddComponent("inspectable")

--     inst:AddComponent("container")
--     inst.components.container:WidgetSetup("sjy_zhuozi_table")  -- 确保与动画符号数量匹配
--     inst.components.container.onopenfn = onopen
--     inst.components.container.onclosefn = onclose
--     inst.components.container.skipclosesnd = true
--     inst.components.container.skipopensnd = true

--     inst:AddComponent("lootdropper")

--     inst:AddComponent("workable")
--     inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
--     inst.components.workable:SetWorkLeft(3)
--     inst.components.workable:SetOnFinishCallback(onhammered)
--     inst.components.workable:SetOnWorkCallback(onhit)

--     inst:AddComponent("preserver")
--     inst.components.preserver:SetPerishRateMultiplier(-1000000)

--     -- 注册事件监听
--     inst:ListenForEvent("itemget", AddDecor)
--     inst:ListenForEvent("itemlose", RemoveDecor)
--     inst:ListenForEvent("onopen", OnUse)
--     inst:ListenForEvent("onclose", OnUse)

--     MakeLargeBurnable(inst)
--     MakeLargePropagator(inst)

--     AddHauntableDropItemOrWork(inst)

--     inst.OnBuiltFn = OnBuiltFn

--     return inst
-- end

-- return Prefab("sjy_zhuozi_table", fn, assets, prefabs),
--     MakePlacer("sjy_zhuozi_table_placer", "sjy_zhuozi_table", "sjy_zhuozi_table", "idle")