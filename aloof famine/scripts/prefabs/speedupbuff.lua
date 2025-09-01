
local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0) --in case of loading
	
    target.components.locomotor:SetExternalSpeedMultiplier(target, "speedupbuff", 2)
	if target.speedupbuff == nil then
		target.speedupbuff = target:DoTaskInTime(600, function()
			target.components.locomotor:RemoveExternalSpeedMultiplier(target, "speedupbuff")
		end)
	end
	
    inst:ListenForEvent("death", function()
        inst.components.debuff:Stop()
    end, target)
end

local function OnTimerDone(inst, data)
    if data.name == "speedupbuff" then
        inst.components.debuff:Stop()
    end
end

local function OnExtended(inst, target)
    inst.components.timer:SetTimeLeft("speedupbuff", 600)
	if target.speedupbuff ~= nil then
		target.speedupbuff:Cancel()
		target.speedupbuff = nil
		target.speedupbuff = target:DoTaskInTime(600, function()
			target.components.locomotor:RemoveExternalSpeedMultiplier(target, "speedupbuff")
		end)
	end
end

local function fn()
    local inst = CreateEntity()

    if not TheWorld.ismastersim then
        --Not meant for client!
        inst:DoTaskInTime(0, inst.Remove)
        return inst
    end

    inst.entity:AddTransform()

    inst.entity:Hide()
    inst.persists = false

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(inst.Remove)
    inst.components.debuff:SetExtendedFn(OnExtended)
    inst.components.debuff.keepondespawn = true

    inst:AddComponent("timer")
    inst.components.timer:StartTimer("speedupbuff", 600)
    inst:ListenForEvent("timerdone", OnTimerDone)

    return inst
end

return Prefab("speedupbuff", fn)
