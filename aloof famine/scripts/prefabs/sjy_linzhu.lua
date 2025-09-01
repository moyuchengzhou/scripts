
local assets =
{
    Asset("ANIM", "anim/sjy_linzhus.zip"),
}

local items = {
	-- hclr_icelevel2 = "hclr_superice2",
    -- hclr_icelevel1 = "hclr_superice1" ,
    -- hclr_mulevel1 = "hclr_supermu1" ,
    -- hclr_mulevel2 = "hclr_supermu2",
    sjy_linzhus = "sjy_linzhus",
}

local function OnPickup(inst)
	if inst.Disappear ~= nil then
		inst.Disappear:Cancel()
		inst.Disappear = nil
	end
end



local function OnDropped(inst,phase)
	if inst.Disappear == nil then
		inst.Disappear = inst:DoTaskInTime(1, function()
            if TheWorld.components.worldstate.data.isday or TheWorld.components.worldstate.data.isdusk or TheWorld:HasTag("cave") then
			if inst ~= nil then
				SpawnPrefab("halloween_firepuff_cold_1").Transform:SetPosition(inst.Transform:GetWorldPosition())
                    inst:Remove()
			end
        end
			inst.Disappear:Cancel()
			inst.Disappear = nil
		end)
	end
end

local function builditem(name,target)

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		
		inst.Transform:SetScale(0.8, 0.8, 0.8)

        inst.AnimState:SetBank("sjy_linzhus")
        inst.AnimState:SetBuild("sjy_linzhus")
        inst.AnimState:PlayAnimation(name)

        MakeInventoryFloatable(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"

        if name ~= "sjy_linzhus"  then
		    inst:AddComponent("sjy_gaibian")
		    inst.components.sjy_gaibian.targetprefab = target
        else
            inst:AddComponent("sjy_wuxiannaijiuyonghu")
        end

        inst:ListenForEvent("ondropped", OnDropped)
        inst:ListenForEvent("ms_playerjoined", inst:PushEvent("ondropped"))
        inst.OnDropped = OnDropped
        inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)


        inst:WatchWorldState("startday", function()
            OnDropped(inst)
        end)
        inst:WatchWorldState("startnight", function()
            OnPickup(inst)
        end)
        -- inst:WatchWorldState("startday", function()
        --     OnDropped(inst)
        -- end)
        -- inst:WatchWorldState("startnight", function()
        --     OnPickup(inst)
        -- end)
        
        -- if TheWorld.components.worldstate.data.isday then
        --     inst:ListenForEvent("ondropped", OnDropped)
        --     inst:ListenForEvent("ms_playerjoined", inst:PushEvent("ondropped"))
        --     inst.OnDropped = OnDropped
        -- end
        -- if TheWorld.components.worldstate.data.dusk then
        --     inst:ListenForEvent("ondropped", OnDropped)
        --     inst:ListenForEvent("ms_playerjoined", inst:PushEvent("ondropped"))
        --     inst.OnDropped = OnDropped
        -- end
        -- if TheWorld.components.worldstate.data.night then
        --     inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)
        -- end
        -- inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)
       



		
        return inst
    end
    return Prefab(name, fn, assets)
end

local t = {}

for k,v in pairs(items) do
	table.insert(assets, Asset("ATLAS", "images/inventoryimages/"..k..".xml"))
	table.insert(t, builditem(k,v))
end
return unpack(t)
