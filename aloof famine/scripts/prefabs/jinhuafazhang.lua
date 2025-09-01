local assets =
{
	Asset("ANIM", "anim/jinhuafazhang.zip"),
	Asset("IMAGE", "images/inventoryimages/jinhuafazhang.tex"),
	Asset("ATLAS", "images/inventoryimages/jinhuafazhang.xml"),
}

local prefabs =
{
	"brilliance_projectile_fx",
	"jinhuafazhang_fx",
}

-- 设置···所有者
local function SetFxOwner(inst, owner)
	if inst._fxowner ~= nil and inst._fxowner.components.colouradder ~= nil then
		inst._fxowner.components.colouradder:DetachChild(inst.fx)
	end
	inst._fxowner = owner
	if owner ~= nil then
		inst.fx.entity:SetParent(owner.entity)
		inst.fx.Follower:FollowSymbol(owner.GUID, "swap_object", nil, nil, nil, true)
		inst.fx.components.highlightchild:SetOwner(owner)
		if owner.components.colouradder ~= nil then
			owner.components.colouradder:AttachChild(inst.fx)
		end
	else
		inst.fx.entity:SetParent(inst.entity)
		--For floating
		inst.fx.Follower:FollowSymbol(inst.GUID, "swap_spear", nil, nil, nil, true)
		inst.fx.components.highlightchild:SetOwner(inst)
	end
end
-- 推idle循环
local function PushIdleLoop(inst)
	if inst.components.finiteuses:GetUses() > 0 then
		inst.AnimState:PushAnimation("idle")
	end
end
-- 停止浮动
local function OnStopFloating(inst)
	if inst.components.finiteuses:GetUses() > 0 then
		inst.fx.AnimState:SetFrame(0)
		inst:DoTaskInTime(0, PushIdleLoop) --#V2C: #HACK restore the looping anim, timing issues
	end
end
-- 在装备上
local function onequip(inst, owner)
	local skin_build = inst:GetSkinBuild()
	if skin_build ~= nil then
		owner:PushEvent("equipskinneditem", inst:GetSkinName())
		owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_jinhuafazhang", inst.GUID, "jinhuafazhang")
	else
		owner.AnimState:OverrideSymbol("swap_object", "jinhuafazhang", "swap_jinhuafazhang")
	end
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
	SetFxOwner(inst, owner)
end
-- 取消装备
local function onunequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
	local skin_build = inst:GetSkinBuild()
	if skin_build ~= nil then
		owner:PushEvent("unequipskinneditem", inst:GetSkinName())
	end
	SetFxOwner(inst, nil)
end
-- 进攻时
local function OnAttack(inst, attacker, target, skipsanity)

	if target.prefab =="lunarthrall_plant" or target.prefab =="monkey" or target.prefab == "powder_monkey" or target.prefab =="prime_mate" or target.prefab =="frog" or target.prefab =="lunarfrog" or target.prefab == "bird_mutant_spitter" or target.prefab == "bird_mutant" then
		if target:IsValid() and target.components.health and not target.components.health:IsDead() then
			target.components.health:Kill()
		end
	end
	
	if inst.skin_sound then
		attacker.SoundEmitter:PlaySound(inst.skin_sound)
	end

	if not target:IsValid() then
		--target killed or removed in combat damage phase
		return
	end

	if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
		target.components.sleeper:WakeUp()
	end
	if target.components.combat ~= nil then
		target.components.combat:SuggestTarget(attacker)
	end
	target:PushEvent("attacked", { attacker = attacker, damage = 0, weapon = inst })
end
-- 安装组件
local function SetupComponents(inst)
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(0)
	inst.components.weapon:SetRange(23, 25)
	inst.components.weapon:SetOnAttack(OnAttack)
	inst.components.weapon:SetProjectile("brilliance_projectile_fx")
end
-- 禁用组件
local function DisableComponents(inst)
	inst:RemoveComponent("equippable")
	inst:RemoveComponent("weapon")
end

local FLOAT_SCALE_BROKEN = { 0.7, 0.5, 0.7 }
local FLOAT_SCALE = { 0.9, 0.6, 0.9 }
-- On 是坏的脏
local function OnIsBrokenDirty(inst)
	if inst.isbroken:value() then
		inst.components.floater:SetSize("med")
		inst.components.floater:SetVerticalOffset(0.15)
		inst.components.floater:SetScale(FLOAT_SCALE_BROKEN)
	else
		inst.components.floater:SetSize("med")
		inst.components.floater:SetVerticalOffset(0.1)
		inst.components.floater:SetScale(FLOAT_SCALE)
	end
end

local SWAP_DATA_BROKEN = { sym_build = "jinhuafazhang", sym_name = "swap_staff_BROKEN_FORGEDITEM_float", bank = "jinhuafazhang", anim = "broken" }
local SWAP_DATA = { sym_build = "jinhuafazhang", sym_name = "swap_jinhuafazhang" }
-- 设置已损坏
local function SetIsBroken(inst, isbroken)
	if isbroken then
		inst.components.floater:SetBankSwapOnFloat(true, -5, SWAP_DATA_BROKEN)
		if inst.fx ~= nil then
			inst.fx:Hide()
		end
	else
		inst.components.floater:SetBankSwapOnFloat(true, -13, SWAP_DATA)
		if inst.fx ~= nil then
			inst.fx:Show()
		end
	end
	inst.isbroken:set(isbroken)
	OnIsBrokenDirty(inst)
end
-- 在破碎时
local function OnBroken(inst)
	if inst.components.equippable ~= nil then
		DisableComponents(inst)
		inst.AnimState:PlayAnimation("broken")
		SetIsBroken(inst, true)
		inst:AddTag("broken")
		inst.components.inspectable.nameoverride = "BROKEN_FORGEDITEM"
	end
end
-- 正在修复
local function OnRepaired(inst)
	if inst.components.equippable == nil then
		SetupComponents(inst)
		inst.fx.AnimState:SetFrame(0)
		inst.AnimState:PlayAnimation("idle", true)
		SetIsBroken(inst, false)
		inst:RemoveTag("broken")
		inst.components.inspectable.nameoverride = nil
	end
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("jinhuafazhang")
	inst.AnimState:SetBuild("jinhuafazhang")
	inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetSymbolBloom("pb_energy_loop")
	inst.AnimState:SetSymbolBloom("stone")
	inst.AnimState:SetSymbolLightOverride("pb_energy_loop01", .5)
	inst.AnimState:SetSymbolLightOverride("pb_ray", .5)
	inst.AnimState:SetSymbolLightOverride("stone", .5)
	inst.AnimState:SetSymbolLightOverride("glow", .25)
	inst.AnimState:SetLightOverride(.1)

	inst:AddTag("rangedweapon")
	inst:AddTag("magicweapon")
	inst:AddTag("show_broken_ui")

	--weapon (from weapon component) added to pristine state for optimization
	inst:AddTag("weapon")

	inst.projectiledelay = FRAMES

	inst:AddComponent("floater")
	inst.isbroken = net_bool(inst.GUID, "jinhuafazhang.isbroken", "isbrokendirty")
	SetIsBroken(inst, false)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		inst:ListenForEvent("isbrokendirty", OnIsBrokenDirty)

		return inst
	end

	local frame = math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1
	inst.AnimState:SetFrame(frame)
	inst.fx = SpawnPrefab("jinhuafazhang_fx")
	inst.fx.AnimState:SetFrame(frame)
	SetFxOwner(inst, nil)
	inst:ListenForEvent("floater_stopfloating", OnStopFloating)

	-- inst:AddComponent("lighter")
	-------
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(5000)
	inst.components.finiteuses:SetUses(5000)

	-- inst:AddComponent("inventoryitem") -- 物品组件
   
	-- inst:AddComponent("planardamage")
	-- inst.components.planardamage:SetBaseDamage(TUNING.STAFF_LUNARPLANT_PLANAR_DAMAGE)

	inst:AddComponent("damagetypebonus")
	inst.components.damagetypebonus:AddBonus("shadow_aligned", inst, TUNING.STAFF_LUNARPLANT_VS_SHADOW_BONUS)

	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/jinhuafazhang.xml" -- 在背包里的贴图
    inst.components.inventoryitem.imagename = "jinhuafazhang"--图片名称
	SetupComponents(inst)

	local setbonus = inst:AddComponent("setbonus")
	setbonus:SetSetName(EQUIPMENTSETNAMES.LUNARPLANT)

	MakeForgeRepairable(inst, FORGEMATERIALS.LUNARPLANT, OnBroken, OnRepaired)
	MakeHauntableLaunch(inst)

	inst.noplanarhitfx = true

	return inst
end

local function fxfn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddFollower()
	inst.entity:AddNetwork()

	inst:AddTag("FX")

	inst.AnimState:SetBank("jinhuafazhang")
	inst.AnimState:SetBuild("jinhuafazhang")
	inst.AnimState:PlayAnimation("swap_loop", true)
	inst.AnimState:SetSymbolBloom("pb_energy_loop")
	inst.AnimState:SetSymbolBloom("stone")
	inst.AnimState:SetSymbolLightOverride("pb_energy_loop01", .5)
	inst.AnimState:SetSymbolLightOverride("pb_ray", .5)
	inst.AnimState:SetSymbolLightOverride("stone", .5)
	inst.AnimState:SetSymbolLightOverride("glow", .25)
	inst.AnimState:SetLightOverride(.1)

	inst:AddComponent("highlightchild")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("colouradder")

	inst.persists = false

	return inst
end

return Prefab("jinhuafazhang", fn, assets, prefabs),
	Prefab("jinhuafazhang_fx", fxfn, assets)
