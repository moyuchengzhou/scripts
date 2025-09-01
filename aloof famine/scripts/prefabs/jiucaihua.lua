local assets =
{
    Asset("ANIM", "anim/jiucaihua.zip"),
	Asset("IMAGE", "images/inventoryimages/jiucaihua.tex"),
    Asset("ATLAS", "images/inventoryimages/jiucaihua.xml"),
	-- Asset("IMAGE", "images/inventoryimages/kaojiucai.tex"),
    -- Asset("ATLAS", "images/inventoryimages/kaojiucai.xml"),
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

    inst.AnimState:SetBank("jiucaihua")
    inst.AnimState:SetBuild("jiucaihua")
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
    inst.components.edible.foodtype = FOODTYPE.VEGGIE 

    -- if cookable then
    --     -- inst:AddComponent("cookable")
    --     inst.components.cookable.product = "kaojiucai"
    -- end

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    MakeHauntableLaunchAndPerish(inst)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("bait")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/jiucaihua.xml"

    -- inst:AddComponent("tradable")
    -- inst.components.tradable.goldvalue = 1

    return inst
end

local function defaultfn()
    local inst = commonfn("idle", true)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.edible.healthvalue = 1
    inst.components.edible.sanityvalue = 8
    inst.components.edible.hungervalue = 1
    inst.components.perishable:SetPerishTime(1440)

    inst.components.floater:SetScale({0.55, 0.5, 0.55})
    inst.components.floater:SetVerticalOffset(0.05)
    inst:AddComponent("tradable")
    return inst
end


return Prefab("jiucaihua", defaultfn, assets)
    -- Prefab("kaojiucai", cookedfn, assets)
