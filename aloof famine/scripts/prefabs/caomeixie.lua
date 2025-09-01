local assets =
{
    Asset("ANIM", "anim/caomeixie.zip"),
    Asset("IMAGE", "images/inventoryimages/caomeixie.tex"),
	Asset("ATLAS", "images/inventoryimages/caomeixie.xml"),
}

local prefabs =
{
    "fishmeat_small",
    "lightbulb",
    "slurtle_shellpieces",
}

local brain = require("brains/lightcrabbrain")

local function OnDropped(inst)
    inst.sg:GoToState("stunned")
end

local function OnCookedFn(inst)
    if inst.components.health then
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/mole/death")
    end
end


local function OnSave(inst, data)
    if inst.components.homeseeker ~= nil and inst.components.homeseeker.home ~= nil then
        data.home = inst.components.homeseeker.home.GUID
        return { data.home }
    end
end

local function OnLoadPostPass(inst, newents, data)
    if data ~= nil and data.home ~= nil then
        local home = newents[data.home]
        if home ~= nil and inst.components.homeseeker ~= nil then
            inst.components.homeseeker:SetHome(home.entity)
        end
    end
end


local function CalcSanityAura(inst)
    return inst.components.combat.target ~= nil and 0.5 or 1
end


local function ShouldWake(inst)
    return true
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    local phys = MakeCharacterPhysics(inst, 20, 0.5)
    phys:SetCapsule(0.25, 0.5)

    inst.DynamicShadow:SetSize(0.8, 0.5)

    inst.Transform:SetSixFaced()

    inst.AnimState:SetBank("caomeixie")
    inst.AnimState:SetBuild("caomeixie")
    inst.AnimState:PlayAnimation("xxx")
    inst.AnimState:SetLightOverride(0.25)

    inst.Light:SetRadius(1)
    inst.Light:SetIntensity(.75)
    inst.Light:SetFalloff(0.5)
    inst.Light:SetColour(125/255, 125/255, 125/255)
    inst.Light:Enable(true)

    inst:AddTag("animal")
    inst:AddTag("prey")
    inst:AddTag("smallcreature")
    inst:AddTag("canbetrapped")
    inst:AddTag("cattoy")
    inst:AddTag("catfood")
    inst:AddTag("stunnedbybomb")
    inst:AddTag("lightbattery")

    --cookable (from cookable component) added to pristine state for optimization
    inst:AddTag("cookable")

    MakeFeedableSmallLivestockPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.walkspeed = TUNING.LIGHTCRAB_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.LIGHTCRAB_RUN_SPEED
    inst:SetStateGraph("SGlightcrab")

    inst:AddComponent("homeseeker")

    inst:SetBrain(brain)

    inst:AddComponent("eater")
	inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/caomeixie.xml"
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = false
    inst.components.inventoryitem.canbepickedupalive = true
    inst.components.inventoryitem:SetSinks(true)

    inst:AddComponent("cookable")
    inst.components.cookable.product = "caomeibean_cooked"
    inst.components.cookable:SetOnCookedFn(OnCookedFn)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(100)
    inst.components.health.murdersound = "monkeyisland/lightcrab/hit"

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    inst:AddComponent("lootdropper")
    inst.components.lootdropper.numrandomloot = 2
	inst.components.lootdropper:AddRandomLoot("sjy_xiehuangjiang", .15)
	inst.components.lootdropper:AddRandomLoot("caomeibean", 1)			-- since we do not have a "small lightbulb", a low chance will have to suffice
	inst.components.lootdropper:AddRandomLoot("slurtle_shellpieces", .85)
    
    -- inst:AddComponent("inventoryitem") 

	-- inst.components.inventoryitem.atlasname = "images/inventoryimages/caomeixie.xml"

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"

    MakeSmallBurnableCharacter(inst, "body")
    MakeTinyFreezableCharacter(inst, "body")

    inst:AddComponent("inspectable")
    inst:AddComponent("sleeper")
	inst.components.sleeper:SetSleepTest(nil)
    inst.components.sleeper:SetWakeTest(ShouldWake)

    MakeHauntablePanic(inst)

    inst.OnSave = OnSave
    inst.OnLoadPostPass = OnLoadPostPass
    
    MakeFeedableSmallLivestock(inst, TUNING.LIGHTCRAB_PERISH_TIME, nil, OnDropped)

    return inst
end

return Prefab("caomeixie", fn, assets, prefabs)
