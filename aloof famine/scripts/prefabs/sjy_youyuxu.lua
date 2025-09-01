local assets =
{
    Asset("ANIM", "anim/sjy_youyuxu.zip"),
	Asset("IMAGE", "images/inventoryimages/sjy_youyuxu.tex"),
    Asset("ATLAS", "images/inventoryimages/sjy_youyuxu.xml"),
	Asset("IMAGE", "images/inventoryimages/sjy_youyuxu_cooked.tex"),
    Asset("ATLAS", "images/inventoryimages/sjy_youyuxu_cooked.xml"),
}

local cooked_prefabs =
{
    "spoiled_food",
}

local rotten_prefabs =
{
    "gridplacer_farmablesoil",
}

local FERTILIZER_DEFS = require("prefabs/fertilizer_nutrient_defs").FERTILIZER_DEFS

local function commonfn(anim, cookable)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sjy_youyuxu")
    inst.AnimState:SetBuild("sjy_youyuxu")
    inst.AnimState:PlayAnimation(anim)

    inst:AddTag("catfood")

    if cookable then
        --cookable (from cookable component) added to pristine state for optimization
        inst:AddTag("cookable")
    end

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT 

    if cookable then
        inst:AddComponent("cookable")
        inst.components.cookable.product = "sjy_youyuxu_cooked"
    end

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(1440)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    MakeHauntableLaunchAndPerish(inst)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("bait")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_youyuxu.xml"

    -- inst:AddComponent("tradable")
    -- inst.components.tradable.goldvalue = 1

    return inst
end

local function defaultfn()
    local inst = commonfn("idle", true)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.edible.healthvalue = 12.5
    inst.components.edible.sanityvalue = -10
    inst.components.edible.hungervalue = -5
    inst.components.perishable:SetPerishTime(1440)

    inst.components.floater:SetScale({0.55, 0.5, 0.55})
    inst.components.floater:SetVerticalOffset(0.05)

    return inst
end

local function cookedfn()
    local inst = commonfn("cooked")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.edible.healthvalue = 18.5
    inst.components.edible.sanityvalue = 10
    inst.components.edible.hungervalue = 5
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)

    inst.components.floater:SetSize("med")
    inst.components.floater:SetScale(0.65)
    
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_youyuxu_cooked.xml"

    return inst
end


return Prefab("sjy_youyuxu", defaultfn, assets),
    Prefab("sjy_youyuxu_cooked", cookedfn, assets)
