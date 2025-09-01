require "prefabutil"

local cooking = require("cooking")

local assets =
{
    Asset("ANIM", "anim/sjy_mogu_table.zip"),
    Asset("IMAGE", "images/inventoryimages/sjy_mogu3_table.tex"),
   Asset("ATLAS", "images/inventoryimages/sjy_mogu3_table.xml"),
   
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
            local symbol_override_build = (recipe ~= nil and recipe.overridebuild) or "cook_pot_food"
            return symbol_override_build,truename,recipe.spice
        end
    else
        local overridebuild = IsModCook(item.prefab) and item.prefab or nil
        local recipe = GetRecipe(item.prefab) 
        local build = (recipe ~= nil and recipe.overridebuild) or overridebuild or "cook_pot_food"
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

    inst.MiniMapEntity:SetIcon("sjy_mogu3_table.tex")

    inst:AddTag("structure")

    --inst:AddTag("myth_nianweidu")

    inst.AnimState:SetBank("sjy_mogu_table")
    inst.AnimState:SetBuild("sjy_mogu_table")
    inst.AnimState:PlayAnimation("idle3")
    inst.AnimState:SetScale(.6,.6,.6)

    MakeObstaclePhysics(inst, 1.5)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("sjy_mogu3_table")
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

return Prefab("sjy_mogu3_table", fn, assets, prefabs),
    MakePlacer("sjy_mogu3_table_placer", "sjy_mogu_table", "sjy_mogu_table", "idle33")
