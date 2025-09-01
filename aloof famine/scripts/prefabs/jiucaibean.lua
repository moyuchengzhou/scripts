local assets =
{
    Asset("ANIM", "anim/jiucaibean.zip"),
	Asset("IMAGE", "images/inventoryimages/jiucaibean.tex"),
    Asset("ATLAS", "images/inventoryimages/jiucaibean.xml"),
	Asset("IMAGE", "images/inventoryimages/kaojiucai.tex"),
    Asset("ATLAS", "images/inventoryimages/kaojiucai.xml"),
}

-- local function oneaten(inst, eater)
--     if eater.components.timer  then -- 判断是玩家
--         if eater.components.combat ~= nil then --这个buff需要攻击组件
--             -- eater.time_l_strengthenhancer = { replace_min = TUNING.SEG_TIME }
--             eater.components.debuffable:AddDebuff("sjy_baojinbi", "sjy_baojinbi")
--             eater.components.talker:Say("热乎乎的豆浆")		
--             end

--         -- if eater.components.freezable then
--         --      eater.components.freezable:AddColdness(10)
--         --      eater.components.talker:Say("草莓蓝莓混杂在一起让冰块更加清爽!!!")	
--         --  end


--     -- elseif eater.components.timer and eater:HasTag("player") or not eater.prefab =="waxwell"  then
--     --     if eater.components.combat ~= nil then --这个buff需要攻击组件
--     --         -- eater.time_l_strengthenhancer = { replace_min = TUNING.SEG_TIME }
--     --         eater.components.debuffable:AddDebuff("sweettea_buff", "sweettea_buff")
--     --         eater.components.talker:Say("夜晚的气息!!!!")		
--     --         end
    
--     end
    
-- end

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

    inst.AnimState:SetBank("jiucaibean")
    inst.AnimState:SetBuild("jiucaibean")
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

    if cookable then
        inst:AddComponent("cookable")
        inst.components.cookable.product = "kaojiucai"
    end

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
    inst.components.inventoryitem.atlasname = "images/inventoryimages/jiucaibean.xml"

    -- inst:AddComponent("tradable")

    -- inst:AddComponent("tradable")
    -- inst.components.tradable.goldvalue = 1

    return inst
end

local function defaultfn()
    local inst = commonfn("idle", true)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.edible.healthvalue = 3
    inst.components.edible.sanityvalue = -5
    inst.components.edible.hungervalue = 18
    inst.components.perishable:SetPerishTime(1440)
    -- inst.components.edible:SetOnEatenFn(oneaten)--吃的时候调用buff效果

    inst.components.floater:SetScale({0.55, 0.5, 0.55})
    inst.components.floater:SetVerticalOffset(0.05)
    inst:AddComponent("tradable")
    return inst
end

local function cookedfn()
    local inst = commonfn("cooked")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.edible.healthvalue = 6
    inst.components.edible.sanityvalue = 5
    inst.components.edible.hungervalue = 20
    inst.components.perishable:SetPerishTime(1440)

    inst.components.floater:SetSize("med")
    inst.components.floater:SetScale(0.65)
    inst:AddComponent("tradable")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kaojiucai.xml"

    return inst
end


return Prefab("jiucaibean", defaultfn, assets),
    Prefab("kaojiucai", cookedfn, assets)
