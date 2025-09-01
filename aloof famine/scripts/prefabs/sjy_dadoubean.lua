local assets =
{
    Asset("ANIM", "anim/sjy_dadoubean.zip"),
	Asset("IMAGE", "images/inventoryimages/sjy_dadoubean.tex"),
    Asset("ATLAS", "images/inventoryimages/sjy_dadoubean.xml"),
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

    inst.AnimState:SetBank("sjy_dadoubean")
    inst.AnimState:SetBuild("sjy_dadoubean")
    inst.AnimState:PlayAnimation(anim)

    inst:AddTag("catfood")
    inst:AddTag("sjy_dadoubean")

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
    inst.components.edible.foodtype = FOODTYPE.INEDIBLE

    -- inst:AddComponent("perishable")
    -- inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    -- inst.components.perishable:StartPerishing()
    -- inst.components.perishable.onperishreplacement = "sjy_lvdoubean"

    MakeHauntableLaunchAndPerish(inst)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:AddRandomLoot("sjy_lvdoubean", 1)
    inst.components.lootdropper.numrandomloot = 1

    inst:AddComponent("bait")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_dadoubean.xml"

    return inst
end

local function defaultfn()
    local inst = commonfn("idle", true)

    if not TheWorld.ismastersim then
        return inst
    end

    -- inst.components.edible.healthvalue = 3
    -- inst.components.edible.sanityvalue = 0
    -- inst.components.edible.hungervalue = 1
    -- inst.components.perishable:SetPerishTime(1440)

    inst.components.floater:SetScale({0.55, 0.5, 0.55})
    inst.components.floater:SetVerticalOffset(0.05)
    

    return inst
end


return Prefab("sjy_dadoubean", defaultfn, assets)
