local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end
local function OnKillBuff(inst)
    inst.components.debuff:Stop()
end

local function OnAttached(inst, target)
    if  target.components.talker~=nil then
        target.components.talker:Say("暗影的力量")
    end
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 0, 0) --in case of loading
    if target.components.health ~= nil and not target.components.health:IsDead() and not target:HasTag("playerghost") then
       local weapon= target.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
      
        -- if  weapon ~= nil and  weapon:HasTag("shadow_item")  and weapon:HasTag("shadow_item")then
        --     local oldonattack=weapon.components.weapon.onattack
        
        --    weapon.components.weapon.onattack= function (inst, owner, target)
        --         if math.random() < 0.4 then
        --             local pt
        --             if target ~= nil and target:IsValid() then
        --                 pt = target:GetPosition()
        --             else
        --                 pt = owner:GetPosition()
        --                 target = nil
        --             end
        --             local offset = FindWalkableOffset(pt, math.random() * 2 * PI, 2, 3, false, true, NoHoles, false, true)
        --             if offset ~= nil then
        --                 local tentacle = SpawnPrefab("shadowtentacle")
        --                 if tentacle ~= nil then
        --                     tentacle.owner = owner
        --                     tentacle.Transform:SetPosition(pt.x + offset.x, 0, pt.z + offset.z)
        --                     tentacle.components.combat:SetTarget(target)
        --                 end
        --             end
        --         end
        --     end
           
        -- end
        if weapon ~= nil and not weapon:HasTag("shadow_item") then
            weapon:AddTag("shadow_item")
            weapon:AddTag("add_shadow")
        end
        if weapon ~= nil and  weapon:HasTag("shadow_item") then
            if  target.components.talker~=nil then
                target.components.talker:Say("它已经获得暗影的力量了")
            end
   
        end
    if  weapon == nil then
          
            if  target.components.talker~=nil then
                target.components.talker:Say("暗影的力量需要武器承载")
            end
            end
    end
    inst.bufftask = inst:DoTaskInTime(1, OnKillBuff)
end
local function OnDetached(inst, target)
    inst:Remove()
end
local function OnExtendedBuff(inst)
    if inst.bufftask ~= nil then
        inst.bufftask:Cancel()
        inst.bufftask = inst:DoTaskInTime(1, OnKillBuff)
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
    --[[Non-networked entity]]

    inst.persists = false

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(OnDetached)
    inst.components.debuff:SetExtendedFn(OnExtendedBuff)
    inst.components.debuff.keepondespawn = true

    return inst
end

return Prefab("shadowtaffybuff", fn)
