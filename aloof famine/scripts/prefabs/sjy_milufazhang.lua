local assets=
{
	Asset("ANIM", "anim/swap_sjy_milufazhang.zip"),
    Asset("ANIM", "anim/sjy_milufazhang.zip"),
	Asset("IMAGE", "images/inventoryimages/sjy_milufazhang.tex"),
	Asset("ATLAS", "images/inventoryimages/sjy_milufazhang.xml"),
}

local prefabs =
{
}

STRINGS.NAMES.SJY_MILUFAZHANG="麋鹿法杖"--名称
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SJY_MILUFAZHANG="一双寒冷的眼睛死死盯着你"--描述

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function deep_freeze_func(inst, target)
    if target == nil then
        return
    end
    if target and not target:IsValid() then
        return
    end
    local bffx = SpawnPrefab("sjy_buff_bing")
    local owner = inst.components.inventoryitem.owner

    bffx.Transform:SetScale(target.Transform:GetScale())
    bffx.entity:SetParent(target.entity)
    bffx.froze_target = target
    if owner and owner.components.temperature then
        owner.components.temperature:SetTemperature(owner.components.temperature.current - 5)
        owner.components.talker:Say("冻住不洗澡！")
    end
end

local function onhaunt(inst)
    -- statements
end

local function checkfn(doer,target,pos)
    return target and target.components and target.components.freezable and target.components.combat
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sjy_milufazhang")
    inst.AnimState:SetBuild("sjy_milufazhang")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("nosteal")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -------

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_milufazhang.xml"
    inst:AddComponent("tradable")
    inst:AddComponent("equippable")
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(23)

    inst.components.equippable:SetOnEquip(function(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_sjy_milufazhang", "swap_sjy_milufazhang")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(deep_freeze_func)
    inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster:SetCanCastFn(checkfn)

    MakeHauntableLaunch(inst)
    AddHauntableCustomReaction(inst, onhaunt, true, false, true)
    return inst
end

return Prefab( "sjy_milufazhang", fn, assets, prefabs)