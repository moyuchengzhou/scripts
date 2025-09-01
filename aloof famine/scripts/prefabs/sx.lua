
local function OnAttached(inst, target)
	inst.entity:SetParent(target.entity)  --父对象和位置
	inst.Transform:SetPosition(0, 0, 0) --in case of loading   --相对位置
   inst:ListenForEvent("death", function() --监听死亡事件‌：停止buff的效果
      inst.components.debuff:Stop()
   end, target)

--    if target.prefab == "wendy" then
      target.components.health.maxhealth = target.components.health.maxhealth + 100  --这里是料理生效给予目标buff
--    end
end

local function OnTimerDone(inst, data)     --倒计时结束后停止buff,原理是调用下面那个移除buff函数
    if data.name == "sx" then
        inst.components.debuff:Stop()
    end
end

local function OnExtended(inst, target)  --重复给予药剂，检查并重置计时器
    inst.components.timer:StopTimer("sx_timer")
    inst.components.timer:StartTimer("sx_timer", 1440)
end

local function OnDetached(inst, target)  --移除buff
    target.components.health.maxhealth = target.components.health.maxhealth + 100  --这里是移除目标buff
     inst:Remove()
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
    inst.components.debuff:SetDetachedFn(OnDetached)
    inst.components.debuff:SetExtendedFn(OnExtended)
    inst.components.debuff.keepondespawn = true

    inst:AddComponent("timer")
    inst.components.timer:SetTimeLeft("sx_timer", 1440)
    inst:ListenForEvent("timerdone", OnTimerDone)

    return inst
end

return Prefab("sx", fn)
















