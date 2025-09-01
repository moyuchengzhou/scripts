
local assets=
{
	Asset("ANIM", "anim/sjy_zrzn.zip"),
	Asset("ANIM", "anim/swap_sjy_zrzn.zip"),
	Asset("IMAGE", "images/inventoryimages/sjy_zrzn.tex"),
	Asset("ATLAS", "images/inventoryimages/sjy_zrzn.xml"),
}

local function onfinished(inst)
    inst:Remove()--耐久用完后，移除这个物体
    end


local prefabs =
{
}
STRINGS.NAMES.SJY_ZRZN="自然之怒"--名称
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SJY_ZRZN="体验一下大自然的愤怒吧"--描述
local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_sjy_zrzn", "swap_sjy_zrzn")
	owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

end

local function onunequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_object")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function onattack(inst, attacker, target, periodic)
	local pos = Vector3(target.Transform:GetWorldPosition())
	for i = 1 , 10 do
		inst:DoTaskInTime(.03*i ,function ()
			TheWorld:PushEvent("ms_sendlightningstrike", pos)
		end)
	end
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sjy_zrzn")  
    inst.AnimState:SetBuild("sjy_zrzn")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable") 
    inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_zrzn.xml"
	
	inst:AddComponent("equippable") 
	inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	inst.components.equippable.insulated = true
	


	inst:AddComponent("weapon")    
	inst.components.weapon:SetDamage(45)
    inst.components.weapon:SetOnAttack(onattack)
	
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(500)
	inst.components.finiteuses:SetUses(500)

	inst.components.finiteuses:SetOnFinished( onfinished )  
	MakeHauntableLaunchAndPerish(inst)
    return inst
end 
    
return Prefab( "sjy_zrzn", fn, assets, prefabs ) 