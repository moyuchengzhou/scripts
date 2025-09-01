
local assets=
{
	Asset("ANIM", "anim/sjy_wlcj.zip"),
	Asset("ANIM", "anim/swap_sjy_wlcj.zip"),
	Asset("IMAGE", "images/inventoryimages/sjy_wlcj.tex"),
	Asset("ATLAS", "images/inventoryimages/sjy_wlcj.xml"),
}

local prefabs =
{
}


local function onfinished(inst)
    inst:Remove()--耐久用完后，移除这个物体
    end


STRINGS.NAMES.SJY_WLCJ="蔓绿翠剑"--名称
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SJY_WLCJ="强大的再生能力"--描述

local damage = math.random(1,71)

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_sjy_wlcj", "swap_sjy_wlcj")
	owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

end

local function onunequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_object")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function onattack(inst, attacker, target, periodic)
	if damage < 28 then
		if math.random() < .5 then
			SpawnPrefab("collapse_small").Transform:SetPosition(target.Transform:GetWorldPosition())
			SpawnPrefab(target.prefab).Transform:SetPosition(target.Transform:GetWorldPosition())
		end
		if math.random() < .2 then
			if attacker ~= nil and attacker.components.health and not attacker.components.health:IsDead() then
				attacker.components.health:DoDelta(-30,nil,nil,true,nil,true)
			end
		end
	end
	 damage = math.random(1,71)
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sjy_wlcj")  
    inst.AnimState:SetBuild("sjy_wlcj")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable") 
    inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_wlcj.xml"
	
	inst:AddComponent("equippable") 
	inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

	inst:AddComponent("weapon")    
	inst.components.weapon:SetDamage(damage)
    inst.components.weapon:SetOnAttack(onattack)
	
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(200)
	inst.components.finiteuses:SetUses(200)

	inst.components.finiteuses:SetOnFinished( onfinished )  
	MakeHauntableLaunchAndPerish(inst)
    return inst
end 
    
return Prefab( "sjy_wlcj", fn, assets, prefabs ) 