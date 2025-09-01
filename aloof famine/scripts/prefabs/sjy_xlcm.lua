


local assets=
{
    Asset("ANIM", "anim/spear.zip"),
    Asset("ANIM", "anim/swap_spear.zip"),
	-- Asset("ATLAS", "images/sjy_xlcm.xml"),
	-- Asset("IMAGE", "images/sjy_xlcm.tex"),

}
local function onattack(weapon, attacker, target)
    if attacker then
        if  target.components.freezable then
            if  target ~= nil and target.components.freezable ~= nil then
                target.components.freezable:AddColdness(1)	
            end	               
        end
    end
end
local function OnEquip(inst, owner)
  owner.AnimState:OverrideSymbol("swap_object", "swap_sjy_xlcm", "symbol0")
  owner.AnimState:Show("ARM_carry")
  owner.AnimState:Hide("ARM_normal")
end
  
local function OnUnequip(inst, owner)
  owner.AnimState:Hide("ARM_carry")
  owner.AnimState:Show("ARM_normal")
end
local function createlight(staff, target, pos)
  local light = SpawnPrefab("deer_ice_burst")
  light.Transform:SetPosition(pos:Get())
  

end	


local function fn()

  local inst = CreateEntity()
  inst.entity:AddTransform()
  inst.entity:AddAnimState()
  inst.entity:AddNetwork()
  MakeInventoryPhysics(inst)
  inst.AnimState:SetBank("spear")
  inst.AnimState:SetBuild("spear")
  inst.AnimState:PlayAnimation("idle")
  inst:AddTag("sharp")
  inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(120)
    inst.components.weapon:SetRange(3,3)
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(2222)
    inst.components.finiteuses:SetUses(2222)  
    inst.components.finiteuses:SetOnFinished(inst.Remove)
    if inst.components.equippable then inst.components.equippable.walkspeedmult =1.5 end

    inst.components.weapon:SetOnAttack(onattack)


	inst:AddComponent("spellcaster")
	inst.components.spellcaster:SetSpellFn(createlight)
	inst.components.spellcaster.canuseonpoint = true
  inst:AddComponent("inspectable")
  inst:AddComponent("inventoryitem")
  inst.components.inventoryitem.atlasname = "images/sjx.xml"
  inst:AddComponent("equippable")
  inst.components.equippable:SetOnEquip( OnEquip )
  inst.components.equippable:SetOnUnequip( OnUnequip )
  return inst
end
  
return  Prefab("sjy_xlcm", fn, assets)
		