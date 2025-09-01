
local assets=
{
	Asset("ANIM", "anim/sjy_wsj_limao.zip"),
	Asset("IMAGE", "images/inventoryimages/sjy_wsj_limao.tex"),
	Asset("ATLAS", "images/inventoryimages/sjy_wsj_limao.xml"),
}

local prefabs =
{
}

local function onopen(inst)
    -- inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	inst.Light:Enable(true)
end

local function onclose(inst)
    -- inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
	inst.Light:Enable(false)
end

local function onequiphat(inst, owner)
	owner.AnimState:OverrideSymbol("swap_hat", "sjy_wsj_limao", "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAT_HAIR")
	-- owner.AnimState:Hide("HAIR_NOHAT")
	-- owner.AnimState:Hide("HAIR")

	if not owner.components.reader then
		owner:AddComponent("reader")
		owner:AddTag("read1")
	end

	if owner:HasTag("monster") then
		owner:AddTag("unmonster")
		owner:RemoveTag("monster")
	end

	if owner:HasTag("merm") then
		owner:RemoveTag("merm")
		owner:AddTag("pig")
	end

	if owner:HasTag("player") then 
		owner.AnimState:Show("HEAD")
		owner.AnimState:Show("HEAD_HAT")
		owner:RemoveTag("scarytoprey")
		owner:AddTag("beefalo")

		owner.components.builder.seafaring_bonus = owner.components.builder.seafaring_bonus + 4
	end

end

local function onunequiphat(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_hat")
	-- owner.AnimState:Hide("HAT")
	-- owner.AnimState:Hide("HAIR_HAT")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")

	if owner:HasTag("read1") then
		owner:RemoveComponent("reader")	
		owner:RemoveTag("read1") 
	end

	if owner:HasTag("unmonster") then
		owner:AddTag("monster")
		owner:RemoveTag("unmonster")
    end	

	if owner:HasTag("pig") then
		owner:AddTag("merm")
		owner:RemoveTag("pig")
	end	

	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Show("HEAD_HAT")
		owner:AddTag("scarytoprey")
		owner:RemoveTag("beefalo")

		owner.components.builder.seafaring_bonus = owner.components.builder.seafaring_bonus - 4
	end

end

local function CalcSanityAura(inst)
    return inst.components.equippable.target ~= nil and -100 or -200
end

local function OnPutInInventory(inst)
    print("开始关灯2")
    inst.Light:Enable(false)
    print("关灯成功2")
	onclose(inst)
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

   inst.entity:AddLight()                          --添加发光组件
   inst.Light:Enable(false)                        --默认关
   inst.Light:SetRadius(4*4)                       --发光范围:半径2格地皮
   inst.Light:SetFalloff(1)                        --衰减
   inst.Light:SetIntensity(0.5)                   --强度
   inst.Light:SetColour(252/255, 138/255, 6/255)  --黄色
   inst:ListenForEvent("ondropped", function()
	inst.Light:Enable(false)
 	end)
    inst.AnimState:SetBank("sjy_wsj_limao")  
    inst.AnimState:SetBuild("sjy_wsj_limao")
    inst.AnimState:PlayAnimation("anim")

	inst:AddTag("hat")
	inst:AddTag("hide")
	inst:AddTag("sjy_wsj_limaotag")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("container")
    inst.components.container:WidgetSetup("sjy_wsj_limao")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

	inst:AddComponent("sanityaura")
	inst.components.sanityaura.aurafn = CalcSanityAura

	inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(-1000000)

    inst:AddComponent("inspectable") 
    inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sjy_wsj_limao.xml"
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
	
	inst:AddComponent("equippable") 
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD 
	inst.components.equippable:SetOnEquip( onequiphat ) 
    inst.components.equippable:SetOnUnequip( onunequiphat ) 

    -- inst:AddComponent("armor")
    -- inst.components.armor:InitCondition(300,0.9) 
	
	inst:AddComponent("waterproofer") 
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_ABSOLUTE)
	
	inst:AddComponent("insulator") 
    inst.components.insulator:SetInsulation(120)
	inst:DoPeriodicTask(0.2,function()
		if "summer" == true then  
			inst.components.insulator:SetWinter()
		elseif "winter" == true  then
			inst.components.insulator:SetSummer()
		end 
	end)
	
	inst:AddComponent("heater")
    inst.components.heater:SetThermics(false, true)
    inst.components.heater.equippedheat = 20
	
	inst:AddComponent("tradable")

	MakeHauntableLaunchAndPerish(inst)
    return inst
end 
    
return Prefab( "sjy_wsj_limao", fn, assets, prefabs ) 